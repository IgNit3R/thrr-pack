
#include "stdafx.h"

namespace TouhouSE {

namespace TGA {

namespace endian = boost::spirit::endian;

#pragma pack(push, 1)
class Header : boost::noncopyable {
public:
	enum TYPE : unsigned char {
		TYPE_EMPTY = 0,
		TYPE_INDEX_COLOR,
		TYPE_FULL_COLOR,
		TYPE_GRAY_SCALE,
		TYPE_RLE_INDEX_COLOR = 9,
		TYPE_RLE_FULL_COLOR,
		TYPE_RLE_GRAY_SCALE,
	};
	endian::ulittle8_t idLength;
	endian::ulittle8_t colorMapType;
	TYPE type;
	class ColorMapSpec : boost::noncopyable {
	public:
		endian::ulittle16_t firstEntryIndex;
		endian::ulittle16_t length;
		endian::ulittle8_t entrySize;

		bool IsValid() const {
			return IsEmpty() || 
				(
					this->firstEntryIndex + this->length <= 255 &&
					(this->entrySize == 8 ||
					this->entrySize == 15 ||
					this->entrySize == 16 ||
					this->entrySize == 24 ||
					this->entrySize == 32)
				);
		}
		bool IsEmpty() const {
			return this->firstEntryIndex == 0 &&
				this->length == 0 &&
				this->entrySize == 0;
		}
	} colorMapSpec;
	endian::ulittle16_t xOrigin;
	endian::ulittle16_t yOrigin;
	endian::ulittle16_t width;
	endian::ulittle16_t height;
	endian::ulittle8_t pixelDepth;
	endian::ulittle8_t imageDescriptor; // 0-3:αチャンネルのビット数、4:ピクセルデータが右から左か、5:ピクセルデータが上から下か、6-7:予約済み

	unsigned int GetAlphaSize() const {
		return this->imageDescriptor & 0x0F;
	}
	bool IsRight2Left() const {
		return (this->imageDescriptor&0x10) != 0;
	}
	bool IsTop2Bottom() const {
		return (this->imageDescriptor&0x20) != 0;
	}
	bool IsValid() const {
		switch (this->type) {
			case TYPE_EMPTY:
				if (this->width != 0 || this->height != 0) {
					return false;
				}
				break;
			case TYPE_INDEX_COLOR:
			case TYPE_RLE_INDEX_COLOR: {
				const unsigned int alpha = GetAlphaSize();
				if (this->colorMapType != 1 || !this->colorMapSpec.IsValid() || this->pixelDepth != 8 ||
					(this->colorMapSpec.length == 0 && (this->width != 0 || this->height != 0)) ||
					(this->colorMapSpec.entrySize == 15 && alpha > 1) ||
					(this->colorMapSpec.entrySize == 16 && alpha > 1) ||
					(this->colorMapSpec.entrySize == 24 && alpha != 0 && alpha != 8) ||
					(this->colorMapSpec.entrySize == 32 && alpha != 0 && alpha != 8))
				{
						return false;
				}
				break;
			}
			case TYPE_GRAY_SCALE:
			case TYPE_RLE_GRAY_SCALE:
				if (this->colorMapType != 0 || !this->colorMapSpec.IsEmpty() || this->pixelDepth != 8) {
					return false;
				}
				break;
			case TYPE_FULL_COLOR:
			case TYPE_RLE_FULL_COLOR: {
				const unsigned int alpha = GetAlphaSize();
				if (this->colorMapType != 0 || !this->colorMapSpec.IsEmpty() ||
					(this->pixelDepth == 15 && alpha > 1) ||
					(this->pixelDepth == 16 && alpha > 1) ||
					(this->pixelDepth == 24 && alpha != 0 && alpha != 8) ||
					(this->pixelDepth == 32 && alpha != 0 && alpha != 8))
				{
					return false;
				}
				break;
			}
			default:
				return false;
		}
		return (this->imageDescriptor&0xC0) == 0;
	}
	bool IsEmpty() const {
		return this->width == 0 && this->height == 0;
	}
};

class Footer : boost::noncopyable {
public:
	endian::ulittle32_t extensionAreaOffset;
	endian::ulittle32_t developerDirectoryOffset;
	union {
		char version1[17];
		struct {
			char value[16];
			endian::ulittle8_t reserved;
		} version2;
	} signature;
	endian::ulittle8_t terminator;

