
namespace TouhouSE {

namespace DX_ARCHIVE {

namespace endian = boost::spirit::endian;

void decrypt(const unsigned int size, const unsigned long long int addr, const std::array<unsigned char, 12> &key, unsigned char * const buf);
bool decompress(const std::vector<unsigned char> &in, std::vector<unsigned char> &out);

template<typename HeaderT>
class Header : boost::noncopyable, public HeaderT {
public:
   bool isValid() const {
      const char expected_signature[] = { 0x44, 0x58 };
      return std::equal(expected_signature, &expected_signature[_countof(expected_signature)], signature)
         && version == HeaderT::getVersion() && header_size == sizeof(Header) && file_data_table_offset < footer_size
         && directory_data_table_offset < footer_size && directory_data_table_offset > file_data_table_offset;
   }
};

template<typename DirectoryDataT>
class DirectoryData : boost::noncopyable, public DirectoryDataT {
public:
   std::vector<std::shared_ptr<DirectoryData<DirectoryDataT> > > child;

   template<typename HeaderT>
   static std::shared_ptr<DirectoryData<DirectoryDataT> > read(std::istream &in, const unsigned long long int file_size, const Header<HeaderT> &header, const std::array<unsigned char, 12> &key) {
      std::shared_ptr<DirectoryData<DirectoryDataT> > result;
      const unsigned int directory_data_footer_size = static_cast<unsigned int>(file_size - header.file_name_table_address - header.directory_data_table_offset);
      if (directory_data_footer_size == 0 || (directory_data_footer_size % DirectoryDataT::getSize()) != 0) {
         return result;
      }
      const unsigned int directory_count = directory_data_footer_size / DirectoryDataT::getSize();
      const unsigned long long int base_addr = header.file_name_table_address + header.directory_data_table_offset;
      in.seekg(base_addr, std::ios::beg);
      if (!in.good()) {
         return result;
      }
      std::map<unsigned long long int, std::shared_ptr<DirectoryData<DirectoryDataT> > > data_list;
      unsigned int long long read_size = 0;
      for (unsigned int i = 0; i < directory_count; i++) {
         const auto data = std::make_shared<DirectoryData<DirectoryDataT> >();
         in.read(reinterpret_cast<char *>(data.get()), DirectoryDataT::getSize());
         if (!in.good()) {
            return result;
         }
         const unsigned long long int addr = base_addr + read_size;
         decrypt(DirectoryDataT::getSize(), DirectoryDataT::getCryptKeyOffset(header, read_size), key, reinterpret_cast<unsigned char *>(data.get()));
         data_list.insert(std::make_pair(addr, data));
         read_size += DirectoryDataT::getSize();
      }
      typedef std::pair<unsigned long long int, std::shared_ptr<DirectoryData<DirectoryDataT> > > DirectoryDataPair;
      for (const DirectoryDataPair &data : data_list) {
         if (data.second->parent_directory_offset == NumericLimits<decltype(data.second->parent_directory_offset)>::max()) {
            continue;
         }
         const std::map<unsigned long long int, std::shared_ptr<DirectoryData<DirectoryDataT> > >::iterator it = data_list.find(
            header.file_name_table_address
            + header.directory_data_table_offset
            + data.second->parent_directory_offset);
         if (it == data_list.end()) {
            return result;
         }
         it->second->child.push_back(data.second);
      }
      result = data_list.begin()->second;
      return result;
   }
};

template<typename FileDataT>
class FileData : boost::noncopyable, public FileDataT {
public:

   template<typename HeaderT>
   static std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > > > read(
      std::istream &in,
      const unsigned long long int file_size,
      const Header<HeaderT> &header,
      const std::array<unsigned char, 12> &key) {
      std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > > > result;
      const unsigned int file_data_footer_size = static_cast<unsigned int>(header.directory_data_table_offset - header.file_data_table_offset);
      if (file_data_footer_size == 0 || (file_data_footer_size % sizeof(FileData<FileDataT>)) != 0) {
         return result;
      }
      const unsigned int file_data_count = file_data_footer_size / sizeof(FileData<FileDataT>);
      const unsigned long long int base_addr = header.file_name_table_address + header.file_data_table_offset;
      in.seekg(base_addr, std::ios::beg);
      if (!in.good()) {
         return result;
      }
      const auto data_list = std::make_shared<std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT>> > >();
      unsigned long long int read_size = 0;
      for (unsigned int i = 0; i < file_data_count; i++) {
         const auto data = std::make_shared<FileData<FileDataT> >();
         in.read(reinterpret_cast<char *>(data.get()), sizeof(FileData<FileDataT>));
         if (!in.good()) {
            return result;
         }
         const unsigned long long int addr = base_addr + read_size;
         decrypt(sizeof(FileData<FileDataT>), FileDataT::getCryptKeyOffset(header, read_size), key, reinterpret_cast<unsigned char *>(data.get()));
         data_list->insert(std::make_pair(addr, data));
         read_size += sizeof(FileData<FileDataT>);
      }
      result = data_list;
      return result;
   }

