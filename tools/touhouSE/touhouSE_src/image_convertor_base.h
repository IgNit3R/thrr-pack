
namespace TouhouSE {

template<class T>
class ImageConverterBase : public ConverterBase {
public:
	static bool Convert(
    const std::filesystem::path &fileName,
    const std::vector<unsigned char> &data,
    std::filesystem::path &resultFileName,
    std::vector<unsigned char> &result,
    ExtractorBase &extractor)
  {
		if (data.size() == 0) {
			return false;
		}
		const boost::iostreams::array_source source(reinterpret_cast<const char *>(&data.front()), reinterpret_cast<const char *>(&data.back() + 1));
		boost::iostreams::stream<boost::iostreams::array_source> in(source);
    const std::shared_ptr<typename T> image = typename T::Open(fileName, in, data.size(), extractor);
		if (!image) {
			return false;
		}
		std::vector<Color> rgbaArray;
		if (!image->CreateRGBAArray(rgbaArray)) {
			return false;
		}
		if (!PNG::ToPng(image->GetWidth(), image->GetHeight(), rgbaArray, result)) {
			return false;
		}
		resultFileName = fileName;
		resultFileName.replace_extension(".png");
		return true;
	}
};

} // TouhouSE
