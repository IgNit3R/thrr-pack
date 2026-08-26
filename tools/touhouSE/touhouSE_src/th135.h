
namespace TouhouSE {

namespace TH135 {

extern const std::array<std::wstring, 20000> DIR_NAME_LIST;

extern const unsigned char KEY[64];
extern const unsigned char PUBLIC_EXPONENT[3];
extern const unsigned char SIGNATURE_DATA[32];
extern const unsigned int MAX_DECRYPT_SIZE;

namespace {

struct closeAlg {
  static void close(const BCRYPT_ALG_HANDLE handle) {
    ::BCryptCloseAlgorithmProvider(handle, 0);
  }
};

class DecryptEngine : public boost::noncopyable {
private:
  const std::unique_ptr<std::remove_pointer<BCRYPT_ALG_HANDLE>::type, decltype(&closeAlg::close)> alg;
  const std::unique_ptr<std::remove_pointer<BCRYPT_KEY_HANDLE>::type, decltype(&::BCryptDestroyKey)> key;

public:
  DecryptEngine(std::unique_ptr<std::remove_pointer<BCRYPT_ALG_HANDLE>::type, decltype(&closeAlg::close)> alg,
    std::unique_ptr<std::remove_pointer<BCRYPT_KEY_HANDLE>::type, decltype(&::BCryptDestroyKey)> key)
  : alg(std::move(alg)), key(std::move(key))
  {
  }

  static std::unique_ptr<DecryptEngine> create() {
    BCRYPT_ALG_HANDLE algRaw = NULL;
    if (!NT_SUCCESS(::BCryptOpenAlgorithmProvider(&algRaw, BCRYPT_RSA_ALGORITHM, NULL, 0))) {
      return{};
    }
    std::unique_ptr<std::remove_pointer<BCRYPT_ALG_HANDLE>::type, decltype(&closeAlg::close)> alg(algRaw, &closeAlg::close);
    auto key = importRsaPublicKey(alg.get());
    if (!key) {
      return{};
    }
    return std::make_unique<DecryptEngine>(std::move(alg), std::move(key));
  }

  static std::unique_ptr<std::remove_pointer<BCRYPT_KEY_HANDLE>::type, decltype(&::BCryptDestroyKey)> importRsaPublicKey(BCRYPT_ALG_HANDLE alg) {
    static std::vector<unsigned char> keyData(sizeof(BCRYPT_RSAKEY_BLOB) + sizeof(PUBLIC_EXPONENT) + sizeof(KEY));
    BCRYPT_RSAKEY_BLOB &keyInfo = *reinterpret_cast<BCRYPT_RSAKEY_BLOB *>(&keyData.front());
    keyInfo.Magic = BCRYPT_RSAPUBLIC_MAGIC;
    keyInfo.BitLength = sizeof(KEY) * 8;
    keyInfo.cbPublicExp = sizeof(PUBLIC_EXPONENT);
    keyInfo.cbModulus = sizeof(KEY);
    keyInfo.cbPrime1 = 0;
    keyInfo.cbPrime2 = 0;
    unsigned char *ptr = &keyData[sizeof(BCRYPT_RSAKEY_BLOB)];
    for (unsigned int i = 0; i < sizeof(PUBLIC_EXPONENT); i++) {
      ptr[i] = PUBLIC_EXPONENT[i];
    }
    ptr = &keyData[sizeof(BCRYPT_RSAKEY_BLOB) + sizeof(PUBLIC_EXPONENT)];
    for (unsigned int i = 0; i < sizeof(KEY); i++) {
      ptr[i] = KEY[i];
    }
    BCRYPT_KEY_HANDLE keyRaw = NULL;
    if (!NT_SUCCESS(::BCryptImportKeyPair(alg, NULL, BCRYPT_RSAPUBLIC_BLOB, &keyRaw, &keyData.front(), keyData.size(), 0))) {
      return{ NULL, ::BCryptDestroyKey };
    }
    return{ keyRaw, ::BCryptDestroyKey };
  }

