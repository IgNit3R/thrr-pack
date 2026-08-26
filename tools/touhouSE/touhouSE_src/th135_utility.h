
namespace TouhouSE {

namespace TH135 {

std::vector<Color> readColor(
  std::vector<unsigned char>::const_iterator it,
  const unsigned int bitCount,
  const unsigned int colorCount,
  const std::vector<Color> * const palette);

std::vector<Color> readPalette(
  std::istream &in,
  const unsigned long long int fileSize);

std::wstring normalize(const std::wstring &in);

unsigned int calcFNV1aHash(const std::wstring &in, const unsigned int init = 0x811C9DC5);
unsigned int calcFNV1aHash2(const std::wstring &in, const unsigned int init = 0x811C9DC5);

} // TH135

} // TouhouSE
