
class container_sink : public boost::iostreams::sink {
public:
  std::vector<unsigned char> &out;
  container_sink(std::vector<unsigned char> &out) : out(out) { }
  
  std::streamsize write(const char * const s, std::streamsize n) {
    out.insert(out.end(), s, s + n);
    return n;
  }
};
