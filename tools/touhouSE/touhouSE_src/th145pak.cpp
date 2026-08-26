#include "stdafx.h"

namespace TouhouSE {

namespace TH145Pak {

namespace {

const unsigned char PUBLIC_EXPONENT[3] = {
   0x01, 0x00, 0x01,
};

const unsigned int MAX_DECRYPT_SIZE = 32;
const unsigned int BUF_SIZE = 64;

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
      : alg(std::move(alg)), key(std::move(key)) {
   }

   static std::unique_ptr<DecryptEngine> create(const std::array<unsigned char, 64> &keySrc) {
      BCRYPT_ALG_HANDLE algRaw = NULL;
      if (!NT_SUCCESS(::BCryptOpenAlgorithmProvider(&algRaw, BCRYPT_RSA_ALGORITHM, NULL, 0))) {
         return{};
      }
      std::unique_ptr<std::remove_pointer<BCRYPT_ALG_HANDLE>::type, decltype(&closeAlg::close)> alg(algRaw, &closeAlg::close);
      auto key = importRsaPublicKey(alg.get(), keySrc);
      if (!key) {
         return{};
      }
      return std::make_unique<DecryptEngine>(std::move(alg), std::move(key));
   }

   static std::unique_ptr<std::remove_pointer<BCRYPT_KEY_HANDLE>::type, decltype(&::BCryptDestroyKey)> importRsaPublicKey(BCRYPT_ALG_HANDLE alg, const std::array<unsigned char, 64> &key) {
      static std::vector<unsigned char> keyData(sizeof(BCRYPT_RSAKEY_BLOB) + sizeof(PUBLIC_EXPONENT) + key.size());
      BCRYPT_RSAKEY_BLOB &keyInfo = *reinterpret_cast<BCRYPT_RSAKEY_BLOB *>(&keyData.front());
      keyInfo.Magic = BCRYPT_RSAPUBLIC_MAGIC;
      keyInfo.BitLength = key.size() * 8;
      keyInfo.cbPublicExp = sizeof(PUBLIC_EXPONENT);
      keyInfo.cbModulus = key.size();
      keyInfo.cbPrime1 = 0;
      keyInfo.cbPrime2 = 0;
      unsigned char *ptr = &keyData[sizeof(BCRYPT_RSAKEY_BLOB)];
      for (unsigned int i = 0; i < sizeof(PUBLIC_EXPONENT); i++) {
         ptr[i] = PUBLIC_EXPONENT[i];
      }
      ptr = &keyData[sizeof(BCRYPT_RSAKEY_BLOB) + sizeof(PUBLIC_EXPONENT)];
      for (unsigned int i = 0; i < key.size(); i++) {
         ptr[i] = key[i];
      }
      BCRYPT_KEY_HANDLE keyRaw = NULL;
      if (!NT_SUCCESS(::BCryptImportKeyPair(alg, NULL, BCRYPT_RSAPUBLIC_BLOB, &keyRaw, &keyData.front(), keyData.size(), 0))) {
         return{ NULL, ::BCryptDestroyKey };
      }
      return{ keyRaw, ::BCryptDestroyKey };
   }

   bool decrypt(const unsigned char * const in, const unsigned int inSize, unsigned char * const out, const unsigned int outSize) {
      const unsigned int bufSize = BUF_SIZE;
      if (in == nullptr || out == nullptr || inSize != bufSize || outSize > MAX_DECRYPT_SIZE) {
         return false;
      }
      std::vector<unsigned char> buf(bufSize);
      ULONG size = 0;
      if (!NT_SUCCESS(::BCryptEncrypt(key.get(), const_cast<unsigned char *>(in), bufSize, NULL, NULL, 0, &buf.front(), buf.size(), &size, BCRYPT_PAD_NONE))) {
         return false;
      }
      unsigned char * const signatureEndIt = &buf[bufSize - outSize];
      if (buf[0] != 0x00 || buf[1] != 0x01 || signatureEndIt[-1] != 0x00 || std::find_if(&buf[2], signatureEndIt - 1, [](const unsigned char a) {return a != 0xFF; }) != signatureEndIt - 1) {
         return false;
      }
      const std::vector<unsigned char>::const_iterator start = buf.end() - outSize;
      const std::vector<unsigned char>::const_iterator end = buf.end();
      std::copy(start, end, out);
      return true;
   }
};

class FolderInfo {
public:
   unsigned int hash;
   unsigned int fileCount;
   std::vector<std::string> fileNameList;

