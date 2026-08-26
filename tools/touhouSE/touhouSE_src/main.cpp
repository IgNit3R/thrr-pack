#include "stdafx.h"
#pragma comment(lib,"Comdlg32.lib")

using namespace Utility;

DatExtractor *DatExtractor::instance = NULL;
FileConverter *FileConverter::instance = NULL;

std::wstring dat_name;

namespace {

struct SumFileCompSize {
   unsigned int operator()(unsigned int value, std::shared_ptr<const LIST> file_data) {
      return value + file_data->comp_size;
   }
};

} // anonymous

DAT_VER GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp) {
   static bool (* const func_list[])(std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) = {TH105::GetList, TH075::GetList, TH11::GetList, TH12::GetList, TH13::GetList, THMJ::GetList, TNB::GetList, NPA::GetList};

   for(unsigned int i = 0; i < DAT_VAR_MAX; i++) {
      const bool result = func_list[DAT_VAR_MAX - 1 - i](list, fp);
      if(result) {
         DAT_VER dat_ver = static_cast<DAT_VER>(DAT_VAR_MAX - 1 - i);
         printf("%d個のファイルを検出しました。\n", list.size());
         return dat_ver;
      }
   }
   return DAT_VER_UNKNOWN;
}

bool PutFile(DAT_VER dat_ver, std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp) {
   static bool (* const func[])(std::shared_ptr<const LIST>, const std::vector<unsigned char> &, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) = {TH105::PutFile, TH075::PutFile, TH11::PutFile, TH12::PutFile, TH13::PutFile, THMJ::PutFile, TNB::PutFile, NPA::PutFile};

   return func[dat_ver](file_data, data, list, fp);
}

bool Extract(std::vector<unsigned char> &data, DAT_VER dat_ver, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
   static bool (* const func[])(std::vector<unsigned char> &, std::shared_ptr<const LIST>, std::shared_ptr<FILE>) = {TH105::Extract, TH075::Extract, TH11::Extract, TH12::Extract, TH13::Extract, THMJ::Extract, TNB::Extract, NPA::Extract};

   return func[dat_ver](data, file_data, fp);
}

const std::wstring Open() {
   std::vector<wchar_t> dir;
   GetAppDir(dir);
   dir.resize(dir.size() + 1);
   ::PathAddBackslashW(&dir.front());

   wchar_t path[MAX_PATH];
   OPENFILENAMEW ofn;
   memset(&ofn, 0, sizeof(OPENFILENAMEW));
   ofn.lStructSize = sizeof(OPENFILENAMEW);
   ofn.lpstrFilter = L"すべての対応形式(*.dat;*.bin;*.npa)\0*.dat;*.bin;*.npa\0All files(*.*)\0*.*\0\0";
   ofn.lpstrFile = path;
   ofn.nMaxFile = sizeof(path);
   ofn.lpstrInitialDir = &dir.front();
   ofn.Flags = OFN_FILEMUSTEXIST;
   ofn.lpstrTitle = L"ファイルを開く";
   ofn.lpstrDefExt = L"dat";

   if (!GetOpenFileNameW(&ofn)) {
      return {};
   }
   return path;
}
const std::wstring Open(const std::wstring &in) {
   if (in.empty()) {
      return Open();
   }
   SetAppDir();
   return in;
}

bool NormalPutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
   if(!file_data) {
      return false;
   }
   char put_filename[256] = "";
   const char * const filename = ::PathFindFileNameA(file_data->fn);
   if(filename == file_data->fn) {
      STRCPY(put_filename, "data/");
   }
   STRCAT(put_filename, file_data->fn);

   std::shared_ptr<FILE> fp = MyFOpen(put_filename, "wb");
   if(!fp) {
      return false;
   }
   if(!data.empty()) {
      if(data.size() != ::fwrite(&data.front(), 1, data.size(), fp.get())) {
         return false;
      }
   }
   return true;
}

void DebugConvert(const std::filesystem::path &path, std::istream &is, const unsigned long long int fileSize) {
   if (fileSize == 0) {
      return;
   }
   std::vector<unsigned char> data(static_cast<unsigned int>(fileSize));
   is.read(reinterpret_cast<char *>(&data.front()), fileSize);
   std::filesystem::path outPath;
   std::vector<unsigned char> convertData;
   const bool convertResult = FileConverter::GetInstance().Convert(path, data, outPath, convertData, *reinterpret_cast<ExtractorBase *>(NULL));
   if (!convertResult) {
      return;
   }
   std::ofstream ofs(outPath, std::ios::binary);
   if (!convertData.empty()) {
      ofs.write(reinterpret_cast<const char *>(&convertData.front()), convertData.size());
   }
   ofs.close();
}

