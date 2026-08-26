#include "stdafx.h"

namespace TouhouSE {

namespace NPA_V1 {

namespace endian = boost::spirit::endian;

#pragma pack(push, 1)
class Header : boost::noncopyable {
public:
	char signature[3];
	endian::ulittle32_t version;
	endian::ulittle32_t key1;
	endian::ulittle32_t key2;
	endian::ulittle8_t unknown1[2];
	endian::ulittle32_t fileCount;
	endian::ulittle8_t unknown2[20];

	bool Read(std::istream &in) {
		if (!in.good()) {
			return false;
		}
		in.read(reinterpret_cast<char *>(this), sizeof(*this));
		if (!in.good() || !IsValid()) {
			return false;
		}
		return true;
	}
	bool IsValid() const {
		return std::equal(&this->signature[0], &this->signature[_countof(this->signature)], "NPA") &&
			this->version == 0x00000001;
	}
};
class FileRecord /* std::vectorに入れるためコメントアウト : boost::noncopyable*/ {
public:
	enum TYPE {
		TYPE_DIR = 1, TYPE_FILE = 2
	};
	std::string fileName;
	endian::ulittle8_t type;
	endian::ulittle32_t unknown;
	endian::ulittle32_t address;
	endian::ulittle32_t size;
	endian::ulittle32_t origSize;

private:
	void FileNameDecrypt(const unsigned int key1, const unsigned int key2, const unsigned int key3) {
		const unsigned int tempKey = key1 * key2;
		const unsigned char key = 0-((tempKey >> 24) + (tempKey >> 16) + (tempKey >> 8) + tempKey + (key3 >> 24) + (key3 >> 16) + (key3 >> 8) + key3);
		static const unsigned char dec = 4;
		for (unsigned int i = 0; i < this->fileName.size(); i++) {
			this->fileName[i] += key - dec * i;
		}
	}
	unsigned char CreateFileDecryptKey(const unsigned int keySeed) const {
		unsigned char result = 0xDF;
		for (const unsigned char c : this->fileName) {
			result += c;
		}
		return static_cast<unsigned char>((result * this->fileName.size() - keySeed) * this->origSize);
	}

public:
	bool Read(std::istream &in, const std::shared_ptr<const Header> header, const unsigned int key) {
		if (!in.good()) {
			return false;
		}
		endian::ulittle32_t fileNameSize;
		in.read(reinterpret_cast<char *>(&fileNameSize), sizeof(fileNameSize));
		if (!in.good() || fileNameSize == 0) {
			return false;
		}
		fileName.resize(fileNameSize);
		in.read(&fileName.front(), fileName.size());
		if (!in.good()) {
			return false;
		}
		FileNameDecrypt(header->key1, header->key2, key);
		in.read(reinterpret_cast<char *>(&this->type), sizeof(*this) - sizeof(fileName));
		if (!in.good() || !IsValid()) {
			return false;
		}
		return true;
	}
	bool IsValid() const {
		if (this->fileName.find('\0') != std::string::npos ||
			(this->origSize != 0 && this->size == 0))
		{
			return false;
		}
		if (this->type == TYPE_DIR) {
			if (this->size != 0 || this->origSize != 0) {
				return false;
			}
		} else if (this->type == TYPE_FILE) {
		} else {
			return false;
		}
		return true;
	}
	void FileBodyDecrypt(const unsigned int keySeed, std::vector<unsigned char> &body) const {
		static const unsigned char dic[0x100] = {
			0xF1, 0x71, 0x80, 0x19, 0x17, 0x01, 0x74, 0x7D, 0x90, 0x47, 0xF9, 0x68, 0xDE, 0xB4, 0x24, 0x40,
			0x73, 0x9E, 0x5B, 0x38, 0x4C, 0x3A, 0x2A, 0x0D, 0x2E, 0xB9, 0x5C, 0xE9, 0xCE, 0xE8, 0x3E, 0x39,
			0xA2, 0xF8, 0xA8, 0x5E, 0x1D, 0x1B, 0xD3, 0x23, 0xCB, 0x9B, 0xB0, 0xD5, 0x59, 0xF0, 0x3B, 0x09,
			0x4D, 0xE4, 0x4A, 0x30, 0x7F, 0x89, 0x44, 0xA0, 0x7A, 0x3C, 0xEE, 0x0E, 0x66, 0xBF, 0xC9, 0x46,
			0x77, 0x21, 0x86, 0x78, 0x6E, 0x8E, 0xE6, 0x99, 0x33, 0x2B, 0x0C, 0xEA, 0x42, 0x85, 0xD2, 0x8F,
			0x5F, 0x94, 0xDA, 0xAC, 0x76, 0xB7, 0x51, 0xBA, 0x0B, 0xD4, 0x91, 0x28, 0x72, 0xAE, 0xE7, 0xD6,
			0xBD, 0x53, 0xA3, 0x4F, 0x9D, 0xC5, 0xCC, 0x5D, 0x18, 0x96, 0x02, 0xA5, 0xC2, 0x63, 0xF4, 0x00,
			0x6B, 0xEB, 0x79, 0x95, 0x83, 0xA7, 0x8C, 0x9A, 0xAB, 0x8A, 0x4E, 0xD7, 0xDB, 0xCA, 0x62, 0x27,
			0x0A, 0xD1, 0xDD, 0x48, 0xC6, 0x88, 0xB6, 0xA9, 0x41, 0x10, 0xFE, 0x55, 0xE0, 0xD9, 0x06, 0x29,
			0x65, 0x6A, 0xED, 0xE5, 0x98, 0x52, 0xFF, 0x8D, 0x43, 0xF6, 0xA4, 0xCF, 0xA6, 0xF2, 0x97, 0x13,
			0x12, 0x04, 0xFD, 0x25, 0x81, 0x87, 0xEF, 0x2F, 0x6C, 0x84, 0x2C, 0xAA, 0xA1, 0xAF, 0x36, 0xCD,
			0x92, 0x0F, 0x2D, 0x67, 0x45, 0xE2, 0x64, 0xB3, 0x20, 0x50, 0x4B, 0xF3, 0x7B, 0x1F, 0x1C, 0x03,
			0xC4, 0xC1, 0x16, 0x61, 0x6F, 0xC7, 0xBE, 0x05, 0xAD, 0x22, 0x34, 0xB2, 0x54, 0x37, 0xF7, 0xD0,
			0xFA, 0x60, 0x8B, 0x14, 0x08, 0xBC, 0xEC, 0xBB, 0x26, 0x9C, 0x57, 0x32, 0x5A, 0x3F, 0x35, 0x6D,
			0xC8, 0xC3, 0x69, 0x7C, 0x31, 0x58, 0xE3, 0x75, 0xD8, 0xE1, 0xC0, 0x9F, 0x11, 0xB5, 0x93, 0x56,
			0xF5, 0x1E, 0xB1, 0x1A, 0x70, 0x3D, 0xFB, 0x82, 0xDC, 0xDF, 0x7E, 0x07, 0x15, 0x49, 0xFC, 0xB8
		};
		if (body.size() == 0) {
			return;
		}
		const unsigned char key = CreateFileDecryptKey(keySeed);
		const unsigned int loopMax = (std::min)(body.size(), 0x1000 + this->fileName.size());
		for (unsigned int i = 0; i < loopMax; i++) {
			body[i] = dic[body[i]] + key - i;
		}
	}
};
#pragma pack(pop)

class Owner : public ExtractorBase {
private:
	std::istream &in;
	const unsigned long long int fileSize;
	const unsigned long long int baseAddr;
	const std::shared_ptr<const Header> header;
	const std::shared_ptr<const std::vector<FileRecord> > fileList;

