
#include "stdafx.h"

namespace TouhouSE {

namespace STEINS_GATE_ZERO {

namespace {

class FileRecord : boost::noncopyable {
public:
   const unsigned int index;
   const unsigned long long int address;
   const unsigned long long int size;
   const std::filesystem::path path;

   FileRecord(
      const unsigned int index,
      const unsigned long long int address,
      const unsigned long long int size,
      const std::filesystem::path path)
      :
      index(index), address(address), size(size), path(path)
   {}

   static std::shared_ptr<FileRecord> Read(std::istream &in, const std::filesystem::path &dir = std::filesystem::path()) {
      std::array<unsigned char, 256> buffer;
      if (!in.good()) {
         return{};
      }
      in.read(reinterpret_cast<char *>(&buffer.front()), buffer.size());
      if (!in.good()) {
         return{};
      }
      const unsigned int index = *reinterpret_cast<unsigned int *>(&buffer[0]);
      const unsigned long long int address = *reinterpret_cast<unsigned int *>(&buffer[4]);
      const unsigned long long int size = *reinterpret_cast<unsigned int *>(&buffer[12]);
      const unsigned long long int size2 = *reinterpret_cast<unsigned int *>(&buffer[20]);
      if (size != size2 || buffer[28] == '/' || buffer[28] == '\\') {
         return{};
      }
      // ファイルパス領域内が0クリアされていなかったら失敗を返す
      const auto it = std::find_if(buffer.begin() + 28 + ::strlen(reinterpret_cast<const char *>(&buffer[28])), buffer.end(),[](const unsigned char value) {return value != '\0';});
      if (it != buffer.end()) {
         return{};
      }
      // パスに..が含まれていたら失敗を返す
      const std::string target = "..";
      const auto it2 = std::search(buffer.begin() + 28 + ::strlen(reinterpret_cast<const char *>(&buffer[28])), buffer.end(), target.begin(), target.end());
      if (it2 != buffer.end()) {
         return{};
      }
      const std::filesystem::path path = dir / reinterpret_cast<const char *>(&buffer[28]);
      return std::make_shared<FileRecord>(index, address, size, path);
   }
};

} // anonymouse

class Owner : public ExtractorBase {
private:
   std::istream &in;
   const std::shared_ptr<const std::vector<std::shared_ptr<const FileRecord> > > file_record_list;

   Owner(std::istream &in, const std::shared_ptr<const std::vector<std::shared_ptr<const FileRecord> > > file_record_list) : in(in), file_record_list(file_record_list) {
   }

public:
   static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int file_size) {
      std::array<unsigned char, 68> buffer;
      if (!in.good()) {
         return{};
      }
      in.read(reinterpret_cast<char *>(&buffer.front()), buffer.size());
      if (!in.good()) {
         return{};
      }
      if (!std::equal(buffer.begin() + 0, buffer.begin() + 4, "MPK\0") // シグネチャチェック
         && *reinterpret_cast<const unsigned int *>(&buffer[4]) != 0x00020000 // 固定値チェック(フォーマットバージョンかなにか)
         && std::find_if(buffer.begin() + 12, buffer.end(), [](const unsigned char it) {return it != 0;}) != buffer.end()) // 現状0で埋まってる部分をチェック
      {
         return{};
      }
      const unsigned int count = *reinterpret_cast<const unsigned int *>(&buffer[8]);
      std::shared_ptr<std::vector<std::shared_ptr<const FileRecord> > > list = std::make_shared<std::vector<std::shared_ptr<const FileRecord> > >();
      const std::filesystem::path dir = std::filesystem::path(dat_name).filename().replace_extension();
      list->reserve(count);
      for (const unsigned int index : boost::irange(0U, count)) {
         const std::shared_ptr<const FileRecord> item = FileRecord::Read(in, dir);
         if (!item || item->index != index || item->address >= file_size || item->address + item->size > file_size) {
            return{};
         }
         list->push_back(item);
      }
      return std::shared_ptr<Owner>(new Owner(in, list));
   }

   bool Extract(const unsigned int index, std::vector<unsigned char> &result) override {
      const FileRecord &record = *file_record_list->at(index);
      in.seekg(record.address);
      result.resize(static_cast<unsigned int>(record.size));
      in.read(reinterpret_cast<char *>(&result.front()), record.size);
      if (!in.good()) {
         return false;
      }
      return true;
   }

   unsigned int GetSize() const override {
      return file_record_list->size();
   }

   std::wstring GetName() const override {
      return L"Steins;Gate0";
   }

   std::filesystem::path GetFileName(unsigned int index) const override {
      return file_record_list->at(index)->path;
   }
};

ADD_DAT_EXTRACTOR(Owner);

} // STEINS_GATE_ZERO

} // ToudouSE
