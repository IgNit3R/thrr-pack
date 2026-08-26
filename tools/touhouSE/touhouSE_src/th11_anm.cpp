
#include "stdafx.h"

namespace TouhouSE {

namespace TH11_ANM {

namespace endian = boost::spirit::endian;

class FileRecord {
private:
  class Header : boost::noncopyable {
  public:
    endian::ulittle32_t unknown1;
    endian::ulittle16_t region_count;
    endian::ulittle16_t attr_count;
    endian::ulittle16_t unknown2;
    endian::ulittle16_t width;
    endian::ulittle16_t height;
    endian::ulittle16_t type;
    endian::ulittle32_t name_offset;
    endian::ulittle16_t left;
    endian::ulittle16_t top;
    endian::ulittle32_t unknown3;
    endian::ulittle32_t image_offset;
    endian::ulittle32_t unknown4;
    endian::ulittle32_t next_offset;
    endian::ulittle8_t unknown5[0x18];
  };

  FileRecord(const std::string name, const unsigned int addr, const std::shared_ptr<const Header> header) :
    name(name), addr(addr), header(header)
  {}

public:
  const std::string name;
  const unsigned int addr;
  const std::shared_ptr<const Header> header;

  static bool Read(std::istream &in, const unsigned long long int file_size, std::vector<FileRecord> &result) {
    if (!in.good()) {
      return false;
    }
    std::shared_ptr<Header> header;
    unsigned int base_addr = 0;
    do {
      header = std::make_shared<Header>();
      in.seekg(base_addr);
      if (!in.good() || file_size < base_addr + sizeof(*header)) {
        return false;
      }
      in.read(reinterpret_cast<char *>(header.get()), sizeof(*header));
      if (!in.good() || file_size < base_addr + header->name_offset || file_size < base_addr + header->next_offset
        || file_size < base_addr + header->image_offset || header->unknown1 != 0x00000008 || header->unknown2 != 0
        || std::count(&header->unknown5[0], &header->unknown5[_countof(header->unknown5)], 0) != _countof(header->unknown5)) {
        return false;
      }
      std::string name;
      in.seekg(base_addr + header->name_offset);
      if (!in.good()) {
        return false;
      }
      while (true) {
        char c;
        in.read(&c, sizeof(c));
        if (!in.good()) {
          return false;
        }
        if (c == '\0') {
          break;
        }
        name.push_back(c);
      }
      if (std::filesystem::path(name).extension() == ".png") {
        result.push_back(FileRecord(name, base_addr, header));
      }
      base_addr += header->next_offset;
    } while(header->next_offset > 0);
    return true;
  }
};

class TouhouTexture: boost::noncopyable {
private:
  class Header : boost::noncopyable {
  public:
    char signature[4];
    endian::ulittle16_t unknown; // 常に0
    endian::ulittle16_t type;
    endian::ulittle16_t width;
    endian::ulittle16_t height;
    endian::ulittle32_t length;
  };

public:
  std::vector<Color> data;
  unsigned int width;
  unsigned int height;

  bool Read(std::istream &in, const unsigned long long int file_size, const FileRecord &record) {
    if (!in.good() || file_size < record.addr + record.header->image_offset + sizeof(Header)) {
      return false;
    }
    in.seekg(record.addr + record.header->image_offset);
    std::shared_ptr<Header> header = std::make_shared<Header>();
    in.read(reinterpret_cast<char *>(header.get()), sizeof(*header));
    if (!in.good() || file_size < record.addr + record.header->image_offset + sizeof(Header) + header->length
      || !std::equal(header->signature, &header->signature[sizeof(header->signature)], "THTX")
      || (header->length == 0 && (header->width != 0 || header->height != 0))
      || (header->length > 0 && (header->width == 0 || header->height == 0))
    ) {
      return false;
    }
    if (header->length == 0) {
      data.clear();
      return true;
    }
    std::vector<unsigned char> raw_data(header->length);
    in.read(reinterpret_cast<char *>(&raw_data.front()), raw_data.size());
    width = header->width;
    height = header->height;
    switch(header->type) {
    case 1:
      return ReadImage1(raw_data);
    case 3:
      return ReadImage3(raw_data);
    case 5:
      return ReadImage5(raw_data);
    case 7:
      return ReadImage7(raw_data);
    default:
      return false;
    }
  }