	Owner(std::istream &in, const unsigned long long int fileSize, const unsigned long long int baseAddr, const std::shared_ptr<const Header> header, const std::shared_ptr<const std::vector<FileRecord> > fileList) :
		in(in), fileSize(fileSize), baseAddr(baseAddr), header(header), fileList(fileList)
	{
	}

public:
	static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int fileSize) {
		std::shared_ptr<Owner> result;
		const std::shared_ptr<Header> header = std::make_shared<Header>();
		static const unsigned int FILE_RECOD_SIZE_MIN = 18;
		if (!header->Read(in) || fileSize < sizeof(*header) + header->fileCount * FILE_RECOD_SIZE_MIN) {
			return result;
		}
		const std::shared_ptr<std::vector<FileRecord> > fileList = std::make_shared<std::vector<FileRecord> >(header->fileCount);
		for (unsigned int i = 0; i < fileList->size(); i++) {
			if (!fileList->at(i).Read(in, header, i)) {
				return result;
			}
		}
		unsigned int maxAddr = 0;
		for (unsigned int i = 0; i < fileList->size(); i++) {
			if (fileList->at(i).type == FileRecord::TYPE_DIR) {
				// FileRecord::Readと並行すると復号に失敗するため分離
				fileList->erase(fileList->begin() + i);
				i--;
				continue;
			}
			maxAddr = (std::max)(maxAddr, fileList->at(i).address + fileList->at(i).size);
		}
		const unsigned long long int baseAddr = in.tellg();
		if (fileSize < baseAddr + maxAddr) {
			return result;
		}
		result.reset(new Owner(in, fileSize, baseAddr, header, fileList));
		return result;
	}
	bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
		if (index >= this->fileList->size() || !in.good()) {
			return false;
		}
		const FileRecord &file = this->fileList->at(index);
		if (file.origSize == 0) {
			result.clear();
			return true;
		}
		in.seekg(this->baseAddr + file.address, std::istream::beg);
		if (!in.good()) {
			return false;
		}
		const bool isCompress = (file.size != file.origSize);
		std::vector<unsigned char> deflateDataImpl;
		std::vector<unsigned char> &deflateData = (isCompress ? deflateDataImpl : result);
		deflateData.resize(file.size);
		in.read(reinterpret_cast<char *>(&deflateData.front()), deflateData.size());
		if (!in.good()) {
			return false;
		}
		file.FileBodyDecrypt(this->header->key1 * this->header->key2, deflateData);
		if (!isCompress) {
			return true;
		}
		result.resize(file.origSize);
		uLongf origSize = file.origSize;
		if (Z_OK != ::uncompress(reinterpret_cast<Bytef *>(&result.front()), &origSize, &deflateData.front(), file.size) ||
			origSize != file.origSize)
		{
			return false;
		}
		return true;
	}
	unsigned int GetSize() const {
		return fileList->size();
	}
	std::wstring GetName() const {
		return L"NitroPlusArchive Ver1";
	}
	std::filesystem::path GetFileName(const unsigned int index) const {
		return this->fileList->at(index).fileName;
	}
};

ADD_DAT_EXTRACTOR(Owner);

} // NFA0_V1

} // TouhouSE
