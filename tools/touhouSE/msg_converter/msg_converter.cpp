
#include "stdafx.h"

std::filesystem::path ReplaceExtension(const std::filesystem::path &path, const wchar_t * const ext) {
  std::filesystem::path result = path;
  result.replace_extension(ext);
  return result;
}

bool ProcMsg(const std::filesystem::path &path, const std::vector<unsigned char> data) {
  const std::filesystem::path out = ReplaceExtension(path, L".txt");
  return Touhou::Msg::TH143Msg2Txt(data, out.string().c_str());
}

bool ProcTxt(const std::filesystem::path &path, const std::vector<unsigned char> data) {
  const std::filesystem::path out = ReplaceExtension(path, L".msg");
  return Touhou::Msg::Txt2Msg(data, out.string().c_str());
}

bool Proc(const std::filesystem::path &path) {
  if (!boost::filesystem::is_regular_file(path)) {
    std::wcout << boost::wformat(L"%1%は存在しないか、ファイルではありません。") % path << std::endl;
    return false;
  }
  const unsigned long long int fileSize = boost::filesystem::file_size(path);
  if (fileSize == 0) {
    std::wcout << L"サイズ0のファイルは処理できません。" << std::endl;
    return false;
  }
  boost::filesystem::ifstream ifs(path, std::ios::binary);
  if (!ifs.good()) {
    std::wcout << boost::wformat(L"%1%のオープンに失敗しました、ファイルをロックしているプロセスを終了してください。") % path << std::endl;
    return false;
  }
  std::vector<unsigned char> data(static_cast<unsigned int>(fileSize));
  ifs.read(reinterpret_cast<char *>(&data.front()), data.size());
  if (!ifs.good()) {
    std::wcout << L"ファイルの読み込みに失敗しました。" << std::endl;
    return false;
  }
  const std::filesystem::path ext = path.extension();
  if (ext == L".msg") {
    return ProcMsg(path, data);
  } else if (ext == L".txt") {
    return ProcTxt(path, data);
  }
  return false;
}

int main(const unsigned int argc, const char * const * const argv) {
  std::locale::global(std::locale("japanese"));
  if (argc < 2) {
    std::wcout << L"usage: msg_converter.exe file [,file]";
    return 1;
  }
  for (unsigned int i = 1; i < argc; i++) {
    const std::filesystem::path path(argv[i]);
    if (!Proc(path)) {
      std::wcout << boost::wformat(L"%1%の変換に失敗しました。\n処理を中断します。\n") % path;
      std::wcin.ignore();
      return 1;
    }
  }
  std::wcout << L"すべての処理に成功しました。\nEnterで終了";
  std::wcin.ignore();
  return 0;
}
