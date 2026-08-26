
#include "stdafx.h"

namespace TouhouSE {

namespace MSG {

namespace endian = boost::spirit::endian;
class MsgConverter : public ConverterBase {
public:
	static bool Convert(
    const std::filesystem::path &path,
    const std::vector<unsigned char> &data,
    std::filesystem::path &resultPath,
    std::vector<unsigned char> &result,
    ExtractorBase &extractor)
  {
    if (data.size() < 12) {
      return false;
    }
    const unsigned int count = *reinterpret_cast<const unsigned int *>(&data.front());
    if (data.size() < 4 + count * 8) {
      return false;
    }
    for (unsigned int i = 0; i < count; i++) {
      const unsigned int addr = *reinterpret_cast<const unsigned int *>(&data[4 + 8 * i]);
      const unsigned int signature = *reinterpret_cast<const unsigned int *>(&data[4 + 8 * i + 4]);
      if (signature != 0x0100 || data.size() < addr + 4) {
        return false;
      }
    }
    resultPath = std::filesystem::path(path).replace_extension(".txt");
    const std::filesystem::path fileName = path.filename();
    if (fileName.native()[0] == 'e' || fileName == "staff.msg") {
      if (!Touhou::Msg::TH10EndingMsg2Txt(data, result)) {
        return false;
      }
    } else {
      if (!Touhou::Msg::TH10Msg2Txt(data, result)) {
        if (!Touhou::Msg::TH11Msg2Txt(data, result)) {
          if (!Touhou::Msg::TH143Msg2Txt(data, result)) {
            return false;
          }
        }
      }
    }
    return true;
  }
};

ADD_FILE_CONVERTER(MsgConverter);

} // MSG

} // TouhouSE