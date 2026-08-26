#include "stdafx.h"

namespace TH075 {

using namespace Utility;

struct th075_list{
	char fn[100];
	unsigned int size;
	unsigned int addr;
};

void load_pal(const unsigned char *data) {
	if(data == NULL){
		return;
	} else {
		for(unsigned int i = 0; i < 256; i++) {
			pal[i].b = static_cast<unsigned char>((data[i*2]&0x1F) << 3);
			pal[i].g = static_cast<unsigned char>(((data[i*2]&0xE0) >> 2) + ((data[i*2+1]&0x03) << 6));
			pal[i].r = static_cast<unsigned char>((data[i*2+1]&0x7C) << 1);
			pal[i].alpha = static_cast<unsigned char>(((data[i*2+1]&0x80)>>7) * 0xFF);
		}
	}
}

bool load_col(std::vector<unsigned char> &buffer, const unsigned char **end_p, const unsigned char *data, unsigned char cn, unsigned int w, unsigned int h) {
	const unsigned int col_count = w * h;
	buffer.clear();
	*end_p = data;
	if(col_count == 0) {
		return true;
	}

	if(cn == 32 || cn == 24){
		buffer.resize(sizeof(Color) * col_count);
		Color *col = reinterpret_cast<Color *>(&buffer.front());
		while(col < reinterpret_cast<Color *>(&buffer.back() + 1)) {
			const unsigned int length = *reinterpret_cast<const unsigned int *>(*end_p);
			*end_p += 4;
			for(unsigned int i = 0; i < length; i++){
				col->b = (*end_p)[0];
				col->g = (*end_p)[1];
				col->r = (*end_p)[2];
				if(cn == 32) {
					col->alpha = (*end_p)[3];
				} else {
					BOOST_ASSERT(cn==24);
					col->alpha = 0xff;
				}
				col++;
			}
			*end_p += 4;
		}
	} else if(cn == 16){
		buffer.resize(sizeof(Color) * col_count);
		Color *col = reinterpret_cast<Color *>(&buffer.front());
		while(col < reinterpret_cast<Color *>(&buffer.back() + 1)) {
			const unsigned int length = *reinterpret_cast<const unsigned short *>(*end_p);
			*end_p += 2;
			for(unsigned int i = 0; i < length; i++){
				col->b = static_cast<unsigned char>(((*end_p)[0]&0x1F) << 3);
				col->g = static_cast<unsigned char>((((*end_p)[0]&0xE0) >> 2) + (((*end_p)[1]&0x03) << 6));
				col->r = static_cast<unsigned char>(((*end_p)[1]&0x7c) << 1);
				col->alpha = static_cast<unsigned char>((((*end_p)[1]&0x80) >> 7) * 0xFF);
				col++;
			}
			*end_p += 2;
		}
	} else if(cn == 8){
		buffer.resize(col_count);
		unsigned char *col = &buffer.front();
		while(col < &buffer.back() + 1) {
			const unsigned int length = **end_p;
			*end_p += 1;
			const unsigned int buf_size = static_cast<unsigned int>(&buffer.back() - col) + 1;
			if(length > buf_size) {
				return false;
			}
			memset(col, **end_p, length);
			col += length;
			*end_p += 1;
		}
	} else {
		printf("ñ¢ëŒâûÇÃêFêîÇ≈Ç∑(%d)\n",cn);
		return false;
	}
	return true;
}

bool th075img_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
	if(data.empty() || !file_data || strlen(file_data->fn) <= 5) {
		return false;
	}

	const unsigned int palette_count = data[0];
	const unsigned int palette_size = 512;
	if(palette_count > 0) {
		load_pal(&data[1]);
	}

	const unsigned char *p = &data[1 + palette_size * palette_count];
	char put_filename[256];
	STRCPY(put_filename, file_data->fn);
	for(unsigned int i = 0; p <= &data.back(); i++){
		const unsigned int w = *reinterpret_cast<const unsigned int *>(&p[0]);
		const unsigned int h = *reinterpret_cast<const unsigned int *>(&p[4]);
		const unsigned char cn = p[12];
		p += 17;

		std::vector<unsigned char> col;
		bool result = load_col(col, &p, p, cn, w, h);
		if(result && !col.empty()) {
			put_filename[strlen(file_data->fn)-4] = '\0';
			STRCATF(put_filename, "/%02d.png", i);
			pngout(w, h, w, &col.front(), put_filename, cn);
		}
	}
	return true;
}


void th075_convert(unsigned char *out, const unsigned char *buffer, unsigned int size, unsigned char a, unsigned char b, unsigned char c) {
	memcpy_s(out, size, buffer, size);
	for(unsigned int i = 0; i < size; i++) {
		out[i] ^= a;
		a += b;
		b += c;
	}
}
bool th075_convert_put(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, unsigned char a, unsigned char b, unsigned char c) {
	if(data.empty() || !file_data) {
		return false;
	}
	std::vector<unsigned char> out(data.size());
	th075_convert(&out.front(), &data.front(), data.size(), a, b, c);
	char put_filename[256];
	STRCPY(put_filename, file_data->fn);
	char * const file_ext = ::PathFindExtensionA(put_filename);
	if(strcmp(file_ext, ".sce") == 0){
		char * const filename = ::PathFindFileNameA(put_filename);
		*filename = '\0';
		STRCAT(put_filename, "scenario.txt");
	} else {
		*file_ext = '\0';
		STRCAT(put_filename, ".txt");
	}
	std::shared_ptr<FILE> fp = MyFOpen(put_filename, "wb");
	if(!fp) {
		return false;
	}
	const unsigned int write_size = ::fwrite(&out.front(), 1, out.size(), fp.get());
	if(write_size != out.size()) {
		return false;
	}
	return true;
}

