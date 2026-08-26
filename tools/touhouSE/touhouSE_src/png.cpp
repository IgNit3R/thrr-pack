#include "stdafx.h"

std::vector<Color> pal(256);

using namespace Utility;

namespace {

void SetColData(unsigned char *buffer, unsigned int buffer_size, unsigned int height, unsigned int width, const unsigned char *col) {
	const unsigned char *c = col;
	for(unsigned int h = 0; h < height; h++) {
		const unsigned int addr = h * (width + 1);
		buffer[addr] = 0;
		errno_t error = memcpy_s(&buffer[addr + 1], buffer_size - addr - 1, c, width);
		BOOST_ASSERT(error == 0);
		c += width;
	}
}

unsigned int Adler32(const unsigned char *data, unsigned int len){
	unsigned short s1 = 1, s2 = 0;
	s1 = 1;
	s2 = 0;
	for(unsigned int i = 0; i < len; i++){
		s1 = static_cast<unsigned short>((s1 + data[i])%65521);
		s2 = static_cast<unsigned short>((s2 + s1)%65521);
	}
	return static_cast<unsigned int>((s2<<16) + s1);
}

unsigned int Adler32(unsigned int height, unsigned int width, const unsigned char *col) {
	const unsigned int data_size = height * (width + 1);
	std::vector<unsigned char> data(data_size);
	SetColData(&data.front(), data_size, height, width, col);
	return Adler32(&data.front(), data_size);
}

void set_compresseddata(unsigned char *buffer, unsigned int buffer_size, unsigned int height, unsigned int width, const unsigned char *col, bool flag) {
	if(flag) {
		*buffer = 1;
	} else {
		*buffer = 0;
	}
	const unsigned int data_size = height * (width + 1);
	BOOST_ASSERT(data_size <= USHRT_MAX);
	*reinterpret_cast<unsigned short *>(&buffer[1]) = static_cast<unsigned short>(data_size);
	*reinterpret_cast<unsigned short *>(&buffer[3]) = static_cast<unsigned short>(~data_size);

	SetColData(&buffer[5], buffer_size - 5, height, width, col);
}

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Chunk : boost::noncopyable {
public:
	Chunk(const char *name) :
		name(name, &name[4]), data(0)
	{
		BOOST_ASSERT(strlen(name) == 4);
	}
	Chunk(const char *name, const unsigned char *data, unsigned int len) :
		name(name, &name[4]), data(data, &data[len])
	{
		BOOST_ASSERT(data != NULL);
		BOOST_ASSERT(strlen(name) == 4);
	}
	bool ToBin(std::vector<unsigned char> &buffer) const {
		buffer.resize(data.size() + 12);
		const unsigned int len = Endian32(data.size());
		memcpy_s(&buffer[0], buffer.size(), &len, sizeof(len));
		memcpy_s(&buffer[4], buffer.size() - 4, &name.front(), name.size());
		if(!data.empty()) {
			memcpy_s(&buffer[8], buffer.size() - 8, &data.front(), data.size());
		}
		const unsigned int crc = Endian32(Crc(&buffer[4], buffer.size() - 8));
		memcpy_s(&buffer[8 + data.size()], buffer.size() - 8 - data.size(), &crc, sizeof(crc));
		return true;
	}
	bool fwrite(std::shared_ptr<FILE> fp) const {
		if(!fp) {
			return false;
		}
		std::vector<unsigned char> buffer;
		if(!ToBin(buffer)) {
			return false;
		}
		if(::fwrite(&buffer.front(), 1, buffer.size(), fp.get()) != buffer.size()) {
			return false;
		}
		return true;
	}
protected:
	const std::vector<char> name;
	const std::vector<unsigned char> data;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, const Chunk &chunk) {
	std::vector<unsigned char> buffer;
	bool result = chunk.ToBin(buffer);
	BOOST_ASSERT(result);
	out.write(reinterpret_cast<char *>(&buffer.front()), buffer.size());
	return out;
}

bool PutIHDR(std::shared_ptr<FILE> fp, unsigned int height, unsigned int width, unsigned int cn) {
	unsigned char data[13];
	*reinterpret_cast<unsigned int *>(&data[0]) = Endian32(width);
	*reinterpret_cast<unsigned int *>(&data[4]) = Endian32(height);
	data[8] = 8;
	if(cn == 8) {
		data[9] = 3;
	} else {
		data[9] = 6;
	}
	data[10] = 0;
	data[11] = 0;
	data[12] = 0;
	const Chunk chunk("IHDR", data, sizeof(data));
	return chunk.fwrite(fp);
}

bool PutPLTE(std::shared_ptr<FILE> fp, const Color *pal) {
	const unsigned int pal_count = 256;
	unsigned char data[pal_count * 3];
	for(unsigned int i = 0; i < pal_count; i++) {
		data[i*3+0] = pal[i].r;
		data[i*3+1] = pal[i].g;
		data[i*3+2] = pal[i].b;
	}
	const Chunk chunk("PLTE", data, sizeof(data));
	return chunk.fwrite(fp);
}

bool PutTRNS(std::shared_ptr<FILE> fp, const Color *pal) {
	const unsigned int pal_count = 256;
	unsigned char data[pal_count];
	for(unsigned int i = 0; i < pal_count; i++) {
		data[i] = pal[i].alpha;
	}
	const Chunk chunk("tRNS", data, sizeof(data));
	return chunk.fwrite(fp);
}

bool PutIDAT(std::shared_ptr<FILE> fp, unsigned int height, unsigned int width, const unsigned char *col) {
	const unsigned int split_height = USHRT_MAX / (width + 1);
	const unsigned int col_split_count = static_cast<unsigned int>(::ceil(static_cast<double>(height) / split_height));
	const unsigned int col_split_size = 5 + split_height * (width + 1);
	const unsigned int adler = Endian32(Adler32(height, width, col));
	const unsigned int data_len = 2 + col_split_count * 5 + height * (width + 1) + 4;
	std::vector<unsigned char> data(data_len);

	*reinterpret_cast<unsigned short *>(&data[0]) = Endian16(0x7801);
	const unsigned char *col_ptr = col;
	for(unsigned int i = 0; i < col_split_count; i++) {
		const unsigned int addr = 2 + i * col_split_size;
		const unsigned int compress_height = (std::min)(split_height, height - i * split_height);
		set_compresseddata(&data[addr], data.size() - addr, compress_height, width, col_ptr, i+1 == col_split_count);
		col_ptr += split_height * width;
	}
	*reinterpret_cast<unsigned int *>(&data[data.size() - 4]) = adler;
	const Chunk chunk("IDAT", &data.front(), data.size());
	return chunk.fwrite(fp);
}

bool PutIEND(std::shared_ptr<FILE> fp) {
	const Chunk chunk("IEND");
	return chunk.fwrite(fp);
}

};

