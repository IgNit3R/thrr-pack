#include "stdafx.h"

namespace TouhouSE {

namespace PNG {

namespace {

// PNGなファイルに拡張子をつけるだけの存在
class PngConvertor : public ConverterBase {
public:
   static bool Convert(
      const std::filesystem::path &path,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultPath,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor)
   {
      if (path.extension() == L".png" || data.size() < 4) {
         return false;
      }
      const std::array<unsigned char, 4> signature = {
         0x89, 0x50, 0x4E, 0x47,
      };
      if (!boost::equal(boost::make_iterator_range(data.begin(), data.begin() + signature.size()), signature)) {
         BOOST_ASSERT(path.extension() != L".png");
         return false;
      }
      resultPath = path;
      resultPath.replace_extension(L".png");
      result = data;
      return true;
   }
};

} // anonymouse

ADD_FILE_CONVERTER(PngConvertor);

} // PNG

} // TouhouSE