	bool IsValid() const {
		return (
			std::equal(&this->signature.version1[0], &this->signature.version1[_countof(this->signature.version1)], "TRUEVISION-TARGA\0") ||
			(std::equal(&this->signature.version2.value[0], &this->signature.version2.value[_countof(this->signature.version2.value)], "TRUEVISION-XFILE") &&
				this->signature.version2.reserved == '.')
			) &&
			this->terminator == 0;
	}
};

class DateTime : boost::noncopyable {
public:
	endian::ulittle16_t month;
	endian::ulittle16_t day;
	endian::ulittle16_t year;
	endian::ulittle16_t hour;
	endian::ulittle16_t minute;
	endian::ulittle16_t second;

	bool IsValid() const {
		return IsEmpty() ||
			(
			0 < this->month && this->month < 13 &&
			0 < this->day && this->day < 32 &&
			this->year < 10000 &&
			this->hour < 24 &&
			this->minute < 60 &&
			this->second < 60
			);
	}
	bool IsEmpty() const {
		return this->month == 0 && this->day == 0 && this->year == 0 && this->hour == 0 && this->minute == 0 && this->second == 0;
	}
};

class Time : boost::noncopyable {
public:
	endian::ulittle16_t hours;
	endian::ulittle16_t minutes;
	endian::ulittle16_t seconds;

	bool IsValid() const {
		return IsEmpty() ||
			(
			this->minutes < 60 &&
			this->seconds < 60
			);
	}
	bool IsEmpty() const {
		return this->hours == 0 && this->minutes == 0 && this->seconds == 0;
	}
};

class Version : boost::noncopyable {
public:
	endian::ulittle16_t number;
	char letter;

	bool IsValid() const {
		return ::isprint(this->letter) != 0;
	}
	bool IsEmpty() const {
		return this->number == 0 && this->letter == ' ';
	}
};

class ExtensionArea : boost::noncopyable {
public:
	endian::ulittle16_t size;
	char authorName[41];
	char authorComments[324];
	DateTime timeStamp;
	Time jobTime;
	char softwareId[41];
	Version softwareVersion;
	struct {
		unsigned char b;
		unsigned char g;
		unsigned char r;
		unsigned char a;
	} keyColor;
	struct {
		endian::ulittle16_t numerator;
		endian::ulittle16_t denominator;
	} pixelAspectRatio;
	struct {
		endian::ulittle16_t numerator;
		endian::ulittle16_t denominator;
	} gammma;
	endian::ulittle32_t colorCorrectionOffset;
	endian::ulittle32_t postageStampOffset;
	endian::ulittle32_t scanLineOffset;
	endian::ulittle8_t attributes;
};

class DeveloperDirectory : boost::noncopyable {
public:
	// TODO
};

class Tga : public ImageBase<Tga>, boost::noncopyable {
private:
	const std::shared_ptr<const Header> header;
	const std::shared_ptr<const std::vector<char> > id;
	const std::shared_ptr<const std::vector<unsigned char> > colorMap;
	const std::shared_ptr<const std::vector<unsigned char> > data;
	/*
	std::shared_ptr<ExtensionArea> extensionArea;
	std::shared_ptr<DeveloperDirectory> developerDerectory;
	std::shared_ptr<Footer> footer;*/

	Tga(const std::shared_ptr<const Header> &header,
		const std::shared_ptr<const std::vector<char> > &id,
		const std::shared_ptr<const std::vector<unsigned char> > &colorMap,
		const std::shared_ptr<const std::vector<unsigned char> > &data
	) :
		header(header), id(id), colorMap(colorMap), data(data)
	{ }
	static unsigned int BuildColor(unsigned char r, unsigned char g, unsigned char b, unsigned char a) {
#if BOOST_ENDIAN_BIG_BYTE
		return (r << 24) + (g << 16) + (b << 8) + a;
#elif BOOST_ENDIAN_LITTLE_BYTE
		return (a << 24) + (b << 16) + (g << 8) + r;
#else
		BOOST_STATIC_ASSERT(false);
#endif
	}
	template<unsigned int DEPTH, unsigned int ALPHA, typename Dumy = void>
	struct PixelConverter {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			BOOST_ASSERT(false);
			return 0;
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 15 && ALPHA == 0>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor((value[1] & 0x7C) << 1, (*reinterpret_cast<const unsigned short *>(&value) & 0x03E0) >> 2, (value[0] & 0x1F) << 3, 0xFF);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 16 && ALPHA == 0>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor((value[1] & 0xF8) << 1, (*reinterpret_cast<const unsigned short *>(&value) & 0x07E0) >> 3, (value[0] & 0x1F) << 3, 0xFF);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<(DEPTH == 16 && ALPHA == 1) || (DEPTH == 15 && ALPHA == 1)>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor((value[1] & 0x7C) << 1, (*reinterpret_cast<const unsigned short *>(&value) & 0x03E0) >> 2, (value[0] & 0x1F) << 3, (value[1] & 0x80) != 0 ? 0x00 : 0xFF);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 24 && ALPHA == 0>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor(value[2], value[1], value[0], 0xFF);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 24 && ALPHA == 8>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor((value[1] & 0xF8) << 1, (*reinterpret_cast<const unsigned short *>(&value) & 0x07E0) >> 3, (value[0] & 0x1F) << 3, value[2]);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 32 && ALPHA == 0>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor(value[2], value[1], value[0], 0xFF);
		}
	};
	template<unsigned int DEPTH, unsigned int ALPHA>
	struct PixelConverter<DEPTH, ALPHA, typename boost::enable_if_c<DEPTH == 32 && ALPHA == 8>::type> {
		static unsigned int Call(typename const unsigned char (&value)[(DEPTH + 7) / 8]) {
			return BuildColor(value[2], value[1], value[0], value[3]);
		}
	};