   FolderInfo(const unsigned int hash, const unsigned int fileCount) : hash(hash), fileCount(fileCount) {
   }

   static std::shared_ptr<std::vector<std::shared_ptr<FolderInfo> > > Read(std::istream &in, DecryptEngine &engine) {
      auto result = std::make_shared<std::vector<std::shared_ptr<FolderInfo> > >();
      std::vector<std::shared_ptr<FolderInfo> > &folderList = *result;
      std::array<unsigned char, BUF_SIZE> buf;
      in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
      if (!in.good()) {
         return{};
      }
      unsigned int folderCount;
      if (!engine.decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&folderCount), sizeof(folderCount))) {
         return{};
      }
      if (folderCount == 0) {
         return result;
      }

      for (const unsigned int i : boost::irange(0U, folderCount)) {
         in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
         if (!in.good()) {
            return{};
         }
         unsigned int info[2];
         if (!engine.decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&info[0]), sizeof(info))) {
            return{};
         }
         folderList.push_back(std::make_shared<FolderInfo>(info[0], info[1]));
      }
      const unsigned int fileCount = std::accumulate(folderList.begin(), folderList.end(), 0U, [](const unsigned int result, const std::shared_ptr<const FolderInfo> folder) {
         return result + folder->fileCount;
      });
      if (fileCount == 0) {
         return result;
      }

      struct {
         unsigned int compressSize;
         unsigned int size;
         unsigned int blockCount;
      } fileNameListInfo;
      in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
      if (!in.good()) {
         return{};
      }
      if (!engine.decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&fileNameListInfo), sizeof(fileNameListInfo))) {
         return{};
      }
      std::vector<unsigned char> compressData(fileNameListInfo.compressSize);
      for (const unsigned int i : boost::irange(0U, fileNameListInfo.blockCount)) {
         in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
         if (!in.good()) {
            return{};
         }
         std::array<unsigned char, 32> temp;
         if (!engine.decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&temp[0]), temp.size())) {
            return{};
         }
         const unsigned int copySize = std::min(temp.size(), compressData.size() - i * temp.size());
         std::copy(temp.begin(), temp.begin() + copySize, compressData.begin() + i * temp.size());
      }
      std::vector<unsigned char> outData(fileNameListInfo.size);
      uLongf outSize = outData.size();
      ::uncompress(&outData[0], &outSize, &compressData[0], compressData.size());

      std::vector<std::string> fileNameList;
      for (std::vector<unsigned char>::const_iterator it = outData.begin();;) {
         const std::vector<unsigned char>::const_iterator findIt = std::find(it, const_cast<const std::vector<unsigned char> *>(&outData)->end(), '\0');
         if (findIt == outData.end()) {
            break;
         }
         fileNameList.push_back(std::string(it, findIt));
         it = findIt + 1;
      }
      if (fileNameList.size() != fileCount) {
         return{};
      }

      std::vector<std::string>::const_iterator it = fileNameList.begin();
      for (const std::shared_ptr<FolderInfo> folder : folderList) {
         for (const unsigned int i : boost::irange(0U, folder->fileCount)) {
            folder->fileNameList.push_back(*it);
            it++;
         }
      }
      return result;
   }
};

class FileInfo : boost::noncopyable {
public:
   unsigned int address;
   unsigned int size;
   unsigned int hash;
   unsigned int unknown;
   std::array<unsigned char, 16> key;

   FileInfo(const unsigned int address, const unsigned int size, const unsigned int hash, const unsigned int unknown, const std::array<unsigned char, 16> key)
      : address(address), size(size), hash(hash), unknown(unknown), key(key) {
   }
};

class FileInfoAndName : public boost::noncopyable {
public:
   std::shared_ptr<const FileInfo> info;
   std::wstring name;

   FileInfoAndName(const std::shared_ptr<const FileInfo> info, const std::wstring name) : info(info), name(name) {
   }
};

