
#define SPRINTF_IMPL_IMPL(proc, buffer, start, fmt, ...)	::proc(&buffer[start], sizeof(buffer) / sizeof(*buffer) - start, fmt, __VA_ARGS__)
#define STRLEN_IMPL(proc, buffer)					::proc(buffer, sizeof(buffer) / sizeof(*buffer))
#define SPRINTF_IMPL(proc, len_proc, buffer, start, fmt, ...)							\
do {															\
	const unsigned int start_pos = start;									\
	const int length = SPRINTF_IMPL_IMPL(proc, buffer, start_pos, fmt, __VA_ARGS__);			\
	BOOST_ASSERT(length != -1);											\
	BOOST_ASSERT(static_cast<unsigned int>(length) == STRLEN_IMPL(len_proc, buffer) - start_pos);	\
} while(false)
#define SPRINTF(buffer, fmt, ...)				SPRINTF_IMPL(sprintf_s, strnlen, buffer, 0, fmt, __VA_ARGS__)
#define WSPRINTF(buffer, fmt, ...)				SPRINTF_IMPL(swprintf_s, wcsnlen, buffer, 0, fmt, __VA_ARGS__)
#define STRLEN(buffer)					STRLEN_IMPL(strnlen, buffer)
#define WSTRLEN(buffer)					STRLEN_IMPL(wcsnlen, buffer)
#define STRCATF(buffer, fmt, ...)				SPRINTF_IMPL(sprintf_s, strnlen, buffer, STRLEN(buffer), fmt, __VA_ARGS__)
#define WSTRCATF(buffer, fmt, ...)				SPRINTF_IMPL(swprintf_s, wcsnlen, buffer, WSTRLEN(buffer), fmt, __VA_ARGS__)

#define STRCPY_IMPL(proc, buffer, source)			::proc(buffer, sizeof(buffer) / sizeof(*buffer), source)
#define STRCPY(buffer, source)				STRCPY_IMPL(strcpy_s, buffer, source)
#define WSTRCPY(buffer, source)				STRCPY_IMPL(wcscpy_s, buffer, source)

#define STRNCPY_IMPL(proc, buffer, source, length)	::proc(buffer, sizeof(buffer) / sizeof(*buffer), source, length)
#define STRNCPY(buffer, source, length)			STRNCPY_IMPL(strncpy_s, buffer, source, length)
#define WSTRNCPY(buffer, source, length)			STRNCPY_IMPL(wcsncpy_s, buffer, source, length)

#define STRCAT_IMPL(proc, dest, source)			::proc(dest, sizeof(dest) / sizeof(*dest), source)
#define STRCAT(dest, source)				STRCAT_IMPL(strcat_s, dest, source)
#define WSTRCAT(dest, source)				STRCAT_IMPL(wstrcat_s, dest, source)

namespace Utility {

#define MULTI_TO_WIDE_PROCS(name)										\
bool name##ToWChar(const char *str, std::vector<wchar_t> *result);					\
bool name##ToWChar(const std::vector<char> &str, std::vector<wchar_t> *result);			\
bool name##ToWChar(const std::string &str, std::vector<wchar_t> *result);				\
bool name##ToWChar(const std::shared_ptr<std::string> str, std::vector<wchar_t> *result);

MULTI_TO_WIDE_PROCS(SJIS)
MULTI_TO_WIDE_PROCS(UTF8)

#undef MULTI_TO_WIDE_PROCS

void GetModuleFileName(std::vector<char> &str);
void GetModuleFileName(std::vector<wchar_t> &str);
void GetAppDir(std::vector<char> &str);
void GetAppDir(std::vector<wchar_t> &str);
void SetAppDir(void);
unsigned int Endian32(unsigned int value);
unsigned short Endian16(unsigned short value);
unsigned int Endian(unsigned int value);
unsigned short Endian(unsigned short value);
unsigned int Crc(const unsigned char *buf, unsigned int len);

std::shared_ptr<FILE> MyFOpen(const std::wstring &path, const wchar_t *type);
std::shared_ptr<FILE> MyFOpen(const std::string &path, const char *type);
std::shared_ptr<FILE> MyPOpen(const std::wstring &path, const wchar_t *type);
std::shared_ptr<FILE> MyPOpen(const std::string &path, const char *type);
bool SJISFileRead(const std::wstring &path, std::vector<wchar_t> *result);
bool UTF8FileRead(const std::wstring &path, std::vector<wchar_t> *result);
std::shared_ptr<const std::string> StrV2Ptr(const std::vector<char> &str);
std::shared_ptr<const std::string> Str2Ptr(const std::string &str);
std::shared_ptr<const std::string> Char2Ptr(const char* str);
std::shared_ptr<const std::wstring> WStrV2Ptr(const std::vector<wchar_t> &str);
std::shared_ptr<const std::wstring> WStr2Ptr(const std::wstring &str);
std::shared_ptr<const std::wstring> WChar2Ptr(const wchar_t* str);

template<class T>
bool FileRead(const std::wstring &path, std::vector<T> &data) {
	BOOST_STATIC_ASSERT(sizeof(T) == 1);
	if(path.empty()) {
		return false;
	}
	std::shared_ptr<FILE> fp = MyFOpen(path, L"rb");
	if(!fp) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_END);
	const long size = ::ftell(fp.get());
	if(size < 0) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_SET);
	data.resize(static_cast<unsigned int>(size));
	const unsigned int read_size = ::fread(&data.front(), 1, data.size(), fp.get());
	if(read_size != data.size()) {
		return false;
	}
	return true;
}

template<class T>
bool FileRead(const std::string &path, std::vector<T> &data) {
	BOOST_STATIC_ASSERT(sizeof(T) == 1);
	std::vector<wchar_t> wpath;
	if(!SJISToWChar(path, &wpath) || wpath.empty()) {
		return false;
	}
	return FileRead(&wpath.front(), data);
}

std::wstring strToWStr(const std::string &in);
std::string wStrToStr(const std::wstring &in);

} // Utility
