
namespace TH075 {

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp);
bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);
bool GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);

} // TH13
