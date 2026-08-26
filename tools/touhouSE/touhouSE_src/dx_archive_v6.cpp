#include "stdafx.h"

namespace TouhouSE {

namespace DX_ARCHIVE_V6 {

namespace endian = boost::spirit::endian;
using namespace TouhouSE::DX_ARCHIVE;

class HeaderV6 {
public:
   endian::ulittle8_t signature[2];
   endian::ulittle16_t version;
   endian::ulittle32_t footer_size;
   endian::ulittle64_t header_size;
   endian::ulittle64_t file_name_table_address;
   endian::ulittle64_t file_data_table_offset;
   endian::ulittle64_t directory_data_table_offset;
   endian::ulittle64_t codepage;

   static constexpr unsigned int getVersion() {
      return 6;
   }
   static bool readKey(const unsigned char * const in, const unsigned long long int file_size, std::array<unsigned char, 12> &key) {
      *reinterpret_cast<unsigned int *>(&key[0]) = *reinterpret_cast<const unsigned int *>(&in[0x0C]) ^ 0x00000000;
      *reinterpret_cast<unsigned int *>(&key[4]) = *reinterpret_cast<const unsigned int *>(&in[0x1C]) ^ 0x00000000;
      *reinterpret_cast<unsigned int *>(&key[8]) = *reinterpret_cast<const unsigned int *>(&in[0x08]) ^ 0x00000030;
      return true;
   }
};

class DirectoryDataV6 {
public:
   endian::ulittle64_t directory_data_offset;
   endian::ulittle64_t parent_directory_offset;
   endian::ulittle64_t file_count;
   endian::ulittle64_t file_data_offset;

   static constexpr unsigned int getSize() {
      return 32;
   }
   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return header.directory_data_table_offset + read_size;
   }
};

class FileDataV6 {
public:
   endian::ulittle64_t name_offset;
   endian::ulittle64_t flag;
   endian::ulittle64_t create_time;
   endian::ulittle64_t last_access_time;
   endian::ulittle64_t last_update_time;
   endian::ulittle64_t body_offset;
   endian::ulittle64_t body_size;
   endian::ulittle64_t body_compress_size;

   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return header.file_data_table_offset + read_size;
   }
};

class FilenameV6 {
public:
   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return read_size;
   }
};

class FileBodyV6 {
public:
   static constexpr unsigned long long int getCryptKeyOffset(const FileRecord &file) {
      return file.file_size;
   }
};

typedef Owner<HeaderV6, DirectoryDataV6, FileDataV6, FilenameV6, FileBodyV6> DAT_EXTRACTOR;
ADD_DAT_EXTRACTOR(DAT_EXTRACTOR);


} // DX_ARCHIVE_V6

} // ToudouSE
