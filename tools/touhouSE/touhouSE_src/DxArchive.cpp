
#include "stdafx.h"

namespace TouhouSE {

namespace DX_ARCHIVE {

void decrypt(const unsigned int size, const unsigned long long int addr, const std::array<unsigned char, 12> &key, unsigned char * const buf) {
   unsigned int table_index = addr % key.size();
   for (unsigned int i = 0; i < size; i++) {
      buf[i] ^= key[table_index];
      table_index = (table_index + 1) % key.size();
   }
}

bool decompress(const std::vector<unsigned char> &in, std::vector<unsigned char> &out) {
   if (in.size() < 9) {
      return false;
   }
   const unsigned int out_size = *reinterpret_cast<const unsigned int *>(&in[0]);
   const unsigned int in_size = *reinterpret_cast<const unsigned int *>(&in[4]);
   if (in_size != in.size()) {
      return false;
   }
   out.resize(out_size);
   const unsigned char compress_flag = in[8];
   for (unsigned int i = 9, out_index = 0; true;) {
      if (in.size() <= i) {
         if (i != in.size() || out_index != out.size()) {
            return false;
         }
         break;
      }
      if (in[i] != compress_flag) {
         if (out.size() <= out_index) {
            return false;
         }
         out[out_index] = in[i];
         i++;
         out_index++;
         continue;
      }
      if (in.size() <= i + 1) {
         return false;
      }
      if (in[i + 1] == compress_flag) {
         if (out.size() <= out_index) {
            return false;
         }
         out[out_index] = in[i];
         i += 2;
         out_index++;
         continue;
      }
      if (in.size() <= i + 2) {
         return false;
      }
      const unsigned char temp = (in[i + 1] > compress_flag ? in[i + 1] - 1 : in[i + 1]);
      const unsigned int index_size = (temp & 0x03) + 1;
      const bool is_ex_length = ((temp & 0x04) != 0);
      const unsigned int len = (is_ex_length ? in[i + 2] << 5 : 0) + (temp >> 3) + 4;
      if (is_ex_length) {
         i += 3;
      } else {
         i += 2;
      }
      const unsigned int index = 1 + (
         index_size == 1 ?
         in[i]
         :
         (index_size == 2 ?
            *reinterpret_cast<const unsigned short *>(&in[i])
            :
            *reinterpret_cast<const unsigned int *>(&in[i]) & 0x00FFFFFF
            )
         );
      i += index_size;
      if (out_index < index) {
         return false;
      }
      for (unsigned int j = 0; j < len; j++) {
         out[out_index] = out[out_index - index];
         out_index++;
      }
   }
   return true;
}

} // DX_ARCHIVE

} // ToudouSE