void pngout(unsigned int width2, unsigned int height, unsigned int width, const unsigned char *col, std::shared_ptr<FILE> fp, unsigned int cn) {
   unsigned char signature[8];
   *reinterpret_cast<unsigned int *>(&signature[0]) = 0x474e5089;
   *reinterpret_cast<unsigned int *>(&signature[4]) = 0x0a1a0a0d;
   fwrite(signature, 4, 2, fp.get());

   bool ihdr_result = PutIHDR(fp, height, width, cn);
   BOOST_ASSERT(ihdr_result);

   if (width2 != width) {
      const Chunk orix("orIx", reinterpret_cast<unsigned char *>(&width2), sizeof(width2));
      bool orix_result = orix.fwrite(fp);
      BOOST_ASSERT(orix_result);
   }

   if (cn == 24 || cn == 32 || cn == 16) {
      width *= 4;
   }
   if (cn == 8) {
      bool plte_result = PutPLTE(fp, &pal.front());
      BOOST_ASSERT(plte_result);
      bool trns_result = PutTRNS(fp, &pal.front());
      BOOST_ASSERT(trns_result);
   }

   bool idat_result = PutIDAT(fp, height, width, col);
   BOOST_ASSERT(idat_result);

   bool iend_result = PutIEND(fp);
   BOOST_ASSERT(iend_result);
   fp.reset();
}

void pngout(const unsigned int width2, const unsigned int height, const unsigned int width, const unsigned char *col, const std::wstring &fn, const unsigned int cn) {
   pngout(width2, height, width, col, MyFOpen(fn, L"wb"), cn);
}

void pngout(const unsigned int width2, const unsigned int height, const unsigned int width, const unsigned char *col, const std::string &fn, const unsigned int cn) {
   pngout(width2, height, width, col, MyFOpen(fn, "wb"), cn);
}










bool get_literal(unsigned char *data, unsigned char **p){
	int type;
	unsigned short len;

	type = (*data&0x06)>>1;
	if(type != 0){
		return false;
	}
	len = *(unsigned short *)&data[1];
	if((unsigned short)~len != *(unsigned short *)&data[3]){
		return false;
	}
	*p = &data[5+len];

//本来はここでやっちゃいけない
	unsigned int adler = Endian32(Adler32(&data[5],len));
	if(adler != *reinterpret_cast<unsigned int *>(*p)){
		return false;
	}

	return (*data&0x01) == 0;
}