class Th145Impl : public ExtractorBase {
private:
   std::istream &in;
   const unsigned long long int fileSize;
   const std::vector<std::shared_ptr<FileInfoAndName> > fileList;

   Th145Impl(std::istream &in, const unsigned long long int fileSize, std::vector<std::shared_ptr<FileInfoAndName> > fileList) :
      in(in), fileSize(fileSize), fileList(std::move(fileList)) {
   }

public:
   static std::shared_ptr<Th145Impl> Open(std::istream &in, const unsigned long long int fileSize, const std::array<unsigned char, 64> &rsaKey, const FilenameArray &filenameList) {
      unsigned char signature[4];
      in.read(reinterpret_cast<char *>(signature), sizeof(signature));
      if (!in.good() || !std::equal(&signature[0], &signature[_countof(signature)], "TFPK")) {
         return{};
      }
      unsigned char version;
      in.read(reinterpret_cast<char *>(&version), sizeof(version));
      if (!in.good() || version != 1) {
         return{};
      }
      const std::unique_ptr<DecryptEngine> engine = DecryptEngine::create(rsaKey);
      if (!engine) {
         return{};
      }
      const std::shared_ptr<std::vector<std::shared_ptr<FolderInfo> > > folderList = FolderInfo::Read(in, *engine);
      if (!folderList) {
         return{};
      }
      std::array<unsigned char, BUF_SIZE> buf;
      in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
      if (!in.good()) {
         return{};
      }
      unsigned int fileCount;
      if (!engine->decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&fileCount), sizeof(fileCount))) {
         return{};
      }
      const unsigned int baseAddress = static_cast<unsigned int>(in.tellg()) + fileCount * (3 * BUF_SIZE);
      std::vector<std::shared_ptr<const FileInfo> > fileInfoList(fileCount);
      for (std::shared_ptr<const FileInfo> &ptr : fileInfoList) {
         in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
         if (!in.good()) {
            return{};
         }
         unsigned int sizeAndAddress[2];
         if (!engine->decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&sizeAndAddress), sizeof(sizeAndAddress))) {
            return{};
         }
         in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
         if (!in.good()) {
            return{};
         }
         unsigned int unknownList[2];
         if (!engine->decrypt(&buf[0], buf.size(), reinterpret_cast<unsigned char *>(&unknownList), sizeof(unknownList))) {
            return{};
         }
         in.read(reinterpret_cast<char *>(&buf[0]), buf.size());
         if (!in.good()) {
            return{};
         }
         std::array<unsigned char, 16> key;
         if (!engine->decrypt(&buf[0], buf.size(), &key[0], key.size())) {
            return{};
         }
         const unsigned int size = sizeAndAddress[0] ^ *reinterpret_cast<const unsigned int *>(&key[0]);
         const unsigned int address = baseAddress + (sizeAndAddress[1] ^ *reinterpret_cast<const unsigned int *>(&key[4]));
         const unsigned int hash = (~(unknownList[0] ^ *reinterpret_cast<const unsigned int *>(&key[8]))) + 1;
         const unsigned int unknown3 = unknownList[1] ^ *reinterpret_cast<const unsigned int *>(&key[12]);
         *reinterpret_cast<unsigned int *>(&key[0]) = (~*reinterpret_cast<const unsigned int *>(&key[0])) + 1;
         *reinterpret_cast<unsigned int *>(&key[4]) = (~*reinterpret_cast<const unsigned int *>(&key[4])) + 1;
         *reinterpret_cast<unsigned int *>(&key[8]) = (~*reinterpret_cast<const unsigned int *>(&key[8])) + 1;
         *reinterpret_cast<unsigned int *>(&key[12]) = (~*reinterpret_cast<const unsigned int *>(&key[12])) + 1;
         ptr.reset(new FileInfo(address, size, hash, unknown3, key));
      }
      std::map<unsigned int, std::wstring> fileNameHash;
      for (const std::wstring &fileName : filenameList) {
         if (fileName.empty()) {
            continue;
         }
         const unsigned int hash = TH135::calcFNV1aHash2(fileName);
         if (fileNameHash.find(hash) != fileNameHash.end()) {
            continue;
         }
         fileNameHash[hash] = fileName;
      }
      // backgroundをbgXXの部分だけ書き換えて探索する
      if (false) {
         std::vector<std::wstring> bgList;
         std::ifstream ifs("C:/Users/sweetie/Desktop/th155tools/log/try_bg.txt");
         while (true) {
            char lineBuf[256];
            ifs.getline(lineBuf, _countof(lineBuf));
            if (!ifs.good()) {
               break;
            }
            const std::wstring fileName = Utility::strToWStr(std::string(lineBuf));
            if (fileName.empty()) {
               continue;
            }
            const std::wstring pathFragment(fileName.begin() + 21, fileName.end()); // bgXXの後のパスだけ取り出す
            for (const unsigned int i : boost::irange(1, 47)) {
               bgList.push_back((boost::wformat(L"data/backGround/bg%02d/%s") % i % pathFragment).str());
            }
         }
         ifs.close();
         for (const std::wstring &fileName : bgList) {
            if (fileName.empty()) {
               continue;
            }
            const unsigned int hash = TH135::calcFNV1aHash2(fileName);
            if (fileNameHash.find(hash) != fileNameHash.end()) {
               continue;
            }
            fileNameHash[hash] = fileName;
         }
      }
      // 追加のファイルリストをファイルから読み込むデバッグ機能
      if (false) {
         std::ifstream ifs(L"C:/Users/sweetie/Desktop/temp2.txt");
         while (true) {
            char lineBuf[256];
            ifs.getline(lineBuf, _countof(lineBuf));
            if (!ifs.good()) {
               break;
            }
            const std::wstring fileName = Utility::strToWStr(std::string(lineBuf));
            if (fileName.empty()) {
               continue;
            }
            const unsigned int hash = TH135::calcFNV1aHash2(fileName);
            if (fileNameHash.find(hash) != fileNameHash.end()) {
               continue;
            }
            fileNameHash[hash] = fileName;
         }
         ifs.close();
      }
      std::vector<std::shared_ptr<FileInfoAndName> > fileList(fileInfoList.size());
      for (const unsigned int i : boost::irange(0U, fileList.size())) {
         std::shared_ptr<FileInfoAndName> &out = fileList[i];
         const std::shared_ptr<const FileInfo> &info = fileInfoList[i];
         const auto it = fileNameHash.find(info->hash);
         std::wstring fileName;
         if (it == fileNameHash.end()) {
            fileName = (boost::wformat(L"data/hash_%08X") % info->hash).str();
         } else {
            fileName = it->second;
            // 実際に存在するファイル名を出力する
            if (false) {
               std::wcout << fileName << std::endl;
            }
         }
         out.reset(new FileInfoAndName(info, fileName));
      }
      // 出力ディレクトリを判明している範囲で考慮する
      if (true) {
         std::filesystem::path prevPath = L"data/";
         std::vector<std::shared_ptr<FileInfoAndName> > targetList;
         for (const auto file : fileList) {
            const auto it = fileNameHash.find(file->info->hash);
            if (it == fileNameHash.end()) {
               targetList.push_back(file);
               continue;
            }
            if (!targetList.empty()) {
               std::filesystem::path p = prevPath;
               std::filesystem::path n = file->name;
               std::filesystem::path outDir;
               while (true) {
                  if (p == n) {
                     outDir = p;
                     break;
                  }
                  if (p.wstring().size() > n.wstring().size()) {
                     p = p.parent_path();
                  } else {
                     n = n.parent_path();
                  }
               }
               for (const auto target : targetList) {
                  const std::filesystem::path path = outDir / (boost::wformat(L"hash_%08X") % target->info->hash).str();
                  target->name = path.wstring();
               }
               targetList.clear();
            }
            prevPath = file->name;
         }
      }
      // 全ファイル名をhashと共に一覧表示
      if (false) {
         for (const std::shared_ptr<const FileInfoAndName> &file : fileList) {
            std::wcout << boost::wformat(L"%08X\t%s\n") % file->info->hash % file->name;
         }
         std::wcin.get();
      }
      // searchFNV1Hash用情報出力
      if (false) {
         std::wstring prevPath = L"data/";
         std::vector<unsigned int> targetList;
         std::vector<std::wstring> resultList;
         for (const auto file : fileList) {
            const auto it = fileNameHash.find(file->info->hash);
            if (it == fileNameHash.end()) {
               targetList.push_back(file->info->hash);
               continue;
            }
            if (!targetList.empty()) {
               targetList.erase(std::unique(targetList.begin(), targetList.end()), targetList.end());
               std::vector<std::wstring> targetListW(targetList.size());
               std::transform(targetList.begin(), targetList.end(), targetListW.begin(), [](const unsigned int hash) {return (boost::wformat(L"0x%08x") % hash).str(); });
               const std::wstring target = boost::algorithm::join(targetListW, L", ");
               resultList.push_back((boost::wformat(L"{ L\"%s\", L\"%s\", {%s} },\n") % prevPath % file->name % target).str());
               targetList.clear();
            }
            prevPath = file->name;
         }
         std::sort(resultList.begin(), resultList.end(), [](const auto &a, const auto &b) {
            return a.size() > b.size();
         });
         for (const auto &item : resultList) {
            std::wcout << item;
         }
         std::cin.get();
      }
      // ファイル名が不明な物は出力しない
      if (false) {
         for (unsigned int i = 0; i < fileList.size(); i++) {
            const auto file = fileList[i];
            const auto it = fileNameHash.find(file->info->hash);
            if (it == fileNameHash.end()) {
               fileList.erase(fileList.begin() + i);
               i--;
               continue;
            }
         }
      }
      return std::shared_ptr<Th145Impl>(new Th145Impl(in, fileSize, std::move(fileList)));
   }

   void Decrypt(std::vector<unsigned char> &data, const FileInfo &info) {
      const unsigned int dataSize = data.size();
      data.resize((data.size() + 3) / 4 * 4);
      unsigned int key2 = *reinterpret_cast<const unsigned int *>(&info.key[0]);
      for (unsigned int i = 0; i < data.size(); i += 4) {
         const unsigned int temp = *reinterpret_cast<unsigned int *>(&data[i]);
         *reinterpret_cast<unsigned int *>(&data[i]) = (*reinterpret_cast<const unsigned int *>(&data[i]) ^ *reinterpret_cast<const unsigned int *>(&info.key[i & 0x0F])) ^ key2;
         key2 = temp;
      }
      data.resize(dataSize);
   }

   bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
      const FileInfo &item = *fileList[index]->info;
      result.resize(item.size);
      if (result.empty()) {
         return true;
      }
      in.seekg(item.address);
      in.read(reinterpret_cast<char *>(&result.front()), result.size());
      if (!in.good()) {
         return false;
      }
      Decrypt(result, item);
      return true;
   }

   unsigned int GetSize() const {
      return fileList.size();
   }

   std::wstring GetName() const {
      return L"東方深秘録";
   }

   std::filesystem::path GetFileName(unsigned int index) const {
      return fileList[index]->name;
   }
};

