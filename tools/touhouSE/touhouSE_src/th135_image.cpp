
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

namespace {

void error(const std::filesystem::path &path, const unsigned int id) {
  std::wcout << boost::wformat(L"Error: 不明なTFBM形式です、code=%d(%s)。\n") % id % path;
  std::cin.get();
}

std::filesystem::path createPalettePath1(const std::filesystem::path &path) {
  std::filesystem::path origFilenameBase = path.filename();
  origFilenameBase.replace_extension();
  const std::wstring &baseStr = origFilenameBase.wstring();
  const std::locale loc;
  const std::wstring::const_iterator findIt = std::find_if(baseStr.begin(), baseStr.end(), [&loc](const wchar_t c) {return std::isdigit(c, loc); });
  if (findIt == baseStr.end()) {
    return{};
  }
  return path.parent_path() / (boost::wformat(L"palette%s.bmp") % std::wstring(findIt, baseStr.end())).str();
}
std::filesystem::path createPalettePath2(const std::filesystem::path &path) {
  return path.parent_path() / L"palette000.bmp";
}
std::filesystem::path createPalettePathFromGlobalConfig(const std::filesystem::path &path) {
  return path.parent_path() / (boost::wformat(L"palette%s.bmp") % DatExtractor::GetInstance().getPaletteId()).str();
}
unsigned int findPath(const std::filesystem::path &path, ExtractorBase &extractor) {
  if (path.empty()) {
    return UINT_MAX;
  }
  for (unsigned int i = 0; i < extractor.GetSize(); i++) {
    if (extractor.GetFileName(i) == path) {
      return i;
    }
  }
  return UINT_MAX;
}
unsigned int searchPalettePath1(const std::filesystem::path &path, ExtractorBase &extractor) {
  return findPath(createPalettePath1(path), extractor);
}
unsigned int searchPalettePath2(const std::filesystem::path &path, ExtractorBase &extractor) {
  return findPath(createPalettePath2(path), extractor);
}
unsigned int searchPalettePathFromGlobalConfig(const std::filesystem::path &path, ExtractorBase &extractor) {
  return findPath(createPalettePathFromGlobalConfig(path), extractor);
}
unsigned int searchPalettePath(const std::filesystem::path &path, ExtractorBase &extractor) {
  if (!DatExtractor::GetInstance().getPaletteId().empty()) {
     return searchPalettePathFromGlobalConfig(path, extractor);
  }
  const unsigned int result1 = searchPalettePath1(path, extractor);
  if (result1 != UINT_MAX) {
    return result1;
  }
  return searchPalettePath2(path, extractor);
}

std::vector<Color> loadPaletteFromTFPA(const std::vector<unsigned char> &data) {
  const boost::iostreams::array_source source(reinterpret_cast<const char *>(&data.front()), reinterpret_cast<const char *>(&data.back() + 1));
  boost::iostreams::stream<boost::iostreams::array_source> in(source);
  return readPalette(in, data.size());
}

std::vector<Color> loadPaletteFromPng(const std::vector<unsigned char> &data) {
   Png png;
   if (!TouhouSE::PNG::FromPng(data, png) || png.w != 16 || png.h != 16 || png.cn != 32) {
      return{};
   }
   return png.col;
}

std::vector<Color> loadPaletteFromPng(const std::filesystem::path &path) {
  std::ifstream ifs(path, std::ios::binary);
  std::vector<unsigned char> data(static_cast<unsigned int>(std::filesystem::file_size(path)));
  if (data.empty()) {
    return{};
  }
  ifs.read(reinterpret_cast<char *>(&data.front()), data.size());
  if (!ifs.good()) {
    return{};
  }
  ifs.close();
  return loadPaletteFromPng(data);
}

std::vector<Color> loadPaletteFromExtractor(const std::filesystem::path &path, ExtractorBase &extractor) {
  const unsigned int index = searchPalettePath(path, extractor);
  if (index == UINT_MAX) {
    return{};
  }
  std::vector<unsigned char> paletteData;
  if (!extractor.Extract(index, paletteData)) {
    return{};
  }
  return loadPaletteFromTFPA(paletteData);
}

std::vector<Color> loadPaletteFromFile(const std::filesystem::path &path) {
  const auto toPng = [](std::filesystem::path path) {path.replace_extension(".png"); return path; };
  std::vector<std::filesystem::path> pathList;
  pathList.push_back(createPalettePath1(path));
  pathList.push_back(toPng(pathList.back()));
  pathList.push_back(createPalettePath2(path));
  pathList.push_back(toPng(pathList.back()));
  for (const std::filesystem::path &palettePath : pathList) {
    if (std::filesystem::is_regular_file(palettePath)) {
      return loadPaletteFromPng(palettePath);
    }
  }
  return{};
}

std::vector<Color> loadPaletteFromCommandline() {
   static std::vector<Color> cache;
   if (!cache.empty()) {
      return cache;
   }
   const std::filesystem::path &path = DatExtractor::GetInstance().getColorPalettePath();
   if (path.empty() || !std::filesystem::exists(path) || !std::filesystem::is_regular_file(path)) {
      return {};
   }
   const unsigned long long int size = std::filesystem::file_size(path);
   if (size <= 0 || size >= 1 * 1024 * 1024 * 1024) {
      return {};
   }
   std::vector<unsigned char> data;
   data.resize(static_cast<unsigned int>(size));
   std::ifstream ifs(path, std::ios::binary);
   ifs.read(reinterpret_cast<char *>(&data.front()), size);
   if (!ifs.good()) {
      return {};
   }
   ifs.close();
   for (auto loadPalette : {loadPaletteFromTFPA, loadPaletteFromPng}) {
      const std::vector<Color> result = loadPalette(data);
      if (!result.empty()) {
         cache = result;
         return result;
      }
   }
   return {};
}

std::vector<Color> loadPalette(const std::filesystem::path &path, ExtractorBase &extractor) {
  const std::vector<Color> commandlinePalette = loadPaletteFromCommandline();
  if (!commandlinePalette.empty()) {
     return commandlinePalette;
  }
  const std::vector<Color> palette1 = loadPaletteFromExtractor(path, extractor);
  if (!palette1.empty()) {
    return palette1;
  }
  return loadPaletteFromFile(path);
}

} // anonymouse

