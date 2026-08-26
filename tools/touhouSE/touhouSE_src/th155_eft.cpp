#include "stdafx.h"

namespace TouhouSE {

namespace TH155 {

namespace {

// Šg’£q‚É.eft‚ğ‚Â‚¯‚é‚½‚ß‚¾‚¯‚Ì‘¶İ
class Th155EftConvertor : public ConverterBase {
public:
   static bool Convert(
      const std::filesystem::path &path,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultPath,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor)
   {
      if (path.extension() == L".eft" || data.size() < 4 || *reinterpret_cast<const unsigned int*>(&data.front()) != '$tfe') {
         return false;
      }
      result = data;
      resultPath = path;
      resultPath.replace_extension(L".eft");
      return true;
   }
};

} // anonymouse

ADD_FILE_CONVERTER(Th155EftConvertor);

} // TH155

} // TouhouSE
