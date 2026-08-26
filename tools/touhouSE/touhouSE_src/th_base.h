
namespace TouhouSE {

namespace SHANGHAI_ALICE {

namespace {

namespace endian = boost::spirit::endian;

class Header : boost::noncopyable {
public:
   endian::ulittle8_t signature[4];
   endian::ulittle32_t list_size;
   endian::ulittle32_t compress_size;
   endian::ulittle32_t list_count;

   template<unsigned int KEY1, unsigned int KEY2, unsigned int KEY3, unsigned int KEY4, unsigned int KEY5>
   bool Read(std::istream &in) {
      if (!in.good()) {
         return false;
      }
      in.read(reinterpret_cast<char *>(this), sizeof(*this));
      TH11::thcrypter(reinterpret_cast<unsigned char *>(this), sizeof(*this), KEY1, KEY2, sizeof(*this), sizeof(*this));
      list_size -= KEY3;
      compress_size -= KEY4;
      list_count -= KEY5;
      if (!in.good() || !IsValid()) {
         return false;
      }
      return true;
   }
   bool IsValid() const {
      const std::string expected_signature = "THA1";
      return std::equal(expected_signature.begin(), expected_signature.end(), signature)
         && compress_size < list_size
         && list_size >= list_count * 12
         && (
         (compress_size == 0 && list_size == 0 && list_count == 0)
            || (compress_size > 0 && list_size > 0 && list_count > 0)
            );
   }
};

class FileRecord {
public:
   std::string name;
   unsigned int addr;
   unsigned int size;
   unsigned int compress_size;

   template<unsigned int KEY1, unsigned int KEY2, unsigned int KEY3>
   static bool Read(std::istream &in, const Header &header, const unsigned long long int file_size, std::vector<FileRecord> &result) {
      if (header.compress_size == 0) {
         result.resize(0);
         return true;
      }
      std::vector<unsigned char> raw_list(header.compress_size);
      in.seekg(-static_cast<long long int>(header.compress_size), std::ios::end);
      in.read(reinterpret_cast<char *>(&raw_list.front()), raw_list.size());
      if (!in.good()) {
         return false;
      }
      TH11::thcrypter(&raw_list.front(), raw_list.size(), KEY1, KEY2, KEY3, raw_list.size());
      if (header.compress_size != header.list_size) {
         std::vector<unsigned char> decompress_list(header.list_size);
         TH11::decomp(&raw_list.front(), raw_list.size(), &decompress_list.front(), decompress_list.size());
         raw_list.swap(decompress_list);
      }
      result.resize(header.list_count);
      std::vector<unsigned char>::const_iterator it = raw_list.begin();
      FileRecord *prev = NULL;
      for (FileRecord &record : result) {
         const std::vector<unsigned char>::const_iterator name_last = std::find(it, static_cast<std::vector<unsigned char>::const_iterator>(raw_list.end()), '\0');
         const unsigned int name_length = std::distance(it, name_last);
         if (name_last == raw_list.end() || name_last == it || name_length > 255) {
            return false;
         }
         record.name.assign(reinterpret_cast<const char *>(&*it), name_length);
         it += (name_length + 1 + 3) / 4 * 4;
         record.addr = *reinterpret_cast<const unsigned int *>(&*it);
         it += 4;
         record.size = *reinterpret_cast<const unsigned int *>(&*it);
         it += 4;
         if (*reinterpret_cast<const unsigned int *>(&*it) != 0) {
            return false;
         }
         it += 4;
         if (prev != NULL) {
            prev->compress_size = record.addr - prev->addr;
            if (!prev->IsValid(record.addr)) {
               return false;
            }
         }
         prev = &record;
      }
      const unsigned int last_addr = static_cast<unsigned int>(file_size) - header.compress_size;
      prev->compress_size = last_addr - prev->addr;
      if (!prev->IsValid(last_addr) || result[0].addr < sizeof(header) || prev->addr > last_addr) {
         return false;
      }
      return true;
   }

