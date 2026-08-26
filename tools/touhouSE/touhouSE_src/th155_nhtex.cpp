#include "stdafx.h"

namespace TouhouSE {

namespace TH155 {

namespace {

class Th155NhtexConvertor : public ConverterBase {
public:
   static bool Convert(
      const std::filesystem::path &path,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultPath,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor) {
      if (data.size() < 52) {
         return false;
      }
      const std::array<unsigned char, 16> header1 = {
         0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      };
      const std::array<unsigned char, 16> header3 = {
         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      };
      if (!boost::equal(boost::make_iterator_range(data.begin(), data.begin() + 16), header1)
         || !boost::equal(boost::make_iterator_range(data.begin() + 32, data.begin() + 48), header3))
      {
         BOOST_ASSERT(path.extension() != L".nhtex");
         return false;
      }
      const unsigned int signature = *reinterpret_cast<const unsigned int *>(&data[48]);
      resultPath = path;
      if (signature == ' SDD') {
         resultPath.replace_extension(L".dds");
      } else if (signature == 0x474E5089) {
         resultPath.replace_extension(L".png");
      } else {
         return false;
      }
      result.assign(data.begin() + 48, data.end());
      return true;
   }
};

} // anonymouse

ADD_FILE_CONVERTER(Th155NhtexConvertor);

} // TH155

} // TouhouSE
