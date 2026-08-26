
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

namespace endian = boost::spirit::endian;

class Th135CsvConvertor : public ConverterBase {
public:
  static bool Convert(
    const std::filesystem::path &path,
    const std::vector<unsigned char> &data,
    std::filesystem::path &resultPath,
    std::vector<unsigned char> &result,
    const ExtractorBase &extractor)
  {
    const unsigned int headerSize = 4 + 1 + 4 + 4;
    if (data.size() < headerSize) {
      return false;
    }
    const std::string signature = "TFCS";
    const unsigned int version = 0;
    if (!std::equal(signature.begin(), signature.end(), data.begin()) || data[4] != version) {
      return false;
    }
    const unsigned int compSize = *reinterpret_cast<const unsigned int *>(&data[5]);
    const unsigned int origSize = *reinterpret_cast<const unsigned int *>(&data[9]);
    if (data.size() - headerSize != compSize || compSize > origSize) {
      return false;
    }
    if (compSize == origSize) {
      if (compSize == 0) {
        result.clear();
        resultPath = path;
        return true;
      }
      return false;
    }
    std::vector<unsigned char> temp;
    temp.resize(origSize);
    uLongf origSizeResult = origSize;
    if (Z_OK != ::uncompress(&temp.front(), &origSizeResult, &data[headerSize], data.size() - headerSize) || origSizeResult != origSize) {
      return false;
    }
    if (temp.size() < 4) {
      return false;
    }
    const unsigned int lineCount = *reinterpret_cast<const unsigned int *>(&temp.front());
    if (lineCount == 0) {
      result.clear();
      return true;
    }
    std::vector<unsigned char>::const_iterator it = temp.begin() + 4;
    unsigned int size = temp.size() - 4;
    boost::interprocess::basic_ovectorstream<std::vector<unsigned char> > os(std::ios::binary);
    for (unsigned int i = 0; i < lineCount; i++) {
      if (size < 4) {
        return false;
      }
      const unsigned int columnCount = *reinterpret_cast<const unsigned int *>(&*it);
      it += 4;
      size -= 4;
      for (unsigned int j = 0; j < columnCount; j++) {
        if (j != 0) {
          os << ",";
          if (!os.good()) {
            return false;
          }
        }
        if (size < 4) {
          return false;
        }
        const unsigned int textSize = *reinterpret_cast<const unsigned int *>(&*it);
        it += 4;
        size -= 4;
        if (size < textSize) {
          return false;
        }
        if (textSize == 0) {
          continue;
        }
        std::vector<wchar_t> text;
        if (!Utility::SJISToWChar(std::string(it, it + textSize), &text)) {
          return false;
        }
        if (std::find(text.begin(), text.end(), L',') != text.end()) {
          os << '\"';
          os.write(&*it, textSize);
          os << '\"';
        } else {
          os.write(&*it, textSize);
        }
        if (!os.good()) {
          return false;
        }
        it += textSize;
        size -= textSize;
      }
      os << "\r\n";
    }
    if (size != 0) {
      return false;
    }
    os.flush();
    os.swap_vector(result);
    resultPath = path;
    resultPath.replace_extension(L".csv");
    return true;
  }
};

ADD_FILE_CONVERTER(Th135CsvConvertor);

} // TH135

} // TouhouSE