  bool decrypt(const unsigned char * const in, const unsigned int inSize, unsigned char * const out, const unsigned int outSize) {
    if (in == nullptr || out == nullptr || inSize != _countof(KEY) || outSize > MAX_DECRYPT_SIZE) {
      return false;
    }
    std::vector<unsigned char> buf(_countof(KEY));
    ULONG size = 0;
    if (!NT_SUCCESS(::BCryptEncrypt(key.get(), const_cast<unsigned char *>(in), inSize, NULL, NULL, 0, &buf.front(), buf.size(), &size, BCRYPT_PAD_NONE))) {
      return false;
    }
    if (!std::equal(&SIGNATURE_DATA[0], &SIGNATURE_DATA[_countof(SIGNATURE_DATA)], &buf.front())) {
      return false;
    }
    const std::vector<unsigned char>::const_iterator start = buf.begin() + _countof(SIGNATURE_DATA);
    const std::vector<unsigned char>::const_iterator end = start + outSize;
    std::copy(start, end, out);
    return true;
  }
};

class Dir : public boost::noncopyable {
public:
  const unsigned int nameHash;
  const unsigned int fileCount;
  Dir(const unsigned int nameHash, const unsigned int fileCount) : nameHash(nameHash), fileCount(fileCount) {
  }
  static std::shared_ptr<Dir> read(std::istream &in, DecryptEngine &engine) {
    unsigned char buf[_countof(KEY)];
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    unsigned int dirImpl[2];
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&dirImpl), sizeof(dirImpl))) {
      return{};
    }
    return std::make_shared<Dir>(dirImpl[0], dirImpl[1]);
  }
  static std::unique_ptr<std::vector<std::shared_ptr<Dir> > > readList(std::istream &in, DecryptEngine &engine, const unsigned int count) {
    std::unique_ptr<std::vector<std::shared_ptr<Dir> > > result = std::make_unique<std::vector<std::shared_ptr<Dir> > >();
    for (unsigned int i = 0; i < count; i++) {
      const std::shared_ptr<Dir> item = read(in, engine);
      if (!item) {
        return{};
      }
      result->push_back(item);
    }
    return result;
  }
};

class FileNameList : public boost::noncopyable {
public:
  const std::unique_ptr<std::vector<std::string> > list;
  FileNameList(std::unique_ptr<std::vector<std::string> > list) : list(std::move(list)) {}
  static std::unique_ptr<FileNameList> read(std::istream &in, DecryptEngine &engine) {
    unsigned char buf[_countof(KEY)];
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    struct {
      unsigned int compSize;
      unsigned int origSize;
      unsigned int blockCount;
    } info;
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&info), sizeof(info))) {
      return{};
    }
    if (info.compSize == 0 && info.origSize == 0 && info.blockCount == 0) {
      return std::make_unique<FileNameList>(std::make_unique<std::vector<std::string> >());
    }
    if ((info.compSize + (MAX_DECRYPT_SIZE - 1)) / MAX_DECRYPT_SIZE != info.blockCount) {
      return{};
    }
    std::vector<unsigned char> compData(info.compSize);
    for (unsigned int i = 0; i < info.blockCount; i++) {
      in.read(reinterpret_cast<char *>(buf), sizeof(buf));
      if (!in.good()) {
        return{};
      }
      const unsigned int readSize = std::min(compData.size() - i * MAX_DECRYPT_SIZE, MAX_DECRYPT_SIZE);
      if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&compData[i * MAX_DECRYPT_SIZE]), readSize)) {
        return{};
      }
    }
    std::vector<unsigned char> data(info.origSize);
    uLongf outSize = data.size();
    if (::uncompress(&data.front(), &outSize, &compData.front(), compData.size()) != Z_OK) {
      return{};
    }
    std::unique_ptr<std::vector<std::string > > list = std::make_unique<std::vector<std::string> >();
    const unsigned char *start = &data.front();
    for (unsigned int i = 0; i < data.size(); i++) {
      if (data[i] == '\0') {
        list->push_back(reinterpret_cast<const char *>(start));
        if (i + 1 == data.size()) {
          return std::make_unique<FileNameList>(std::move(list));
        }
        start = &data[i + 1];
        continue;
      }
    }
    return{};
  }
};

