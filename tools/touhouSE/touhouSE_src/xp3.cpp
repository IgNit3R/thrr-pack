#include "stdafx.h"

namespace XP3 {

namespace endian = boost::spirit::endian;

#pragma pack(push, 1)
class Header : boost::noncopyable {
public:
	char signature[4];
	endian::ulittle16_t version;
	endian::ulittle8_t unknown0[2];
	endian::ulittle32_t fileCount;
	endian::ulittle8_t unknown1[4];

	bool IsValid() const {
		return std::equal(&this->signature[0], &this->signature[_countof(this->signature)], "NFA0") &&
			this->version == 1;
	}
};
class Footer : boost::noncopyable {
public:
	endian::ulittle8_t unknown1;
	endian::ulittle64_t size;
	endian::ulittle64_t unknown2;
};
class FileRecord /* std::vectorに入れるためコメントアウト : boost::noncopyable*/ {
public:
	FileRecord() {}
	endian::ulittle8_t unknown[8];
	endian::ulittle32_t size;
	endian::ulittle32_t address;
	endian::ulittle32_t flags;
	wchar_t name[64];
	
	void Decrypt() {
		BOOST_FOREACH(char &c, std::make_pair(reinterpret_cast<char *>(this), &reinterpret_cast<char *>(this)[sizeof(*this)])) {
			c ^= 0x08;
		}
	}
	bool IsValid() const {
		return std::find(&this->name[0], &this->name[_countof(this->name)], '\0') != &this->name[_countof(this->name)];
	}
};
#pragma pack(pop)

class Owner : public ExtractorBase {
private:
	std::istream &in;
	const unsigned long long int fileSize;
	const std::shared_ptr<const Header> header;
	const std::shared_ptr<const std::vector<FileRecord> > fileList;

	Owner(std::istream &in, const unsigned long long int fileSize, const std::shared_ptr<const Header> header, const std::shared_ptr<const std::vector<FileRecord> > fileList) :
		in(in), fileSize(fileSize), header(header), fileList(fileList)
	{
		return;
	}

public:
	static std::shared_ptr<Owner> Open(std::istream &in, const unsigned long long int fileSize) {
		std::shared_ptr<Owner> result;
		if (!in.good()) {
			return result;
		}
		const std::shared_ptr<Header> header(new Header());
		in.read(reinterpret_cast<char *>(header.get()), sizeof(*header));
		if (!in.good() || !header->IsValid() ||
			fileSize < sizeof(*header) + static_cast<unsigned long long int>(sizeof(FileRecord)) * header->fileCount)
		{
			return result;
		}
		const std::shared_ptr<std::vector<FileRecord> > fileList(new std::vector<FileRecord>(header->fileCount));
		if (header->fileCount > 0) {
			in.read(reinterpret_cast<char *>(&fileList->front()), sizeof(FileRecord) * header->fileCount);
			if (!in.good()) {
				return result;
			}
			BOOST_FOREACH(FileRecord &file, *fileList) {
				file.Decrypt();
				if (!file.IsValid() || static_cast<unsigned long long int>(file.address) + file.size > fileSize) {
					return result;
				}
			}
		}
		return std::shared_ptr<Owner>(new Owner(in, fileSize, header, fileList));
	}
	bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
		if (index >= GetSize() || !in.good()) {
			return false;
		}
		const FileRecord &file = fileList->at(index);
		if (file.size == 0) {
			result.clear();
			return true;
		}
		result.resize(file.size);
		in.read(reinterpret_cast<char *>(&result.front()), result.size());
		if (!in.good()) {
			return false;
		}
		if (true || file.flags == 1) {
			BOOST_FOREACH(unsigned char &c, result) {
				c ^= 0x08;
			}
		}
		return true;
	}
	unsigned int GetSize() const {
		return fileList->size();
	}
	std::wstring GetName() const {
		return L"吉里吉里 XP3";
	}
	std::filesystem::path GetFileName(const unsigned int index) const {
		return this->fileList->at(index).name;
	}
};

ADD_DAT_EXTRACTOR(Owner);

} // XP3
