
template<typename T>
class NumericLimits {
public:
   static constexpr T max();
   static constexpr T min();
};
template<typename T>
class NumericLimits<const T> : public NumericLimits<T> {};

template<>
class NumericLimits<unsigned long long int> {
public:
   static constexpr unsigned long long int max() {
      return 0xFFFFFFFFFFFFFFFF;
   }
   static constexpr unsigned long long int min() {
      return 0x00;
   }
};
template<>
class NumericLimits<unsigned int> {
public:
   static constexpr unsigned int max() {
      return 0xFFFFFFFF;
   }
   static constexpr unsigned int min() {
      return 0x00;
   }
};
template<>
class NumericLimits<unsigned short> {
public:
   static constexpr unsigned short max() {
      return 0xFFFF;
   }
   static constexpr unsigned short min() {
      return 0x00;
   }
};
template<>
class NumericLimits<unsigned char> {
public:
   static constexpr unsigned char max() {
      return 0xFF;
   }
   static constexpr unsigned char min() {
      return 0x00;
   }
};
template<>
class NumericLimits<boost::spirit::endian::ulittle64_t> : public NumericLimits<unsigned long long int> {
};

template<>
class NumericLimits<boost::spirit::endian::ulittle32_t> : public NumericLimits<unsigned int> {
};

template<>
class NumericLimits<boost::spirit::endian::ulittle16_t> : public NumericLimits<unsigned short> {
};

template<>
class NumericLimits<boost::spirit::endian::ulittle8_t> : public NumericLimits<unsigned char> {
};