   bool isDir() const {
      return (flag & FILE_ATTRIBUTE_DIRECTORY) != 0;
   }
};

template<typename FilenameT>
class Filename : boost::noncopyable, public FilenameT {
private:

public:
   const std::string name;

   Filename() {
   }
   Filename(const char * const name) : name(name) {
   }

   template<typename HeaderT>
   static std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > > read(
      std::istream &in,
      const unsigned long long int file_size,
      const Header<HeaderT> &header,
      const std::array<unsigned char, 12> &key) {
      std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > > result;
      in.seekg(header.file_name_table_address, std::ios::beg);
      if (!in.good()) {
         return result;
      }
      const auto data_list = std::make_shared<std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > >();
      unsigned long long int read_size = 0;
      while (read_size < header.file_data_table_offset) {
         unsigned int length = 0;
         in.read(reinterpret_cast<char *>(&length), 2);
         if (!in.good()) {
            return result;
         }
         const unsigned long long int addr = header.file_name_table_address + read_size;
         decrypt(2, FilenameT::getCryptKeyOffset(header, read_size), key, reinterpret_cast<unsigned char *>(&length));
         length = length * 4;
         in.seekg(2, std::ios::cur);
         read_size += 4;
         if (length == 0) {
            data_list->insert(std::make_pair(addr, std::make_shared<const Filename<FilenameT> >()));
            continue;
         }
         std::vector<char> name(length);
         in.seekg(name.size(), std::ios::cur);
         read_size += name.size();
         in.read(&name.front(), name.size());
         decrypt(name.size(), FilenameT::getCryptKeyOffset(header, read_size), key, reinterpret_cast<unsigned char *>(&name.front()));
         read_size += name.size();
         data_list->insert(std::make_pair(addr, std::make_shared<const Filename<FilenameT> >(&name.front())));
      }
      result = data_list;
      return result;
   }
};

class FileRecord : boost::noncopyable {
private:
   template<typename HeaderT, typename DirectoryDataT, typename FileDataT, typename FilenameT>
   static bool createListImpl(
      const Header<HeaderT> &header,
      const DirectoryData<DirectoryDataT> &directory_data,
      const std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > > &file_data_list,
      const std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > &filename_list,
      std::vector<std::shared_ptr<const FileRecord> > &out,
      const std::filesystem::path &cur = L"data") {
      for (unsigned int i = 0; i < directory_data.file_count; i++) {
         const unsigned long long int file_data_addr =
            header.file_name_table_address
            + header.file_data_table_offset
            + directory_data.file_data_offset
            + i * sizeof(FileData<FileDataT>);
         const std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > >::const_iterator file_data_it = file_data_list.find(file_data_addr);
         if (file_data_it == file_data_list.end()) {
            return false;
         }
         const FileData<FileDataT> &file_data = *file_data_it->second;
         if (file_data.isDir()) {
            continue;
         }
         const unsigned long long int filename_addr = header.file_name_table_address + file_data.name_offset;
         const std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > >::const_iterator filename_it = filename_list.find(filename_addr);
         if (filename_it == filename_list.end()) {
            return false;
         }
         const Filename<FilenameT> &filename = *filename_it->second;
         out.push_back(std::make_shared<const FileRecord>(
            sizeof(Header<HeaderT>) + file_data.body_offset,
            cur / filename.name,
            file_data.body_size,
            file_data.body_compress_size == NumericLimits<decltype(file_data.body_compress_size)>::max()
            ? NumericLimits<decltype(FileRecord::file_compress_size)>::max() : file_data.body_compress_size));
      }
      for (const std::shared_ptr<const DirectoryData<DirectoryDataT> > childImpl : directory_data.child) {
         const DirectoryData<DirectoryDataT> &child = *childImpl;
         const unsigned long long int file_data_addr = header.file_name_table_address + header.file_data_table_offset + child.directory_data_offset;
         const std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > >::const_iterator file_data_it = file_data_list.find(file_data_addr);
         if (file_data_it == file_data_list.end()) {
            return false;
         }
         const FileData<FileDataT> &file_data = *file_data_it->second;
         const unsigned long long int filename_addr = header.file_name_table_address + file_data.name_offset;
         const std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > >::const_iterator filename_it = filename_list.find(filename_addr);
         if (filename_it == filename_list.end()) {
            return false;
         }
         const Filename<FilenameT> &filename = *filename_it->second;
         if (!createListImpl(header, child, file_data_list, filename_list, out, cur / filename.name)) {
            return false;
         }
      }
      return true;
   }

public:
   const unsigned long long int addr;
   const std::filesystem::path path;
   const unsigned long long int file_size;
   const unsigned long long int file_compress_size;

   FileRecord(const unsigned long long int addr, const std::filesystem::path &path, const unsigned long long int file_size, const unsigned long long int file_compress_size) :
      addr(addr), path(path), file_size(file_size), file_compress_size(file_compress_size) {
   }

