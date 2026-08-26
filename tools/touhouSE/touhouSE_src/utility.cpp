#include "stdafx.h"

namespace Utility {

namespace {

errno_t wfopen2(FILE ** fp, const wchar_t *fn, const wchar_t *type) {
	if(::_wfopen_s(fp, fn, type) == 0 && *fp != NULL) {
		return 0;
	}

	wchar_t str[256];
	WSTRCPY(str, fn);

	wchar_t *s = str;
	while(*s != '\0'){
		if(*s == '\\' || *s == '/'){
			*s = '\0';
			CreateDirectoryW(str, NULL);
			*s = '/';
		}
		s++;
	}
	errno_t error = ::_wfopen_s(fp, fn, type);
	if(error != 0) {
		return error;
	}
	return 0;
}

void MyFClose(FILE *fp) {
	if(fp == NULL) {
		return;
	}
	::fclose(fp);
}

void MyPClose(FILE *fp) {
	if(fp == NULL) {
		return;
	}
	::_pclose(fp);
}

bool CharToWChar(const char *buffer, unsigned int buffer_size, unsigned int code_page, std::vector<wchar_t> *result) {
	if(buffer == NULL || result == NULL) {
		return false;
	}
	const int size = ::MultiByteToWideChar(code_page, MB_ERR_INVALID_CHARS, buffer, static_cast<int>(buffer_size), NULL, 0);
	if(size <= 0) {
		return false;
	}
	result->resize(static_cast<unsigned int>(size)+1);
	const int convert_size = ::MultiByteToWideChar(code_page, MB_ERR_INVALID_CHARS, buffer, static_cast<int>(buffer_size), &result->front(), static_cast<int>(result->size()));
	if(convert_size <= 0) {
		return false;
	}
	(*result)[static_cast<unsigned int>(size)] = L'\0';
	return true;
}

bool FileReadW(const std::wstring &path, unsigned int code_page, std::vector<wchar_t> *result) {
	if(result == NULL) {
		return false;
	}
	std::vector<char> multi;
	if(!FileRead(path, multi)) {
		return false;
	}
	if(!CharToWChar(&multi.front(), multi.size(), code_page, result)) {
		return false;
	}
	return true;
}

std::vector<unsigned int> crc_table;

void MakeCRCTable(void){
	const unsigned int table_size = 256;
	crc_table.resize(table_size);
	for(unsigned int i = 0; i < table_size; i++) {
		unsigned int c = static_cast<unsigned int>(i);
		for(unsigned int l = 0; l < 8; l++) {
			if (c & 1) {
				c = 0xedb88320L ^ (c >> 1);
			} else {
				c = c >> 1;
			}
		}
		crc_table[i] = c;
	}
}

} // anonymous

#undef GetModuleFileName
bool GetModuleFileName(std::vector<char> &str) {
	::SetLastError(ERROR_SUCCESS);
	unsigned int size = 256;
	while(true) {
		str.resize(size);
		const unsigned int length = ::GetModuleFileNameA(NULL, &str.front(), str.size());
		const DWORD error = ::GetLastError();
		if(error == ERROR_SUCCESS && length <= size) {
			if(length < size) {
				str.resize(length);
			}
			break;
		} else if(error == ERROR_INSUFFICIENT_BUFFER) {
			size *= 2;
			continue;
		} else {
			str.clear();
			return false;
		}
	}
	return true;
}
bool GetModuleFileName(std::vector<wchar_t> &str) {
   ::SetLastError(ERROR_SUCCESS);
   unsigned int size = MAX_PATH;
   while (true) {
      str.resize(size);
      const unsigned int length = ::GetModuleFileNameW(NULL, &str.front(), str.size());
      const DWORD error = ::GetLastError();
      if (error == ERROR_SUCCESS && length <= size) {
         if (length < size) {
            str.resize(length);
         }
         break;
      } else if (error == ERROR_INSUFFICIENT_BUFFER) {
         size *= 2;
         continue;
      } else {
         str.clear();
         return false;
      }
   }
   return true;
}

void GetAppDir(std::vector<char> &str) {
	const bool get_result = GetModuleFileName(str);
	BOOST_ASSERT(get_result);
	BOOST_ASSERT(!str.empty());
	const BOOL path_remove_result = ::PathRemoveFileSpecA(&str.front());
	BOOST_ASSERT(path_remove_result == TRUE);
	str.resize(::strlen(&str.front()) + 1);
}
void GetAppDir(std::vector<wchar_t> &str) {
   const bool get_result = GetModuleFileName(str);
   BOOST_ASSERT(get_result);
   BOOST_ASSERT(!str.empty());
   const BOOL path_remove_result = ::PathRemoveFileSpecW(&str.front());
   BOOST_ASSERT(path_remove_result == TRUE);
   str.resize(::wcslen(&str.front()) + 1);
}

void SetAppDir(void) {
	std::vector<char> dir_name;
	GetAppDir(dir_name);
	BOOST_ASSERT(!dir_name.empty());
	const BOOL result = ::SetCurrentDirectoryA(&dir_name.front());
	BOOST_ASSERT(result == TRUE);
}

unsigned int Endian32(unsigned int value){
	return reinterpret_cast<unsigned char *>(&value)[3]
		+ reinterpret_cast<unsigned char *>(&value)[2]*0x100
		+ reinterpret_cast<unsigned char *>(&value)[1]*0x10000
		+ static_cast<unsigned int>(reinterpret_cast<unsigned char *>(&value)[0]*0x01000000);
}

unsigned short Endian16(unsigned short value){
	return static_cast<unsigned short>(reinterpret_cast<unsigned char *>(&value)[1] + reinterpret_cast<unsigned char *>(&value)[0] * 0x100);
}

unsigned int Endian(unsigned int value) {
	return Endian32(value);
}

unsigned short Endian(unsigned short value) {
	return Endian16(value);
}

unsigned int Crc(const unsigned char *buf, unsigned int len) {
	if(crc_table.empty()) {
		MakeCRCTable();
	}

	unsigned long c = 0xffffffffL;
	for(unsigned int i = 0; i < len; i++) {
		c = crc_table[(c ^ buf[i]) & 0xff] ^ (c >> 8);
	}
	return c ^ 0xffffffffL;
}

std::shared_ptr<FILE> MyFOpen(const std::wstring &path, const wchar_t *type) {
	std::shared_ptr<FILE> result;
	FILE *fp;
	const errno_t error = wfopen2(&fp, path.c_str(), type);
	if(error == 0) {
		BOOST_ASSERT(fp != NULL);
		result.reset(fp, &MyFClose);
	}
	return result;
}

std::shared_ptr<FILE> MyFOpen(const std::string &path, const char *type) {
	std::vector<wchar_t> wpath;
	std::vector<wchar_t> wtype;
	std::shared_ptr<FILE> result;
	if(!SJISToWChar(path, &wpath) || wpath.empty()) {
		return result;
	}
	if(!SJISToWChar(type, &wtype) || wtype.empty()) {
		return result;
	}
	result = MyFOpen(&wpath.front(), &wtype.front());
	return result;
}

std::shared_ptr<FILE> MyPOpen(const std::wstring &command, const wchar_t *type) {
	std::shared_ptr<FILE> result;
	FILE * const fp = ::_wpopen(command.c_str(), type);
	if(fp != NULL) {
		result.reset(fp, &MyPClose);
	}
	return result;
}

std::shared_ptr<FILE> MyPOpen(const std::string &command, const char *type) {
	std::vector<wchar_t> wcommand;
	std::vector<wchar_t> wtype;
	std::shared_ptr<FILE> result;
	if(!SJISToWChar(command, &wcommand) || wcommand.empty()) {
		return result;
	}
	if(!SJISToWChar(type, &wtype) || wtype.empty()) {
		return result;
	}
	result = MyPOpen(&wcommand.front(), &wtype.front());
	return result;
}

bool SJISFileRead(const std::wstring &path, std::vector<wchar_t> *result) {
	return FileReadW(path, CP_ACP, result);
}

bool UTF8FileRead(const std::wstring &path, std::vector<wchar_t> *result) {
	return FileReadW(path, CP_UTF8, result);
}

std::shared_ptr<const std::string> StrV2Ptr(const std::vector<char> &str) {
	return std::shared_ptr<const std::string>(new std::string(&str.front(), str.size()));
}

std::shared_ptr<const std::string> Str2Ptr(const std::string &str) {
	return std::shared_ptr<const std::string>(new std::string(str));
}

std::shared_ptr<const std::string> Char2Ptr(const char* str) {
	return std::shared_ptr<const std::string>(new std::string(str));
}

std::shared_ptr<const std::wstring> WStrV2Ptr(const std::vector<wchar_t> &str) {
	return std::shared_ptr<const std::wstring>(new std::wstring(&str.front(), str.size()));
}

std::shared_ptr<const std::wstring> WStr2Ptr(const std::wstring &str) {
	return std::shared_ptr<const std::wstring>(new std::wstring(str));
}

std::shared_ptr<const std::wstring> WChar2Ptr(const wchar_t* str) {
	return std::shared_ptr<const std::wstring>(new std::wstring(str));
}

#define MULTI_TO_WIDE_PROCS(name, code_page)													\
bool name##ToWChar(const char *str, std::vector<wchar_t> *result) {										\
	return CharToWChar(str, strlen(str), code_page, result);										\
}																			\
bool name##ToWChar(const std::vector<char> &str, std::vector<wchar_t> *result) {								\
	return CharToWChar(&str.front(), str.size(), code_page, result);									\
}																			\
bool name##ToWChar(const std::string &str, std::vector<wchar_t> *result) {									\
	return CharToWChar(str.c_str(), str.size(), code_page, result);									\
}																			\
bool name##ToWChar(const std::shared_ptr<std::string> str, std::vector<wchar_t> *result) {						\
	return CharToWChar(str->c_str(), str->size(), code_page, result);									\
}

MULTI_TO_WIDE_PROCS(SJIS, CP_ACP)
MULTI_TO_WIDE_PROCS(UTF8, CP_UTF8)

std::wstring strToWStr(const std::string &in) {
  if (in.empty()) {
    return{};
  }
  const unsigned int size = ::MultiByteToWideChar(CP_ACP, MB_ERR_INVALID_CHARS, &in.front(), in.size(), NULL, 0);
  if (size == 0) {
    return{};
  }
  std::wstring temp;
  temp.resize(size);
  ::MultiByteToWideChar(CP_ACP, MB_ERR_INVALID_CHARS, &in.front(), in.size(), &temp.front(), temp.size());
  return temp;
}

std::string wStrToStr(const std::wstring &in) {
  if (in.empty()) {
    return{};
  }
  const unsigned int size = ::WideCharToMultiByte(CP_ACP, 0, &in.front(), in.size(), NULL, 0, NULL, NULL);
  if (size == 0) {
    return{};
  }
  std::string temp;
  temp.resize(size);
  ::WideCharToMultiByte(CP_ACP, 0, &in.front(), in.size(), &temp.front(), temp.size(), NULL, NULL);
  return temp;
}

} // Utility
