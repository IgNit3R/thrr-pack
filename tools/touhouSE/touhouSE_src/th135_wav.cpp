
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

namespace endian = boost::spirit::endian;

#pragma pack(push, 1)
struct WaveHeader : public boost::noncopyable {
  char riffSignature[4];
  unsigned int size;
  char waveSignature[4];
  char fmtSignature[4];
  unsigned int fmtSize;
  unsigned short formatId;
  unsigned short channelCount;
  unsigned int sampleRate;
  unsigned int dataRate;
  unsigned short blockSize;
  unsigned short bitCount;
  char dataSignature[4];
  unsigned int dataSize;
  void setup() {
    const std::string riff = "RIFF";
    const std::string wave = "WAVE";
    const std::string fmt = "fmt ";
    const std::string data = "data";
    std::copy(riff.begin(), riff.end(), riffSignature);
    std::copy(wave.begin(), wave.end(), waveSignature);
    std::copy(fmt.begin(), fmt.end(), fmtSignature);
    std::copy(data.begin(), data.end(), dataSignature);
    size = sizeof(WaveHeader) - 8 + dataSize;
    fmtSize = 2 + 2 + 4 + 4 + 2 + 2;
  }
};
#pragma pack(pop)

class Th135WavConvertor : public ConverterBase {
public:
static bool Convert(
  const std::filesystem::path &path,
  const std::vector<unsigned char> &data,
  std::filesystem::path &resultPath,
  std::vector<unsigned char> &result,
  ExtractorBase &extractor)
{
  const unsigned int headerSize = 4 + 1 + 2 + 2 + 4 + 4 + 2 + 2 + 2 + 4;
  if (data.size() < headerSize) {
    return false;
  }
  const std::string signature = "TFWA";
  const unsigned int version = 0;
  if (!std::equal(signature.begin(), signature.end(), &data.front()) || data[4] != version) {
    return false;
  }
  result.resize(sizeof(WaveHeader));
  WaveHeader &header = *reinterpret_cast<WaveHeader *>(&result.front());
  header.formatId = *reinterpret_cast<const unsigned short *>(&data[5]);
  header.channelCount = *reinterpret_cast<const unsigned short *>(&data[7]);
  header.sampleRate = *reinterpret_cast<const unsigned int *>(&data[9]);
  header.dataRate = *reinterpret_cast<const unsigned int *>(&data[13]);
  header.blockSize = *reinterpret_cast<const unsigned short *>(&data[17]);
  header.bitCount = *reinterpret_cast<const unsigned short *>(&data[19]);
  const unsigned int unknown = *reinterpret_cast<const unsigned short *>(&data[21]);
  header.dataSize = *reinterpret_cast<const unsigned int *>(&data[23]);
  if (header.formatId != 1 || (header.channelCount != 1 && header.channelCount != 2)
    || (header.bitCount != 8 && header.bitCount != 16 && header.bitCount != 24)
    || header.bitCount / 8 * header.channelCount != header.blockSize
    || header.sampleRate * header.blockSize != header.dataRate
    || data.size() - headerSize != header.dataSize)
  {
    return false;
  }
  header.setup();
  result.resize(result.size() + header.dataSize);
  std::copy(data.begin() + headerSize, data.end(), result.begin() + sizeof(WaveHeader));
  resultPath = path;
  resultPath.replace_extension(L".wav");
  return true;
}
};

ADD_FILE_CONVERTER(Th135WavConvertor);

} // TH135

} // TouhouSE