// 拡張子に.matをつけるためだけの存在
class Th145MatConvertor : public ConverterBase {
public:
   static bool Convert(
      const std::filesystem::path &path,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultPath,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor) {
      if (data.size() < 20) {
         return false;
      }
      const std::array<unsigned char, 16> header = {
         0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
      };
      if (!boost::equal(boost::make_iterator_range(data.begin(), data.begin() + 16), header)) {
         BOOST_ASSERT(path.extension() != L".mat");
         return false;
      }
      const unsigned int count = *reinterpret_cast<const unsigned int *>(&data[16]);
      if (count == 0 || data.size() < 16 + 4 + count) {
         return false;
      }
      const std::string fileName(data.begin() + 16 + 4, data.begin() + 16 + 4 + count);
      // デバッグ出力
      if (false) {
         std::cout << boost::format("%s: %s\n") % path.string() % fileName;
      }
      if (path.extension() == L".mat") {
         return false;
      }
      result = data;
      resultPath = path;
      resultPath.replace_extension(L".mat");
      return true;
   }
};

ADD_FILE_CONVERTER(Th145MatConvertor);

} // anonymouse

std::shared_ptr<ExtractorBase> OpenTh145Pak(std::istream &in, const unsigned long long int fileSize, const std::array<unsigned char, 64> &rsaKey, const FilenameArray &filenameList) {
   return Th145Impl::Open(in, fileSize, rsaKey, filenameList);
}

} // TH145Pak

} // TouhouSE
