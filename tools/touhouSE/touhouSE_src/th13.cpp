#include "stdafx.h"

namespace TH13 {

using namespace ::Utility;
using namespace TH11;
using namespace DatUtility;

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	static unsigned int conv_map[8][4] = {
		{0x1b,	0x73,	0x0100,	0x3800},
		{0x12,	0x43,	0x0200,	0x3E00},
		{0x35,	0x79,	0x0400,	0x3C00},
		{0x03,	0x91,	0x0080,	0x6400},
		{0xab,	0xdc,	0x0080,	0x6E00},
		{0x51,	0x9E,	0x0100,	0x4000},
		{0xc1,	0x15,	0x0400,	0x2C00},
		{0x99,	0x7d,	0x0080,	0x4400}
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
			return Touhou::Msg::TH13EndingMsg2Txt(file_data, data);
		} else {
			return Touhou::Msg::TH13Msg2Txt(file_data, data);
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

	if(!TryVerFileExtract(DAT_VAR_TH13, list, fp)) {
		return false;
	}

	if(!TryAnmFileExtract(DAT_VAR_TH13, list, fp)) {
		return false;
	}
	return true;
}

} // TH13