class FileInfo : public boost::noncopyable {
public:
  const unsigned int size;
  const unsigned int address;
  const unsigned int hash;
  const std::array<unsigned char, 16> key;
  FileInfo(const unsigned int size, const unsigned int address, const unsigned int hash, const std::array<unsigned char, 16> &key) :
    size(size), address(address), hash(hash), key(key)
  {
  }
  static std::shared_ptr<FileInfo> read(std::istream &in, DecryptEngine &engine) {
    unsigned char buf[_countof(KEY)];
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    struct {
      unsigned int size;
      unsigned int address;
    } info;
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&info), sizeof(info))) {
      return{};
    }
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    unsigned int hash;
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&hash), sizeof(hash))) {
      return{};
    }
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    std::array<unsigned char, 16> key;
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&key.front()), key.size())) {
      return{};
    }
    return std::make_shared<FileInfo>(info.size, info.address, hash, key);
  }
  static std::unique_ptr<std::vector<std::shared_ptr<FileInfo> > > readAll(std::istream &in, DecryptEngine &engine) {
    unsigned char buf[_countof(KEY)];
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    unsigned int count;
    if (!engine.decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&count), sizeof(count))) {
      return{};
    }
    std::unique_ptr<std::vector<std::shared_ptr<FileInfo> > > result = std::make_unique<std::vector<std::shared_ptr<FileInfo> > >();
    for (unsigned int i = 0; i < count; i++) {
      const std::shared_ptr<FileInfo> item = read(in, engine);
      if (!item) {
        return{};
      }
      result->push_back(item);
    }
    return result;
  }
};

} // anonymous

template<typename T>
class Th135ArchiveExtractorBase : public ExtractorBase {
private:
  std::istream &in;
  const std::unique_ptr<std::vector<std::shared_ptr<FileInfo> > > fileInfoList;
  const std::vector<std::filesystem::path> pathList;
  const unsigned int headerSize;

  // debug
  static std::map<unsigned int, std::wstring> dirHashList;
  static std::set<unsigned int> hashSet;
  static std::set<unsigned int> notfoundHashSet;

public:
  Th135ArchiveExtractorBase(std::istream &in, std::unique_ptr<std::vector<std::shared_ptr<FileInfo> > > fileInfoList, std::vector<std::filesystem::path> pathList, const unsigned int headerSize) :
    in(in), fileInfoList(std::move(fileInfoList)), pathList(std::move(pathList)), headerSize(headerSize)
  {
  }

  template<unsigned int KEY_SIZE>
  bool blockDecrypt(std::vector<unsigned char> &data, const std::array<unsigned char, KEY_SIZE> &key) {
    for (unsigned int i = 0; i < data.size(); i++) {
      data[i] = data[i] ^ key[i % KEY_SIZE];
    }
    return true;
  }

  static std::map<unsigned int, std::wstring> createDirHashMap() {
    std::map<unsigned int, std::wstring> result;
    for (const std::wstring &str : T::getDirNameList()) {
      if (str.empty()) {
        continue;
      }
      result.insert({ T::calcHash(Utility::wStrToStr(str)), str });
    }
    return result;
  }

  static std::wstring dirHashToName(const unsigned int hash) {
    static bool init = true;
    if (init) {
      dirHashList = createDirHashMap();
      for (const std::pair<unsigned int, std::wstring> &item : dirHashList) {
        hashSet.insert(item.first);
      }
      BOOST_ASSERT(hashSet.size() == dirHashList.size());
      init = false;
    }
    const std::map<unsigned int, std::wstring>::const_iterator it = dirHashList.find(hash);
    if (it == dirHashList.end()) {
      notfoundHashSet.insert(hash);
      return{};
    }
    hashSet.erase(hash);
    return it->second;
  }

  static std::vector<std::wstring> getExistDirNameList() {
    std::vector<std::wstring> result;
    for (const std::pair<unsigned int, std::wstring> &item : dirHashList) {
      const std::set<unsigned int>::const_iterator it = hashSet.find(item.first);
      if (it != hashSet.end()) {
        continue;
      }
      result.push_back(item.second);
    }
    std::sort(result.begin(), result.end());
    return result;
  }

  static bool isDirNameOk() {
    return hashSet.empty();
  }

  static const std::set<unsigned int> &getNotfoundHashSet() {
    return notfoundHashSet;
  }