class ProgressPrinter {
private:
   const bool enable;
   time_t start;
public:
   ProgressPrinter(const bool enable) :enable(enable) {
      time(&start);
   }
   void progress(const unsigned int i, const unsigned int total) {
      if (!enable) {
         return;
      }
      time_t elapsed;
      time(&elapsed);
      elapsed = elapsed - start;
      const unsigned int remainder = static_cast<unsigned int>(static_cast<double>(total - i) * elapsed / i);
      std::wcout << boost::wformat(L"\r%6u/%6u %02u:%02u(残り%02u:%02u)")
         % (i + 1)
         % total
         % static_cast<unsigned int>(elapsed / 60)
         % static_cast<unsigned int>(elapsed % 60)
         % static_cast<unsigned int>(remainder / 60)
         % static_cast<int>(remainder % 60);
   }
   void finish() {
      if (!enable) {
         return;
      }
      std::wcout << std::endl;
   }
};

template<typename T>
std::shared_ptr<ExtractorBase> getExtractor(std::istream &in, const unsigned long long int fileSize, const T &funcList) {
   for (const auto &func : funcList) {
      in.seekg(0, std::ios::beg);
      const std::shared_ptr<ExtractorBase> result = func(in, fileSize);
      if (result) {
         return result;
      }
   }
   return {};
}

std::vector<std::pair<unsigned int, std::filesystem::path> > ExtractorBase::MakeFileList(const std::filesystem::path &basePath) const {
   std::vector<std::pair<unsigned int, std::filesystem::path> > list;
   for (unsigned int i : boost::irange(0U, GetSize())) {
      std::filesystem::path path = basePath / GetFileName(i);
      bool reject = false;
      for (const std::shared_ptr<Pattern> pattern : DatExtractor::GetInstance().getRejectPattern()) {
         if (pattern->match(path)) {
            reject = true;
            break;
         }
      }
      if (reject) {
         continue;
      }
      const auto &selectList = DatExtractor::GetInstance().getSelectPattern();
      if (!selectList.empty()) {
         bool select = false;
         for (const std::shared_ptr<Pattern> pattern : selectList) {
            if (pattern->match(path)) {
               select = true;
               break;
            }
         }
         if (!select) {
            continue;
         }
      }
      list.push_back(std::make_pair(i, std::move(path)));
   }
   return list;
}

bool DatExtractor::ExtractAll(const std::filesystem::path &path, const bool printProgress) {
   if (!std::filesystem::is_regular_file(path)) {
      std::wcout << boost::wformat(L"\n%1%がファイルではありません。\nファイル以外の展開はサポートされません。\n") % path.wstring();
      return false;
   }
   const unsigned long long int fileSize = std::filesystem::file_size(path);
   std::ifstream ifs(path, std::ios::binary);
   if (!ifs.is_open()) {
      std::wcout << boost::wformat(L"\n%1%を開けませんでした。\n%1%の関連アプリを終了して実行しなおしてください。\n") % path.wstring();
      return false;
   }
   const std::shared_ptr<ExtractorBase> extractor = getExtractor(ifs, fileSize, this->openFuncList);
   if (!extractor) {
      //DebugConvert(path, ifs, fileSize);
      std::wcout << boost::wformat(L"\n%1%は非対応のファイルフォーマットです。\n") % path.wstring();
      return false;
   }
   return ExtractAll(extractor, L"", {}, printProgress);
}

bool DatExtractor::ExtractAll(
   const std::shared_ptr<ExtractorBase> extractor,
   const std::filesystem::path &basePath,
   const std::function<void(unsigned int i, unsigned int total)> &func,
   const bool printProgress,
   const bool enableSelectAndReject)
{
   if (printProgress) {
      std::wcout << boost::wformat(L"\nフォーマット：%1%\n展開を始めます。\n\n") % extractor->GetName();
   }
   ProgressPrinter pp(printProgress);
   const std::vector<std::pair<unsigned int, std::filesystem::path> > list = extractor->MakeFileList(basePath);
   bool result = true;
   for (unsigned int i = 0; i < list.size(); i++) {
      const std::filesystem::path &fileName = list[i].second;
      std::vector<unsigned char> data;
      const bool extractResult = extractor->Extract(list[i].first, data);
      if (!extractResult) {
         std::wcout << boost::wformat(L"\nファイル%1%の展開に失敗しました。\n%1%は無視されます。\n") % fileName.wstring();
         result = false;
         continue;
      }
      result &= ExtractImpl(fileName, std::move(data), *extractor);
      pp.progress(i, list.size());
      if (func) {
         func(i, list.size());
      }
   }
   pp.finish();
   return result;
}

