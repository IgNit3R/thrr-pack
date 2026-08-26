#include "stdafx.h"

namespace TouhouSE {

namespace WOLF {

namespace endian = boost::spirit::endian;

namespace {

const unsigned char table[] = {0xF0, 0x35, 0x6B, 0x1C, 0xFB, 0x9B, 0xED, 0x1D, 0x03, 0x70, 0xE3, 0x2D};

void decrypt(const unsigned int size, const unsigned int addr, unsigned char * const buf) {
  unsigned int key = addr % 0x0C;
  unsigned int i = 0;
  if (size >= 0x0C) {
    if (key != 0) {
      for (unsigned int index = key; index < 0x0C; index++, i++) {
        buf[i] ^= table[index];
      }
      key = 0;
    }
    if (size - i >= 0x0C) {
      const unsigned int key1 = *reinterpret_cast<const unsigned int *>(&table[0]);
      const unsigned int key2 = *reinterpret_cast<const unsigned int *>(&table[4]);
      const unsigned int key3 = *reinterpret_cast<const unsigned int *>(&table[8]);
      for (unsigned int count = (size - i) / 0x0C; count > 0; count--, i += 0x0C) {
        *reinterpret_cast<unsigned int *>(&buf[i+0]) ^= key1;
        *reinterpret_cast<unsigned int *>(&buf[i+4]) ^= key2;
        *reinterpret_cast<unsigned int *>(&buf[i+8]) ^= key3;
      }
    }
  }
  for (unsigned int index = key; i < size; i++, index = (index + 1) % 0x0C) {
    buf[i] ^= table[index];
  }
}

void uncompress(const unsigned char * const in, unsigned char * const out) {
  if (out == NULL || in == NULL) {
    return;
  }
  unsigned char *curOut = out;
  unsigned int size = *reinterpret_cast<const unsigned int *>(&in[4]);
  unsigned char flagId = in[8];
  const unsigned char *curIn = &in[9];
  size -= 9;
  while(size != 0) {
    if (flagId != curIn[0]) {
      *curOut = curIn[0];
      curOut++;
      curIn++;
      size--;
      continue;
    }
    if (curIn[1] == flagId) {
      *curOut = curIn[1];
      curOut++;
      curIn += 2;
      size -= 2;
      continue;
    }
    const unsigned int temp = curIn[1] + (curIn[1] > flagId ? -1 : 0);
    unsigned int len = temp >> 3;
    unsigned char type = temp & 0x03;
    size -= 2;
    curIn += 2;
    if ((temp&0x04) != 0) {
      len |= curIn[0] << 5;
      curIn++;
      size--;
    }
    len += 4;
    unsigned int offset;
    switch(type) {
    case 2:
      offset = (curIn[2] << 16) | *reinterpret_cast<const unsigned short *>(&curIn[0]);
      curIn += 3;
      size -= 3;
      break;
    case 1:
      offset = *reinterpret_cast<const unsigned short *>(&curIn[0]);
      curIn += 2;
      size -= 2;
      break;
    case 0:
      offset = curIn[0];
      curIn++;
      size--;
      break;
    default:
      break;
    }
    offset++;
    while (len > offset) {
      ::memcpy(curOut, curOut - offset, offset);
      curOut += offset;
      len -= offset;
      offset += offset;
    }
    ::memcpy(curOut, curOut - offset, len);
    curOut += len;
  }
}

} // anonymous

class Header : boost::noncopyable {
public:
  endian::ulittle8_t signature[4];
  endian::ulittle32_t footer_size;
  endian::ulittle32_t unknown1;
  endian::ulittle32_t unknown2;
  endian::ulittle32_t filename_footer_size;
  endian::ulittle32_t unknown3;

  bool Read(std::istream &in) {
		if (!in.good()) {
			return false;
		}
    const unsigned int addr = static_cast<unsigned int>(in.tellg());
		in.read(reinterpret_cast<char *>(this), sizeof(*this));
    decrypt(sizeof(*this), addr, reinterpret_cast<unsigned char *>(this));
		if (!in.good() || !IsValid()) {
			return false;
		}
		return true;
  }
	bool IsValid() const {
    const char expected_signature[] = {0x44, 0x58, 0x03, 0x00};
    return std::equal(expected_signature, &expected_signature[_countof(expected_signature)], signature)
      && filename_footer_size + 40 + 8 + 12 <= footer_size;
	}
};

class SignatureFooter {
public:
  endian::ulittle32_t unknown1;
  endian::ulittle32_t next_flag;
  endian::ulittle32_t file_count;
  endian::ulittle32_t unknown2;

