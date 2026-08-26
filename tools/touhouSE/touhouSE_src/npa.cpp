#include "stdafx.h"

namespace NPA {

using namespace ::Utility;

namespace {

void UnCrypt(unsigned char *data, unsigned int size) {
	const unsigned char map[] = {0xBD, 0xAA, 0xBC, 0xB4, 0xAB, 0xB6, 0xBC, 0xB4};
	for(unsigned int i = 0; i < size; i++) {
		data[i] ^= map[i % (sizeof(map) / sizeof(*map))];
	}
}

} // anonymous

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp) {
	BOOST_ASSERT(file_data->comp_size == file_data->size);
	if(file_data->size == 0) {
		data.clear();
		return true;
	}
	data.resize(file_data->size);
	::fseek(fp.get(), static_cast<int>(file_data->addr), SEEK_SET);
	if(data.size() != ::fread(&data.front(), 1, data.size(), fp.get())) {
		return false;
	}
	UnCrypt(&data.front(), data.size());
	return true;
}

bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &, std::shared_ptr<FILE>) {
	const char * const file_ext = ::PathFindExtensionA(file_data->fn);
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
	if(file_size < 4){
		return false;
	}
	::fseek(fp.get(), 0, SEEK_SET);
	unsigned int head_size;
	if(1 != fread(&head_size, 4, 1, fp.get())) {
		return false;
	}
	unsigned int read_size = 4;
	if(head_size < 4 || file_size < read_size + head_size) {
		return false;
	}
	std::vector<unsigned char> head_data(head_size);
	if(head_size != ::fread(&head_data.front(), 1, head_size, fp.get())) {
		return false;
	}
	read_size += head_size;
	UnCrypt(&head_data.front(), head_data.size());
	const unsigned char *p = &head_data.front();
	const unsigned int file_count = *reinterpret_cast<const unsigned int *>(p);
	p += 4;
	if (file_size < read_size + static_cast<unsigned long long int>(file_count) * (4 + 1 + 4 + 4 + 4)) {
		return false;
	}

	list.resize(file_count);
	unsigned int last_addr = 0;
	const unsigned char * const end = &head_data.back();
	for(unsigned int i = 0; i < file_count; i++) {
		list[i].reset(new LIST());
		if(end - p + 1 < 4) {
			return false;
		}
		const unsigned int filename_length = *reinterpret_cast<const unsigned int *>(p);
		p += 4;
		if(filename_length > 99 || static_cast<unsigned int>(std::distance(p, end + 1)) < filename_length + 12) {
			return false;
		}
		if(0 != ::memcpy_s(list[i]->fn, sizeof(list[i]->fn), p, filename_length)) {
			return false;
		}
		p += filename_length;
		list[i]->fn[filename_length] = '\0';
		list[i]->comp_size = list[i]->size = *reinterpret_cast<const unsigned int *>(p);
		p += 4;
		list[i]->addr = *reinterpret_cast<const unsigned int *>(p);
		p += 4;
		p += 4; // unknown
		if(last_addr < list[i]->addr + list[i]->comp_size) {
			last_addr = list[i]->addr + list[i]->comp_size;
		}
	}
	if(last_addr > file_size) {
		return false;
	}
	return true;
}

} // NPA
