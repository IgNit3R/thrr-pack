#include "stdafx.h"

namespace TNB {

using namespace ::Utility;

const unsigned int DIC_SIZE = 2048;

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class tnb_dictionary : boost::noncopyable {
public:
	tnb_dictionary(void) {
		memset(map, 0, sizeof(map));
		cur = 0;
	}
	void Add(const unsigned char *buffer, unsigned int length) {
		if(cur + length <= DIC_SIZE) {
			memcpy_s(&map[cur], DIC_SIZE - cur, buffer, length);
		} else {
			memcpy_s(&map[cur], DIC_SIZE - cur, buffer, DIC_SIZE - cur);
			for(unsigned int buf_len = length - (DIC_SIZE - cur); buf_len > 0; buf_len -= (std::min)(buf_len, DIC_SIZE)) {
				memcpy_s(map, DIC_SIZE, &buffer[length - buf_len], (std::min)(buf_len, DIC_SIZE));
			}
		}
		cur = (cur + length) % DIC_SIZE;
	}
	unsigned char Get(unsigned int pos) {
		BOOST_ASSERT(pos < DIC_SIZE);
		const unsigned char result = map[pos];
		map[cur] = result;
		cur = (cur + 1) % DIC_SIZE;
		return result;
	}
	void Get(unsigned char *out, unsigned int relative_pos, unsigned int length) {
		unsigned char *out_ptr = out;
		unsigned int pos;
		if(cur >= relative_pos) {
			pos = cur - relative_pos;
		} else {
			pos = cur + DIC_SIZE - relative_pos;
		}
		for(unsigned int i = 0; i < length; i++) {
			*out_ptr = Get(pos);
			pos = (pos + 1) % DIC_SIZE;
			out_ptr++;
		}
	}
protected:
	unsigned char map[DIC_SIZE];
	unsigned int cur;
};
#pragma warning(pop)
#pragma pack(pop)

#undef DIC_SIZE

void tnb_convert(const unsigned char *in, unsigned int in_size, unsigned char *out, unsigned int out_size){
	tnb_dictionary dic;

	BOOST_ASSERT(in_size < out_size);

#define IN_INC(n)	{in+=n;in_size-=n;}
#define OUT_INC(n)	{out+=n;out_size-=n;}

	while(in_size > 0 && out_size > 0){
		const unsigned int header = *in;
		IN_INC(1);
		if(header < 0x80){
			const unsigned int len = header + 1;
			BOOST_ASSERT(in_size >= len);
			BOOST_ASSERT(out_size >= len);
			memcpy_s(out, out_size, in, len);
			dic.Add(out, len);
			IN_INC(len);
			OUT_INC(len);
		} else {
			unsigned int len = (header & 0x0F) + 3;
			BOOST_ASSERT(in_size >= 1);
			unsigned int pos = *in + 1 + (0x100 * ((header >> 4) & 0x07));
			IN_INC(1);
			BOOST_ASSERT(out_size >= len);
			dic.Get(out, pos, len);
			OUT_INC(len);
		}
	}
}

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	if(file_data->comp_size == 0) {
		if(file_data->size == 0) {
			data.clear();
			return true;
		}
		return false;
	}
	std::vector<unsigned char> temp(file_data->comp_size);
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	if(temp.size() != ::fread(&temp.front(), 1, temp.size(), fp.get())) {
		return false;
	}
	if(file_data->size == file_data->comp_size) {
		data.swap(temp);
	} else if(file_data->size > file_data->comp_size) {
		data.resize(file_data->size);
		tnb_convert(&temp.front(), temp.size(), &data.front(), data.size());
	} else {
		return false;
	}
	return true;
}

