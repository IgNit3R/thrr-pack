
#include "stdafx.h"

namespace TouhouSE {

namespace TH145_CM {

extern const std::array<std::wstring, 20000> DIR_NAME_LIST;

class Owner : public TH135::Th135ArchiveExtractorBase<Owner> {
public:
  Owner(
    std::istream &in,
    std::unique_ptr<std::vector<std::shared_ptr<TH135::FileInfo> > > fileInfoList,
    std::vector<std::filesystem::path> pathList,
    const unsigned int headerSize)
    :
    Th135ArchiveExtractorBase<Owner>(in, std::move(fileInfoList), std::move(pathList), headerSize)
  {}

  static const std::array<std::wstring, 20000> &getDirNameList() {
    return DIR_NAME_LIST;
  }

  static unsigned int calcHash(const std::string &in, const unsigned int init = 0x811C9DC5) {
    return TH135::calcFNV1aHash(Utility::strToWStr(in), init);
  }

  std::wstring GetName() const {
    return L"ê[îÈò^ÉRÉ~ÉPëÃå±î≈";
  }
};

ADD_DAT_EXTRACTOR(Owner);

} // TH145_CM

} // TouhouSE
