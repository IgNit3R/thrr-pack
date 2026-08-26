
#include "stdafx.h"

namespace TouhouSE {

namespace DDS {

namespace endian = boost::spirit::endian;

#pragma pack(push, 1)
class Dds : public ImageBase<Dds>, boost::noncopyable {
private:
	struct Header : boost::noncopyable {
		enum FLAGS {
			FLAG_USE_CAPS = 0x00000001, FLAG_USE_HEIGHT = 0x00000002, FLAG_USE_WIDTH = 0x00000004,
			FLAG_USE_PITCH_SIZE = 0x00000008, FLAG_USE_FORMAT_INFO = 0x00001000, FLAG_USE_MIP_MAP = 0x00020000,
			FLAG_USE_LINEAR_SIZE = 0x00080000,
		};
		char signature[4];
		endian::ulittle32_t size;
		endian::ulittle32_t flags;
		endian::ulittle32_t height;
		endian::ulittle32_t width;
		union {
			endian::ulittle32_t pitchSize;
			endian::ulittle32_t linearSize;
		} plUnion;
		endian::ulittle32_t depth;
		endian::ulittle32_t mipMapCount;
		endian::ulittle32_t reserved1[11];
		struct FormatInfo : boost::noncopyable {
			enum FLAGS {
				FLAG_USE_ALPHA = 0x00000001, FLAG_ALPHA_ONLY = 0x00000002, FLAG_USE_CODEC = 0x00000004,
				FLAG_USE_RGB = 0x00000040,
			};
			endian::ulittle32_t size;
			endian::ulittle32_t flags;
			char signature[4];
			endian::ulittle32_t bitDepth;
			endian::ulittle32_t redBitMask;
			endian::ulittle32_t greenBitMask;
			endian::ulittle32_t blueBitMask;
			endian::ulittle32_t alphaBitMask;
			bool CheckCodecName(const char * const name) const {
				return std::equal(&this->signature[0], &this->signature[_countof(this->signature)], name);
			}
			bool IsValid() const {
				if (this->size != sizeof(*this)) {
					return false;
				}
				if (this->flags == FLAG_USE_CODEC) {
          /*
					if (this->bitDepth != 0 || this->redBitMask != 0 || this->greenBitMask != 0 ||
						this->blueBitMask != 0 || this->alphaBitMask != 0)
					{
						return false;
					}
          */
					if (!IsDXT1() && !IsDXT2() && !IsDXT3() && !IsDXT4() && !IsDXT5())
					{
						return false;
					}
					/*
				} else if (this->flags == FLAG_ALPHA_ONLY) {
					if (this->bitDepth != 0 || this->redBitMask != 0 || this->greenBitMask != 0 ||
						this->blueBitMask != 0 || this->alphaBitMask != 0 || !IsPlain())
					{
						return false;
					}*/
				} else if ((this->flags&FLAG_USE_RGB) != 0) {
					if ((this->flags&~(FLAG_USE_ALPHA | FLAG_USE_RGB)) != 0 ||
						(this->bitDepth != 16 && this->bitDepth != 24 && this->bitDepth != 32) ||
						this->redBitMask == 0 || this->greenBitMask == 0 || this->blueBitMask == 0 ||
						!IsPlain())
					{
						return false;
					}
					if ((this->flags&FLAG_USE_ALPHA) == 0 && this->alphaBitMask != 0) {
						return false;
					}
				} else {
					return false;
				}
				return true;
			}
			bool IsDXT1() const {
				return CheckCodecName("DXT1");
			}
			bool IsDXT2() const {
				return CheckCodecName("DXT2");
			}
			bool IsDXT3() const {
				return CheckCodecName("DXT3");
			}
			bool IsDXT4() const {
				return CheckCodecName("DXT4");
			}
			bool IsDXT5() const {
				return CheckCodecName("DXT5");
			}
			bool IsPlain() const {
				return CheckCodecName("\0\0\0\0");
			}
		} formatInfo;
		struct Caps : boost::noncopyable {
			enum FLAGS {
				FLAG_MULTI_SURFACE = 0x00000008, FLAG_USE_TEXTURE = 0x00001000, FLAG_USE_MIP_MAP = 0x00400000,
			};
			endian::ulittle32_t flags;
			endian::ulittle32_t caps;
			endian::ulittle32_t reserved[2];
			bool IsValid(const bool useMipMap = false, const unsigned int mipMapCount = 0) const {
				if ((this->flags&(0xFFFFFFFF - FLAG_MULTI_SURFACE - FLAG_USE_MIP_MAP)) != FLAG_USE_TEXTURE || this->caps != 0 ||
					std::count(&this->reserved[0], &this->reserved[_countof(this->reserved)], 0) != _countof(this->reserved))
				{
					return false;
				}
				if (useMipMap) {
					if ((this->flags & FLAG_USE_MIP_MAP) != FLAG_USE_MIP_MAP) {
						return false;
					}
				} else {
					if ((this->flags&FLAG_USE_MIP_MAP) != 0) {
						return false;
					}
				}
				return true;
			}
		} caps;
		endian::ulittle32_t reserved2;
		bool IsValid() const {
			if(!std::equal(&this->signature[0], &this->signature[_countof(this->signature)], "DDS "))
			{
				return false;
			}
			if ((this->size + 4) != sizeof(*this))
			{
				return false;
			}
			if (this->height == 0 || this->width == 0 ||
				this->depth != 0)
			{
				return false;
			}
			if (((this->flags&FLAG_USE_MIP_MAP) == 0 && this->mipMapCount != 0))
			{
				return false;
			}
			if (std::count(&this->reserved1[0], &this->reserved1[_countof(this->reserved1)], 0) != _countof(this->reserved1))
			{
				return false;
			}
			if (!this->formatInfo.IsValid())
			{
				return false;
			}
			if (!this->caps.IsValid((this->flags&FLAG_USE_MIP_MAP) != 0, this->mipMapCount))
			{
				return false;
			}
			if (this->reserved2 != 0)
			{
				return false;
			}
			const unsigned int tempFlags = this->flags & (0xFFFFFFFF - FLAG_USE_MIP_MAP);
			if (tempFlags == (FLAG_USE_CAPS | FLAG_USE_HEIGHT | FLAG_USE_WIDTH | FLAG_USE_FORMAT_INFO | FLAG_USE_PITCH_SIZE)) {
				if (!this->formatInfo.IsPlain() || this->plUnion.pitchSize != CalcPitchSize()) {
					return false;
				}
			} else if(tempFlags == (FLAG_USE_CAPS | FLAG_USE_HEIGHT | FLAG_USE_WIDTH | FLAG_USE_FORMAT_INFO | FLAG_USE_LINEAR_SIZE)) {
				if (this->plUnion.linearSize != CalcLinearSize()) {
					return false;
				}
			} else {
				return false;
			}
			return true;
		}
		unsigned int GetBodySize() const {
			if (this->formatInfo.IsPlain()) {
				return this->plUnion.pitchSize * this->height;
			}
			return this->plUnion.linearSize;
		}
		unsigned int CalcPitchSize() const {
			return (this->formatInfo.bitDepth / 8 * this->width + 3) / 4 * 4;
		}
		unsigned int CalcLinearSize() const {
			unsigned int tableSize;
			if (this->formatInfo.IsDXT1()) {
				tableSize = 8;
			} else if (this->formatInfo.IsDXT2() || this->formatInfo.IsDXT3() || this->formatInfo.IsDXT4() || this->formatInfo.IsDXT5()) {
				tableSize = 16;
			} else {
				return 0;
			}
			const unsigned int tableWidthCount = (this->width + 3) / 4;
			const unsigned int tableHeightCount = (this->height + 3) / 4;
			const unsigned int tableCount = tableWidthCount * tableHeightCount;
			return tableCount * tableSize;
		}
		// 不正なデータをがんばって正しいデータに直す
		bool TryValid() {
			if ((this->flags&FLAG_USE_LINEAR_SIZE) != 0 && this->formatInfo.IsPlain()) {
				this->flags -= FLAG_USE_LINEAR_SIZE;
			}
			if ((this->flags&FLAG_USE_PITCH_SIZE) != 0 && !this->formatInfo.IsPlain()) {
				this->flags -= FLAG_USE_PITCH_SIZE;
			}
			if ((this->flags&(FLAG_USE_PITCH_SIZE | FLAG_USE_LINEAR_SIZE)) == 0) {
				if (this->formatInfo.IsPlain()) {
					this->flags |= FLAG_USE_PITCH_SIZE;
					this->plUnion.pitchSize = CalcPitchSize();
				} else {
					this->flags |= FLAG_USE_LINEAR_SIZE;
					this->plUnion.linearSize = CalcLinearSize();
				}
			}
      if ((this->flags&FLAG_USE_MIP_MAP) == 0 && this->mipMapCount != 0) {
        this->mipMapCount = 0;
      }

			return IsValid();
		}
	};
	Dds(const std::shared_ptr<Header> header, const std::shared_ptr<std::vector<unsigned char> > data) :
		header(header), data(data)
	{ }
	static unsigned int GetShiftCount(unsigned int mask) {
		if (mask == 0) {
			return 0;
		}
		unsigned int result = 0;
		while (mask%2 == 0) {
			result++;
			mask >>= 1;
		}
		return result;
	}
	static double GetMulCount(const unsigned int mask, const unsigned int shiftCount) {
		const unsigned int temp = mask >> shiftCount;
		if (temp == 0) {
			return 0;
		}
		return 0xFF / temp;
	}
	bool CreateRGBAArrayPlain(std::vector<Color> &result) const {
		const unsigned int rShift = GetShiftCount(this->header->formatInfo.redBitMask);
		const unsigned int gShift = GetShiftCount(this->header->formatInfo.greenBitMask);
		const unsigned int bShift = GetShiftCount(this->header->formatInfo.blueBitMask);
		const unsigned int aShift = GetShiftCount(this->header->formatInfo.alphaBitMask);
		const double rMul = GetMulCount(this->header->formatInfo.redBitMask, rShift);
		const double gMul = GetMulCount(this->header->formatInfo.greenBitMask, gShift);
		const double bMul = GetMulCount(this->header->formatInfo.blueBitMask, bShift);
		const double aMul = GetMulCount(this->header->formatInfo.alphaBitMask, aShift);
		const unsigned int pixelSize = this->header->formatInfo.bitDepth / 8;
		result.resize(GetWidth() * GetHeight());
		std::vector<Color>::iterator it = result.begin();
		for (unsigned int h = 0; h < GetHeight(); h++) {
			const unsigned int end = h * this->header->plUnion.pitchSize + pixelSize * GetWidth();
			for (unsigned int i = h * this->header->plUnion.pitchSize; i < end; i+=pixelSize, ++it) {
				// pitchSizeは4の倍数であることが保障されているのでこのキャストで範囲外アクセスすることはない
				const unsigned int pixel = *reinterpret_cast<const unsigned int *>(&this->data->at(i));
				it->r = static_cast<unsigned char>(((pixel & this->header->formatInfo.redBitMask) >> rShift) * rMul);
				it->g = static_cast<unsigned char>(((pixel & this->header->formatInfo.greenBitMask) >> gShift) * gMul);
				it->b = static_cast<unsigned char>(((pixel & this->header->formatInfo.blueBitMask) >> bShift) * bMul);
				it->alpha = this->header->formatInfo.alphaBitMask == 0 ? 0xFF : static_cast<unsigned char>(((pixel & this->header->formatInfo.alphaBitMask) >> aShift) * aMul);
			}
		}
		return true;
	}
	static inline void ConvertColor(const unsigned int w, const unsigned int h, const unsigned int x, const unsigned int y, const unsigned char * const p, std::vector<Color> &result) {
		static const unsigned int rMask = 0xF800;
		static const unsigned int gMask = 0x07E0;
		static const unsigned int bMask = 0x001F;
		static const unsigned int rShift = 11;
		static const unsigned int gShift = 5;
		static const unsigned int bShift = 0;
		static const double rMul = 255 / 0x1F;
		static const double gMul = 255 / 0x3F;
		static const double bMul = 255 / 0x1F;
		Color col[4];
		for (unsigned int i = 0; i < 2; i++) {
			col[i].r = static_cast<unsigned char>(((*reinterpret_cast<const unsigned short *>(&p[2 * i]) & rMask) >> rShift) * rMul);
			col[i].g = static_cast<unsigned char>(((*reinterpret_cast<const unsigned short *>(&p[2 * i]) & gMask) >> gShift) * gMul);
			col[i].b = static_cast<unsigned char>(((*reinterpret_cast<const unsigned short *>(&p[2 * i]) & bMask) >> bShift) * bMul);
			col[i].alpha = 0xFF;
		}
		if (*reinterpret_cast<const unsigned short *>(&p[0]) > *reinterpret_cast<const unsigned short *>(&p[2])) {
			col[2].r = (col[0].r * 2 + col[1].r) / 3;
			col[2].g = (col[0].g * 2 + col[1].g) / 3;
			col[2].b = (col[0].b * 2 + col[1].b) / 3;
			col[2].alpha = 0xFF;
			col[3].r = (col[0].r + col[1].r * 2) / 3;
			col[3].g = (col[0].g + col[1].g * 2) / 3;
			col[3].b = (col[0].b + col[1].b * 2) / 3;
			col[3].alpha = 0xFF;
		} else {
			col[2].r = (col[0].r + col[1].r) / 2;
			col[2].g = (col[0].g + col[1].g) / 2;
			col[2].b = (col[0].b + col[1].b) / 2;
			col[2].alpha = 0xFF;
			col[3].r = 0;
			col[3].g = 0;
			col[3].b = 0;
			col[3].alpha = 0;
		}
		for (unsigned int i = 0; i < 4 && y + i < h; i++) {
			result[w * (y + i) + x    ] = col[(p[4 + i]&0x03)];
			if (x + 1 >= w) { continue; }
			result[w * (y + i) + x + 1] = col[(p[4 + i]&0x0C) >> 2];
			if (x + 2 >= w) { continue; }
			result[w * (y + i) + x + 2] = col[(p[4 + i]&0x30) >> 4];
			if (x + 3 >= w) { continue; }
			result[w * (y + i) + x + 3] = col[(p[4 + i]&0xC0) >> 6];
		}
	}
	bool CreateRGBAArrayDXT1(std::vector<Color> &result) const {
		const unsigned int w = GetWidth();
		const unsigned int h = GetHeight();
		result.resize(w * h);
		std::vector<unsigned char>::const_iterator it = this->data->begin();
		for (unsigned int y = 0; y < h; y += 4) {
			for (unsigned int x = 0; x < w; x += 4, it += 8) {
				ConvertColor(w, h, x, y, &*it, result);
			}
		}
		return true;
	}
	static void ConvertBlend(std::vector<Color> &result) {
		for (Color &color : result) {
			if (color.alpha == 0) {
				color.r = color.g = color.b = 0;
				continue;
			}
			color.r = color.r * 255 / color.alpha;
			color.g = color.g * 255 / color.alpha;
			color.b = color.b * 255 / color.alpha;
		}
	}
	bool CreateRGBAArrayDXT2(std::vector<Color> &result) const {
		if (!CreateRGBAArrayDXT3(result)) {
			return false;
		}
		ConvertBlend(result);
		return true;
	}
	bool CreateRGBAArrayDXT3(std::vector<Color> &result) const {
		const unsigned int w = GetWidth();
		const unsigned int h = GetHeight();
		result.resize(w * h);
		static const unsigned int aMul = 255 / 0x0F;
		std::vector<unsigned char>::const_iterator it = this->data->begin();
		for (unsigned int y = 0; y < h; y += 4) {
			for (unsigned int x = 0; x < w; x += 4, it += 16) {
				ConvertColor(w, h, x, y, &*it + 8, result);
				for (unsigned int i = 0; i < 4 && y + i < h; i++) {
					result[w * (y + i) + x    ].alpha = (((&*it)[2 * i    ]&0x0F)     ) * aMul;
					if (x + 1 >= w) { continue; }
					result[w * (y + i) + x + 1].alpha = (((&*it)[2 * i    ]&0xF0) >> 4) * aMul;
					if (x + 2 >= w) { continue; }
					result[w * (y + i) + x + 2].alpha = (((&*it)[2 * i + 1]&0x0F)     ) * aMul;
					if (x + 3 >= w) { continue; }
					result[w * (y + i) + x + 3].alpha = (((&*it)[2 * i + 1]&0xF0) >> 4) * aMul;
				}
			}
		}
		return true;
	}
	bool CreateRGBAArrayDXT4(std::vector<Color> &result) const {
		if (!CreateRGBAArrayDXT5(result)) {
			return false;
		}
		ConvertBlend(result);
		return true;
	}
	static inline void ConvertAlpha(const unsigned int w, const unsigned int h, const unsigned int x, const unsigned int y, const unsigned char * const p, std::vector<Color> &result) {
		unsigned char alpha[8];
		alpha[0] = p[0];
		alpha[1] = p[1];
		if (alpha[0] > alpha[1]) {
			alpha[2] = (alpha[0] * 6 + alpha[1]    ) / 7;
			alpha[3] = (alpha[0] * 5 + alpha[1] * 2) / 7;
			alpha[4] = (alpha[0] * 4 + alpha[1] * 3) / 7;
			alpha[5] = (alpha[0] * 3 + alpha[1] * 4) / 7;
			alpha[6] = (alpha[0] * 2 + alpha[1] * 5) / 7;
			alpha[7] = (alpha[0]     + alpha[1] * 6) / 7;
		} else {
			alpha[2] = (alpha[0] * 4 + alpha[1]    ) / 5;
			alpha[3] = (alpha[0] * 3 + alpha[1] * 2) / 5;
			alpha[4] = (alpha[0] * 2 + alpha[1] * 3) / 5;
			alpha[5] = (alpha[0]     + alpha[1] * 4) / 5;
			alpha[6] = 0x00;
			alpha[7] = 0xFF;
		}
		for (unsigned int i = 0; i < 2; i++) {
			if (y + 2 * i >= h) { break; }
			result[w * (y + 2 * i    ) + x    ].alpha = alpha[(p[2 + 3 * i]&0x07)];
			if (x + 1 < w) {
				result[w * (y + 2 * i    ) + x + 1].alpha = alpha[(p[2 + 3 * i]&0x38) >> 3];
				if (x + 2 < w) {
					result[w * (y + 2 * i    ) + x + 2].alpha = alpha[(*reinterpret_cast<const unsigned short *>(&p[2 + 3 * i])&0x01C0) >> 6];
					if (x + 3 < w) {
						result[w * (y + 2 * i    ) + x + 3].alpha = alpha[(p[3 + 3 * i]&0x0E) >> 1];
					}
				}
			}
			if (y + 2 * i + 1 >= h) { break; }
			result[w * (y + 2 * i + 1) + x    ].alpha = alpha[(p[3 + 3 * i]&0x70) >> 4];
			if (x + 1 >= w) { continue; }
			result[w * (y + 2 * i + 1) + x + 1].alpha = alpha[(*reinterpret_cast<const unsigned short *>(&p[3 + 3 * i])&0x0380) >> 7];
			if (x + 2 >= w) { continue; }
			result[w * (y + 2 * i + 1) + x + 2].alpha = alpha[(p[4 + 3 * i]&0x1C) >> 2];
			if (x + 3 >= w) { continue; }
			result[w * (y + 2 * i + 1) + x + 3].alpha = alpha[(p[4 + 3 * i]&0xE0) >> 5];
		}
	}
	bool CreateRGBAArrayDXT5(std::vector<Color> &result) const {
		const unsigned int w = GetWidth();
		const unsigned int h = GetHeight();
		result.resize(w * h);
		static const unsigned int aMul = 255 / 0x0F;
		std::vector<unsigned char>::const_iterator it = this->data->begin();
		for (unsigned int y = 0; y < h; y += 4) {
			for (unsigned int x = 0; x < w; x += 4, it += 16) {
				ConvertColor(w, h, x, y, &*it + 8, result);
				ConvertAlpha(w, h, x, y, &*it, result);
			}
		}
		return true;
	}
public:
	static std::shared_ptr<Dds> Open(const std::filesystem::path &fileName, std::istream &in, const unsigned long long int file_size, ExtractorBase &extractor) {
		std::shared_ptr<Dds> result;
		if (!in.good()) {
			return result;
		}
		const std::shared_ptr<Header> header(new Header());
		in.read(reinterpret_cast<char *>(header.get()), sizeof(*header));
		if (!in.good() || !header->TryValid()) {
			return result;
		}
		const std::shared_ptr<std::vector<unsigned char> > data(new std::vector<unsigned char>(header->GetBodySize()));
		in.read(reinterpret_cast<char *>(&*data->begin()), data->size());
		if (!in.good()) {
			return result;
		}
		result.reset(new Dds(header, data));
		return result;
	}
	bool CreateRGBAArray(std::vector<Color> &result) const {
		if (this->header->formatInfo.IsPlain()) {
			return CreateRGBAArrayPlain(result);
		} else if (this->header->formatInfo.IsDXT1()) {
			return CreateRGBAArrayDXT1(result);
		} else if (this->header->formatInfo.IsDXT2()) {
			return CreateRGBAArrayDXT2(result);
		} else if (this->header->formatInfo.IsDXT3()) {
			return CreateRGBAArrayDXT3(result);
		} else if (this->header->formatInfo.IsDXT4()) {
			return CreateRGBAArrayDXT4(result);
		}
		return CreateRGBAArrayDXT5(result);
	}
	unsigned int GetWidth() const {
		return this->header->width;
	}
	unsigned int GetHeight() const {
		return this->header->height;
	}
private:
	const std::shared_ptr<Header> header;
	const std::shared_ptr<std::vector<unsigned char> > data;
};
#pragma pack(pop)

class DdsConverter : public ImageConverterBase<Dds> { };

ADD_FILE_CONVERTER(DdsConverter);

} // DDS

} // TouhouSE
