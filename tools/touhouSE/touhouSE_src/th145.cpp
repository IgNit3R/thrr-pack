#include "stdafx.h"

namespace TouhouSE {

namespace TH145 {

namespace {

class Owner : public ExtractorBase {
private:
  std::shared_ptr<ExtractorBase> ptr;

  Owner(std::shared_ptr<ExtractorBase> ptr) : ptr(ptr) {
  }

public:
  static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int fileSize) {
    const std::array<unsigned char, 64> rsaKey = {
      0xC6, 0x43, 0xE0, 0x9D, 0x35, 0x5E, 0x98, 0x1D, 0xBE, 0x63, 0x6D, 0x3A, 0x5F, 0x84, 0x0F, 0x49,
      0xB8, 0xE8, 0x53, 0xF5, 0x42, 0x06, 0x37, 0x3B, 0x36, 0x25, 0xCB, 0x65, 0xCE, 0xDD, 0x68, 0x8C,
      0xF7, 0x5D, 0x72, 0x0A, 0xC0, 0x47, 0xBD, 0xFA, 0x3B, 0x10, 0x4C, 0xD2, 0x2C, 0xFE, 0x72, 0x03,
      0x10, 0x4D, 0xD8, 0x85, 0x15, 0x35, 0x55, 0xA3, 0x5A, 0xAF, 0xC3, 0x4A, 0x3B, 0xF3, 0xE2, 0x37,
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
    return L"“Œ•û[”é˜^";
  }

  std::filesystem::path GetFileName(unsigned int index) const override {
    return ptr->GetFileName(index);
  }
};

} // anonymouse

ADD_DAT_EXTRACTOR(Owner);

} // TH145

} // TouhouSE