void DatExtractor::PrintList(const std::filesystem::path &path) {
   if (!std::filesystem::is_regular_file(path)) {
      return;
   }
   const unsigned long long int fileSize = std::filesystem::file_size(path);
   std::ifstream ifs(path, std::ios::binary);
   if (!ifs.is_open()) {
      return;
   }
   const std::shared_ptr<ExtractorBase> extractor = getExtractor(ifs, fileSize, this->openFuncList);
   if (!extractor) {
      return;
   }
   for (const auto &item : extractor->MakeFileList(L"")) {
      std::wcout << item.second.wstring() << std::endl;
   }
}

bool writeFile(std::filesystem::path outPath, const std::vector<unsigned char> &data, std::filesystem::path srcFilePath = L"") {
   if (srcFilePath.empty()) {
      srcFilePath = outPath;
   }
   const std::filesystem::path outDir = std::filesystem::path(outPath).remove_filename();
   try {
      std::filesystem::create_directories(std::filesystem::absolute(outDir));
   } catch (const std::filesystem::filesystem_error &error) {
      std::cout << error.what();
      return false;
   }
   if (std::filesystem::exists(outPath)) {
      const std::filesystem::path ext = outPath.extension();
      const std::filesystem::path name = outPath.replace_extension().filename();
      const std::filesystem::path dir = outPath.remove_filename();
      for (unsigned int i = 1; ; i++) {
         const std::wstring filename = (boost::wformat(L"%s(%d).dummy"/*ファイル名に.を含むと無限ループするのでダミー拡張子をつける*/) % name.wstring() % i).str();
         const std::filesystem::path temp = std::filesystem::path(dir / filename).replace_extension(ext);
         if (!std::filesystem::exists(temp)) {
            outPath = temp;
            break;
         }
      }
   }
   std::ofstream ofs(outPath, std::ios::binary);
   if (!ofs.is_open()) {
      std::wcout << boost::wformat(L"\nファイル%1%の出力に失敗しました。\n%1%は無視されます。\n") % srcFilePath.wstring();
      return false;
   }
   if (data.size() > 0) {
      ofs.write(reinterpret_cast<const char *>(&data.front()), data.size());
      if (!ofs.good()) {
         std::wcout << boost::wformat(L"\nファイル%1%の出力に失敗しました。\n%1%は無視されます。\n") % srcFilePath.wstring();
         return false;
      }
   }
   ofs.close();
   return true;
}

bool DatExtractor::ExtractImpl(const std::filesystem::path &fileName, std::vector<unsigned char> data, ExtractorBase &ownerExtractor) {
   if (data.empty()) {
      return writeFile(fileName, data, fileName);
   }

   // アーカイブなら展開を試みる
   if (recursiveEnable) {
      const boost::iostreams::array_source source(reinterpret_cast<const char *>(&data.front()), reinterpret_cast<const char *>(&data.back() + 1));
      boost::iostreams::stream<boost::iostreams::array_source> in(source);
      const std::shared_ptr<ExtractorBase> extractor = getExtractor(in, data.size(), this->openFuncList);
      if (extractor) {
         return ExtractAll(extractor, std::filesystem::path(fileName).remove_filename(), {}, false);
      }
   }

   // 形式変換も試みる
   std::filesystem::path outPath = fileName;
   if (convertEnable) {
      while (true) {
         std::filesystem::path tempPath;
         std::vector<unsigned char> tempData;
         const bool convertResult = FileConverter::GetInstance().Convert(outPath, data, tempPath, tempData, ownerExtractor);
         if (!convertResult) {
            break;
         }
         outPath = std::move(tempPath);
         data = std::move(tempData);
      }
   }

   return writeFile(outPath, data, fileName);
}

