#include "stdafx.h"

namespace THMJ {

using namespace Utility;

bool thmj_convert(const unsigned char *in, unsigned int in_size, unsigned char *out, unsigned int out_size) {
	unsigned char dic[0x1000];
	unsigned int addr = 0xFF0;

	memset(dic, 0, 0x1000);
	const unsigned char *in_ptr = in;
	const unsigned char * const in_end = &in[in_size];
	unsigned char *out_ptr = out;
	const unsigned char * const out_end = &out[out_size];
	while(out_ptr < out_end && in_ptr < in_end){
		unsigned int flags = static_cast<unsigned int>(*in_ptr + 0x100);
		in_ptr++;
		while(flags > 1) {
			if((flags&0x01) == 1){
				if(in_ptr >= in_end || out_ptr >= out_end) {
					return false;
				}
				*out_ptr = *in_ptr;
				dic[addr] = *in_ptr;
				out_ptr++;
				in_ptr++;
				addr = (addr + 1) % sizeof(dic);
			} else {
				if(&in_ptr[2] > in_end) {
					return false;
				}
				unsigned int dic_ptr = static_cast<unsigned int>(in_ptr[0] + ((in_ptr[1]&0xF0) << 4));
				const unsigned int len = static_cast<unsigned int>((in_ptr[1]&0x0F) + 3);
				if(&out_ptr[len] > out_end) {
					return false;
				}
				in_ptr += 2;
				for(unsigned int i = 0; i < len; i++) {
					*out_ptr = dic[dic_ptr];
					out_ptr++;
					dic[addr] = dic[dic_ptr];
					addr = (addr + 1) % sizeof(dic);
					dic_ptr = (dic_ptr + 1) % sizeof(dic);
				}
			}
			if(in_ptr == in_end) {
				break;
			}
			flags >>= 1;
		}
	}
	return true;
}

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	if(file_data->size == 0) {
		data.clear();
		return true;
	}
	data.resize(file_data->size);
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	::fread(&data.front(), 1, data.size(), fp.get());
	if(data.size() < 4) {
		return true;
	}
	if(::memcmp(&data[0], "LZSS", 4) == 0) {
		const unsigned int out_size = *reinterpret_cast<unsigned int*>(&data[4]);
		std::vector<unsigned char> out(out_size);
		if(!thmj_convert(&data[8], data.size() - 8, &out[0], out_size)) {
			return false;
		}
		data.swap(out);
	}

	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	char dir[MAX_PATH];
	::GetCurrentDirectoryA(MAX_PATH, dir);
	std::shared_ptr<FILE> fp = MyFOpen(file_data->fn, "wb");
	if(!fp) {
		return false;
	}
	if(data.empty()) {
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
	const unsigned int dat_size = static_cast<unsigned int>(::ftell(fp.get()));
	if(dat_size < 16) {
		return false;
	}
	::fseek(fp.get(), 0, SEEK_SET);
	unsigned char head[8];
	if(sizeof(head) != ::fread(head, 1, sizeof(head), fp.get())) {
		return false;
	}
	if(*reinterpret_cast<const unsigned int *>(head) != 0x4B434150) {//Ž¯•ÊŽqPACK
		return false;
	}
	const unsigned int file_count = *reinterpret_cast<unsigned int*>(&head[4]);
	if(dat_size <= file_count * 80) {
		return false;
	}

	list.resize(file_count);
	for(unsigned int i = 0; i < file_count; i++) {
		list[i].reset(new LIST());
		if(64 != ::fread(list[i]->fn, 1, 64, fp.get())) {
			return false;
		}
		if(STRLEN(list[i]->fn) >= 64){
			return false;
		}
		::fseek(fp.get(), 8, SEEK_CUR);
		if(1 != ::fread(&list[i]->addr, 4, 1, fp.get())) {
			return false;
		}
		if(1 != ::fread(&list[i]->comp_size, 4, 1, fp.get())) {
			return false;
		}
		list[i]->size = list[i]->comp_size;
	}
	return true;
}

} // THMJ
