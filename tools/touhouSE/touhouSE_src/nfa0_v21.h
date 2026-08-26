
namespace NFA0_V2_BASE {

namespace endian = boost::spirit::endian;

template<typename T, typename T2>
class NFA0Base {
public:
  void Decrypt() {
    T::Decrypt(reinterpret_cast<unsigned char *>(this), sizeof(T2));
  }
};

#pragma pack(push, 1)

template<typename T>
class Header : public NFA0Base<T, Header<T> > {
public:
  char signature[4];
  endian::ulittle16_t version;
  endian::ulittle16_t fileCount;
  endian::ulittle32_t type;

  bool IsValid() const {
    return std::equal(&this->signature[0], &this->signature[_countof(this->signature)], "NFA0") &&
      this->version == 2;
  }
};

template<typename T>
class RawFileRecord17 : public NFA0Base<T, RawFileRecord17<T> > {
public:
  endian::ulittle32_t size;
  endian::ulittle32_t address;
  endian::ulittle32_t unknown;
  char name[128];

  bool IsValid() const {
    return std::find(&this->name[0], &this->name[_countof(this->name)], '\0') != &this->name[_countof(this->name)];
  }
  const char *GetName(const unsigned int, const std::filesystem::path &) const {
    return name;
  }
  const unsigned int GetSize(const unsigned int) const {
    return size;
  }
  unsigned int GetOrigSize() const {
    return size;
  }
};

template<typename T>
class RawFileRecord1 : public NFA0Base<T, RawFileRecord1<T> > {
public:
  endian::ulittle32_t size;
  endian::ulittle32_t address;
  endian::ulittle32_t unknown;

  bool IsValid() const {
    return true;
  }
  const std::filesystem::path GetName(const unsigned int index, const std::filesystem::path &path) const {
    std::ostringstream temp;
    temp << index;
    std::filesystem::path result = temp.str();
    if (path.extension() == ".snd") {
      if (path.filename() == "jingle.snd" || path.filename() == "se.snd") {
       result.replace_extension(".wav");
      } else {
       result.replace_extension(".ogg");
      }
    } else if (path.extension() == ".spk") {
       result.replace_extension(".lua.lcd");
    } else if (path.wstring().find(L".mov") != std::wstring::npos) {
       result.replace_extension(".ogv");
    } else {
       result.replace_extension();
    }
    return result;
  }
  const unsigned int GetSize(const unsigned int) const {
    return size;
  }
  unsigned int GetOrigSize() const {
    return size;
  }
};

template<typename T>
class RawFileRecord5 : public NFA0Base<T, RawFileRecord5<T> > {
public:
  endian::ulittle32_t origSize;
  endian::ulittle32_t address;
  endian::ulittle32_t unknown;

  bool IsValid() const {
    return true;
  }
  const std::filesystem::path GetName(const unsigned int index, const std::filesystem::path &path) const {
    std::ostringstream temp;
    temp << index;
    std::filesystem::path result = temp.str();
    if (path.filename() == "font.cat") {
       result.replace_extension(".bmf");
    }
    return result;
  }
  unsigned int GetSize(const unsigned int nextAddr) const {
    return nextAddr - address;
  }
  unsigned int GetOrigSize() const {
    return origSize;
  }
};

class FileRecord {
public:
  std::filesystem::path path;
  unsigned int address;
  unsigned int size;
  bool crypt;
  bool compress;
  unsigned int origSize;
  unsigned int index;