namespace endian = boost::spirit::endian;

class Th135Image : public ImageBase<Th135Image>, boost::noncopyable {
private:
#pragma pack(push, 1)
  struct Header {
    char signature[4];
    unsigned char version;
    unsigned char bitCount;
    unsigned int width; // 見た目上の幅
    unsigned int height;
    unsigned int width2; // 実際の幅、widthより広い分にはゴミデータなどが配置される
    unsigned int compSize;
  };
#pragma pack(pop)
  const Header header;
  const std::vector<unsigned char> data;
  const std::vector<Color> palette;
public:
  Th135Image(const Header &header, const std::vector<unsigned char> data, const std::vector<Color> palette)
    :header(header), data(std::move(data)), palette(std::move(palette))
  {
  }
  static std::shared_ptr<Th135Image> Open(const std::filesystem::path &fileName, std::istream &in, const unsigned long long int fileSize, ExtractorBase &extractor) {
    const unsigned int headerSize = sizeof(Header);
    if (fileSize < headerSize) {
      return{};
    }
    Header header;
    in.read(reinterpret_cast<char *>(&header), sizeof(Header));
    if (!in.good() || !std::equal(&header.signature[0], &header.signature[4], "TFBM") || header.width2 < header.width
      || header.version != 0 || header.bitCount % 8 != 0 || header.compSize + headerSize != fileSize
      || (header.bitCount != 32 && header.bitCount != 8 && header.bitCount != 16 && header.bitCount != 24))
    {
      return{};
    }
    const unsigned int origSize = header.width2 * header.height * (header.bitCount / 8);
    // 圧縮したら容量が増える場合は圧縮しない、なんてことはしていないようなのでチェックしない
    std::vector<unsigned char> temp(header.compSize);
    in.read(reinterpret_cast<char *>(&temp.front()), header.compSize);
    if (!in.good()) {
      error(fileName, 3);
      return{};
    }
    std::vector<unsigned char> data(origSize);
    uLongf origSizeResult = origSize;
    if (Z_OK != ::uncompress(&data.front(), &origSizeResult, &temp.front(), temp.size()) || origSizeResult != origSize) {
      error(fileName, 4);
      return{};
    }
    std::vector<Color> palette;
    if (header.bitCount == 8) {
      palette = loadPalette(fileName, extractor);
      if (palette.empty()) {
        static bool errorViewFlag = true;
        if (errorViewFlag) {
          std::wcout << L"Error: パレットの読み込みに失敗しました、いくつかのファイルが無変換で出力されます。\n";
          std::wcout << L"Tips: 別ファイルにパレットが含まれている場合、そちらを展開した上に展開すると動作する場合があります。\n";
          errorViewFlag = false;
        }
        return{};
      }
    }
    return std::make_shared<Th135Image>(header, std::move(data), std::move(palette));
  }
  bool CreateRGBAArray(std::vector<Color> &result) const {
    const std::vector<Color> temp = readColor(data.begin(), header.bitCount, header.width2 * header.height, &palette);
    if (header.width == header.width2) {
      result = std::move(temp);
      return true;
    }
    result.resize(header.width * header.height);
    std::vector<Color>::iterator outIt = result.begin();
    std::vector<Color>::const_iterator inIt = temp.begin();
    const unsigned int skipSize = header.width2 - header.width;
    for (unsigned int h = 0; h < header.height; h++) {
      for (unsigned int w = 0; w < header.width; w++) {
        *outIt = *inIt;
        outIt++;
        inIt++;
      }
      inIt += skipSize;
    }
    return true;
  }
  unsigned int GetWidth() const {
    return header.width;
  }
  unsigned int GetHeight() const {
    return header.height;
  }
};

class Th135ImageConvertor : public ImageConverterBase<Th135Image> { };

ADD_FILE_CONVERTER(Th135ImageConvertor);

} // TH135

} // TouhouSE
