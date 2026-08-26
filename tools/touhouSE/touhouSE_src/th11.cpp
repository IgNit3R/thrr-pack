#include "stdafx.h"

namespace TH11 {

using namespace ::Utility;
using namespace TH11::Utility;
using namespace DatUtility;

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	static unsigned int conv_map[8][4] = {
		{0x1b,	0x37,	0x0040,	0x2800},
		{0x51,	0xe9,	0x0040,	0x3000},
		{0xc1,	0x51,	0x0080,	0x3200},
		{0x03,	0x19,	0x0400,	0x7800},
		{0xab,	0xcd,	0x0200,	0x2800},
		{0x12,	0x34,	0x0080,	0x3200},
		{0x35,	0x97,	0x0080,	0x2800},
		{0x99,	0x37,	0x0400,	0x2000}
	};

	data.resize(file_data->comp_size);
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	if(data.size() != ::fread(&data.front(), 1, data.size(), fp.get())) {
		return false;
	}
	const unsigned int key_index = CalcKeyIndex(file_data);
	thcrypter(&data.front(), data.size(), static_cast<unsigned char>(conv_map[key_index][0]), static_cast<unsigned char>(conv_map[key_index][1]), conv_map[key_index][2], conv_map[key_index][3]);

	if(file_data->size != data.size()) {
		std::vector<unsigned char> temp(file_data->size);
		decomp(&data.front(), data.size(), &temp.front(), temp.size());
		data.swap(temp);
	}
	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	if(!file_data || data.empty()) {
		return false;
	}
	const char * const file_ext = ::PathFindExtensionA(file_data->fn);
	if(strcmp(file_ext, ".anm") == 0) {
		return th11img_convert(file_data, data);
	} else if(strcmp(file_ext, ".msg") == 0) {
		const char * const filename = ::PathFindFileNameA(file_data->fn);
		if(filename[0] == 'e' || ::strcmp(filename, "staff.msg") == 0) {
			return Touhou::Msg::TH11EndingMsg2Txt(file_data, data);
		} else {
			return Touhou::Msg::TH11Msg2Txt(file_data, data);
		}
	} else {
		char put_filename[256] = "data/";
		STRCAT(put_filename, file_data->fn);
		std::shared_ptr<FILE> fp = MyFOpen(put_filename, "wb");
		if(!fp) {
			return false;
		}
		if(data.size() != ::fwrite(&data.front(), 1, data.size(), fp.get())) {
			return false;
		}
	}
	return true;
}

bool GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp) {
	if(!fp) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_END);
	th11dat.size = static_cast<unsigned int>(::ftell(fp.get()));
	::fseek(fp.get(), 0, SEEK_SET);
	if(th11dat.size < 16) {
		return false;
	}
	unsigned char header[16];
	if(sizeof(header) != ::fread(header, 1, sizeof(header), fp.get())) {
		return false;
	}
	thcrypter(header, 0x10, 0x1B, 0x37, 0x10, 0x10);
	if(*reinterpret_cast<const unsigned int *>(&header[0]) != 0x31414854) {
		return false;
	}
	th11dat.list_size = *reinterpret_cast<const unsigned int *>(&header[4]) - 0x075BCD15;
	th11dat.comp_lsize = *reinterpret_cast<const unsigned int *>(&header[8]) - 0x3ADE68B1;
	th11dat.list_num = *reinterpret_cast<const unsigned int *>(&header[12]) - 0x08180754;
	const unsigned int file_count = th11dat.list_num;
	if(th11dat.list_size < th11dat.list_num * 12 || th11dat.comp_lsize < th11dat.list_num * 4 || th11dat.list_num < 5 || 
		th11dat.list_size < th11dat.comp_lsize || th11dat.list_num*12 + th11dat.comp_lsize > th11dat.size || th11dat.list_size > th11dat.size) {
		return false;
	}

	::fseek(fp.get(), -static_cast<int>(th11dat.comp_lsize), SEEK_END);
	if(th11dat.comp_lsize == 0) {
		return false;
	}
	std::vector<unsigned char> data(th11dat.comp_lsize);
	if(data.size() != ::fread(&data.front(), 1, data.size(), fp.get())) {
		return false;
	}
	thcrypter(&data.front(), data.size(), 0x3E, 0x9B, 0x80, data.size());
	if(th11dat.comp_lsize != th11dat.list_size) {
		std::vector<unsigned char> out_buffer(th11dat.list_size);
		decomp(&data.front(), data.size(), &out_buffer.front(), out_buffer.size());
		data.swap(out_buffer);
	}
	const bool file_list_result = head_print(list, data, file_count);
	data.clear();
	if(file_list_result != 0){
		return false;
	}

	if(!TryVerFileExtract(DAT_VAR_TH11, list, fp)) {
		return false;
	}

	if(!TryAnmFileExtract(DAT_VAR_TH11, list, fp)) {
		return false;
	}
	return true;
}

