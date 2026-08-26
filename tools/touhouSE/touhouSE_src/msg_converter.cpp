#include "stdafx.h"

using namespace boost::assign;
using namespace ::Utility;

#define CREATE_CONVERT_PROC(proc_name, new_ext, convert_proc)		\
void proc_name(const char *in_filename) {					\
	char out_filename[256];						\
	STRCPY(out_filename, in_filename);					\
	char * const file_ext = ::PathFindExtensionA(out_filename);	\
	*file_ext = '\0';							\
	STRCAT(out_filename, new_ext);					\
	const bool result = convert_proc(in_filename, out_filename);	\
	BOOST_ASSERT(result);						\
}

CREATE_CONVERT_PROC(Msg2Txt,	".txt", Touhou::Msg::TH13Msg2Txt)
CREATE_CONVERT_PROC(EndingMsg2Txt,	".txt", Touhou::Msg::TH13EndingMsg2Txt)
CREATE_CONVERT_PROC(Txt2Msg,	".msg", Touhou::Msg::Txt2Msg)

#undef CREATE_CONVERT_PROC

void TH125Mission2Txt(const char *filename) {
	std::vector<unsigned char> data;
	const bool read_result = FileRead(filename, data);
	BOOST_ASSERT(read_result);
	boost::shared_ptr<LIST> file_data(new LIST());
	file_data->addr = 0;
	file_data->comp_size = file_data->size = data.size();
	STRCPY(file_data->fn, filename);
	const bool convert_result = th125mission_convert(file_data, data);
	BOOST_ASSERT(convert_result);
}

int main(unsigned int argc, const char *argv[]){
	if(argc < 2) {
		printf("Usage: msg_converter SOURCE...");
		return 0;
	}
	SetAppDir();

	for(unsigned int i = 1; i < argc; i++) {
		const char *path = argv[i];
		const char *filename = ::PathFindFileNameA(path);
		const char *ext = ::PathFindExtensionA(path);
		if(strcmp(ext, ".msg") == 0) {
			if(strcmp(filename, "mission.msg") == 0) {
				printf("%s mission.msg to txt\n", path); 
				TH125Mission2Txt(path);
			} else if(strcmp(filename, "staff.msg") == 0 || strncmp(filename, "e", 1) == 0) {
				printf("%s ending.msg to txt\n", path); 
				EndingMsg2Txt(path);
			} else {
				printf("%s msg to txt\n", path); 
				Msg2Txt(path);
			}
		} else if(strcmp(ext, ".txt") == 0) {
			printf("%s txt to msg\n", path);
			Txt2Msg(path);
		} else {
			printf("Unknown Extention File(%s)\n", path);
		}
	}
	printf("Press Enter To Exit...");
	getchar();
	return 0;
}