  void Set(const std::filesystem::path &path, const unsigned int address, const unsigned int size, bool crypt) {
    this->path = path;
    this->address = address;
    this->size = size;
    this->crypt = crypt;
    this->compress = false;
    this->origSize = size;
  }
  void Set(const std::filesystem::path &path, const unsigned int address, const unsigned int size, bool crypt, unsigned int origSize, unsigned int index) {
    this->path = path;
    this->address = address;
    this->size = size;
    this->crypt = crypt;
    this->compress = size != origSize;
    this->origSize = origSize;
    this->index = index;
  }
};
#pragma pack(pop)

template<typename T, typename Func>
class Owner : public ExtractorBase {
private:
  std::istream &in;
  const std::shared_ptr<const std::vector<FileRecord> > fileList;

protected:
  Owner(std::istream &in, const std::shared_ptr<const std::vector<FileRecord> > fileList) :
    in(in), fileList(fileList)
  {
  }

public:
  static std::shared_ptr<T> Open(std::istream &in, const unsigned long long int fileSize) {
    std::shared_ptr<T> result;
    if (!in.good()) {
      return result;
    }
    Header<Func> header;
    in.read(reinterpret_cast<char *>(&header), sizeof(header));
    if (!in.good() || !header.IsValid()) {
      return result;
    }

    const std::shared_ptr<std::vector<FileRecord> > fileList(new std::vector<FileRecord>());
    if (!OpenImpl(in, 0, "", static_cast<unsigned int>(fileSize), false, *fileList)) {
      return result;
    }
    return std::shared_ptr<T>(new T(in, fileList));
  }
  template<typename T>
  static bool AddFileList(std::istream &in, const unsigned int baseAddr, const Header<Func> &header, const std::filesystem::path &path, const unsigned int fileSize, bool crypt, std::vector<FileRecord> &result) {
    if (fileSize < sizeof(header)+ static_cast<unsigned long long int>(sizeof(T)) * header.fileCount) {
      return false;
    }

    std::vector<T> fileList(header.fileCount);
    in.read(reinterpret_cast<char *>(&fileList.front()), sizeof(T)* header.fileCount);
    if (!in.good()) {
      return false;
    }
    const std::filesystem::path dir = std::filesystem::path(path).replace_extension();
    if (!crypt) {
      for (unsigned int i = 0; i < fileList.size(); i++) {
        fileList[i].Decrypt();
      }
    }
    for (unsigned int i = 0; i < fileList.size(); i++) {
      T &file = fileList[i];
      const unsigned int size = file.GetSize(fileList.size() == i + 1 ? fileSize : fileList[i + 1].address);
      if (!file.IsValid() || static_cast<unsigned long long int>(file.address) + size > fileSize) {
        return false;
      }
      const std::filesystem::path name = file.GetName(i, path);
      if (size != file.GetOrigSize()) {
        if (!OpenCompressData(in, baseAddr + file.address, dir / name, size, !crypt, file.GetOrigSize(), result)) {
          return false;
        }
        continue;
      }
      if (!OpenImpl(in, baseAddr + file.address, dir / name, size, !crypt, result)) {
        return false;
      }
    }
    return true;
  }
  static bool OpenImpl(std::istream &in, const unsigned int baseAddr, const std::filesystem::path &path, const unsigned int fileSize, bool crypt, std::vector<FileRecord> &result) {
    if (fileSize < sizeof(Header<Func>)) {
      result.resize(result.size() + 1);
      result.back().Set(path, baseAddr, fileSize, crypt);
      return true;
    }
    in.seekg(baseAddr, std::ios::beg);
    Header<Func> header;
    in.read(reinterpret_cast<char *>(&header), sizeof(header));
    if (!in.good()) {
      return false;
    }
    if (crypt) {
      header.Decrypt();
    }
    if (!header.IsValid()) {
      result.resize(result.size() + 1);
      result.back().Set(path, baseAddr, fileSize, crypt);
      return true;
    }
    if (header.fileCount == 0) {
      return true;
    }
    switch (header.type) {
    case 17:
      return AddFileList<RawFileRecord17<Func> >(in, baseAddr, header, path, fileSize, crypt, result);
    case 0:
      return AddFileList<RawFileRecord1<Func> >(in, baseAddr, header, path, fileSize, !crypt, result);
    case 1:
      return AddFileList<RawFileRecord1<Func> >(in, baseAddr, header, path, fileSize, crypt, result);
    case 5:
      return AddFileList<RawFileRecord5<Func> >(in, baseAddr, header, path, fileSize, crypt, result);
    case 4:
      return AddFileList<RawFileRecord5<Func> >(in, baseAddr, header, path, fileSize, false, result);
    default:
      return false;
    }
  }
  static bool OpenCompressData(std::istream &in, const unsigned int baseAddr, const std::filesystem::path &path, const unsigned int fileSize, bool crypt, const unsigned int origSize, std::vector<FileRecord> &result) {
    if (fileSize == 0 || origSize == 0) {
      return false;
    }
    std::vector<unsigned char> compData(fileSize);
    in.read(reinterpret_cast<char *>(&compData.front()), compData.size());
    if (!in.good()) {
      return false;
    }
    if (crypt) {
      Func::Decrypt(&compData.front(), compData.size());
    }
    std::vector<unsigned char> origData(origSize);
    unsigned long origSizeResult = origSize;
    if (Z_OK != ::uncompress(&origData.front(), &origSizeResult, &compData.front(), compData.size()) || origSizeResult != origSize) {
      return false;
    }
    if (!reinterpret_cast<Header<Func> *>(&origData.front())->IsValid()) {
      result.resize(result.size() + 1);
      result.back().Set(path, baseAddr, fileSize, crypt, origSize, 0);
      return true;
    }
    boost::iostreams::array_source source(reinterpret_cast<char *>(&origData.front()), origData.size());
    boost::iostreams::stream<boost::iostreams::array_source> stream(source);
    std::shared_ptr<T> owner = T::Open(stream, origData.size());
    if (!owner) {
      return false;
    }
    const std::filesystem::path dir = std::filesystem::path(path).replace_extension();
    for (unsigned int i = 0; i < owner->GetSize(); i++) {
      result.resize(result.size() + 1);
      result.back().Set(dir / owner->GetFileName(i), baseAddr, fileSize, crypt, origSize, i);
    }
    return true;
  }
  bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
    if (index >= GetSize() || !in.good()) {
      return false;
    }
    const FileRecord &file = fileList->at(index);
    if (file.size == 0) {
      result.clear();
      return true;
    }
    result.resize(file.size);
    in.seekg(file.address);
    in.read(reinterpret_cast<char *>(&result.front()), result.size());
    if (!in.good()) {
      return false;
    }
    if (file.crypt) {
      Func::Decrypt(&result.front(), result.size());
    }
    if (!file.compress) {
      return true;
    }
    std::vector<unsigned char> temp(file.origSize);
    unsigned long origSize = file.origSize;
    if (Z_OK != ::uncompress(&temp.front(), &origSize, &result.front(), result.size())) {
      return false;
    }
    std::swap(result, temp);
    if (!reinterpret_cast<Header<Func> *>(&result.front())->IsValid()) {
      return true;
    }
    std::vector<unsigned char> sourceImpl;
    std::swap(sourceImpl, result);
    boost::iostreams::array_source source(reinterpret_cast<char *>(&sourceImpl.front()), sourceImpl.size());
    boost::iostreams::stream<boost::iostreams::array_source> stream(source);
    std::shared_ptr<T> owner = T::Open(stream, sourceImpl.size());
    if (!owner) {
      return false;
    }
    if (owner->GetSize() <= file.index) {
      return false;
    }
    return owner->Extract(file.index, result);
  }
  unsigned int GetSize() const {
    return fileList->size();
  }
  std::filesystem::path GetFileName(const unsigned int index) const {
    return this->fileList->at(index).path;
  }
};

} // NFA0_V21
