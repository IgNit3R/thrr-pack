#include "stdafx.h"

namespace TouhouSE {

namespace TH155 {

namespace {

class Owner : public ExtractorBase {
private:
   std::shared_ptr<ExtractorBase> ptr;

   Owner(std::shared_ptr<ExtractorBase> ptr) : ptr(ptr) {
   }

public:
   static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int fileSize) {
      const std::array<unsigned char, 64> rsaKey = {
         0xC4, 0x4D, 0x6A, 0x2F, 0x05, 0x78, 0x2C, 0x0F, 0xD7, 0x5C, 0x82, 0x97, 0x17, 0x60, 0x91, 0xDD,
         0x6F, 0x83, 0x61, 0x81, 0xD1, 0x4E, 0x06, 0x9B, 0x94, 0x37, 0xD2, 0x98, 0x4D, 0xE4, 0x7B, 0xBF,
         0x42, 0x60, 0xA7, 0x8F, 0x88, 0xD6, 0xFD, 0xFE, 0xE1, 0xF5, 0x6A, 0x0B, 0x29, 0xCF, 0x0B, 0xED,
         0x66, 0xF0, 0xAC, 0x4E, 0xD7, 0xEF, 0x96, 0x06, 0x8B, 0xFA, 0x8E, 0x33, 0x48, 0xA3, 0x02, 0x7D,
      };
      std::shared_ptr<ExtractorBase> ptr = TH145Pak::OpenTh145Pak(in, fileSize, rsaKey, FILE_NAME_LIST);
      if (!ptr) {
         return{};
      }
      return std::shared_ptr<Owner>(new Owner(ptr));
   }

   bool Extract(const unsigned int index, std::vector<unsigned char> &result) override {
      return ptr->Extract(index, result);
   }

   unsigned int GetSize() const override {
      return ptr->GetSize();
   }

   std::wstring GetName() const override {
      return L"“Œ•ûœßˆË‰Ø";
   }

   std::filesystem::path GetFileName(unsigned int index) const override {
      return ptr->GetFileName(index);
   }
};

} // anonymouse

ADD_DAT_EXTRACTOR(Owner);

} // TH155

} // TouhouSE
