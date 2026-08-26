
namespace TouhouSE {

template<class T>
class ImageBase {
public:
	static std::shared_ptr<typename T> Open(std::istream &in, const unsigned long long int file_size);
	bool CreateRGBAArray(std::vector<Color> &result) const;
	unsigned int GetWidth() const;
	unsigned int GetHeight() const;
};

} // TouhouSE