	template<unsigned int DEPTH, unsigned int ALPHA>
	static void ColorConvert(const std::vector<unsigned char> &in, Color &out) {
		std::transform(reinterpret_cast<typename const unsigned char (*)[(DEPTH + 7) / 8]>(&in.front()),
			reinterpret_cast<typename const unsigned char (*)[(DEPTH + 7) / 8]>(&in.back() + 1),
			reinterpret_cast<unsigned int *>(&out),
			typename PixelConverter<DEPTH, ALPHA>::Call);
	}
	template<unsigned int DEPTH, unsigned int ALPHA>
	void CreateRGBAColorMapImpl(std::vector<Color> &result) const {
		if (this->header->colorMapSpec.entrySize == typename DEPTH && this->header->GetAlphaSize() == typename ALPHA) {
			typename ColorConvert<DEPTH, ALPHA>(*this->colorMap, result.front());
		}
	}

public:
	static std::shared_ptr<Tga> Open(const std::filesystem::path &fileName, std::istream &in, const unsigned long long int file_size, ExtractorBase &extractor) {
		std::shared_ptr<Tga> result;
		if (!in.good()) {
			return result;
		}
		const std::shared_ptr<Header> header(new Header());
		in.read(reinterpret_cast<char *>(header.get()), sizeof(Header));
		if (!in.good() || !header->IsValid()) {
			return result;
		}
		const std::shared_ptr<std::vector<char> > id(new std::vector<char>(header->idLength));
		if (header->idLength != 0) {
			in.read(&id->front(), header->idLength);
			if (!in.good()) {
				return result;
			}
		}
		const std::shared_ptr<std::vector<unsigned char> > colorMap(new std::vector<unsigned char>((header->colorMapSpec.entrySize + 7) / 8 * header->colorMapSpec.length));
		if (colorMap->size() != 0) {
			in.read(reinterpret_cast<char *>(&colorMap->front()), colorMap->size());
			if (!in.good()) {
				return result;
			}
		}
		const unsigned int pixelSize = (header->pixelDepth + 7) / 8;
		std::shared_ptr<std::vector<unsigned char> > data;
		if (Header::TYPE_INDEX_COLOR <= header->type && header->type <= Header::TYPE_GRAY_SCALE) {
			data.reset(new std::vector<unsigned char>(pixelSize * header->width * header->height));
			in.read(reinterpret_cast<char *>(&data->front()), data->size());
			if (!in.good()) {
				return result;
			}
		} else if (Header::TYPE_RLE_INDEX_COLOR <= header->type && header->type <= Header::TYPE_RLE_GRAY_SCALE) {
			data.reset(new std::vector<unsigned char>());
			unsigned int i = 0;
			while (i < static_cast<unsigned int>(header->width) * header->height) {
				data->resize(data->size() + 1 + pixelSize);
				in.read(reinterpret_cast<char *>(&*(data->end() - 1 - pixelSize)), 1 + pixelSize);
				if (!in.good()) {
					return result;
				}
				const unsigned int length = *(data->end() - 1 - pixelSize);
				if (length < 0x80 && length > 0) {
					data->resize(data->size() + length * pixelSize);
					in.read(reinterpret_cast<char *>(&*(data->end() - length * pixelSize)), length * pixelSize);
					if (!in.good()) {
						return result;
					}
				}
				i += (length&0x7F) + 1;
			}
			if (i != static_cast<unsigned int>(header->width) * header->height) {
				return result;
			}
		} else {
			return result;
		}
		return std::shared_ptr<Tga>(new Tga(header, id, colorMap, data));
	}
	unsigned int GetWidth() const {
		return this->header->xOrigin + this->header->width;
	}
	unsigned int GetHeight() const {
		return this->header->yOrigin + this->header->height;
	}
	void CreateRGBAColorMap(std::vector<Color> &result) const {
		if (this->header->colorMapType == 0) {
			result.clear();
			return;
		}
		result.resize(this->header->colorMapSpec.firstEntryIndex + this->header->colorMapSpec.length);
		if (this->header->colorMapSpec.length == 0) {
			return;
		}
		CreateRGBAColorMapImpl<15, 0>(result);
		CreateRGBAColorMapImpl<15, 1>(result);
		CreateRGBAColorMapImpl<16, 0>(result);
		CreateRGBAColorMapImpl<16, 1>(result);
		CreateRGBAColorMapImpl<24, 0>(result);
		CreateRGBAColorMapImpl<24, 8>(result);
		CreateRGBAColorMapImpl<32, 0>(result);
		CreateRGBAColorMapImpl<32, 8>(result);
	}

private:
	template<unsigned int PIXEL_SIZE>
	static void RunLengthDecodeImplImpl(
		const std::vector<unsigned char>::const_iterator it,
		const std::vector<unsigned char>::iterator outIt,
		const unsigned int length,
		typename boost::enable_if_c<PIXEL_SIZE == 1>::type * =0)
	{
		std::fill(outIt, outIt + length, *it);
	}
	template<unsigned int PIXEL_SIZE>
	static void RunLengthDecodeImplImpl(
		const std::vector<unsigned char>::const_iterator it,
		const std::vector<unsigned char>::iterator outIt,
		const unsigned int length,
		typename boost::enable_if_c<PIXEL_SIZE == 2>::type * =0)
	{
		std::fill(reinterpret_cast<unsigned short *>(&*outIt), reinterpret_cast<unsigned short *>(&*outIt) + length, *reinterpret_cast<const unsigned short *>(&*it));
	}
	template<unsigned int PIXEL_SIZE>
	static void RunLengthDecodeImplImpl(
		const std::vector<unsigned char>::const_iterator it,
		const std::vector<unsigned char>::iterator outIt,
		const unsigned int length,
		typename boost::enable_if_c<PIXEL_SIZE == 3>::type * =0)
	{
		struct size24bit { unsigned char dummy[3]; };
		std::fill(reinterpret_cast<size24bit *>(&*outIt), reinterpret_cast<size24bit *>(&*outIt) + length, *reinterpret_cast<const size24bit *>(&*it));
	}
	template<unsigned int PIXEL_SIZE>
	static void RunLengthDecodeImplImpl(
		const std::vector<unsigned char>::const_iterator it,
		const std::vector<unsigned char>::iterator outIt,
		const unsigned int length,
		typename boost::enable_if_c<PIXEL_SIZE == 4>::type * =0)
	{
		std::fill(reinterpret_cast<unsigned int *>(&*outIt), reinterpret_cast<unsigned int *>(&*outIt) + length, *reinterpret_cast<const unsigned int *>(&*it));
	}
	template<unsigned int PIXEL_SIZE>
	static void RunLengthDecodeImpl(std::vector<unsigned char>::const_iterator it, const std::vector<unsigned char>::const_iterator endIt, std::vector<unsigned char>::iterator outIt) {
		while (it != endIt) {
			const unsigned int length = (*it & 0x7F) + 1;
			if (*it >= 0x80) {
				++it;
				typename RunLengthDecodeImplImpl<PIXEL_SIZE>(it, outIt, length);
				outIt += length * typename PIXEL_SIZE;
				it += typename PIXEL_SIZE;
			} else {
				++it;
				outIt = std::copy(it, it + length * typename PIXEL_SIZE, outIt);
				it += length * typename PIXEL_SIZE;
			}
		}
	}
	static void RunLengthDecode(const std::vector<unsigned char> &in, const unsigned int pixelSize, const unsigned int pixelCount, std::vector<unsigned char> &result) {
		result.resize(pixelSize * pixelCount);
		std::vector<unsigned char>::const_iterator it = in.begin();
		const std::vector<unsigned char>::const_iterator endIt = in.end();
		std::vector<unsigned char>::iterator outIt = result.begin();
		switch (pixelSize) {
			case 1: { RunLengthDecodeImpl<1>(it, endIt, outIt); break; }
			case 2: { RunLengthDecodeImpl<2>(it, endIt, outIt); break; }
			case 3: { RunLengthDecodeImpl<3>(it, endIt, outIt); break; }
			case 4: { RunLengthDecodeImpl<4>(it, endIt, outIt); break; }
			default: {
				BOOST_ASSERT(false);
				break;
			}
		}
	}
	template<unsigned int DEPTH, unsigned int ALPHA>
	void CreateRGBAArrayImpl(const std::vector<unsigned char> &in, std::vector<Color> &result) const {
		if (this->header->pixelDepth == typename DEPTH && this->header->GetAlphaSize() == typename ALPHA) {
			typename ColorConvert<DEPTH, ALPHA>(in, result[this->header->colorMapSpec.length]);
		}
	}
public:
	bool CreateRGBAArray(std::vector<Color> &result) const {
		result.clear();
		result.resize(this->GetWidth() * this->GetHeight());
		if (this->header->type == Header::TYPE_EMPTY || this->data->size() == 0) {
			return true;
		}
		const unsigned int pixelSize = (this->header->pixelDepth + 7) / 8;
		const unsigned int pixelCount = this->header->width * this->header->height;
		std::vector<unsigned char> rawData;
		if (Header::TYPE_RLE_INDEX_COLOR <= this->header->type && this->header->type <= Header::TYPE_RLE_GRAY_SCALE) {
			RunLengthDecode(*this->data, pixelSize, pixelCount, rawData);
		}
		const std::vector<unsigned char> &in = (Header::TYPE_RLE_INDEX_COLOR <= this->header->type && this->header->type <= Header::TYPE_RLE_GRAY_SCALE) ? rawData : *this->data;
		std::vector<Color> tempImage(this->header->width * this->header->height);
		if (this->header->type == Header::TYPE_INDEX_COLOR || this->header->type == Header::TYPE_RLE_INDEX_COLOR) {
			std::vector<Color> colorMap;
			CreateRGBAColorMap(colorMap);
			std::vector<Color>::iterator outIt = tempImage.begin();
			for (const unsigned char index : in) {
				if (index >= colorMap.size()) {
					return false;
				}
				*outIt = colorMap[index];
				++outIt;
			}
		} else if (this->header->type == Header::TYPE_GRAY_SCALE || this->header->type == Header::TYPE_RLE_GRAY_SCALE) {
			std::vector<Color>::iterator outIt = tempImage.begin();
			for (const unsigned char c : in) {
				outIt->alpha = 0xFF;
				outIt->r = outIt->g = outIt->b = c;
			}
		} else {
			CreateRGBAArrayImpl<15, 0>(in, tempImage);
			CreateRGBAArrayImpl<15, 1>(in, tempImage);
			CreateRGBAArrayImpl<16, 0>(in, tempImage);
			CreateRGBAArrayImpl<16, 1>(in, tempImage);
			CreateRGBAArrayImpl<24, 0>(in, tempImage);
			CreateRGBAArrayImpl<24, 8>(in, tempImage);
			CreateRGBAArrayImpl<32, 0>(in, tempImage);
			CreateRGBAArrayImpl<32, 8>(in, tempImage);
		}
		unsigned int x = this->header->xOrigin;
		unsigned int y = this->header->yOrigin;
		if (!this->header->IsRight2Left()) {
			if (!this->header->IsTop2Bottom()) {
				for (unsigned int i = 0; i < this->header->height; i++) {
					std::copy(tempImage.begin() + i * this->header->width,
						tempImage.begin() + (i + 1) * this->header->width,
						result.begin() + (GetHeight() - 1 - i) * GetWidth() + this->header->xOrigin);
				}
			} else {
				if (x == 0 && y == 0) {
					result.swap(tempImage);
				} else {
					for (unsigned int i = 0; i < this->header->height; i++) {
						std::copy(tempImage.begin() + i * this->header->width,
							tempImage.begin() + (i + 1) * this->header->width,
							result.begin() + (this->header->yOrigin + i) * GetWidth() + this->header->xOrigin);
					}
				}
			}
		} else {
			if (!this->header->IsTop2Bottom()) {
				for (unsigned int i = 0; i < this->header->height; i++) {
					for (unsigned int l = 0; l < this->header->width; l++) {
						result[(GetHeight() - 1 - i) * GetWidth() + this->header->xOrigin + this->header->width - 1 - l] = tempImage[i * this->header->width + l];
					}
				}
			} else {
				for (unsigned int i = 0; i < this->header->height; i++) {
					for (unsigned int l = 0; l < this->header->width; l++) {
						result[(this->header->yOrigin + i) * GetWidth() + this->header->xOrigin + this->header->width - 1 - l] = tempImage[i * this->header->width + l];
					}
				}
			}
		}
		return true;
	}
};
#pragma pack(pop)

class TgaConverter : public ImageConverterBase<Tga> { };

ADD_FILE_CONVERTER(TgaConverter);

} // TGA

} //TouhouSE