  bool ReadImage1(const std::vector<unsigned char> &in) {
    const unsigned int pixel_count = width * height;
    if (in.size() != pixel_count * 4) {
      return false;
    }
    data.resize(pixel_count);
    for (unsigned int i = 0; i < pixel_count; i++) {
      data[i].b     = in[i * 4 + 0];
      data[i].g     = in[i * 4 + 1];
      data[i].r     = in[i * 4 + 2];
      data[i].alpha = in[i * 4 + 3];
    }
    return true;
  }

  bool ReadImage3(const std::vector<unsigned char> &in) {
    const unsigned int pixel_count = width * height;
    if (in.size() != pixel_count * 2) {
      return false;
    }
    data.resize(pixel_count);
    for (unsigned int i = 0; i < pixel_count; i++) {
      data[i].b     = ((in[i * 2 + 0] & 0x1F) >> 0) * 0xFF / 0x1F;
      data[i].g     = ((*reinterpret_cast<const unsigned short *>(&in[i * 2 + 0]) & 0x07E0) >> 5) * 0xFF / 0x3F;
      data[i].r     = ((in[i * 2 + 1] & 0xF8) >> 3) * 0xFF / 0x1F;
      data[i].alpha = 0xFF;
    }
    return true;
  }

  bool ReadImage5(const std::vector<unsigned char> &in) {
    const unsigned int pixel_count = width * height;
    if (in.size() != pixel_count * 2) {
      return false;
    }
    data.resize(pixel_count);
    for (unsigned int i = 0; i < pixel_count; i++) {
      data[i].b     = ((in[i * 2 + 0] & 0x0F) >> 0) * 0xFF / 0x0F;
      data[i].g     = ((in[i * 2 + 0] & 0xF0) >> 4) * 0xFF / 0x0F;
      data[i].r     = ((in[i * 2 + 1] & 0x0F) >> 0) * 0xFF / 0x0F;
      data[i].alpha = ((in[i * 2 + 1] & 0xF0) >> 4) * 0xFF / 0x0F;
    }
    return true;
  }

  bool ReadImage7(const std::vector<unsigned char> &in) {
    const unsigned int pixel_count = width * height;
    if (in.size() != pixel_count) {
      return false;
    }
    data.resize(pixel_count);
    for (unsigned int i = 0; i < pixel_count; i++) {
      data[i].b = data[i].g = data[i].r = in[i];
      data[i].alpha = 0xFF;
    }
    return true;
  }

  bool ToPng(std::vector<unsigned char> &result) {
    return PNG::ToPng(width, height, data, result);
  }
};

class Owner : public ExtractorBase {
private:
	std::istream &in;
	const unsigned long long int file_size;
	const std::shared_ptr<const std::vector<FileRecord> > file_list;

  Owner(std::istream &in, const unsigned long long int file_size, const std::shared_ptr<const std::vector<FileRecord> > file_list) :
    in(in), file_size(file_size), file_list(file_list)
  {
  }

public:
  static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int file_size) {
    std::shared_ptr<Owner> result;

    const std::shared_ptr<std::vector<FileRecord> > list = std::make_shared<std::vector<FileRecord> >();
    if (!FileRecord::Read(in, file_size, *list)) {
      return result;
    }
    result.reset(new Owner(in, file_size, list));
    return result;
  }

  bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
    const FileRecord &record = file_list->at(index);
    TouhouTexture texture;
    if (!texture.Read(in, file_size, record)) {
      return false;
    }
    return texture.ToPng(result);
  }

  unsigned int GetSize() const {
    return file_list->size();
  }

  std::wstring GetName() const {
    return L"東方地霊殿アニメーション定義ファイル";
  }

  std::filesystem::path GetFileName(unsigned int index) const {
    return file_list->at(index).name;
  }
};


ADD_DAT_EXTRACTOR(Owner);

} // TH11_ANM

} // TouhouSE