#define cl_convert(a,b)		th075_convert_put(a,b,0x60,0x61,0x41)
#define sce_convert(a,b)		th075_convert_put(a,b,0x63,0x62,0x42)
#define mr_convert(a,b)		th075_convert_put(a,b,0x5C,0x5A,0x3D)
#define index_convert(a,b,c)	th075_convert(a,b,c,0x64,0x64,0x4d)

bool wave_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
	if(!file_data) {
		return false;
	}
	if(data.size() < 4) {
		return false;
	}
	const unsigned int file_count = *reinterpret_cast<const unsigned int *>(&data[0]);
	const unsigned char *p = &data[4];
	char put_filename[256];
	STRCPY(put_filename, file_data->fn);
	char * const file_ext = ::PathFindExtensionA(put_filename);
	for(unsigned int i = 0; i < file_count && p <= &data.back(); i++) {
		if(p > &data.back()) {
			return false;
		}
		if(*p == 0) {
			p++;
			continue;
		}
		if(&p[22] > &data.back()) {
			return false;
		}
		const unsigned int wave_size = *reinterpret_cast<const unsigned int *>(&p[1]);
		if(&p[23 + wave_size] > &data.back() + 1) {
			return false;
		}
		unsigned char header[44];
		memcpy(&header[0], "RIFF", 4);
		*reinterpret_cast<unsigned int *>(&header[4]) = wave_size + 36;
		memcpy_s(&header[8], sizeof(header) - 8, "WAVEfmt ", 8);
		*reinterpret_cast<unsigned int *>(&header[16]) = 0x00000010;
		memcpy_s(&header[20], sizeof(header) - 20, &p[5], 16);
		memcpy_s(&header[36], sizeof(header) - 36, "data", 4);
		*reinterpret_cast<unsigned int *>(&header[40]) = wave_size;
		
		*file_ext = '\0';
		STRCATF(put_filename, "/%02d.wav", i);
		std::shared_ptr<FILE> fp = MyFOpen(put_filename, "wb");
		if(!fp) {
			return false;
		}
		if(sizeof(header) != ::fwrite(header, 1, sizeof(header), fp.get())) {
			return false;
		}
		if(wave_size != ::fwrite(&p[23], 1, wave_size, fp.get())) {
			return false;
		}
		p += 23 + wave_size;
	}
	return true;
}

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	if(!fp || !file_data) {
		return false;
	}
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	data.resize(file_data->size);
	if(!data.empty()) {
		const unsigned int read_size = ::fread(&data.front(), 1, data.size(), fp.get());
		if(read_size != data.size()) {
			return false;
		}
	}
	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	const char * const filename = ::PathFindFileNameA(file_data->fn);
	const char * const file_ext = ::PathFindExtensionA(file_data->fn);
	if(strcmp(filename, "cardlist.dat") == 0) {
		return cl_convert(file_data, data);
	} else if(strcmp(file_ext, ".sce") == 0) {
		return sce_convert(file_data, data);
	} else if(strcmp(filename, "musicroom.dat") == 0) {
		return mr_convert(file_data, data);
	} else if(strcmp(file_ext, ".dat") == 0) {
		if(strncmp(file_data->fn, "wave\\", 5) == 0) {
			return wave_convert(file_data, data);
		} else {
			return th075img_convert(file_data, data);
		}
	} else {
		std::shared_ptr<FILE> fp = MyFOpen(file_data->fn, "wb");
		if(!fp) {
			return false;
		}
		if(!data.empty()) {
			const unsigned int write_size = ::fwrite(&data.front(), 1, data.size(), fp.get());
			if(write_size != data.size()) {
				return false;
			}
		}
	}
	return true;
}

bool GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp) {
	const unsigned int struct_size = sizeof(struct th075_list); // 108
	if(!fp) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_END);
	const unsigned int file_size = static_cast<unsigned int>(::ftell(fp.get()));
	if(file_size < 2){
		return false;
	}
	::fseek(fp.get(), 0, SEEK_SET);
	unsigned short file_count;
	::fread(&file_count, 2, 1, fp.get());
	if(file_size < struct_size * file_count){
		return false;
	}
	std::vector<unsigned char> buffer(struct_size * file_count);
	if(file_count != ::fread(&buffer.front(), struct_size, file_count, fp.get())) {
		return false;
	}
	std::vector<th075_list> th075dat(file_count);
	index_convert(reinterpret_cast<unsigned char *>(&th075dat.front()), &buffer.front(), struct_size * file_count);
	buffer.clear();

	list.resize(file_count);
	unsigned int last_addr = 0;
	for(unsigned int i = 0; i < file_count; i++) {
		list[i].reset(new LIST());
		if(STRLEN(th075dat[i].fn) > 99){
			return false;
		}
		STRCPY(list[i]->fn, th075dat[i].fn);
		list[i]->comp_size = list[i]->size = th075dat[i].size;
		list[i]->addr = th075dat[i].addr;
		if(last_addr < list[i]->addr + list[i]->size) {
			last_addr = list[i]->addr + list[i]->size;
		}
	}
	th075dat.clear();

	if(last_addr > file_size){
		return false;
	}
	return true;
}

} // TH075