void check_idat(unsigned char *data){
	unsigned char *s;

	if((*data&0x0F) != 8){
		printf("データ圧縮方法に未知の値が指定されています(%d)\n",*data&0x0F);
	}
	//printf("CINFO：%d(%d)\n",(*data&0xF0)>>4,(int)pow(2.0,(((*data&0xF0)>>4)-2.0)));
	//printf("FLEVEL：%d\n",(data[1]&0xC0)>>6);
	//printf("FDICT：%d\n",(data[1]&0x20)>>5);
	if((data[0]*256+data[1])%31 != 0){
		printf("FCHECKエラー\n31の倍数になっていません\n");
	}

	s = &data[2];
	while(get_literal(s,&s));
}

std::vector<unsigned char> GetChunk(std::shared_ptr<FILE> fp) {
	BOOST_ASSERT(fp);

	unsigned int len;
	if(fread(&len,4,1,fp.get()) != 1){
		printf("データ長が存在しません\nIENDチャンクが存在しませんでした\n");
		return std::vector<unsigned char>();
	}
	len = Endian32(len);

	char name[5];
	if(fread(name,1,4,fp.get()) != 4){
		printf("チャンクタイプが存在しません\nIENDチャンクが存在しませんでした\n");
		return std::vector<unsigned char>();
	}
	name[4] = '\0';

	std::vector<unsigned char> result(len+4);
	if(result.size() != len+4){
		printf("メモリー確保に失敗しました\nチャンクサイズが大きすぎる可能性があります\n");
		return std::vector<unsigned char>();
	}
	*(int *)&result.front() = *(int *)name;

	if(len > 0) {
		if(fread(&result[4],1,len,fp.get()) != len){
			printf("チャンクデータが存在しません\nIENDチャンクが存在しませんでした\n");
			return std::vector<unsigned char>();
		}
	}

	unsigned int c;
	if(fread(&c,4,1,fp.get()) != 1){
		printf("CRCが存在しません\nIENDチャンクが存在しませんでした\n");
		return std::vector<unsigned char>();
	}
	if(c != Endian32(Crc(&result.front(), result.size()))){
		printf("CRCが一致しません(%sチャンク)\n", name);
		return std::vector<unsigned char>();
	}
	//printf("\nチャンク名：%s\nデータ長:%d\nCRC32：%08x\n", name, len, c);
	if(!strncmp(name,"IDAT",4)){
		check_idat(&result[4]);
	}
	return result;
}

std::shared_ptr<Png> load_png(const char *filename){
	std::shared_ptr<Png> result;
	if(filename == NULL) {
		return result;
	}
	
	std::shared_ptr<Png> png(new Png());
	std::shared_ptr<FILE> fp = MyFOpen(filename, "rb");
	if(!fp){
		return result;
	}
	unsigned char signature[8];
	fread(signature, 1, 8, fp.get());
	if(*reinterpret_cast<unsigned int *>(&signature[0]) != 0x474E5089 || *reinterpret_cast<unsigned int *>(&signature[4]) != 0x0A1A0A0D){
		printf("PNGシグネチャが間違っています\n");
		return result;
	}
	std::vector<unsigned char> chunk = GetChunk(fp);
	if(chunk.size() < 4){
		return result;
	}
	if(memcmp(&chunk.front(), "IHDR", 4)) {
		printf("最初のチャンクがIHDRではありません\n");
		return result;
	}
	png->w = Endian32(*reinterpret_cast<unsigned int *>(&chunk[4]));
	png->h = Endian32(*reinterpret_cast<unsigned int *>(&chunk[8]));
	if(*(int *)&chunk[13] == 6) {
		png->cn = 32;
	} else {
		png->cn = 8;
	}
	while(1){
		chunk = GetChunk(fp);
		if(chunk.size() < 4){
			return result;
		}
		if(memcmp(&chunk.front(),"PLTE",4) == 0){
		} else if(memcmp(&chunk.front(),"IDAT",4) == 0){
			png->col.resize(png->w * png->h);
			unsigned char *data = &chunk[6];
			for(unsigned int i = 0; i < png->w * png->h;){
				unsigned int len = *(unsigned short *)&data[1];//ここだけはエンディアン変換かけてはいけない
				data = &data[5];
				while(len > 0){
					data++;
					memcpy(&png->col[i], data, 4*png->w);
					data += 4*png->w;
					len -= 4*png->w+1;
					i += png->w;
				}
			}
		} else if(memcmp(&chunk.front(),"IEND",4) == 0) {
			break;
		}
	}
	result = png;
	return result;
}