bool DatExtract(const std::vector<std::wstring> &filename_list) {
   bool result = true;
   for (std::wstring filename : filename_list) {
      std::wcout << boost::wformat(L"%sを展開します。\n") % filename;
      dat_name = filename;
      const std::shared_ptr<FILE> fp = MyFOpen(filename, L"rb");
      std::vector<std::shared_ptr<LIST> > file_list;
      const DAT_VER dat_ver = GetList(file_list, fp);
      if(dat_ver == DAT_VER_UNKNOWN) {
         if (!DatExtractor::GetInstance().ExtractAll(filename)) {
            result = false;
         }
         continue;
      } else {
         const char * const dat_type[] = {"緋想天", "萃夢想", "地霊殿", "星蓮船", "神霊廟", "幻想麻雀", "テンドーブレード", "NitroPlusArchive"};
         if(!file_list.empty()) {
            printf("\nフォーマット：%s\nファイル展開を始めます。\n\n", dat_type[dat_ver]);
         }
         time_t start;
         time(&start);
         const unsigned int total_size = std::accumulate(file_list.begin(), file_list.end(), static_cast<unsigned int>(0), SumFileCompSize());
         unsigned int current_size = 0;
         unsigned int count = 0;
         for (std::shared_ptr<const LIST> file_data : file_list) {
            current_size += file_data->comp_size;
            count++;
            std::vector<unsigned char> data;
            const bool extract_result = Extract(data, dat_ver, file_data, fp);
            if(!extract_result) {
               printf("\nファイル%sの展開に失敗しました。\n%sは無視されます。\n", file_data->fn, file_data->fn);
               result = false;
               continue;
            }
            const bool put_result = PutFile(dat_ver, file_data, data, file_list, fp);
            if(!put_result) {
               result = false;
               const bool normal_put_result = NormalPutFile(file_data, data);
               if(normal_put_result) {
                  printf("\nファイル%sの出力に失敗しました。\n%sは無変換で出力されます。\n", file_data->fn, file_data->fn);
               } else {
                  printf("\nファイル%sの出力に失敗しました。\n%sは無視されます。\n", file_data->fn, file_data->fn);
               }

            }

            time_t elapsed;
            time(&elapsed);
            elapsed = elapsed - start;
            unsigned int remainder = static_cast<unsigned int>(static_cast<double>(total_size - current_size) * elapsed/current_size);//time_tが4バイトの場合オーバーフローするのでdoubleにキャスト
            printf("\r%6u/%6u %02u:%02u(残り%02u:%02u)",
               count, file_list.size(), static_cast<unsigned int>(elapsed/60), static_cast<unsigned int>(elapsed%60), static_cast<unsigned int>(remainder/60), static_cast<int>(remainder%60));
         }
      }
      printf("\n展開終了しました\n");
   }
   return result;
}