typedef struct region {
	int id;
	float left;
	float top;
	float right;
	float bottom;
}REGION;

typedef struct attr {
	unsigned short type;
	unsigned short len;
	int addr;
}ATTR;

struct dat_data th11dat;

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class BitReader : boost::noncopyable {
public:
	BitReader(const unsigned char *start, unsigned int size) :
		start(start), size(size), pos(0)
	{
		BOOST_ASSERT(start != NULL);
	}
	~BitReader() {
	}

	unsigned int ReadBit(unsigned int len) {
		BOOST_ASSERT(len <= 32);
		unsigned int bit_pos = pos % 8;
		unsigned int index = 0;
		const unsigned char * const max = start + (pos + len) / 8 + 1;
		unsigned int result = 0;
		unsigned int value = static_cast<unsigned int>(1) << (len - 1);
		for(const unsigned char *p = start + pos / 8; p < max; p++){
			while(bit_pos < 8){
				if(p < start + size && (*p&(1<<(7-bit_pos)))) {
					result |= value;
				}
				value >>= 1;
				bit_pos++;
				index++;
			}
			bit_pos = 0;
		}

		pos += len;
		return result;
	}
	bool ReadBit(void) {
		return ReadBit(1) == 1;
	}
	char ReadChar(void) {
		return static_cast<char>(ReadBit(8));
	}
	unsigned char ReadUChar(void) {
		return static_cast<unsigned char>(ReadBit(8));
	}

private:
	const unsigned char * const start;
	const unsigned int size;
	unsigned int pos;
};
#pragma warning(pop)
#pragma pack(pop)

#define DICT_SIZE 0x2000
void decomp(const unsigned char *in, unsigned int in_size, unsigned char *out, unsigned int out_size) {
	BOOST_ASSERT(in != NULL);
	BOOST_ASSERT(out != NULL);
	unsigned char dict[DICT_SIZE],*o;
	unsigned int dictop = 1;
	BitReader bit(in, in_size);
	o = out;
	memset(dict, 0, DICT_SIZE);
	while(1){
		if(bit.ReadBit()) {
			const unsigned char value = bit.ReadUChar();
			if(static_cast<unsigned int>(o-out) >= out_size) {
				return;
			}
			*o = value;
			o++;
			dict[dictop % DICT_SIZE] = value;
			dictop++;
		} else {
			const unsigned int ofs = bit.ReadBit(13);
			if(!ofs) {
				return;
			}
			const unsigned int len = bit.ReadBit(4) + 3;
			for(unsigned int i = 0; i < len; i++) {
				const unsigned char value = dict[(ofs + i) % DICT_SIZE];
				if(static_cast<unsigned int>(o-out) >= out_size){
					return;
				}
				*o = value;
				o++;
				dict[dictop % DICT_SIZE] = value;
				dictop++;
			}
		}
	}
}

void thcrypter(unsigned char* in, unsigned int in_size, unsigned char key, unsigned char step, unsigned int block, unsigned int limit) {
	const unsigned int temp = in_size % block;
	const unsigned int dec_size = (in_size %2) + ((temp < block / 4) ? temp : 0);
	if(in_size <= dec_size) {
		return;
	}
	const unsigned int crypt_size = in_size - dec_size;
	std::vector<unsigned char> out(crypt_size);
	unsigned char *in_cur = in;
	unsigned char *out_cur = &out.front();
	const unsigned char* out_end = (std::min)(out_cur + crypt_size, out_cur + limit);
	while(out_cur < out_end){
		const unsigned int block_size = (std::min)(static_cast<unsigned int>(out_end - out_cur), block);
		const unsigned int increment = block_size / 2 + ((block_size % 2) ? 1 : 0);
		unsigned char *p;
		for(p = out_cur + block_size - 1; p > out_cur; p -= 2) {
			p[0] = static_cast<unsigned char>(in_cur[0] ^ key);
			p[-1] = static_cast<unsigned char>(in_cur[increment] ^ (key + step * increment));
			in_cur++;
			key += step;
		}

		if(block_size % 2 == 1) {
			p[0] = static_cast<unsigned char>(in_cur[0] ^ key);
			key += step;
		}

		key += static_cast<unsigned char>(step * increment);
		in_cur += increment;
		out_cur += block_size;
	}

	memcpy_s(in, in_size, &out.front(), static_cast<unsigned int>(out_cur - &out.front()));
}
/*
void read_region(char *head,int num,char *p,char *filename,int x,int y,int add) {
	REGION reg;
	int addr,i;
	char fn[256];
	FILE *fp;

	strcpy(fn,filename);
	strcpy(&fn[strlen(fn)-4],".txt");
	if(add){
		fp = fopen2(fn,"a");
	} else {
		fp = fopen2(fn,"w");
		fprintf(fp,"//id\tleft\ttop\tright\tbottom\n");
	}
	i = 0;
	while(i < num){
		addr = *(int *)&head[i*4];
		memcpy(&reg,p+addr,sizeof(REGION));
		fprintf(fp,"%d\t%.0f\t%.0f\t%.0f\t%.0f\n",reg.id,reg.left+x,reg.top+y,reg.right,reg.bottom);
		i++;
	}
	fclose(fp);
}*/
/*
void read_attr(ATTR *attr, int num, char *base, char *filename) {
	int i;
	char fn[256];
	FILE *fp;

	strcpy(fn,filename);
	strcpy(&fn[strlen(fn)-4],".attr");
	fp = fopen2(fn,"w");
	i = 0;
	while(i < num){
		fprintf(fp,"%d\t%d\t0x%08x\n",attr[i].type,attr[i].len,attr[i].addr);
		i++;
	}
	fclose(fp);
}*/

