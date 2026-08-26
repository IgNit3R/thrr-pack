
enum DAT_VER {
	DAT_VER_TH105 = 0,
	DAT_VAR_TH075,
	DAT_VAR_TH11,
	DAT_VAR_TH12,
	DAT_VAR_TH13,
	DAT_VAR_THMJ,
	DAT_VAR_TNB,
	DAT_VAR_NPA,
	DAT_VAR_MAX,
	DAT_VER_UNKNOWN = DAT_VAR_MAX,
};

typedef struct data_list{
	char fn[100];
	unsigned int size;
	unsigned int comp_size;
	unsigned int addr;
}LIST;

extern std::wstring dat_name;

DAT_VER GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);
bool PutFile(DAT_VER dat_ver, std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);
bool Extract(std::vector<unsigned char> &data, DAT_VER dat_ver, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp);






class ExtractorBase : boost::noncopyable {
public:
	virtual bool Extract(const unsigned int index, std::vector<unsigned char> &result) = 0;
	virtual unsigned int GetSize() const = 0;
	virtual std::wstring GetName() const = 0;
	virtual std::filesystem::path GetFileName(unsigned int index) const = 0;

   std::vector<std::pair<unsigned int, std::filesystem::path> > MakeFileList(const std::filesystem::path &basePath) const;
};

class DatExtractor : boost::noncopyable {
private:
	static DatExtractor *instance;
	std::vector<std::function<std::shared_ptr<ExtractorBase> (std::istream &/*in*/, const unsigned long long int /*fileSize*/)> > openFuncList;
   bool convertEnable;
   std::wstring paletteId;
   std::filesystem::path colorPalettePath;
   bool recursiveEnable;
   std::vector<std::shared_ptr<Pattern> > rejectPattern;
   std::vector<std::shared_ptr<Pattern> > selectPattern;

	DatExtractor() : convertEnable(true), recursiveEnable(true) { }

  bool ExtractImpl(const std::filesystem::path &fileName, std::vector<unsigned char> data, ExtractorBase &ownerExtractor);

public:
	static DatExtractor &GetInstance() {
		if (DatExtractor::instance == NULL) {
			DatExtractor::instance = new DatExtractor();
		}
		return *DatExtractor::instance;
	}
	template<typename T>
	void Add() {
		this->openFuncList.push_back(std::bind(typename T::Open, _1, _2));
	}
   bool ExtractAll(const std::filesystem::path &path, const bool printProgress = true);
   bool ExtractAll(
      const std::shared_ptr<ExtractorBase> extractor,
      const std::filesystem::path &basePath = L"",
      const std::function<void(unsigned int i, unsigned int total)> &func = {},
      const bool printProgress = true,
      const bool enableSelectAndReject = true);
   void PrintList(const std::filesystem::path &path);

   void setConvertEnable(const bool flag) {
      convertEnable = flag;
   }
   bool isConvertEnable() const {
      return convertEnable;
   }
   void setPaletteId(const std::wstring paletteId) {
      this->paletteId = paletteId;
   }
   const std::wstring &getPaletteId() const {
      return paletteId;
   }
   void setColorPalettePath(const std::filesystem::path &colorPalettePath) {
      this->colorPalettePath = colorPalettePath;
   }
   const std::filesystem::path &getColorPalettePath() const {
      return colorPalettePath;
   }
   void setRecursiveEnable(const bool flag) {
      recursiveEnable = flag;
   }
   bool isRecursiveEnable() const {
      return recursiveEnable;
   }
   const std::vector<std::shared_ptr<Pattern> > getRejectPattern() const {
      return rejectPattern;
   }
   void addRejectPattern(const std::shared_ptr<Pattern> pattern) {
      rejectPattern.push_back(pattern);
   }
   const std::vector<std::shared_ptr<Pattern> > getSelectPattern() const {
      return selectPattern;
   }
   void addSelectPattern(const std::shared_ptr<Pattern> pattern) {
      selectPattern.push_back(pattern);
   }
};

template<typename T>
class ExtractorAdder : boost::noncopyable {
public:
	ExtractorAdder() {
		DatExtractor::GetInstance().Add<T>();
	}
};

#define ADD_DAT_EXTRACTOR(extractorClass) ExtractorAdder<extractorClass> datClass##__LINE__







class ConverterBase : boost::noncopyable {
public:
};

class FileConverter : boost::noncopyable {
private:
   static FileConverter *instance;
   std::vector<std::function<bool (
      const std::filesystem::path &,
      const std::vector<unsigned char> &,
      std::filesystem::path &,
      std::vector<unsigned char> &,
      ExtractorBase &)> > convertFuncList;

   FileConverter() { }

public:
   static FileConverter &GetInstance() {
      if (FileConverter::instance == NULL) {
         FileConverter::instance = new FileConverter();
      }
      return *FileConverter::instance;
   }
   template<typename T>
   void Add() {
      this->convertFuncList.push_back(std::bind(typename T::Convert, _1, _2, _3, _4, _5));
   }
   bool Convert(
      const std::filesystem::path &fileName,
      const std::vector<unsigned char> &data,
      std::filesystem::path &resultFileName,
      std::vector<unsigned char> &result,
      ExtractorBase &extractor) const {
      for (
         const std::function<bool (
            const std::filesystem::path &,
            const std::vector<unsigned char> &,
            std::filesystem::path &,
            std::vector<unsigned char> &,
            ExtractorBase &)> &func
         : this->convertFuncList)
      {
         if (func(fileName, data, resultFileName, result, extractor)) {
            return true;
         }
      }
      return false;
   }
};

template<typename T>
class ConverterAdder : boost::noncopyable {
public:
	ConverterAdder() {
		FileConverter::GetInstance().Add<T>();
	}
};

#define ADD_FILE_CONVERTER(converterClass) ConverterAdder<converterClass> converterClass##__LINE__