   template<typename HeaderT, typename DirectoryDataT, typename FileDataT, typename FilenameT>
   static std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > createList(
      const Header<HeaderT> &header,
      const DirectoryData<DirectoryDataT> &directory_data,
      const std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > > &file_data,
      const std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > &filename_list) {
      std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > result;
      const std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > list = std::make_shared<std::vector<std::shared_ptr<const FileRecord> > >();
      if (!createListImpl(header, directory_data, file_data, filename_list, *list)) {
         return result;
      }
      result = list;
      return result;
   }
};

template<typename HeaderT, typename DirectoryDataT, typename FileDataT, typename FilenameT, typename FileBodyT>
class Owner : public ExtractorBase {
private:
   std::istream &in;
   const unsigned long long int file_size;
   const std::array<unsigned char, 12> key;
   const std::shared_ptr<const Header<HeaderT> > header;
   const std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > file_record_list;

   Owner(
      std::istream &in,
      const unsigned long long int file_size,
      const std::array<unsigned char, 12> key,
      const std::shared_ptr<const Header<HeaderT> > header,
      const std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > file_record_list)
      :
      in(in), file_size(file_size), key(key), header(header), file_record_list(file_record_list) {
   }

   static bool readHeaderAndKey(
      std::istream &in,
      const unsigned long long int file_size,
      std::shared_ptr<Header<HeaderT> > &header,
      std::array<unsigned char, 12> &key) {
      if (file_size < sizeof(Header<HeaderT>)) {
         return false;
      }
      header.reset(new Header<HeaderT>());
      in.read(reinterpret_cast<char *>(header.get()), sizeof(Header<HeaderT>));
      if (!in.good()) {
         return false;
      }
      if (!HeaderT::readKey(reinterpret_cast<const unsigned char *>(header.get()), file_size, key)) {
         return false;
      }
      decrypt(sizeof(Header<HeaderT>), 0, key, reinterpret_cast<unsigned char *>(header.get()));
      if (!header->isValid()) {
         return false;
      }
      if (header->file_name_table_address > file_size) {
         return false;
      }
      const unsigned int footer_size = static_cast<unsigned int>(file_size - header->file_name_table_address);
      if (header->footer_size != footer_size) {
         return false;
      }
      return header->file_name_table_address < file_size;
   }

public:
   static std::shared_ptr<Owner<HeaderT, DirectoryDataT, FileDataT, FilenameT, FileBodyT> > Open(std::istream &in, const unsigned long long int file_size) {
      std::shared_ptr<Owner<HeaderT, DirectoryDataT, FileDataT, FilenameT, FileBodyT> > result;
      std::array<unsigned char, 12> key;
      std::shared_ptr<Header<HeaderT> > headerImpl;
      if (!readHeaderAndKey(in, file_size, headerImpl, key)) {
         return result;
      }
      std::shared_ptr<const Header<HeaderT> > header = headerImpl;
      const auto directory_data = DirectoryData<DirectoryDataT>::read(in, file_size, *header, key);
      if (!directory_data) {
         return result;
      }
      const std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const FileData<FileDataT> > > > file_data = FileData<FileDataT>::read(in, file_size, *header, key);
      if (!file_data) {
         return result;
      }
      const std::shared_ptr<std::map<unsigned long long int, std::shared_ptr<const Filename<FilenameT> > > > filename_list = Filename<FilenameT>::read(in, file_size, *header, key);
      if (!filename_list) {
         return result;
      }
      const std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > file_record_list = FileRecord::createList(
         *header,
         *directory_data,
         *file_data,
         *filename_list);
      if (!file_record_list) {
         return result;
      }
      result.reset(new Owner(in, file_size, key, header, file_record_list));
      return result;
   }

   bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
      const FileRecord &file = *(*file_record_list)[index];
      in.seekg(file.addr, std::ios::beg);
      if (!in.good()) {
         return false;
      }
      bool isCompress = (file.file_compress_size != NumericLimits<decltype(file.file_compress_size)>::max());
      const unsigned int read_size = static_cast<unsigned int>(isCompress ? file.file_compress_size : file.file_size);
      result.resize(read_size);
      if (result.size() == 0) {
         return true;
      }
      in.read(reinterpret_cast<char *>(&result.front()), read_size);
      if (!in.good()) {
         return false;
      }
      decrypt(result.size(), FileBodyT::getCryptKeyOffset(file), key, reinterpret_cast<unsigned char *>(&result.front()));
      if (isCompress) {
         std::vector<unsigned char> temp;
         if (!decompress(result, temp)) {
            return false;
         }
         result.swap(temp);
      }
      return true;
   }

   unsigned int GetSize() const {
      return file_record_list->size();
   }

   std::wstring GetName() const {
      return (boost::wformat(L"DxArchiveV%d") % HeaderT::getVersion()).str();
   }

   std::filesystem::path GetFileName(unsigned int index) const {
      return (*file_record_list)[index]->path;
   }
};

} // DX_ARCHIVE

} // ToudouSE