   bool IsValid(const unsigned int next_addr) {
      return next_addr >= addr
         && next_addr == addr + compress_size
         && size >= compress_size
         && name.size() < 256;
   }
};

} // anonymous

template<typename T, unsigned int KEY1, unsigned int KEY2, unsigned int KEY3, unsigned int KEY4, unsigned int KEY5, unsigned int KEY6, unsigned int KEY7, unsigned int KEY8>
class ThOwnerBase : public ExtractorBase {
protected:
   std::istream &in;
   const unsigned long long int file_size;
   const std::shared_ptr<const Header> header;
   const std::shared_ptr<const std::vector<FileRecord> > file_list;

   ThOwnerBase(std::istream &in, const unsigned long long int file_size, const std::shared_ptr<const Header> header, const std::shared_ptr<const std::vector<FileRecord> > file_list) :
    in(in), file_size(file_size), header(header), file_list(file_list)
  {
   }

private:
   bool SearchExt(const std::string &ext, unsigned int * const result) {
      unsigned int i = 0;
      for (const FileRecord record : *file_list.get()) {
         const std::filesystem::path path(record.name);
         if (path.extension() == ext) {
            *result = i;
            return true;
         }
         i++;
      }
      return false;
   }

   bool TryVerFileExtract() {
      unsigned int index;
      if (!SearchExt(".ver", &index)) {
         return true; // verファイルを含まないのでテストスキップ
      }
      std::vector<unsigned char> data;
      if (!Extract(index, data)) {
         return false;
      }
      for (const unsigned char c : data) {
         if (::isalnum(c) == 0 && ::isspace(c) == 0) {
            return false;
         }
      }
      return true;
   }

public:
   static std::shared_ptr<T> Open(std::istream &in, const unsigned long long int file_size) {
      std::shared_ptr<T> result;
      if (file_size < sizeof(Header)) {
         return result;
      }

      const std::shared_ptr<Header> header = std::make_shared<Header>();
      if (!header->Read<KEY1, KEY2, KEY3, KEY4, KEY5>(in) || header->compress_size + sizeof(*header) > file_size) {
         return result;
      }

      const std::shared_ptr<std::vector<FileRecord> > list = std::make_shared<std::vector<FileRecord> >(header->list_count);
      if (!FileRecord::Read<KEY6, KEY7, KEY8>(in, *header, file_size, *list)) {
         return result;
      }
      std::shared_ptr<T> temp = std::make_shared<T>(in, file_size, header, list);
      if (!temp->TryVerFileExtract()) {
         return result;
      }
      result = temp;
      return result;
   }

   bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
      if (!in.good()) {
         return false;
      }
      const FileRecord &record = file_list->at(index);
      if (record.compress_size == 0) {
         result.resize(0);
         return true;
      }
      in.seekg(record.addr);
      result.resize(record.compress_size);
      in.read(reinterpret_cast<char *>(&result.front()), result.size());
      if (!in.good()) {
         return false;
      }
      const unsigned int * const keys = GetConvMap(DatUtility::CalcKeyIndex(&record.name.front(), record.name.length()));
      TH11::thcrypter(&result.front(), result.size(), keys[0], keys[1], keys[2], keys[3]);
      if (record.size != record.compress_size) {
         std::vector<unsigned char> decompress_data(record.size);
         TH11::decomp(&result.front(), result.size(), &decompress_data.front(), decompress_data.size());
         result.swap(decompress_data);
      }
      return true;
   }

   unsigned int GetSize() const {
      return header->list_count;
   }

   std::filesystem::path GetFileName(unsigned int index) const {
      return std::filesystem::path("data") / file_list->at(index).name;
   }

   virtual const unsigned int *GetConvMap(unsigned int index) = 0;
};

} // SHANGHAI_ALICE

} // TouhouSE