  static std::shared_ptr<T> Open(std::istream &in, const unsigned long long int file_size) {
    if (!in.good()) {
      return{};
    }
    unsigned char signature[4];
    in.read(reinterpret_cast<char *>(signature), sizeof(signature));
    if (!in.good() || !std::equal(&signature[0], &signature[_countof(signature)], "TFPK")) {
      return{};
    }
    unsigned char version;
    in.read(reinterpret_cast<char *>(&version), sizeof(version));
    if (!in.good() || version != 0) {
      return{};
    }
    unsigned char buf[_countof(KEY)];
    in.read(reinterpret_cast<char *>(buf), sizeof(buf));
    if (!in.good()) {
      return{};
    }
    const std::unique_ptr<DecryptEngine> engine = DecryptEngine::create();
    if (!engine) {
      return{};
    }
    unsigned int dirCount;
    if (!engine->decrypt(buf, _countof(buf), reinterpret_cast<unsigned char *>(&dirCount), sizeof(dirCount))) {
      return{};
    }
    std::unique_ptr<std::vector<std::shared_ptr<Dir> > > dirList = Dir::readList(in, *engine, dirCount);
    if (!dirList) {
      return{};
    }
    const unsigned int fileCount = std::accumulate(dirList->begin(), dirList->end(), 0, [](const unsigned int cur, const std::shared_ptr<Dir> &item) {
      return cur + item->fileCount;
    });
    std::unique_ptr<FileNameList> fileNameList = FileNameList::read(in, *engine);
    if (!fileNameList || fileNameList->list->size() != fileCount) {
      return{};
    }
    std::unique_ptr<std::vector<std::shared_ptr<FileInfo> > > fileInfoList = FileInfo::readAll(in, *engine);
    if (!fileInfoList || fileInfoList->size() != fileCount) {
      return{};
    }
    const std::vector<std::filesystem::path> pathList = buildPathList(*dirList, *fileNameList, *fileInfoList);
    if (pathList.empty()) {
      return{};
    }
    // 使用されているディレクトリ一覧表示
    if (false && !isDirNameOk()) {
      std::wcout << boost::wformat(L"Error: 未使用のhashを含んでいます。\n");
      for (const std::wstring &name : getExistDirNameList()) {
        std::wcout << name << std::endl;
      }
      std::cin.get();
    }
    // searchFNV1Hash用情報出力
    if (false) {
      std::filesystem::path prevPath = L"data/";
      std::vector<unsigned int> targetList;
      for (unsigned int i = 0; i < pathList.size(); i++) {
        const FileInfo &info = *fileInfoList->at(i);
        const std::filesystem::path &path = pathList.at(i);
        const wchar_t hashSignature[] = L"data\\hash_";
        if (std::equal(&hashSignature[0], &hashSignature[_countof(hashSignature) - 1], path.wstring().begin())) {
          unsigned int hash = 0;
          ::swscanf_s(path.wstring().c_str(), L"data\\hash_%08x", &hash);
          targetList.push_back(hash);
          continue;
        }
        if (!targetList.empty()) {
          targetList.erase(std::unique(targetList.begin(), targetList.end()), targetList.end());
          std::vector<std::wstring> targetListW(targetList.size());
          std::transform(targetList.begin(), targetList.end(), targetListW.begin(), [](const unsigned int hash) {return (boost::wformat(L"0x%08x") % hash).str(); });
          const std::wstring target = boost::algorithm::join(targetListW, L", ");
          std::wcout << boost::wformat(L"{ L\"%s\", L\"%s\", {%s} },\n") % prevPath.wstring() % path.wstring() % target;
          targetList.clear();
        }
        prevPath = path;
      }
      std::cin.get();
    }
    // 全ファイル名をディレクトリhashと共に一覧表示
    if (false) {
      for (const std::filesystem::path &path : pathList) {
        const std::wstring dirPath = path.parent_path().wstring();
        const wchar_t hashSignature[] = L"data\\hash_";
        unsigned int hash = 0;
        if (!std::equal(&hashSignature[0], &hashSignature[_countof(hashSignature) - 1], path.wstring().begin())) {
          hash = T::calcHash(Utility::wStrToStr(dirPath) + '/');
        } else {
          ::swscanf_s(dirPath.c_str(), L"data\\hash_%08x", &hash);
        }
        std::wcout << boost::wformat(L"%08x\t%s\n") % hash % path;
      }
      std::cin.get();
    }
    // 不明フォルダhash一覧表示
    if (false) {
      const std::set<unsigned int> &hashSet = getNotfoundHashSet();
      std::wcout << boost::wformat(L"不明フォルダ名残り: %d\n") % hashSet.size();
      for (const unsigned int hash : hashSet) {
        std::wcout << boost::wformat(L"%08x\n") % hash;
      }
      std::cin.get();
    }
    return std::make_shared<T>(in, std::move(fileInfoList), std::move(pathList), static_cast<unsigned int>(in.tellg()));
  }
  static std::vector<std::filesystem::path> buildPathList(
    const std::vector<std::shared_ptr<Dir> > &dirList,
    const FileNameList &fileNameList,
    const std::vector<std::shared_ptr<FileInfo> > &fileInfoList)
  {
    std::map<unsigned int, std::variant<std::filesystem::path, std::pair<unsigned int, std::string> > > hashToPathMap;
    unsigned int index = 0;
    for (const std::shared_ptr<Dir> &dir : dirList) {
      for (unsigned int i = 0; i < dir->fileCount; i++, index++) {
        const std::string fileName = fileNameList.list->at(index);
        const unsigned int hash = T::calcHash(fileName, dir->nameHash);
        const std::wstring dirPath = dirHashToName(dir->nameHash);
        if (dirPath.empty()) {
          hashToPathMap.insert({ hash, std::make_pair(dir->nameHash, fileName) });
          continue;
        }
        const std::filesystem::path path = std::filesystem::path(dirPath) / fileName;
        hashToPathMap.insert({ hash, path });
      }
    }
    std::vector<std::variant<std::filesystem::path, std::pair<unsigned int, std::string> > > pathListRaw;
    for (const std::shared_ptr<FileInfo> &info : fileInfoList) {
      const std::map<unsigned int, std::variant<std::filesystem::path, std::pair<unsigned int, std::string> > >::const_iterator it = hashToPathMap.find(info->hash);
      if (it == hashToPathMap.end()) {
        return{};
      }
      pathListRaw.push_back(it->second);
    }
    std::filesystem::path prevPath = L"data/";
    std::vector<std::filesystem::path> pathList;
    std::vector<std::pair<unsigned int, std::string> > notFoundDirHashList;
    for (unsigned int i = 0; i < pathListRaw.size(); i++) {
      const std::variant<std::filesystem::path, std::pair<unsigned int, std::string> > &item = pathListRaw[i];
      if (item.index() == 1) {
        notFoundDirHashList.push_back(std::get<std::pair<unsigned int, std::string> >(item));
        continue;
      }
      const std::filesystem::path &path = std::get<std::filesystem::path>(item);
      if (!notFoundDirHashList.empty()) {
        std::filesystem::path dirPath;
        for (std::filesystem::path p = prevPath; !p.empty(); p = p.parent_path()) {
          for (std::filesystem::path n = path; !n.empty(); n = n.parent_path()) {
            if (p == n) {
              dirPath = p;
              break;
            }
          }
          if (!dirPath.empty()) {
            break;
          }
        }
        //dirPath = L"data"; // debug
        for (const std::pair<unsigned int, std::string> &info : notFoundDirHashList) {
          pathList.push_back(dirPath / (boost::wformat(L"hash_%08x") % info.first).str() / info.second);
        }
        notFoundDirHashList.clear();
      }
      prevPath = path;
      pathList.push_back(path);
    }
    return pathList;
  }

  bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
    const FileInfo &info = *fileInfoList->at(index);
    result.resize(info.size);
    if (result.empty()) {
      return true;
    }
    in.seekg(headerSize + info.address);
    in.read(reinterpret_cast<char *>(&result.front()), result.size());
    if (!in.good()) {
      return false;
    }
    if (!blockDecrypt(result, info.key)) {
      return false;
    }
    return true;
  }

  unsigned int GetSize() const {
    return fileInfoList->size();
  }

  std::filesystem::path GetFileName(unsigned int index) const {
    return pathList.at(index);
  }
};

template<typename T> std::map<unsigned int, std::wstring> Th135ArchiveExtractorBase<T>::dirHashList;
template<typename T> std::set<unsigned int> Th135ArchiveExtractorBase<T>::hashSet;
template<typename T> std::set<unsigned int> Th135ArchiveExtractorBase<T>::notfoundHashSet;

} // TH135

} // TouhouSE
