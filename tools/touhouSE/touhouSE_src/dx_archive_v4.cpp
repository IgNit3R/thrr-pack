#include "stdafx.h"

namespace TouhouSE {

namespace DX_ARCHIVE_V4 {

namespace endian = boost::spirit::endian;
using namespace TouhouSE::DX_ARCHIVE;

class HeaderV4 {
public:
   endian::ulittle8_t signature[2];
   endian::ulittle16_t version;
   endian::ulittle32_t footer_size;
   endian::ulittle32_t header_size;
   endian::ulittle32_t file_name_table_address;
   endian::ulittle32_t file_data_table_offset;
   endian::ulittle32_t directory_data_table_offset;
   endian::ulittle32_t codepage;

   static constexpr unsigned int getVersion() {
      return 4;
   }
   static bool readKey(const unsigned char * const in, const unsigned long long int file_size, std::array<unsigned char, 12> &key) {
      *reinterpret_cast<unsigned int *>(&key[0]) = *reinterpret_cast<const unsigned int *>(&in[0]) ^ 0x00045844;
      *reinterpret_cast<unsigned int *>(&key[8]) = *reinterpret_cast<const unsigned int *>(&in[8]) ^ 0x0000001C;
      const unsigned int file_name_table_address = *reinterpret_cast<const unsigned int *>(&in[12]) ^ *reinterpret_cast<const unsigned int *>(&key[0]);
      if (file_name_table_address > file_size) {
         return false;
      }
      const unsigned int footer_size = static_cast<unsigned int>(file_size) - file_name_table_address;
      *reinterpret_cast<unsigned int *>(&key[4]) = *reinterpret_cast<const unsigned int *>(&in[4]) ^ footer_size;
      return true;
   }
};

class DirectoryDataV4 {
public:
   endian::ulittle32_t directory_data_offset;
   endian::ulittle32_t parent_directory_offset;
   endian::ulittle32_t file_count;
   endian::ulittle32_t file_data_offset;

   static constexpr unsigned int getSize() {
      return 16;
   }
   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return header.file_name_table_address + header.directory_data_table_offset + read_size;
   }
};

class FileDataV4 {
public:
   endian::ulittle32_t name_offset;
   endian::ulittle32_t flag;
   endian::ulittle64_t create_time;
   endian::ulittle64_t last_access_time;
   endian::ulittle64_t last_update_time;
   endian::ulittle32_t body_offset;
   endian::ulittle32_t body_size;
   endian::ulittle32_t body_compress_size;

   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return header.file_name_table_address + header.file_data_table_offset + read_size;
   }
};

class FilenameV4 {
public:
   template<typename HeaderT>
   static constexpr unsigned long long int getCryptKeyOffset(const Header<HeaderT> &header, const unsigned long long int read_size) {
      return header.file_name_table_address + read_size;
   }
};

class FileBodyV4 {
public:
   static constexpr unsigned long long int getCryptKeyOffset(const FileRecord &file) {
      return file.addr;
   }
};

typedef Owner<HeaderV4, DirectoryDataV4, FileDataV4, FilenameV4, FileBodyV4> DAT_EXTRACTOR;
ADD_DAT_EXTRACTOR(DAT_EXTRACTOR);

} // DX_ARCHIVE_V4

} // ToudouSE
