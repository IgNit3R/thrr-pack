
#include "stdafx.h"

bool proc(const std::filesystem::path &path) {
  if (!boost::filesystem::is_regular_file(path)) {
    return false;
  }
  const unsigned long long int fileSize = boost::filesystem::file_size(path);
  if (fileSize == 0) {
    return false;
  }
  boost::filesystem::ifstream ifs(path, std::ios::binary);
  if (!ifs.good()) {
    return false;
  }
  const std::optional<TouhouSE::Squirrel3::CNut> cnut = TouhouSE::Squirrel3::CNut::read(ifs, fileSize);
  if (!cnut) {
    return false;
  }
  ifs.close();
  const std::filesystem::path outPath = std::filesystem::path(path).replace_extension(".nut");
  boost::filesystem::ofstream ofs(outPath);
  ofs << cnut->toString();
  ofs.close();
  return true;
}

int main(const unsigned int argc, const char * const * const argv) {
  std::locale loc = std::locale("japanese").combine<std::numpunct<char> >(std::locale::classic()).combine<std::numpunct<wchar_t> >(std::locale::classic());
  std::locale::global(loc);
  std::wcout.imbue(loc);
  std::cout.imbue(loc);
  if (argc < 2) {
    std::wcout << boost::wformat(L"usage: %s filename.cnut\n") % std::filesystem::path(argv[0]).filename().wstring();
    return 1;
  }
  for (unsigned int i = 1; i < argc; i++) {
    if (!proc(argv[i])) {
      return 1;
    }
  }
  return 0;
}
