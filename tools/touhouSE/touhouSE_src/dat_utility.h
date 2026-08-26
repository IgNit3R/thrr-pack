
namespace DatUtility {

unsigned int CalcKeyIndex(std::shared_ptr<const LIST> file_data);
unsigned int CalcKeyIndex(const char * const name, const unsigned int length);
std::shared_ptr<const LIST> ExtFindFile(const std::vector<std::shared_ptr<LIST> > &file_list, const char *ext);
bool TryVerFileExtract(DAT_VER dat_ver, const std::vector<std::shared_ptr<LIST> > &file_list, std::shared_ptr<FILE> fp);
bool TryAnmFileExtract(DAT_VER dat_ver, const std::vector<std::shared_ptr<LIST> > &file_list, std::shared_ptr<FILE> fp);

} // DatUtility