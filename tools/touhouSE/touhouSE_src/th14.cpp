#include "stdafx.h"

namespace TouhouSE {

namespace TH14 {

using namespace TouhouSE::SHANGHAI_ALICE;

class Owner : public ThOwnerBase<Owner, 0x1B, 0x37, 0x075BCD15, 0x3ADE68B1, 0x08180754, 0x3E, 0x9B, 0x80> {
public:

  Owner(std::istream &in, const unsigned long long int file_size, const std::shared_ptr<const Header> header, const std::shared_ptr<const std::vector<FileRecord> > file_list) :
    ThOwnerBase(in, file_size, header, file_list)
  {
  }

  const unsigned int *GetConvMap(const unsigned int index) {
	  static const unsigned int conv_map[8][4] = {
      {0x1B,	0x73,	0x0100,	0x3800},
      {0x12,	0x43,	0x0200,	0x3E00},
		  {0x35,	0x79,	0x0400,	0x3C00},
		  {0x03,	0x91,	0x0080,	0x6400},
		  {0xab,	0xDC,	0x0080,	0x7000},
		  {0x51,	0x9E,	0x0100,	0x4000},
		  {0xC1,	0x15,	0x0400,	0x2C00},
		  {0x99,	0x7D,	0x0080,	0x4400}
	  };
    BOOST_ASSERT(index < _countof(conv_map));
    return conv_map[index];
  }

  std::wstring GetName() const {
    return L"‹Pjé";
  }
};

ADD_DAT_EXTRACTOR(Owner);

} // TH14

} // TouhouSE