std::shared_ptr<Png> col_sum(const char *fn, Color *col, unsigned int w, unsigned int h, unsigned int x, unsigned int y) {
	std::vector<Color> c;
	std::shared_ptr<Png> png = load_png(fn);
	if(!png){
		png.reset(new Png());
		png->w = 0;
		png->h = 0;
		png->cn = 32;
	}
	const unsigned int new_width = (std::max)(x + w, png->w);
	const unsigned int new_height = (std::max)(y + h, png->h);

	c.resize(new_width * new_height);
	std::vector<Color>::iterator it = c.begin();
	for(unsigned int h_index = 0; h_index < new_height; h_index++) {
		for(unsigned int w_index = 0; w_index < new_width; w_index++) {
			if(x <= w_index && w_index < x + w && y <= h_index && h_index < y + h) {
				*it = col[w * (h_index - y) + w_index - x];
			} else if(w_index < png->w && h_index < png->h) {
				*it = png->col[png->w * h_index + w_index];
			}
			++it;
		}
	}

	png->col.swap(c);
	png->w = new_width;
	png->h = new_height;
	return png;
}

bool th11img_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
	if(!file_data || data.empty()) {
		return false;
	}

	const unsigned char *cur = &data.front();
	while(cur <= &data.back()) {
		if(data.size() < static_cast<unsigned int>(cur - &data.front()) + 0x28) {
			return false;
		}
		const unsigned int image_filename_addr = *reinterpret_cast<const unsigned int *>(&cur[0x10]);
		if(data.size() <= image_filename_addr) {
			return false;
		}
		const char *image_filename = reinterpret_cast<const char *>(cur) + image_filename_addr;
		if(::strlen(image_filename) > 251 || data.size() < image_filename_addr + strlen(image_filename) + 1) {
			return false;
		}
		char put_filename[256];
		SPRINTF(put_filename, "data/%s", image_filename);
		if(strcmp(&put_filename[strlen(put_filename)-4],".png") == 0){
			const unsigned int w2 = *reinterpret_cast<const unsigned short *>(&cur[0x14]);
			const unsigned int h2 = *reinterpret_cast<const unsigned short *>(&cur[0x16]);
			//read_attr((ATTR*)&s[0x40+*(short *)&s[0x04]*4],*(short *)&s[0x06],s,fn);

			const unsigned int image_addr = *reinterpret_cast<const unsigned int *>(&cur[0x1C]);
			const unsigned char * const image_ptr = cur + image_addr;
			if(data.size() < static_cast<unsigned int>(image_ptr - &data.front()) + 16) {
				return false;
			}

			if(memcmp(image_ptr, "THTX", 4) != 0) {
				return false;
			}
			const unsigned int type = *reinterpret_cast<const unsigned short *>(&image_ptr[6]);
			const unsigned int w = *reinterpret_cast<const unsigned short *>(&image_ptr[8]);
			const unsigned int h = *reinterpret_cast<const unsigned short *>(&image_ptr[10]);
			const unsigned int len = *reinterpret_cast<const unsigned int*>(&image_ptr[12]);
			const unsigned char *col_ptr = &image_ptr[16];
			std::vector<Color> col(w * h);

			if(type == 1){
				if(data.size() < image_ptr - &data.front() + 16 + w * h * 4) {
					return false;
				}
				for(unsigned int i = 0; i < w*h; i++){
					col[i].b = col_ptr[0];
					col[i].g = col_ptr[1];
					col[i].r = col_ptr[2];
					col[i].alpha = col_ptr[3];
					col_ptr+=4;
				}
			} else if(type == 5){
				if(data.size() < image_ptr - &data.front() + 16 + w * h * 2) {
					return false;
				}
				for(unsigned int i = 0; i < w*h; i++){
					col[i].b = static_cast<unsigned char>((col_ptr[0]&0x0F) << 4);
					col[i].g = static_cast<unsigned char>(col_ptr[0]&0xF0);
					col[i].r = static_cast<unsigned char>((col_ptr[1]&0x0F) << 4);
					col[i].alpha = static_cast<unsigned char>(col_ptr[1]&0xF0);
					col_ptr+=2;
				}
			} else if(type == 3){
				if(data.size() < image_ptr - &data.front() + 16 + w * h * 2) {
					return false;
				}
				for(unsigned int i = 0; i < w*h; i++){
					col[i].b = static_cast<unsigned char>((col_ptr[0]&0x1F) << 3);
					col[i].g = static_cast<unsigned char>(((col_ptr[0]&0xE0) >> 3) + ((col_ptr[1]&0x07) << 5));
					col[i].r = static_cast<unsigned char>(col_ptr[1]&0xF8);
					col[i].alpha = 0xFF;
					col_ptr+=2;
				}
			} else if(type == 7) {
				if(data.size() < image_ptr - &data.front() + 16 + w * h) {
					return false;
				}
				for(unsigned int i = 0; i < w*h; i++){
					col[i].b = *col_ptr;
					col[i].g = *col_ptr;
					col[i].r = *col_ptr;
					col[i].alpha = 0xFF;
					col_ptr+=1;
				}
			} else {
				if(data.size() < image_ptr - &data.front() + 16 + w * h * 2) {
					return false;
				}
				printf("unknown format\n"
					"filename\t%s\n"
					"format\t%d\n"
					"address\t%08x" ,put_filename, type, image_ptr - &data.front());
				for(unsigned int i = 0; i < w*h; i++){
					col[i].b = col_ptr[0];
					col[i].g = col_ptr[1];
					col[i].r = 0;
					col[i].alpha = 0xFF;
					col_ptr+=2;
				}
			}
			if(col_ptr != &image_ptr[16 + len]) {
				return false;
			}
			std::shared_ptr<Png> png = col_sum(put_filename, &col.front(), w, h, w2, h2);
			if(png) {
				//read_region(&base[0x40],*(short *)&base[0x04],base,fn,w2,h2,1);
				pngout(png->w, png->h, png->w, reinterpret_cast<unsigned char *>(&png->col.front()), put_filename, png->cn);
			} else {
				//read_region(&base[0x40],*(short *)&base[0x04],base,fn,w2,h2,0);
				/*fp = fopen(fn,"rb");
				while(fp != NULL){
					strcpy(&fn[strlen(fn)-4],"_.png");
					fclose(fp);
					fp = fopen(fn,"rb");
				}*/
				pngout(w, h, w, reinterpret_cast<unsigned char *>(&col.front()), put_filename, 32);
			}
		}
		if(*reinterpret_cast<const unsigned int *>(&cur[0x24]) == 0) {
			break;
		}
		cur += *reinterpret_cast<const unsigned int *>(&cur[0x24]);
	}
	return true;
}

