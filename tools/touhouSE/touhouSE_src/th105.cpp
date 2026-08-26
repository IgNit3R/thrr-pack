#include "stdafx.h"

namespace TH105 {

using namespace Utility;

void th105_crypt_impl(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	unsigned char a = key1;
	unsigned char b = key2;
	for(unsigned int i = 0; i < data_size; i++){
		data[i] ^= a;
		a += b;
		b += key3;
	}
}
void th105_encrypt(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	th105_crypt_impl(data, data_size, key1, key2, key3);
}
void th105_decrypt(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	th105_crypt_impl(data, data_size, key1, key2, key3);
}

void th105_filelistcrypt_impl(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	init_genrand(6 + data_size);
	for(unsigned int i = 0; i < data_size; i++){
		data[i] ^= genrand_int32();
	}
	th105_crypt_impl(data, data_size, key1, key2, key3);
}
void th105_filelistencrypt(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	th105_filelistcrypt_impl(data, data_size, key1, key2, key3);
}
void th105_filelistdecrypt(unsigned char *data, unsigned int data_size, unsigned char key1, unsigned char key2, unsigned char key3) {
	th105_filelistcrypt_impl(data, data_size, key1, key2, key3);
}

void th105_filecrypt_impl(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data) {
	const unsigned char a = static_cast<unsigned char>((file_data->addr>>1) | 0x23);
	for(unsigned int i = 0; i < file_data->size; i++) {
		data[i] ^= a;
	}
}
void th105_fileencrypt(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data) {
	th105_filecrypt_impl(data, file_data);
}
void th105_filedecrypt(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data) {
	th105_filecrypt_impl(data, file_data);
}

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	data.resize(file_data->size);
	if(data.size() != ::fread(&data.front(), 1, data.size(), fp.get())) {
		return false;
	}
	th105_filedecrypt(data, file_data);
	return true;
}

bool pal_extract(std::vector<unsigned char> &buffer, const std::wstring &dat_name, const std::wstring &pal_name) {
	const unsigned int pal_size = 768;

   std::filesystem::path dir = dat_name;
   dir.remove_filename();
	const std::wstring find_filename = dir.wstring() + L"/*.dat";

	WIN32_FIND_DATAW fd;
	const HANDLE hSearch = ::FindFirstFileW(find_filename.c_str(), &fd);
	if(hSearch == INVALID_HANDLE_VALUE) {
		return false;
	}
	bool result = false;
	while(true) {
		const std::wstring command = (boost::wformat(L"pal_extract --noprint %s %s/%s") % pal_name % dir.wstring() % fd.cFileName).str();
		std::shared_ptr<FILE> fp = MyPOpen(command, L"rb");
		if(!fp) {
			printf("pal_extractが見つかりませんでした。\n");
			break;
		}
		buffer.resize(pal_size);
		const unsigned int read_size = ::fread(&buffer.front(), 1, pal_size, fp.get());
		fp.reset();
		if(read_size == pal_size){
			result = true;
			break;
		}
		if(!::FindNextFileW(hSearch, &fd)) {
			if(GetLastError() == ERROR_NO_MORE_FILES) {
				break;
			}
		}
	}
	FindClose(hSearch);
	return result;
}

