
#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
struct Color {
public:
	Color() {
	}
	Color(unsigned char r, unsigned char g, unsigned char b, unsigned char alpha) :
		r(r), g(g), b(b), alpha(alpha)
	{ }
	unsigned char r;
	unsigned char g;
	unsigned char b;
	unsigned char alpha;
};
#pragma warning(pop)
#pragma pack(pop)

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Png : boost::noncopyable {
public:
	unsigned int w;
	unsigned int h;
	unsigned int cn;
	std::vector<Color> col;
	std::vector<char> pal;
};
#pragma warning(pop)
#pragma pack(pop)

extern std::vector<Color> pal;

void pngout(unsigned int width2, unsigned int height, unsigned int width, const unsigned char *col, const std::wstring &fn, unsigned int cn);
void pngout(unsigned int width2, unsigned int height, unsigned int width, const unsigned char *col, const std::string &fn, unsigned int cn);
std::shared_ptr<Png> load_png(const char *filename);

namespace TouhouSE {

namespace PNG {

bool ToPng(unsigned int width, unsigned int height, const std::vector<Color> &data, std::vector<unsigned char> &result);
bool FromPng(const std::vector<unsigned char> &data, Png &result);

} // PNG

} // TouhouSE