bool head_print(std::vector<std::shared_ptr<LIST> > &list, const std::vector<unsigned char> data, unsigned int total_file_count) {
	list.resize(total_file_count);

	unsigned int file_count = 0;
	unsigned int total_size = 0;
	std::shared_ptr<LIST> prev;
	for(unsigned int i = 0; i < data.size() && file_count < total_file_count; i += 12, file_count++) {
		list[file_count].reset(new LIST());
		STRCPY(list[file_count]->fn, reinterpret_cast<const char *>(&data[i]));
		i += static_cast<unsigned int>(::ceil((STRLEN(list[file_count]->fn) + 1) / 4.0)) * 4;
		list[file_count]->addr = *reinterpret_cast<const unsigned int *>(&data[i]);
		if(list[file_count]->addr > th11dat.size) {
			return false;
		}
		if(prev) {
			prev->comp_size = list[file_count]->addr - prev->addr;
			total_size += prev->comp_size;
			if(total_size > th11dat.size) {
				return false;
			}
		}
		list[file_count]->size = *reinterpret_cast<const unsigned int *>(&data[i+4]);
		if(list[file_count]->size > 1024*1024*512){
			return false;
		}
		if(*reinterpret_cast<const unsigned int *>(&data[i+8]) != 0){
			return false;
		}
		prev = list[file_count];
	}
	if(file_count != total_file_count){
		return false;
	}
	prev->comp_size = th11dat.size - th11dat.comp_lsize - prev->addr;
	return 0;
}

} // TH11