void th105_loadpal(const std::wstring &filename, const unsigned int n, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> dat_fp) {
	static std::filesystem::path prev_pal_filename;
	BOOST_ASSERT(n < 999);

	std::filesystem::path read_filename = filename;
   read_filename.remove_filename();
   read_filename = read_filename / (boost::wformat(L"palette%03d.pal") % n).str();
	if(prev_pal_filename == read_filename) {
		return;
	}
	prev_pal_filename = read_filename;

   const std::vector<std::shared_ptr<LIST> >::const_iterator findIt = std::find_if(list.begin(), list.end(),
      [&read_filename](const auto &a) {
         return read_filename == a->fn;
      }
   );

	std::vector<unsigned char> data;
	if(findIt == list.end()){
		std::shared_ptr<FILE> fp = MyFOpen(read_filename.wstring(), L"rb");
		if(!fp){
			pal_extract(data, dat_name, read_filename.wstring());
		} else {
			data.resize(768);
			const unsigned int read_size = fread(&data.front(), 1, data.size(), fp.get());
			BOOST_ASSERT(read_size == data.size());
		}
	} else {
		Extract(data, *findIt, dat_fp);
	}
	if(data.empty()){
		return;
	}
	const unsigned char cn = data[0];
	if(cn != 16) {
		printf("\n不正なpalファイルです\n");
	} else {
		for(unsigned int i = 0; i < 256; i++) {
			pal[i].b = static_cast<unsigned char>((data[i*2+1]&0x1F) << 3);
			pal[i].g = static_cast<unsigned char>(((data[i*2+1]&0xE0) >> 2) + ((data[i*2+2]&0x03) << 6));
			pal[i].r = static_cast<unsigned char>((data[i*2+2]&0x7C) << 1);
			pal[i].alpha = static_cast<unsigned char>(((data[i*2+2]&0x80)>>7)*0xFF);
		}
	}
}

bool ex_cv01(const std::vector<unsigned char> &data, const std::wstring &fn, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	std::vector<unsigned char> buffer(data);
	th105_decrypt(&buffer.front(), buffer.size(), 0x8B, 0x71, 0x95);
	std::shared_ptr<FILE> fp = MyFOpen(fn, L"wb");
	if(!fp){
		std::wcout << boost::wformat(L"ファイルオープンに失敗しました(ex_cv01)\n%sは出力されません\n") % fn;
		return false;
	}
	if(buffer.size() != ::fwrite(&buffer.front(), 1, buffer.size(), fp.get())) {
		return false;
	}
	return true;
}

bool ex_cv3(const std::vector<unsigned char> &data, const std::wstring &fn, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	std::shared_ptr<FILE> fp = MyFOpen(fn, L"wb");
	if(!fp){
      std::wcout << boost::wformat(L"ファイルオープンに失敗しました(ex_cv3)\n%sは出力されません\n") % fn;
		return false;
	}
	if(!memcmp(&data.front(), "RIFF", 4)){
		if(16 != ::fwrite(&data[20], 1, 16, fp.get())) {
			return false;
		}
		if(data.size() - 40 != ::fwrite(&data[40], 1, data.size()-40, fp.get())) {
			return false;
		}
	} else {
		const unsigned int wave_size = *reinterpret_cast<const unsigned int *>(&data[18]);
		unsigned char header[44];
		memcpy_s(header, sizeof(header), "RIFF", 4);
		*reinterpret_cast<unsigned int *>(&header[4]) = wave_size + 36;
		memcpy_s(&header[8], sizeof(header) - 8, "WAVEfmt ", 8);
		*reinterpret_cast<unsigned int *>(&header[16]) = 0x00000010;
		memcpy_s(&header[20], sizeof(header) - 20, &data.front(), 16);
		memcpy_s(&header[36], sizeof(header) - 36, "data", 4);
		*reinterpret_cast<unsigned int *>(&header[40]) = wave_size;
		if(sizeof(header) != ::fwrite(header, 1, sizeof(header), fp.get())) {
			return false;
		}
		if(wave_size != ::fwrite(&data[22], 1, wave_size, fp.get())) {
			return false;
		}
	}
	return true;
}

