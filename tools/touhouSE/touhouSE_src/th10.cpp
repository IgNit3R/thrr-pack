#include "stdafx.h"

namespace TouhouSE {

namespace TH10 {

using namespace TouhouSE::SHANGHAI_ALICE;

class Owner : public ThOwnerBase<Owner, 0x1B, 0x37, 0x075BCD15, 0x3ADE68B1, 0x08180754, 0x3E, 0x9B, 0x80> {
public:

  Owner(std::istream &in, const unsigned long long int file_size, const std::shared_ptr<const Header> header, const std::shared_ptr<const std::vector<FileRecord> > file_list) :
    ThOwnerBase(in, file_size, header, file_list)
  {
  }

  const unsigned int *GetConvMap(const unsigned int index) {
	  static const unsigned int conv_map[8][4] = {
      {0x1b,	0x37,	0x0040,	0x2800},
      {0x51,	0xe9,	0x0040,	0x3000},
		  {0xc1,	0x51,	0x0080,	0x3200},
		  {0x03,	0x19,	0x0400,	0x7800},
		  {0xab,	0xcd,	0x0200,	0x2800},
		  {0x12,	0x34,	0x0080,	0x3200},
		  {0x35,	0x97,	0x0080,	0x2800},
		  {0x99,	0x37,	0x0400,	0x2000}
	  };
    BOOST_ASSERT(index < _countof(conv_map));
    return conv_map[index];
  }

  std::wstring GetName() const {
    return L"•—_˜^";
  }
};

ADD_DAT_EXTRACTOR(Owner);

} // TH10

} // TouhouSE