bool tnb_ex_tga(const unsigned char *data, unsigned int size, const char *filename) {
	char put_filename[256];
	STRCPY(put_filename, filename);
	char * const file_ext = ::PathFindExtensionA(put_filename);
	*file_ext = '\0';
	STRCAT(put_filename, ".png");
	if(size < 18) {
		return false;
	}
	const bool palette_exists = (data[1] == 0x01);
	const unsigned int compress_type = data[2];
	const unsigned int w = *reinterpret_cast<const unsigned short*>(&data[12]);
	const unsigned int h = *reinterpret_cast<const unsigned short*>(&data[14]);
	const unsigned char cn = data[16];
	const unsigned char *p = &data[18];
	if(palette_exists && cn == 8) {
		const unsigned int palette_size = *reinterpret_cast<const unsigned short*>(&data[5]);
		if(palette_size > 256) {
			return false;
		}
		const unsigned char palette_cn = data[7];
		if(palette_cn == 32) {
			if(p + sizeof(Color) * palette_size > data + size) {
				return false;
			}
			::memcpy_s(&pal.front(), sizeof(Color) * pal.size(), p, sizeof(Color) * palette_size);
			p += sizeof(Color) * palette_size;
		} else if(palette_cn == 24){
			if(p + 3 * palette_size > data + size) {
				return false;
			}
			for(unsigned int i = 0; i < palette_size; i++) {
				memcpy_s(&pal[i], sizeof(Color) * (pal.size() - i), p, 3);
				p += 3;
				pal[i].alpha = 0xFF;
			}
		} else {
			return false;
		}
		for(unsigned int i = 0; i < 256; i++) {
			std::swap(pal[i].r, pal[i].b);
		}

		std::vector<unsigned char> map(w * h);
		if(compress_type == 0x01) {
			if(p + w * h > data + size) {
				return false;
			}
			memcpy_s(&map.front(), map.size(), p, w * h);
			p += w * h;
		} else if(compress_type == 0x09){
			unsigned char *c = &map.front();
			while(c <= &map.back()){
				if(p >= data+size) {
					return false;
				}
				if(*p >= 0x80){
					unsigned char *end = c + ((*p)&0x7f) + 1;
					if(end > &map.back()+1) {
						return false;
					}
					p++;
					if(p >= data+size) {
						return false;
					}
					while(c < end){
						*c = *p;
						c++;
					}
					p++;
				} else {
					if(p + *p + 2 > data+size || c + *p + 1 > &map.back()+1) {
						return false;
					}
					::memcpy(c, p + 1, static_cast<unsigned int>(*p + 1));
					c += *p + 1;
					p += *p + 2;
				}
			}
		} else {
			return false;
		}
		if(!(data[17]&0x20)){
			std::vector<unsigned char> temp(w);
			for(unsigned int i = 0; i < h/2; i++) {
				memcpy(&temp.front(), &map[w*i], w);
				memcpy_s(&map[w*i], map.size() - w * i, &map[w*(h-i-1)], w);
				memcpy_s(&map[w*(h-i-1)], map.size() - w * (h - i - 1), &temp.front(), w);
			}
		}
		if(data[17]&0x10){
			return false;
		}
		pngout(w, h, w, &map.front(), put_filename, 8);
	} else if(!palette_exists){
		std::vector<Color> map(w*h);
		if(cn == 32){
			if(compress_type == 0x02) {
				if(map.size() < w * h || p + w * h * sizeof(Color) > data+size) {
					return false;
				}
				::memcpy(&map.front(), p, w*h*sizeof(Color));
				p += w*h*sizeof(Color);
			} else if(compress_type == 0x0A) {
				Color *c = &map.front();
				while(c <= &map.back()) {
					if(p >= data+size) {
						return false;
					}
					if(*p >= 0x80){
						const unsigned int len = static_cast<unsigned int>(((*p)&0x7f));
						const Color * const end = c + len + 1;
						p++;
						if(end > &map.back()+1 || &p[3] >= data+size) {
							return false;
						}
						while(c < end) {
							c->b = p[0];
							c->g = p[1];
							c->r = p[2];
							c->alpha = p[3];
							c++;
						}
						p += 4;
					} else {
						const unsigned int len = *p;
						p++;
						const Color * const end = c + len + 1;
						if(&p[len * 4] > data+size || end > &map.back()+1) {
							return false;
						}
						while(c < end){
							c->b = p[0];
							c->g = p[1];
							c->r = p[2];
							c->alpha = p[3];
							c++;
							p+=4;
						}
					}
				}
			} else {
				return false;
			}
		} else if(cn == 24) {
			if(compress_type == 0x02) {
				if(map.size() < w * h || p + w * h * 3 > data+size) {
					return false;
				}
				for(unsigned int i = 0; i < w*h; i++) {
					map[i].b = p[0];
					map[i].g = p[1];
					map[i].r = p[2];
					map[i].alpha = 0xFF;
					p+=3;
				}
			} else if(compress_type == 0x0A) {
				Color *c = &map.front();
				while(c < &map.back()) {
					if(p >= data+size) {
						return false;
					}
					if(*p >= 0x80){
						const unsigned int len = static_cast<unsigned int>(((*p)&0x7f));
						const Color * const end = c + len + 1;
						p++;
						if(end > &map.back()+1 || &p[2] > data+size) {
							return false;
						}
						while(c < end) {
							c->b = p[0];
							c->g = p[1];
							c->r = p[2];
							c->alpha = 0xFF;
							c++;
						}
						p += 3;
					} else {
						const unsigned int len = *p;
						p++;
						const Color * const end = c + len + 1;
						if(&p[len * 3] > data+size || end > &map.back()+1) {
							return false;
						}
						while(c < end) {
							c->b = p[0];
							c->g = p[1];
							c->r = p[2];
							c->alpha = 0xFF;
							c++;
							p += 3;
						}
					}
				}
			} else {
				return false;
			}
		}
		if(!(data[17]&0x20)){ // 画像の配置順
			std::vector<Color> temp(w);
			for(unsigned int i = 0; i < h/2; i++) {
				memcpy(&temp.front(),								&map[w*i],		w*sizeof(Color));
				memcpy_s(&map[w*i],		sizeof(Color) * (map.size() - w * i),		&map[w*(h-i-1)],	w*sizeof(Color));
				memcpy_s(&map[w*(h-i-1)],	sizeof(Color) * (map.size() - w * (h-i-1)),	&temp.front(),	w*sizeof(Color));
			}
		}
		if(data[17]&0x10){
			return false;
		}
		pngout(w, h, w, reinterpret_cast<unsigned char*>(&map.front()), put_filename, 32);
	} else {
		return false;
	}
	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	const char * const file_ext = ::PathFindExtensionA(file_data->fn);
	if(strcmp(file_ext, ".tga") == 0){
		if(data.size() == 0) {
			return false;
		}
		return tnb_ex_tga(&data.front(), data.size(), file_data->fn);
	}

	std::shared_ptr<FILE> fp = MyFOpen(file_data->fn, "wb");
	if(file_data->size == 0) {
		return true;
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
	if(file_size < 12){
		return false;
	}
	unsigned int tail[2];
	::fseek(fp.get(), -static_cast<int>(sizeof(tail)), SEEK_END);
	if(2 != ::fread(tail, 4, 2, fp.get())) {
		return false;
	}
	const unsigned int addr = tail[1] * 4;
	if(tail[0] != 0x00000004 || addr >= file_size - 8){//識別子じゃないけど固定値なので識別子扱い
		return false;
	}
	::fseek(fp.get(), static_cast<int>(addr), SEEK_SET);
	unsigned int file_count;
	if(1 != ::fread(&file_count, 4, 1, fp.get())) {
		return false;
	}
	if(addr + 4 + file_count * 21 + 8 > file_size){
		return false;
	}

	list.resize(file_count);
	unsigned int last_addr = 0;
	for(unsigned int i = 0; i < file_count; i++) {
		list[i].reset(new LIST());
		if(1 != ::fread(&list[i]->addr, 4, 1, fp.get())) {
			return false;
		}
		list[i]->addr *= 4;
		if(1 != ::fread(&list[i]->comp_size, 4, 1, fp.get())) {
			return false;
		}
		if(1 != ::fread(&list[i]->size, 4, 1, fp.get())) {
			return false;
		}
		::fseek(fp.get(), 4, SEEK_CUR);
		unsigned int len;
		if(1 != ::fread(&len, 4, 1, fp.get())) {
			return false;
		}
		if(len > 99){
			return false;
		}
		if(len != ::fread(list[i]->fn, 1, len, fp.get())) {
			return false;
		}
		list[i]->fn[len] = '\0';
		if(last_addr < list[i]->addr + list[i]->comp_size) {
			last_addr = list[i]->addr + list[i]->comp_size;
		}
	}
	if(last_addr > addr) {
		return false;
	}
	return true;
}

} // TNB