bool ex_cv2(const std::vector<unsigned char> &data, const std::wstring &fn, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> dat_fp) {
	const unsigned char cn = data[0];
	const unsigned int w2 = *reinterpret_cast<const unsigned int *>(&data[1]);
	const unsigned int h = *reinterpret_cast<const unsigned int *>(&data[5]);
	const unsigned int w = *reinterpret_cast<const unsigned int *>(&data[9]);
	if(h == 0 || w2 == 0) {
		pngout(w, h, w2, NULL, fn, cn);
		return true;
	}
	if(cn == 24 || cn == 32){
		std::vector<unsigned char> buffer(sizeof(Color) * h * w2);
		Color *col = reinterpret_cast<Color *>(&buffer.front());
		const unsigned char *p = &data[17];
		for(unsigned int i = 0; i < h*w2; i++){
			col[i].b = p[0];
			col[i].g = p[1];
			col[i].r = p[2];
			col[i].alpha = p[3];
			p+=4;
			if(((i+1)%w2) == 0) {
				p += 4 * (w-w2);
			}
		}
		pngout(w, h, w2, &buffer.front(), fn, cn);
	} else if(cn == 8){
		th105_loadpal(fn, 0, list, dat_fp);
		std::vector<unsigned char> buffer(h * w2);
		const unsigned char *p = &data[17];
		for(unsigned int i = 0; i < h*w2; i+=w2) {
			memcpy_s(&buffer[i], buffer.size() - i, p, w2);
			p += w;
		}
		pngout(w, h, w2, &buffer.front(), fn, cn);
	} else {
      std::filesystem::path cv2_filename = fn;
      cv2_filename.replace_extension(".cv2");
		std::shared_ptr<FILE> fp = MyFOpen(cv2_filename.wstring(), L"wb");
		fwrite(&data.front(), 1, data.size(), fp.get());
	}
	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> dat_fp) {
	if(!file_data || data.empty() || list.empty() || !dat_fp) {
		return false;
	}
   const char * const file_ext = ::PathFindExtensionA(file_data->fn);
#define EXT_CONV(ext, put_ext, proc)						\
	if(!strcmp(file_ext, ext)){							\
		std::filesystem::path put_filename =  file_data->fn;\
      put_filename.replace_extension(put_ext);\
		return proc(data, put_filename.wstring(), list, dat_fp);			\
	}

	EXT_CONV(".cv0", ".txt", ex_cv01);
	EXT_CONV(".cv1", ".csv", ex_cv01);
	EXT_CONV(".cv2", ".png", ex_cv2);
	EXT_CONV(".cv3", ".wav", ex_cv3);

#undef EXT_CONV

	std::shared_ptr<FILE> fp = MyFOpen(file_data->fn, "wb");
	if(!fp) {
		return false;
	}
	if(data.size() != ::fwrite(&data.front(), 1, data.size(), fp.get())) {
		return false;
	}
	return true;
}

bool GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp) {
	if(!fp) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_END);
	const unsigned int file_size = static_cast<unsigned int>(::ftell(fp.get()));
	if(file_size < 6) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_SET);
	unsigned short file_count;
	if(1 != ::fread(&file_count, 2, 1, fp.get())) {
		return false;
	}
	unsigned int file_list_size;
	if(1 != ::fread(&file_list_size, 4, 1, fp.get())) {
		return false;
	}
	if(file_size < file_list_size + 6) {
		return false;
	}
	std::vector<unsigned char> file_list_data(file_list_size);
	::fread(&file_list_data.front(), 1, file_list_size, fp.get());
	th105_filelistdecrypt(&file_list_data.front(), file_list_size, 0xC5, 0x83, 0x53);

	list.resize(file_count);
	unsigned char *p = &file_list_data.front();
	unsigned int last_addr = 0;
	for(unsigned int i = 0; i < file_count && p < &file_list_data.back() + 1; i++){
		list[i].reset(new LIST());
		list[i]->addr = *reinterpret_cast<unsigned int *>(&p[0]);
		list[i]->comp_size = list[i]->size = *reinterpret_cast<unsigned int *>(&p[4]);
		if(list[i]->addr + list[i]->size > last_addr){
			last_addr = list[i]->addr + list[i]->size;
		}
		const unsigned int filename_length = p[8];
		if(filename_length > 99) {
			return false;
		}
		memcpy(list[i]->fn, &p[9], filename_length);
		list[i]->fn[filename_length] = '\0';
		if(STRLEN(list[i]->fn) != filename_length){
			return false;
		}
		p += 9 + filename_length;
	}
	if(last_addr > file_size){
		return false;
	}
	return true;
}

} // TH105
