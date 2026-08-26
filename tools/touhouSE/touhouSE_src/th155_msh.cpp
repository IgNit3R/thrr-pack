#include "stdafx.h"

namespace TouhouSE {

namespace TH155 {

namespace {

// ägí£éqÇ….mshÇÇ¬ÇØÇÈÇΩÇﬂÇæÇØÇÃë∂ç›
class Th155MshConvertor : public ConverterBase {
public:
   static bool Convert(
      const std::filesystem::path &path,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultPath,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor)
   {
      const std::array<unsigned char, 16> header = {
         0x11, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
      };
      if (path.extension() == L".msh" || data.size() < 59
         || !boost::equal(boost::make_iterator_range(data.begin(), data.begin() + 16), header)
         || *reinterpret_cast<const unsigned int*>(&data.front() + 0x37) != 'toor')
      {
         BOOST_ASSERT(path.extension() != L".msh");
         return false;
      }
      result = data;
      resultPath = path;
      resultPath.replace_extension(L".msh");
      return true;
   }
};

} // anonymouse

ADD_FILE_CONVERTER(Th155MshConvertor);

} // TH155

} // TouhouSE