bool ParseArgs(std::vector<std::wstring> &filename_list, bool &is_enter_sleep, bool &viewList, const unsigned int argc, const wchar_t * const argv[]) {
   is_enter_sleep = true;
   viewList = false;
   if(argc == 0 || argv == NULL) {
      return false;
   }
   for(unsigned int i = 0; i < argc; i++) {
      if(argv[i] == NULL) {
         return false;
      }
   }
   if(argc == 1) {
      const std::wstring open_filename = Open();
      if(open_filename.empty()) {
         return false;
      }
      filename_list.push_back(open_filename);
      return true;
   }
   bool result = true;
   for(unsigned int i = 1; i < argc; i++) {
      const std::wstring &item = argv[i];
      if (item.substr(0, 2) == L"--") {
         const std::wstring name = item.substr(2);
         if (name == L"no-convert") {
            DatExtractor::GetInstance().setConvertEnable(false);
         } else if (name == L"cui") {
            is_enter_sleep = false;
         } else if (name == L"paletteId") {
            if (argc <= i) {
               result = false;
               std::wcout << boost::wformat(L"エラー:パレットIDの指定がありません。\n");
               continue;
            }
            DatExtractor::GetInstance().setPaletteId(argv[i + 1]);
            i++;
         } else if (name == L"use-color-palette") {
            if (argc <= i) {
               result = false;
               std::wcout << boost::wformat(L"エラー:パレットのパス指定がありません。\n");
               continue;
            }
            DatExtractor::GetInstance().setColorPalettePath(argv[i + 1]);
            i++;
         } else if (name == L"no-recursive") {
            DatExtractor::GetInstance().setRecursiveEnable(false);
         } else if (std::regex_match(name, std::wregex(L"^(?:reject|select)(?:-(?:regex|glob))?$"))) {
            if (argc <= i) {
               result = false;
               std::wcout << boost::wformat(L"エラー:パターン文字列の指定がありません。\n");
               continue;
            }
            const std::wstring patternString = argv[i + 1];
            std::wstring::const_iterator sep = std::find(name.begin(), name.end(), L'-');
            const std::wstring op(name.begin(), sep);
            if (sep != name.end()) {
               sep++;
            }
            const std::wstring type(sep, name.end());
            std::shared_ptr<Pattern> pattern;
            if (type.empty()) {
               pattern.reset(new PlainPattern(patternString));
            } else if (type == L"regex") {
               pattern.reset(new RegexPattern(patternString));
            } else if (type == L"glob") {
               pattern.reset(new GlobPattern(patternString));
            } else {
               result = false;
               std::wcout << boost::wformat(L"エラー:不明な内部エラー。\n");
               continue;
            }
            if (op == L"select") {
               DatExtractor::GetInstance().addSelectPattern(pattern);
            } else if (op == L"reject") {
               DatExtractor::GetInstance().addRejectPattern(pattern);
            } else {
               result = false;
               std::wcout << boost::wformat(L"エラー:不明な内部エラー。\n");
               continue;
            }
            i++;
         } else if (name == L"view-list") {
            viewList = true;
         } else {
            result = false;
            std::wcout << boost::wformat(L"無効なオプション(%s)\n") % name;
         }
      } else if(item[0] == L'-' || item[0] == L'/') {
         switch(item[1]) {
            case L'c':
               is_enter_sleep = false;
               break;
            case L'n':
               DatExtractor::GetInstance().setConvertEnable(false);
               break;
            default:
               result = false;
               std::wcout << boost::wformat(L"無効なオプション(%s)\n") % &item[1];
               break;
         }
      } else {
         filename_list.push_back(argv[i]);
      }
   }
   if (false) { // デバッグ表示
      std::cout << "parse success\n";
      for (const auto &item : filename_list) {
         std::wcout << item << std::endl;
      }
      std::wcout << boost::wformat(L"is_enter_sleep:%s\n") % is_enter_sleep;
      std::wcout << boost::wformat(L"paletteId:%s\n") % DatExtractor::GetInstance().getPaletteId();
      std::wcout << boost::wformat(L"useColorPalette:%s\n") % DatExtractor::GetInstance().getColorPalettePath();
      std::wcout << boost::wformat(L"isConvertEnable:%s\n") % DatExtractor::GetInstance().isConvertEnable();
      std::wcout << boost::wformat(L"isRecursiveEnable:%s\n") % DatExtractor::GetInstance().isRecursiveEnable();
      std::wcout << boost::wformat(L"reject_pattern:\n");
      for (const auto &item : DatExtractor::GetInstance().getRejectPattern()) {
         std::wcout << item->toString() << std::endl;
      }
      std::wcout << boost::wformat(L"select_pattern:\n");
      for (const auto &item : DatExtractor::GetInstance().getSelectPattern()) {
         std::wcout << item->toString() << std::endl;
      }
      std::wcin.get();
   }
   return result;
}

int main() {
   std::locale loc = std::locale("japanese").combine<std::numpunct<char> >(std::locale::classic()).combine<std::numpunct<wchar_t> >(std::locale::classic());
   std::locale::global(loc);
   std::wcout.imbue(loc);
   std::cout.imbue(loc);
   SetAppDir();

   unsigned int argc;
   const wchar_t * const * const argv = ::CommandLineToArgvW(::GetCommandLineW(), reinterpret_cast<int *>(&argc));
   std::vector<std::wstring> filename_list;
   bool is_enter_sleep;
   bool viewList;
   if(!ParseArgs(filename_list, is_enter_sleep, viewList, argc, argv)) {
      return 1;
   }
   if (viewList) {
      for (const auto &path : filename_list) {
         DatExtractor::GetInstance().PrintList(path);
      }
      return 0;
   }
   const bool result = DatExtract(filename_list);
   if(is_enter_sleep) {
      printf("全ての処理が終了しました\n終了する場合はENTERを押してください\n");
      getchar();
   }
   return result ? 0 : 1;
}

