
namespace TouhouSE {

namespace TH145Pak {

typedef std::array<std::wstring, 20000> FilenameArray;

std::shared_ptr<ExtractorBase> OpenTh145Pak(std::istream &in, const unsigned long long int fileSize, const std::array<unsigned char, 64> &rsaKey, const FilenameArray &filenameList);

} // TH145Pak

} // TouhouSE
