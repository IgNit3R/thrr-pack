
#include "stdafx.h"

namespace TouhouSE {

namespace Squirrel3 {

class CNutConverter : public ConverterBase {
public:
  static bool Convert(
    const std::filesystem::path &path,
    const std::vector<unsigned char> &data,
    std::filesystem::path &resultPath,
    std::vector<unsigned char> &result,
    ExtractorBase &extractor)
  {
    const boost::iostreams::array_source source(reinterpret_cast<const char *>(&data.front()), reinterpret_cast<const char *>(&data.back() + 1));
    boost::iostreams::stream<boost::iostreams::array_source> in(source);
    const std::optional<TouhouSE::Squirrel3::CNut> cnut = TouhouSE::Squirrel3::CNut::read(in, data.size());
    if (!cnut) {
      return false;
    }
    const std::string str = boost::algorithm::replace_all_copy(cnut->toString(), "\n", "\r\n");
    result.clear();
    result.assign(str.begin(), str.end());
    resultPath = path;
    resultPath.replace_extension(".nut");
    return true;
  }
};

ADD_FILE_CONVERTER(CNutConverter);

} // Squirrel3

}// TouhouSE
