
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

std::vector<Color> readColor(
  std::vector<unsigned char>::const_iterator it,
  const unsigned int bitCount,
  const unsigned int colorCount,
  const std::vector<Color> * const palette)
{
  std::vector<Color> result(colorCount);
  if (bitCount == 32) {
    for (Color &c : result) {
      c.b = it[0];
      c.g = it[1];
      c.r = it[2];
      c.alpha = it[3];
      it += 4;
    }
  }
  else if (bitCount == 24) {
    for (Color &c : result) {
      c.b = it[0];
      c.g = it[1];
      c.r = it[2];
      c.alpha = 0xFF;
      it += 3;
    }
  }
  else if (bitCount == 16) {
    for (Color &c : result) {
      c.b = (it[0] & 0x1F) * 255 / 0x1F;
      c.g = (((it[1] & 0x03) << 3) | ((it[0] & 0xE0) >> 5)) * 255 / 0x1F;
      c.r = ((it[1] & 0x7C) >> 2) * 255 / 0x1F;
      c.alpha = ((it[1] & 0x80) == 0 ? 0x00 : 0xFF);
      it += 2;
    }
  }
  else if (bitCount == 8) {
    for (Color &c : result) {
      const Color &pal = palette->at(*it);
      c = pal;
      it++;
    }
  }
  return result;
}

std::vector<Color> readPalette(
  std::istream &in,
  const unsigned long long int fileSize)
{
  const unsigned int headerSize = 4 + 1 + 4;
#pragma pack(push, 1)
  struct {
    char signature[4];
    unsigned char version;
    unsigned int compSize;
  } header;
#pragma pack(pop)
  if (fileSize < headerSize) {
    return{};
  }
  in.read(reinterpret_cast<char *>(&header), sizeof(header));
  if (!in.good() || !std::equal(&header.signature[0], &header.signature[_countof(header.signature)], "TFPA") || header.version != 0) {
    return{};
  }
  const unsigned int colorCount = 256;
  const unsigned int colorByteCount = sizeof(Color);
  const unsigned int origSize = (colorByteCount * colorCount) /* 32bit color */ + (2 * colorCount) /* 16bit color */;
  if (header.compSize == 0 || header.compSize >= origSize || fileSize - headerSize != header.compSize) {
    return{};
  }
  std::vector<unsigned char> temp(header.compSize);
  in.read(reinterpret_cast<char *>(&temp.front()), temp.size());
  if (!in.good()) {
    return{};
  }
  std::vector<unsigned char> data(origSize);
  uLongf origSizeResult = data.size();
  if (Z_OK != ::uncompress(reinterpret_cast<unsigned char *>(&data.front()), &origSizeResult, &temp.front(), header.compSize)) {
    return{};
  }
  /* 16bit palette */
  //return readColor(data.begin(), 16, colorCount, NULL);
  return readColor(data.begin() + 2 * colorCount, 32, colorCount, NULL);
}

std::wstring normalize(const std::wstring &in) {
  std::wstring temp;
  temp.resize(in.size());
  std::locale loc;
  std::transform(in.begin(), in.end(), temp.begin(), [&loc](const wchar_t c) {
    if (c == L'/') {
      return L'\\';
    }
    // ascii”ÍˆÍŠO•¶Žš‚È‚ç‚»‚Ì‚Ü‚Ü•Ô‚·
    if (c > 0xFF) {
      return c;
    }
    return std::tolower(c, loc);
  });
  return temp;
}

unsigned int calcFNV1aHash(const std::wstring &in, const unsigned int init) {
  const std::string temp = Utility::wStrToStr(normalize(in));
  return std::accumulate(temp.begin(), temp.end(), init, [](const unsigned int cur, const unsigned char c) {
    return (cur ^ c) * 0x1000193;
  });
}

unsigned int calcFNV1aHash2(const std::wstring &in, const unsigned int init) {
  const std::string temp = Utility::wStrToStr(normalize(in));
  return std::accumulate(temp.begin(), temp.end(), init, [](const unsigned int cur, const char c) {
    return (cur ^ c) * 0x1000193;
  });
}

} // TH135

} // TouhouSE
