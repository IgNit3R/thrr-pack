#include "stdafx.h"

namespace DatUtility {

namespace {

#pragma warning(push)
#pragma warning(disable: 4512)
struct FindListExt {
	FindListExt(const char *ext) : ext(ext) { }
	const char * const ext;
	bool operator()(std::shared_ptr<LIST> file) const {
		const char * const file_ext = ::PathFindExtensionA(file->fn);
		return (::strcmp(ext, file_ext) == 0);
	}
};
#pragma warning(pop)

bool ThAnmImgCheck(const std::vector<unsigned char> &data) {
	BOOST_ASSERT(!data.empty());
	const unsigned char *cur = &data.front();
	while(true) {
		if(data.size() < static_cast<unsigned int>(cur - &data.front()) + 0x28) {
			return false;
		}
		const unsigned int image_filename_addr = *reinterpret_cast<const unsigned int *>(&cur[0x10]);
		if(data.size() <= image_filename_addr) {
			return false;
		}
		const char * const image_filename = reinterpret_cast<const char *>(cur) + image_filename_addr;
		if(strlen(image_filename) > 251 || strlen(image_filename) < 1 || data.size() < image_filename_addr + strlen(image_filename) + 1) {
			return false;
		}
		const unsigned int image_addr = *reinterpret_cast<const unsigned int *>(&cur[0x1C]);
		if(strcmp(&image_filename[strlen(image_filename)-4], ".png") == 0) {
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
			unsigned int color_num;
			if(type == 1){
				color_num = 4;
			} else if(type == 5){
				color_num = 2;
			} else if(type == 3){
				color_num = 2;
			} else if(type == 7) {
				color_num = 1;
			} else {
				return false;
			}
			if(data.size() < image_ptr - &data.front() + 16 + w * h * color_num) {
				return false;
			}
			if(w * h * color_num != len) {
				return false;
			}
		} else {
      if (image_addr != 0 || image_filename[0] != '@') {
        return false;
      }
    }
		if(*reinterpret_cast<const unsigned int *>(&cur[0x24])==0) {
			break;
		}
		cur += *reinterpret_cast<const unsigned int *>(&cur[0x24]);
	}
	return true;
}

} // anonymous

unsigned int CalcKeyIndex(std::shared_ptr<const LIST> file_data) {
	BOOST_ASSERT(file_data);
  return CalcKeyIndex(file_data->fn, ::strlen(file_data->fn));
}

unsigned int CalcKeyIndex(const char * const name, const unsigned int length) {
	unsigned int result = 0;
	for(unsigned int i = 0; i < length; i++) {
		result += static_cast<unsigned char>(name[i]);
	}
	return (result & 7);
}

std::shared_ptr<const LIST> ExtFindFile(const std::vector<std::shared_ptr<LIST> > &file_list, const char *ext) {
	std::shared_ptr<const LIST> result;
	std::vector<std::shared_ptr<LIST> >::const_iterator it = std::find_if(file_list.begin(), file_list.end(), FindListExt(ext));
	if(it != file_list.end()) {
		result = *it;
	}
	return result;
}

bool TryVerFileExtract(DAT_VER dat_ver, const std::vector<std::shared_ptr<LIST> > &file_list, std::shared_ptr<FILE> fp) {
	std::shared_ptr<const LIST> file_data = ExtFindFile(file_list, ".ver");
	if(!file_data) {
		return false;
	}

	std::vector<unsigned char> ver_data;
	const bool extract_result = Extract(ver_data, dat_ver, file_data, fp);
	if(!extract_result || ver_data.size() != file_data->size) {
		return false;
	}

	for(unsigned int i = 0; i < ver_data.size(); i++) {
		if(!isspace(ver_data[i]) && !isalnum(ver_data[i])) {
			return false;
		}
	}
	return true;
}

bool FindFile(const std::vector<std::shared_ptr<LIST> > &file_list, const char * const name, std::shared_ptr<LIST> &result) {
  for (const std::shared_ptr<LIST> file : file_list) {
    if (::strncmp(file->fn, name, sizeof(file->fn)) == 0) {
      result = file;
      return true;
    }
  }
  return false;
}

bool TryAnmFileExtractImpl(const DAT_VER dat_ver, const std::shared_ptr<LIST> file, const std::shared_ptr<FILE> fp) {
  std::vector<unsigned char> img_data;
  const bool extract_result = Extract(img_data, dat_ver, file, fp);
  if (!extract_result || img_data.empty()) {
    return false;
  }
  if (!ThAnmImgCheck(img_data)) {
    return false;
  }
  return true;
}

bool TryAnmFileExtractSingle(const DAT_VER dat_ver, const std::vector<std::shared_ptr<LIST> > &file_list, const std::shared_ptr<FILE> fp, const char * const name) {
  std::shared_ptr<LIST> file;
  if (!FindFile(file_list, name, file)) {
    // äYìñÉtÉ@ÉCÉãÇä‹Ç‹Ç»Ç¢èÍçáÇÕê¨å˜Ç∆ÇµÇƒàµÇ§
    return true;
  }
  if (!TryAnmFileExtractImpl(dat_ver, file, fp)) {
    return false;
  }
  return true;
}

bool TryAnmFileExtract(const DAT_VER dat_ver, const std::vector<std::shared_ptr<LIST> > &file_list, const std::shared_ptr<FILE> fp) {
	bool check_list[8];
	for(unsigned int i = 0; i < 8; i++) {
		check_list[i] = false;
	}
	unsigned int hit = 0;
	for(unsigned int id = 0; id < file_list.size() && hit < 8; id++) {
		const char * const file_ext = ::PathFindExtensionA(file_list[id]->fn);
		if(strcmp(file_ext, ".anm") != 0) {
			continue;
		}
		const unsigned int key_index = CalcKeyIndex(file_list[id]);
		if(check_list[key_index]) {
			continue;
		}
    if (!TryAnmFileExtractImpl(dat_ver, file_list[id], fp)) {
      return false;
    }
		check_list[key_index] = true;
		hit++;
	}
  const char * const list[] = {"title.anm"};
  for (const char * const name : list) {
    if (!TryAnmFileExtractSingle(dat_ver, file_list, fp, name)) {
      return false;
    }
  }
	return true;
}

} // DatUtility