namespace TouhouSE {

namespace PNG {

namespace {

class UCharVectorO : boost::noncopyable {
private:
	std::vector<unsigned char> &result;
public:
	UCharVectorO(std::vector<unsigned char> &result) : result(result) { }
	static void Write(png_struct *png, png_byte *data, png_size_t size) {
		UCharVectorO * const out = reinterpret_cast<UCharVectorO *>(::png_get_io_ptr(png));
		BOOST_ASSERT(out != NULL);
		const unsigned int cur = out->result.size();
		out->result.resize(cur + size);
		std::copy(&data[0], &data[size], &out->result[cur]);
	}
	static void Flush(png_struct *png) {
	}
};

class UCharVectorI : boost::noncopyable {
private:
  const std::vector<unsigned char> &result;
  unsigned int readIndex;
public:
  UCharVectorI(const std::vector<unsigned char> &result) : result(result), readIndex(0){ }
  static void Read(png_struct * const png, png_byte * const data, png_size_t size) {
    UCharVectorI * const out = reinterpret_cast<UCharVectorI *>(::png_get_io_ptr(png));
    if (out->readIndex + size > out->result.size()) {
      size = out->result.size() - out->readIndex;
    }
    std::copy(out->result.begin() + out->readIndex, out->result.begin() + out->readIndex + size, data);
    out->readIndex += size;
  }
};

void png_write_struct_free(png_struct *png) {
	::png_destroy_write_struct(&png, NULL);
}

void png_info_free(png_struct * const png, png_info *info) {
	::png_destroy_info_struct(png, &info);
}

void png_read_struct_free(png_struct *png) {
  ::png_destroy_read_struct(&png, NULL, NULL);
}

} // anonymous

bool ToPng(unsigned int width, unsigned int height, const std::vector<Color> &data, std::vector<unsigned char> &result) {
	const std::shared_ptr<png_struct> png(::png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL), png_write_struct_free);
	if (!png) {
		return false;
	}
	const std::shared_ptr<png_info> info(::png_create_info_struct(png.get()), std::bind(png_info_free, png.get(), _1));
	if (!info) {
		return false;
	}
	result.clear();
	UCharVectorO io(result);
	::png_set_write_fn(png.get(), &io, UCharVectorO::Write, UCharVectorO::Flush);
	::png_set_IHDR(png.get(), info.get(), width, height, 8, PNG_COLOR_TYPE_RGB_ALPHA, PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT, PNG_FILTER_TYPE_BASE);
	::png_write_info(png.get(), info.get());
	std::vector<const png_byte *> rows(height);
	for (unsigned int i = 0; i < height; i++) {
		rows[i] = reinterpret_cast<const png_byte *>(&data[i * width]);
	}
	::png_write_image(png.get(), const_cast<png_byte **>(&rows.front()));
	::png_write_end(png.get(), info.get());
	return true;
}

bool FromPng(const std::vector<unsigned char> &data, Png &result) {
  const std::unique_ptr<png_struct, void (*)(png_struct *)> png(::png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL), png_read_struct_free);
  const std::unique_ptr<png_info, std::function<void (png_info *)> > info(::png_create_info_struct(png.get()), std::bind(png_info_free, png.get(), _1));
  const std::unique_ptr<png_info, std::function<void (png_info *)> > end(::png_create_info_struct(png.get()), std::bind(png_info_free, png.get(), _1));
  UCharVectorI io(data);
  ::png_set_read_fn(png.get(), &io, UCharVectorI::Read);
  unsigned char signature[8];
  UCharVectorI::Read(png.get(), signature, 8);
  if (::png_sig_cmp(signature, 0, 8) != 0) {
    return false;
  }
  ::png_set_sig_bytes(png.get(), 8);
  ::png_read_png(png.get(), info.get(), PNG_TRANSFORM_PACKING | PNG_TRANSFORM_STRIP_16, NULL);
  const unsigned int width = ::png_get_image_width(png.get(), info.get());
  const unsigned int height = ::png_get_image_height(png.get(), info.get());
  const Color * const * const rows = reinterpret_cast<const Color * const *>(::png_get_rows(png.get(), info.get()));
  result.w = width;
  result.h = height;
  result.cn = 32;
  result.pal.clear();
  result.col.resize(width * height);
  for (unsigned int h = 0; h < height; h++) {
    for (unsigned int w = 0; w < width; w++) {
      result.col[h * width + w] = rows[h][w];
    }
  }
  return true;
}

} // PNG

} // TouhouSE