  static bool Read(std::istream &in, std::vector<SignatureFooter> &result) {
    if (!in.good()) {
      return false;
    }
    in.seekg(-static_cast<int>(sizeof(SignatureFooter)), std::ios::end);
    for (unsigned int i = 0; ; i++) {
      const unsigned int addr = static_cast<unsigned int>(in.tellg());
      result.resize(i + 1);
      SignatureFooter &cur = result[i];
      in.read(reinterpret_cast<char *>(&cur), sizeof(SignatureFooter));
      decrypt(sizeof(SignatureFooter), addr, reinterpret_cast<unsigned char *>(&cur));
      if (!in.good() || !cur.IsValid()) {
        return false;
      }
      if (cur.next_flag == 0xFFFFFFFF) {
        break;
      }
      in.seekg(-static_cast<int>(sizeof(SignatureFooter)) * 2, std::ios::cur);
    }
    std::reverse(result.begin(), result.end());
    return true;
  }

	bool IsValid() const {
    return true;
	}
};

class AttributesFooterHeader : boost::noncopyable {
public:
  endian::ulittle8_t signature[4];
  endian::ulittle32_t version;

  bool Read(std::istream &in) {
    if (!in.good()) {
      return false;
    }
    const unsigned int addr = static_cast<unsigned int>(in.tellg());
    in.read(reinterpret_cast<char *>(this), sizeof(*this));
    decrypt(sizeof(*this), addr, reinterpret_cast<unsigned char *>(this));
    return in.good() && IsValid();
  }
	bool IsValid() const {
    const unsigned char expected_signature[] = {0xFF, 0xFF, 0xFF, 0xFF};
    return std::equal(expected_signature, &expected_signature[_countof(expected_signature)], signature)
      && (version == 4 || version == 0);
	}
};

class Attributes {
public:
  endian::ulittle8_t signature[4];
  endian::ulittle64_t create_time;
  endian::ulittle64_t last_write_time;
  endian::ulittle64_t last_access_time;
  endian::ulittle32_t offset;
  endian::ulittle32_t original_size;
  endian::ulittle32_t compress_size;
  endian::ulittle32_t unknown;

  static bool Read(std::istream &in, const std::vector<SignatureFooter> &footerList, std::vector<std::vector<Attributes> > &result) {
    if (!in.good() || footerList.size() == 0) {
      return false;
    }
    result.resize(footerList.size());
    for (unsigned int i = 0; i < result.size(); i++) {
      const SignatureFooter &footer = footerList[i];
      if (footer.file_count == 0) {
        result[i].resize(0);
        continue;
      }
      result[i].resize(footer.file_count);
      const unsigned int addr = static_cast<unsigned int>(in.tellg());
      const unsigned int readSize = sizeof(Attributes) * footer.file_count;
      in.read(reinterpret_cast<char *>(&result[i].front()), readSize);
      if (!in.good()) {
        return false;
      }
      decrypt(readSize, addr, reinterpret_cast<unsigned char *>(&result[i].front()));
      for (const Attributes &attr : result[i]) {
        if (!attr.IsValid()) {
          return false;
        }
      }
    }
    return true;
  }

	bool IsValid() const {
    const unsigned char expected_signature[][4] = {
      {0x20, 0x00, 0x00, 0x00},
      {0x10, 0x00, 0x00, 0x00}
    };
    return std::equal(expected_signature[0], &expected_signature[0][_countof(expected_signature)], signature)
      || std::equal(expected_signature[1], &expected_signature[1][_countof(expected_signature)], signature);
	}
};

class FilenameFooter {
public:
  endian::ulittle16_t length;
  endian::ulittle16_t unknown;
  std::string filename;

  static bool Read(std::istream &in, const std::vector<SignatureFooter> &footerList, std::vector<std::vector<FilenameFooter> > &result) {
    if (!in.good() || footerList.size() == 0) {
      return false;
    }
    in.seekg(4, std::ios::cur);
    if (footerList.size() == 1) {
      result.resize(1);
      return ReadImpl(in, footerList[0], result[0]);
    }
    const SignatureFooter &folderFooter = footerList[0];
    result.resize(footerList.size());
    result[0].resize(footerList.size() - 1);
    for (unsigned int i = 1; i < result.size(); i++) {
      if (footerList[i].next_flag != 0 && footerList[i].next_flag != 0xFFFFFFFF) {
        result[0][i-1].filename = '.';
      } else {
        if (!ReadSingle(in, result[0][i-1])) {
          return false;
        }
      }
      if (!ReadImpl(in, footerList[i], result[i])) {
        return false;
      }
    }
    return true;
  }

