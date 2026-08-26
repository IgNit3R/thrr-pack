#include "stdafx.h"

namespace NFA0_V2X {

namespace endian = boost::spirit::endian;

class Decryptor {
public:
  static void Decrypt(unsigned char * const buf, const unsigned int size) {
    for (const unsigned int i : boost::irange(size)) {
      unsigned char &c = buf[i];
      const unsigned char temp = (c ^ (c >> 4));
      c = rotateRight(temp ^ (temp << 4), 0xE7);
    }
  }

private:
  static unsigned char rotateRight(unsigned char c, unsigned int rawShift) {
    const unsigned int shift = rawShift % 8;
    return (c >> shift) + (c << (8 - shift));
  }
};

class Owner : public NFA0_V2_BASE::Owner<Owner, Decryptor> {
public:
  Owner(std::istream &in, const std::shared_ptr<const std::vector<NFA0_V2_BASE::FileRecord> > fileList) : NFA0_V2_BASE::Owner<Owner, Decryptor>(in, fileList) {
  }

  std::wstring GetName() const {
    return L"•sŽv‹c‚ÌŒ¶‘z‹½3";
  }
};

ADD_DAT_EXTRACTOR(Owner);

} // NFA0_V21
