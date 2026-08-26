
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

namespace endian = boost::spirit::endian;

class Th135Palette : public ImageBase<Th135Palette>, boost::noncopyable {
private:
  const std::vector<Color> palette;
public:
  Th135Palette(const std::vector<Color> palette) : palette(std::move(palette)) {
  }
  static std::shared_ptr<Th135Palette> Open(const std::filesystem::path &fileName, std::istream &in, const unsigned long long int fileSize, ExtractorBase &extractor) {
    const std::vector<Color> palette = readPalette(in, fileSize);
    if (palette.empty()) {
      return{};
    }
    return std::make_shared<Th135Palette>(std::move(palette));
  }
  bool CreateRGBAArray(std::vector<Color> &result) const {
    result = palette;
    return true;
  }
  unsigned int GetWidth() const {
    return 16;
  }
  unsigned int GetHeight() const {
    return 16;
  }
};

class Th135PaletteConvertor : public ImageConverterBase<Th135Palette> { };

ADD_FILE_CONVERTER(Th135PaletteConvertor);

} // TH135

} // TouhouSE
