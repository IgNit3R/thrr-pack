
#include "stdafx.h"

namespace TouhouSE {

namespace TH145Trial {

namespace {

class Owner : public ExtractorBase {
private:
  std::shared_ptr<ExtractorBase> ptr;

  Owner(std::shared_ptr<ExtractorBase> ptr) : ptr(ptr) {
  }

public:
  static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int fileSize) {
    const std::array<unsigned char, 64> rsaKey = {
      0xA0, 0xA3, 0x90, 0x18, 0x81, 0x57, 0x61, 0x9E, 0x5E, 0xA2, 0x3E, 0x6D, 0x34, 0xCC, 0x07, 0x1C,
      0xA0, 0x2F, 0x44, 0xCC, 0xB5, 0xB2, 0xCB, 0x7A, 0xCC, 0xF6, 0x4F, 0x07, 0x74, 0x87, 0xB5, 0xAE,
      0xAB, 0x3F, 0x96, 0xA8, 0x4C, 0xE7, 0x6E, 0x55, 0xAC, 0xF3, 0xC9, 0x2A, 0x44, 0x87, 0xDD, 0xA2,
      0xB5, 0x9B, 0xE9, 0x4E, 0x46, 0x7A, 0x0D, 0x85, 0xA3, 0x0E, 0xCC, 0xDC, 0x9F, 0x84, 0xB6, 0x4D,
    };
    std::shared_ptr<ExtractorBase> ptr = TH145Pak::OpenTh145Pak(in, fileSize, rsaKey, TH145::FILE_NAME_LIST);
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
    return L"“Œ•û[”é˜^Web‘ÌŒ±”Å";
  }

  std::filesystem::path GetFileName(unsigned int index) const override {
    return ptr->GetFileName(index);
  }
};

} // anonymouse

ADD_DAT_EXTRACTOR(Owner);

} // TH145Trial

} // TouhouSE