  static bool ReadImpl(std::istream &in, const SignatureFooter &footer, std::vector<FilenameFooter> &result) {
    if (!in.good()) {
      return false;
    }
    if (footer.file_count == 0) {
      result.resize(0);
      return true;
    }
    result.resize(footer.file_count);
    for (FilenameFooter &klass : result) {
      if (!ReadSingle(in, klass)) {
        return false;
      }
    }
    return true;
  }
  static bool ReadSingle(std::istream &in, FilenameFooter &result) {
    unsigned int addr = static_cast<unsigned int>(in.tellg());
    in.read(reinterpret_cast<char *>(&result.length), 4);
    decrypt(4, addr, reinterpret_cast<unsigned char *>(&result.length));
    if (!in.good() || result.length == 0) {
      return false;
    }
    addr += 4;
    std::vector<char> temp(result.length * 4);
    in.seekg(temp.size(), std::ios::cur);
    addr += temp.size();
    in.read(&temp.front(), temp.size());
    if (!in.good()) {
      return false;
    }
    decrypt(temp.size(), addr, reinterpret_cast<unsigned char *>(&temp.front()));
    result.filename = &temp.front();
    return true;
  }
};

class Footer : boost::noncopyable {
public:
  std::vector<std::vector<FilenameFooter> > filename_footer;
  AttributesFooterHeader attributes_footer_header;
  std::vector<std::vector<Attributes> > attributes;
  std::vector<SignatureFooter> signature_footer;

  bool Read(std::istream &in, const Header &header) {
    if (!in.good()) {
      return false;
    }
    if (!SignatureFooter::Read(in, signature_footer)) {
      return false;
    }
    in.seekg(-static_cast<int>(header.footer_size), std::ios::end);
    if (!FilenameFooter::Read(in, signature_footer, filename_footer)) {
      return false;
    }
    in.seekg(40, std::ios::cur);
    if (!attributes_footer_header.Read(in)) {
      return false;
    }
    if (!Attributes::Read(in, signature_footer, attributes)) {
      return false;
    }
    return true;
  }
};

class Owner : public ExtractorBase {
private:
	std::istream &in;
	const unsigned long long int file_size;
	const std::shared_ptr<const Header> header;
	const std::shared_ptr<const Footer> footer;

  Owner(std::istream &in, const unsigned long long int file_size, const std::shared_ptr<const Header> header, const std::shared_ptr<const Footer> footer) :
    in(in), file_size(file_size), header(header), footer(footer)
  {
  }

public:
  static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int file_size) {
    std::shared_ptr<Owner> result;
    if (file_size < sizeof(Header)) {
      return result;
    }

    const std::shared_ptr<Header> header = std::make_shared<Header>();
    if (!header->Read(in)) {
      return result;
    }

    const std::shared_ptr<Footer> footer = std::make_shared<Footer>();
    if (!footer->Read(in, *header)) {
      return result;
    }
    result.reset(new Owner(in, file_size, header, footer));
    return result;
  }

  bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
    if (!in.good()) {
      return false;
    }
    const std::pair<unsigned int, unsigned int> indexPair = GetIndex(index);
    const Attributes &attr = footer->attributes[indexPair.first][indexPair.second];
    if (attr.compress_size == 0 || attr.original_size == 0) {
      result.resize(0);
      return true;
    }
    const unsigned int addr = sizeof(Header) + attr.offset;
    in.seekg(addr);
    result.resize(attr.compress_size == 0xFFFFFFFF ? attr.original_size : attr.compress_size);
    in.read(reinterpret_cast<char *>(&result.front()), result.size());
    if (!in.good()) {
      return false;
    }
    decrypt(result.size(), addr, reinterpret_cast<unsigned char *>(&result.front()));
    if (attr.compress_size != 0xFFFFFFFF) {
      std::vector<unsigned char> decompress_data(attr.original_size);
      uncompress(&result.front(), &decompress_data.front());
      result.swap(decompress_data);
    }
    return true;
  }

  struct CountFile {
    unsigned int operator()(const unsigned int value, const SignatureFooter &footer) {
      return value + footer.file_count;
    }
  };

  unsigned int GetSize() const {
    if (footer->signature_footer.size() == 1) {
      return footer->signature_footer[0].file_count;
    }
    return std::accumulate(footer->signature_footer.begin() + 1, footer->signature_footer.end(), 0U, CountFile());
  }

  std::wstring GetName() const {
    return L"WOLF RPG";
  }

  std::filesystem::path GetFileName(const unsigned int index) const {
    if (footer->signature_footer.size() == 1) {
      return std::filesystem::path("data") / footer->filename_footer[0].at(index).filename;
    }
    const std::pair<unsigned int, unsigned int> indexPair = GetIndex(index);
    return std::filesystem::path("data") / footer->filename_footer[0][indexPair.first - 1].filename / footer->filename_footer[indexPair.first][indexPair.second].filename;
  }

  std::pair<unsigned int, unsigned int> GetIndex(unsigned int index) const {
    if (footer->signature_footer.size() == 1) {
      return std::make_pair(0U, index);
    }
    for (unsigned int i = 1; i < footer->signature_footer.size(); i++) {
      if (index < footer->signature_footer[i].file_count) {
        return std::make_pair(i, index);
      }
      index -= footer->signature_footer[i].file_count;
    }
    BOOST_ASSERT(false);
    return std::make_pair(0U, 0U);
  }
};

ADD_DAT_EXTRACTOR(Owner);

} // WOLF

} // TouhouSE
