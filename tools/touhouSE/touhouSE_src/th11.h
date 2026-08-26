
namespace TH11 {

bool Extract(std::vector<unsigned char> &data, std::shared_ptr<const LIST> file_data, std::shared_ptr<FILE> fp);
bool PutFile(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data, const std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);
bool GetList(std::vector<std::shared_ptr<LIST> > &list, std::shared_ptr<FILE> fp);

void decomp(const unsigned char *in, unsigned int in_size, unsigned char *out, unsigned int out_size);
void thcrypter(unsigned char* in, unsigned int size, unsigned char key, unsigned char step, unsigned int block, unsigned int limit);
bool th11img_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data);
bool th11msg_convert(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data);
bool head_print(std::vector<std::shared_ptr<LIST> > &list, const std::vector<unsigned char> data, unsigned int total_file_count);

struct dat_data{
	unsigned int size;
	unsigned int list_size;
	unsigned int comp_lsize;
	unsigned int list_num;
};

extern struct dat_data th11dat;

} // TH11
