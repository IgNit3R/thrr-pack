#include "stdafx.h"

namespace TH11 { namespace Utility {

namespace {

bool TextCryptImpl(unsigned char *data, unsigned int size) {
	BOOST_ASSERT(data);
	unsigned char a = 0x77;
	unsigned char b = 0x07;
	for(unsigned int i = 0; i < size; i++){
		data[i] ^= a;
		a += b;
		b += 0x10;
	}
	return true;
}

} // anonymous

bool TextDeCrypt(unsigned char *data, unsigned int size) {
	return TextCryptImpl(data, size);
}
bool TextDeCrypt(std::vector<unsigned char> &data) {
	return TextDeCrypt(&data.front(), data.size());
}
bool TextEnCrypt(unsigned char *data, unsigned int size) {
	return TextCryptImpl(data, size);
}
bool TextEnCrypt(std::vector<unsigned char> &data) {
	return TextEnCrypt(&data.front(), data.size());
}

} // Utility

} // TH11
