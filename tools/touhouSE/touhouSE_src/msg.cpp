#include "stdafx.h"

// ADDマクロ使用箇所で警告が出るため
#pragma warning(push)
#pragma warning(disable: 4834) // 返り値を破棄しています。

namespace Touhou { namespace Msg {

using namespace boost::assign;
using namespace ::Utility;

namespace {

void PrintTab(std::ostream &out, unsigned int count) {
	for(unsigned int i = 0; i < count; i++) {
		out << "\t";
	}
}

void DeleteSpace(char *s) {
	while(*s != '\0') {
		if(*s == '"') {
			s++;
			while(*s != '"' && *s != '\0') {
				s++;
			}
			if(*s == '"') {
				s++;
			}
		} else if(*s == ' ' || *s == '\t' || *s == '\r' || *s == '\n' || *s == ';') {
			::memmove(s, &s[1], ::strlen(&s[1])+1);
		} else {
			*s = static_cast<char>(::tolower(*s));
			s++;
		}
	}
}

#pragma warning(push)
#pragma warning(disable: 4512)
struct FindModelCode {
	FindModelCode(unsigned char code) : code(code) { }
	const unsigned char code;
	bool operator ()(std::shared_ptr<const CodeModel> model) const {
		return model->GetCode() == code;
	}
};
#pragma warning(pop)

#pragma warning(push)
#pragma warning(disable: 4512)
struct FindModelPrintEndFlag {
	FindModelPrintEndFlag(bool is_print, bool is_end) : is_print(is_print), is_end(is_end) { }
	const bool is_print;
	const bool is_end;
	bool operator ()(std::shared_ptr<const CodeModel> model) const {
		return (is_print == model->IsPrint() && is_end == model->IsEnd());
	}
};
#pragma warning(pop)

#pragma warning(push)
#pragma warning(disable: 4512)
struct FindModelProcName {
	FindModelProcName(const std::string &proc_name, const std::string &symbol) : proc_name(proc_name), symbol(symbol) { }
	const std::string proc_name;
	const std::string symbol;
	bool operator ()(std::shared_ptr<const CodeModel> model) const {
		return (proc_name == model->GetProcName()) && (symbol == model->GetSymbol());
	}
};
#pragma warning(pop)

#define PARSE_ASSERT(expr, fmt, ...)        \
	if(!(expr)) {                             \
    if (PRINT_MSG_ERROR) {                  \
		  ::printf(fmt, __VA_ARGS__);           \
		  ::printf("この行は無視されます。\n");	\
    }                                       \
		return false;                           \
	}
#define PARSE_FATAL_ASSERT(expr, fmt, ...)  \
	if(!(expr)) {                             \
    if (PRINT_MSG_ERROR) {                  \
		  ::printf(fmt, __VA_ARGS__);           \
		  ::printf("処理を中断します。\n");     \
    }                                       \
		return false;                           \
	}

} // anonymous

CodeModel::CodeModel(const std::string &proc_name, unsigned char code, bool is_print, bool is_end) :
	proc_name(proc_name), code(code), is_print(is_print), is_end(is_end)
{
}

CodeModel &CodeModel::operator()(VAR_TYPE var_type) {
	BOOST_ASSERT(var_type != VAR_TYPE_SYMBOL);
	param_type_list.push_back(var_type);
	return *this;
}

CodeModel &CodeModel::operator()(VAR_TYPE var_type, const std::string &symbol) {
	BOOST_ASSERT(var_type == VAR_TYPE_SYMBOL);
	param_type_list.push_back(var_type);
	this->symbol = symbol;
	return *this;
}

const std::string &CodeModel::GetProcName(void) const {
	return proc_name;
}

unsigned char CodeModel::GetCode(void) const {
	return code;
}

bool CodeModel::IsPrint(void) const {
	return is_print;
}

bool CodeModel::IsEnd(void) const {
	return is_end;
}

const std::vector<CodeModel::VAR_TYPE> &CodeModel::GetParamTypeList(void) const {
	return param_type_list;
}

const std::string &CodeModel::GetSymbol(void) const {
	return symbol;
}

bool CodeModel::ParseText(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, unsigned short *cur_time, const std::vector<std::string> &param_list) const {
	PARSE_ASSERT(param_list.size() == param_type_list.size(), "引数の数が一致していません(要求:%d、実際:%d)\n", param_list.size(), param_type_list.size());

	if(proc_name == "sleep") { // sleepだけ例外処理
		const int sleep_time = ::atoi(param_list[0].c_str());
		PARSE_ASSERT(1 <= sleep_time && sleep_time <= USHRT_MAX - *cur_time, "sleepに指定できる値の範囲を超えています(%d)\n", sleep_time);
		*cur_time += static_cast<unsigned short>(sleep_time);
		out.reset();
		return true;
	}

	std::vector<unsigned char> params;
	for(unsigned int i = 0; i < param_list.size(); i++) {
		switch(param_type_list[i]) {
			case VAR_TYPE_STRING:
			case VAR_TYPE_CRYPT_STRING: {
				const unsigned int len = static_cast<unsigned int>(::ceil((param_list[i].length() + 1.0) / 4.0)) * 4;
				const unsigned int addr = params.size();
				params.resize(params.size() + len);
				::memcpy(&params[addr], param_list[i].c_str(), param_list[i].length());
				for(unsigned int l = param_list[i].length(); l < len; l++) {
					params[addr + l] = '\0';
				}
				if(param_type_list[i] == VAR_TYPE_CRYPT_STRING) {
					const bool result = TH11::Utility::TextEnCrypt(&params[addr], len);
					BOOST_ASSERT(result);
				}
				break;
			}
			case VAR_TYPE_NUMBER: {
				const int value = ::atoi(param_list[i].c_str());
				const unsigned int addr = params.size();
				params.resize(params.size() + 4);
				::memcpy(&params[addr], &value, 4);
				break;
			}
			case VAR_TYPE_SYMBOL: {
				BOOST_ASSERT(symbol == param_list[i]);
				break;
			}
			case VAR_TYPE_BOOL: {
				unsigned int value;
				if("true" == param_list[i]) {
					value = 1;
				} else if("false" == param_list[i]) {
					value = 0;
				} else {
					PARSE_ASSERT(false, "引数の型が一致しません、「%s」は真偽値ではありません。\n", param_list[i].c_str());
				}
				const unsigned int addr = params.size();
				params.resize(params.size() + 4);
				::memcpy(&params[addr], &value, 4);
				break;
			}
			case VAR_TYPE_FLOAT: {
				const float value = static_cast<float>(::atof(param_list[i].c_str()));
				const unsigned int addr = params.size();
				params.resize(params.size() + 4);
				memcpy(&params[addr], &value, 4);
				break;
			}
			case VAR_TYPE_COLOR: {
				unsigned int r,g,b;
				const int result = ::sscanf_s(param_list[i].c_str(), "#%02x%02x%02x", &r, &g, &b);
				PARSE_ASSERT(result == 3 && 7 == param_list[i].length() && param_list[i][0] == '#', "引数の型が一致しません、「%s」はカラーコードではありません。\n", param_list[i].c_str());
				const unsigned int addr = params.size();
				params.resize(params.size() + 4);
				params[addr + 0] = static_cast<unsigned char>(r);
				params[addr + 1] = static_cast<unsigned char>(g);
				params[addr + 2] = static_cast<unsigned char>(b);
				params[addr + 3] = 0x00;
				break;
			}
		}
	}
	out.reset(new Proc(model_list, *cur_time, shared_from_this(), params));
	return true;
}

bool CodeModel::ParseBin(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, unsigned short time, const std::vector<unsigned char> &param) const {
	unsigned int param_index = 0;
	unsigned int param_count = 0;
	for (CodeModel::VAR_TYPE var_type : param_type_list) {
		switch(var_type) {
			case CodeModel::VAR_TYPE_STRING:
			case CodeModel::VAR_TYPE_CRYPT_STRING: {
				PARSE_FATAL_ASSERT(param.size() - 1 >= param_index, "引数の数が一致していません(関数:%s、要求:%d、実際:%d)\n", proc_name.c_str(), param_type_list.size(), param_count);
				param_index = param.size();
				break;
			}
			case CodeModel::VAR_TYPE_FLOAT:
			case CodeModel::VAR_TYPE_NUMBER: {
				PARSE_FATAL_ASSERT(param.size() >= param_index + 4, "引数の数が一致していません(関数:%s、要求:%d、実際:%d)\n", proc_name.c_str(), param_type_list.size(), param_count);
				param_index += 4;
				break;
			}
			case CodeModel::VAR_TYPE_SYMBOL:
				break;
			case CodeModel::VAR_TYPE_BOOL: {
				PARSE_FATAL_ASSERT(param.size() >= param_index + 4, "引数の数が一致していません(関数:%s、要求:%d、実際:%d)\n", proc_name.c_str(), param_type_list.size(), param_count);
				const unsigned int bool_value = *reinterpret_cast<const unsigned int *>(&param[param_index]);
				PARSE_FATAL_ASSERT(bool_value < 2, "bool型が期待されていますが、bool以外の値が設定されています(%d)\n", bool_value);
				param_index += 4;
				break;
			}
			case CodeModel::VAR_TYPE_COLOR: {
				PARSE_FATAL_ASSERT(param.size() >= param_index + 4, "引数の数が一致していません(関数:%s、要求:%d、実際:%d)\n", proc_name.c_str(), param_type_list.size(), param_count);
				PARSE_FATAL_ASSERT(param[param_index+3] == 0x00, "カラーコード型が期待されていますが、カラーコード以外の値が設定されています(%08x)\n", *reinterpret_cast<const unsigned int *>(&param[param_index]));
				param_index += 4;
				break;
			}
		}
		param_count++;
	}
	out.reset(new Proc(model_list, time, shared_from_this(), param));
	return true;
}



ModelList::ModelList(const std::string &msg_type_name) : msg_type_name(msg_type_name) {
}

#define ADD(proc_name, code, ...) ptr.reset(new CodeModel(proc_name, code, __VA_ARGS__)); instance->push_back(ptr); (*ptr)

//static
std::shared_ptr<const ModelList> ModelList::GetTH10MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH10_MSG"));
	if(instance->empty()) {
		std::shared_ptr<CodeModel> ptr;
		ADD("sleep",			0xFF)(CodeModel::VAR_TYPE_NUMBER);//本来codeは存在しない
		ADD("",			0x00, false, true);
		ADD("enable_img",		0x01)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
		ADD("enable_img",		0x02)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
		ADD("enable_textarea",	0x03);
		ADD("disable_img",		0x04)(CodeModel::VAR_TYPE_SYMBOL, "player");
		ADD("disable_img",		0x05)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
		ADD("disable_textarea",	0x06);
		ADD("mode",			0x07)(CodeModel::VAR_TYPE_SYMBOL, "player");
		ADD("mode",			0x08)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
		ADD("mode",			0x09)(CodeModel::VAR_TYPE_SYMBOL, "other");
		ADD("enter_sleep",			0x0A)(CodeModel::VAR_TYPE_NUMBER);
		ADD("unknown11",		0x0B);
		ADD("call_boss",		0x0C);
		ADD("image_change",		0x0D)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
		ADD("image_change",		0x0E)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
		ADD("print",			0x10)(CodeModel::VAR_TYPE_CRYPT_STRING);
		ADD("unknown18",		0x12);
		ADD("play_bgm",		0x13);
		ADD("name_img",		0x14);
		ADD("next_stage",		0x15);
		ADD("unknown23",		0x17);
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH11MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH11_MSG"));
	if(instance->empty()) {
		std::shared_ptr<CodeModel> ptr;
		ADD("sleep",			0xFF)(CodeModel::VAR_TYPE_NUMBER);//本来codeは存在しない
		ADD("",			0x00, false, true);
		ADD("enable_img",		0x01)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
		ADD("enable_img",		0x02)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
		ADD("enable_textarea",	0x03);
		ADD("disable_img",		0x04)(CodeModel::VAR_TYPE_SYMBOL, "player");
		ADD("disable_img",		0x05)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
		ADD("disable_textarea",	0x06);
		ADD("mode",			0x07)(CodeModel::VAR_TYPE_SYMBOL, "player");
		ADD("mode",			0x08)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
		ADD("mode",			0x09)(CodeModel::VAR_TYPE_SYMBOL, "other");
		ADD("skip",			0x0A)(CodeModel::VAR_TYPE_BOOL);
		ADD("enter_sleep",		0x0B)(CodeModel::VAR_TYPE_NUMBER);
		ADD("call_boss",		0x0C);
		ADD("image_change",		0x0D)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
		ADD("image_change",		0x0E)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
		ADD("print",			0x11)(CodeModel::VAR_TYPE_CRYPT_STRING);
		ADD("unknown18",		0x12);
		ADD("play_bgm",		0x13);
		ADD("name_img",		0x14);
		ADD("next_stage",		0x15);
		ADD("end_bgm",		0x16);
		ADD("unknown23",		0x17);
		ADD("unknown24",		0x18);
		ADD("print_position",	0x19)(CodeModel::VAR_TYPE_NUMBER);
		ADD("bgm_fadeout",		0x1B)(CodeModel::VAR_TYPE_FLOAT);
		ADD("set_ballon_position",	0x1C)(CodeModel::VAR_TYPE_FLOAT)(CodeModel::VAR_TYPE_FLOAT);
		ADD("set_baloon_type",	0x1D)(CodeModel::VAR_TYPE_NUMBER);
		ADD("unknown30",		0x1E);
		ADD("summon",			0x1F)(CodeModel::VAR_TYPE_NUMBER);
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH12MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH11MsgInstance()->begin(), GetTH11MsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH125MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH125_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH11MsgInstance()->begin(), GetTH11MsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH128MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH128_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH11MsgInstance()->begin(), GetTH11MsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH13MsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH13_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH11MsgInstance()->begin(), GetTH11MsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH143MsgInstance(void) {
  static std::shared_ptr<ModelList> instance(new ModelList("TH143_MSG"));
  if (instance->empty()) {
    std::shared_ptr<CodeModel> ptr;
    ADD("sleep", 0xFF)(CodeModel::VAR_TYPE_NUMBER);//本来codeは存在しない
    ADD("", 0x00, false, true);
    ADD("enable_img", 0x01)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
    ADD("enable_img", 0x02)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
    ADD("enable_textarea", 0x03);
    ADD("disable_img", 0x04)(CodeModel::VAR_TYPE_SYMBOL, "player");
    ADD("disable_img", 0x05)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
    ADD("disable_textarea", 0x06);
    ADD("mode", 0x07)(CodeModel::VAR_TYPE_SYMBOL, "player");
    ADD("mode", 0x08)(CodeModel::VAR_TYPE_SYMBOL, "enemy");
    ADD("mode", 0x09)(CodeModel::VAR_TYPE_SYMBOL, "other");
    ADD("skip", 0x0A)(CodeModel::VAR_TYPE_BOOL);
    ADD("enter_sleep", 0x0B)(CodeModel::VAR_TYPE_NUMBER);
    ADD("call_boss", 0x0C);
    ADD("image_change", 0x0D)(CodeModel::VAR_TYPE_SYMBOL, "player")(CodeModel::VAR_TYPE_NUMBER);
    ADD("image_change", 0x0E)(CodeModel::VAR_TYPE_SYMBOL, "enemy")(CodeModel::VAR_TYPE_NUMBER);
    ADD("print", 0x11)(CodeModel::VAR_TYPE_CRYPT_STRING);
    ADD("unknown18", 0x12);
    ADD("play_bgm", 0x13);
    ADD("name_img", 0x14);
    ADD("next_stage", 0x15);
    ADD("end_bgm", 0x16);
    ADD("unknown23", 0x17);
    ADD("unknown24", 0x18);
    ADD("print_position", 0x19)(CodeModel::VAR_TYPE_NUMBER);
    ADD("bgm_fadeout", 0x1B)(CodeModel::VAR_TYPE_FLOAT);
    ADD("set_ballon_position", 0x1C)(CodeModel::VAR_TYPE_FLOAT)(CodeModel::VAR_TYPE_FLOAT);
    ADD("set_baloon_type", 0x1D)(CodeModel::VAR_TYPE_NUMBER);
    ADD("unknown30", 0x1E);
    ADD("summon", 0x1F)(CodeModel::VAR_TYPE_NUMBER);
    ADD("show_tutorial", 0x21)(CodeModel::VAR_TYPE_NUMBER);
  }
  return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH10EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH11_ENDING_MSG"));
	if(instance->empty()) {
		std::shared_ptr<CodeModel> ptr;
		ADD("sleep",				0xFF)(CodeModel::VAR_TYPE_NUMBER);//本来codeは存在しない
		ADD("",				0x00, false, true);
		ADD("print",				0x03)(CodeModel::VAR_TYPE_CRYPT_STRING);
		ADD("enter_sleep",			0x05)(CodeModel::VAR_TYPE_NUMBER);
		ADD("enter_sleep_next_page",	0x06)(CodeModel::VAR_TYPE_NUMBER);
		ADD("load_anm",			0x07)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_STRING);
		ADD("set_background_image",		0x08)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER);
		ADD("set_text_color",		0x09)(CodeModel::VAR_TYPE_COLOR);
		ADD("play_bgm",			0x0A)(CodeModel::VAR_TYPE_STRING);
		ADD("unknown11",			0x0B);
		ADD("call_staffroll",		0x0C, true, true)(CodeModel::VAR_TYPE_STRING);
		ADD("unknown14",			0x0E)(CodeModel::VAR_TYPE_NUMBER);
		ADD("unknown15",			0x0F)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER);
		ADD("unknown16",			0x10)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER);
		ADD("unknown17",			0x11)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER)(CodeModel::VAR_TYPE_NUMBER);
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH11EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH12EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH125EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH128EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH13EndingMsgInstance(void) {
	static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
	if(instance->empty()) {
		instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
	}
	return instance;
}

//static
std::shared_ptr<const ModelList> ModelList::GetTH143EndingMsgInstance(void) {
  static std::shared_ptr<ModelList> instance(new ModelList("TH12_ENDING_MSG"));
  if (instance->empty()) {
    instance->assign(GetTH10EndingMsgInstance()->begin(), GetTH10EndingMsgInstance()->end());
  }
  return instance;
}

#undef ADD

std::shared_ptr<const CodeModel> ModelList::FindCode(unsigned char code) const {
	std::vector<std::shared_ptr<const CodeModel> >::const_iterator it = std::find_if(begin(), end(), FindModelCode(code));
	if(it == end()) {
		return std::shared_ptr<const CodeModel>();
	}
	return *it;
}

std::shared_ptr<const CodeModel> ModelList::FindDefaultEndProc(void) const {
	std::vector<std::shared_ptr<const CodeModel> >::const_iterator it = std::find_if(begin(), end(), FindModelPrintEndFlag(false, true));
	if(it == end()) {
		return std::shared_ptr<const CodeModel>();
	}
	return *it;
}

std::shared_ptr<const CodeModel> ModelList::FindProcName(const std::string &proc_name, const std::string &symbol) const {
	std::vector<std::shared_ptr<const CodeModel> >::const_iterator it = std::find_if(begin(), end(), FindModelProcName(proc_name, symbol));
	if(it == end()) {
		return std::shared_ptr<const CodeModel>();
	}
	return *it;
}

bool ModelList::ParseText(std::shared_ptr<Proc> &out, unsigned short *cur_time, const std::string &proc_name, const std::vector<std::string> &param_list) const {
	std::shared_ptr<const CodeModel> model;
	model = FindProcName(proc_name);
	if(!model) {
		PARSE_ASSERT(param_list.size() != 0, "存在しない関数、もしくは引数の数が違います(関数名:%s、引数:%d)\n", proc_name.c_str(), param_list.size());
		model = FindProcName(proc_name, param_list[0]);
		PARSE_ASSERT(model, "存在しない関数名です(%s)\n", proc_name.c_str());
	}
	return model->ParseText(out, shared_from_this(), cur_time, param_list);
}

bool ModelList::ParseBin(std::shared_ptr<Proc> &out, unsigned short time, unsigned char code, const std::vector<unsigned char> &param) const {
	const std::shared_ptr<const CodeModel> model = FindCode(code);
	if(PRINT_MSG_ERROR && !model) {
		printf("code:0x%02x %d", code, time);
		for(unsigned int i = 0; i < param.size(); i++) {
			printf(" %02x", param[i]);
		}
	}
	PARSE_FATAL_ASSERT(model, "不明な命令番号(0x%02x)\n", code);
	return model->ParseBin(out, shared_from_this(), time, param);
}

const std::string &ModelList::GetMsgTypeName(void) const {
	return msg_type_name;
}



Proc &Proc::operator=(const Proc &obj) {
	BOOST_ASSERT(model_list == obj.model_list);
	time = obj.GetTime();
	model = obj.GetModel();
	param = obj.GetParam();
	return *this;
}
Proc::Proc(std::shared_ptr<const ModelList> model_list, unsigned short time, std::shared_ptr<const CodeModel> model, const std::vector<unsigned char> &param) :
	model_list(model_list), time(time), model(model), param(param)
{
}

Proc::Proc(std::shared_ptr<const ModelList> model_list) :
	model_list(model_list), time(0)
{
}

//static
bool Proc::ParseText(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, const std::string &text, unsigned short *cur_time) {
	const std::string::size_type proc_name_length = text.find_first_of('(');
	PARSE_ASSERT(proc_name_length != std::string::npos, "関数呼び出し以外の記述は許されません。\n");
	std::string proc_name(text, 0, proc_name_length);
	std::vector<std::string> param_list;
	if(text[proc_name_length + 1] != ')') {
		unsigned int param_index = proc_name_length + 1;
		while(true) {
			if(text[param_index] == '"') {
				param_index++;
				const std::string::size_type quot_end_pos = text.find('"', param_index);
				PARSE_ASSERT(quot_end_pos != std::string::npos, "二重引用符「""」が閉じていません。\n");
				param_list.push_back(std::string(text, param_index, quot_end_pos - param_index));
				param_index = quot_end_pos + 1;
				if(text[param_index] == ')') {
					param_index++;
					break;
				}
				if(text[param_index] == ',') {
					param_index++;
					continue;
				}
				PARSE_ASSERT(false, "不明なトークン(%c)\n", text[param_index]);
			} else {
				const std::string::size_type param_split_pos = text.find(',', param_index);
				if(param_split_pos == std::string::npos) {
					const std::string::size_type param_end_pos = text.find(')', param_index);
					PARSE_ASSERT(param_end_pos != std::string::npos, "丸括弧「()」が閉じていません。\n");
					param_list.push_back(std::string(text, param_index, param_end_pos - param_index));
					param_index = param_end_pos + 1;
					break;
				}
				param_list.push_back(std::string(text, param_index, param_split_pos - param_index));
				param_index = param_split_pos + 1;
			}
		}
		PARSE_ASSERT(text.length() == param_index, "関数呼び出しの後には改行が必要です。\n");
	}
	return model_list->ParseText(out, cur_time, proc_name, param_list);
}

//static
bool Proc::ParseBin(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, std::istream &in) {
	unsigned char header[4];
	in.read(reinterpret_cast<char *>(header), sizeof(header));
	PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました\n");
	const unsigned short time = *reinterpret_cast<unsigned short *>(&header[0]);
	const unsigned char code = header[2];
	const unsigned char param_len = header[3];
	std::vector<unsigned char> param(param_len);
	if(param_len != 0) {
		in.read(reinterpret_cast<char *>(&param.front()), param_len);
		PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました\n");
	}
	return model_list->ParseBin(out, time, code, param);
}

unsigned int Proc::GetBinOutSize(void) const {
	return 4 + param.size();
}

bool Proc::OutText(std::ostream &out, unsigned int tab) const {
	if(!model) {
		return false;
	}
	if(!model->IsPrint()) {
		return true;
	}
	PrintTab(out, tab);
	out << model->GetProcName() << "(";
	bool first = true;
	unsigned int param_index = 0;
	for (CodeModel::VAR_TYPE var_type : model->GetParamTypeList()) {
		if(!first) {
			out << ", ";
		}
		switch(var_type) {
			case CodeModel::VAR_TYPE_STRING:
			case CodeModel::VAR_TYPE_CRYPT_STRING: {
				if(param_index >= param.size()) {
					return false;
				}
				std::vector<unsigned char> text(&param[param_index], &param.back() + 1);
				if(var_type == CodeModel::VAR_TYPE_CRYPT_STRING) {
					if(!TH11::Utility::TextDeCrypt(text)) {
						return false;
					}
				}
				out << "\"" << reinterpret_cast<char *>(&text.front()) << "\"";
				param_index += text.size();
				break;
			}
			case CodeModel::VAR_TYPE_NUMBER: {
				if(param_index + 4 > param.size()) {
					return false;
				}
				const int value = *reinterpret_cast<const int *>(&param[param_index]);
				out << value;
				param_index += 4;
				break;
			}
			case CodeModel::VAR_TYPE_SYMBOL: {
				out << model->GetSymbol();
				break;
			}
			case CodeModel::VAR_TYPE_BOOL: {
				if(param_index + 4 > param.size()) {
					return false;
				}
				const unsigned int bool_index = *reinterpret_cast<const unsigned int *>(&param[param_index]);
				if(bool_index >= 2) {
					return false;
				}
				const char * const boolean[2] = {"FALSE", "TRUE"};
				out << boolean[bool_index];
				param_index += 4;
				break;
			}
			case CodeModel::VAR_TYPE_FLOAT: {
				if(param_index + 4 > param.size()) {
					return false;
				}
				const float value = *reinterpret_cast<const float *>(&param[param_index]);
				out << value;
				param_index += 4;
				break;
			}
			case CodeModel::VAR_TYPE_COLOR: {
				if(param_index + 4 > param.size()) {
					return false;
				}
				char color_code[8];
				SPRINTF(color_code, "#%02x%02x%02x", param[param_index + 0], param[param_index + 1], param[param_index + 2]);
				out << color_code;
				param_index += 4;
				break;
			}
		}
		first = false;
	}
	out << ");" << std::endl;
	if(!out.good()) {
		return false;
	}
	return true;
}

bool Proc::OutBin(std::ostream &out) const {
	unsigned char header[4];
	*reinterpret_cast<unsigned short *>(header) = time;
	header[2] = model->GetCode();
	BOOST_ASSERT(param.size() <= UCHAR_MAX);
	header[3] = static_cast<unsigned char>(param.size());
	out.write(reinterpret_cast<const char *>(header), sizeof(header));
	if(!out.good()) {
		return false;
	}
	if(!param.empty()) {
		out.write(reinterpret_cast<const char *>(&param.front()), param.size());
		if(!out.good()) {
			return false;
		}
	}
	return true;
}


std::shared_ptr<const ModelList> Proc::GetModelList(void) const {
	return model_list;
}

unsigned short Proc::GetTime(void) const {
	return time;
}

void Proc::SetTime(unsigned short time) {
	this->time = time;
}

std::shared_ptr<const CodeModel> Proc::GetModel(void) const {
	return model;
}

void Proc::SetModel(std::shared_ptr<const CodeModel> model) {
	this->model = model;
}

const std::vector<unsigned char> Proc::GetParam(void) const {
	return param;
}

std::vector<unsigned char> Proc::GetParam(void) {
	return param;
}

void Proc::SetParam(const std::vector<unsigned char> &param) {
	this->param = param;
}

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Proc> proc) {
	proc->OutBin(out);
	return out;
}

std::istream &operator>>(std::istream &in, std::shared_ptr<Proc> &proc) {
	BOOST_ASSERT(proc);
	std::shared_ptr<Proc> temp;
	const bool result = Proc::ParseBin(temp, proc->GetModelList(), in);
	BOOST_ASSERT(result);
	BOOST_ASSERT(temp);
	*proc = *temp;
	return in;
}



Script &Script::operator=(const Script &obj) {
	BOOST_ASSERT(model_list == obj.model_list);
	proc_list = obj.proc_list;
	return *this;
}

Script::Script(std::shared_ptr<const ModelList> model_list) : model_list(model_list) {
}

unsigned int Script::GetBinOutSize(void) const {
	unsigned int result = 0;
	for (std::shared_ptr<const Proc> proc : proc_list) {
		BOOST_ASSERT(proc);
		result += proc->GetBinOutSize();
	}
	result += 4;
	return result;
}


#undef PARSE_ASSERT
#define PARSE_ASSERT(expr, fmt, ...)			\
	if(!(expr)) {						\
		::printf(fmt, __VA_ARGS__);			\
		::printf("この行は無視されます。\n");	\
		continue;					\
	}


//static
bool Script::ParseText(std::shared_ptr<Script> &out, std::shared_ptr<const ModelList> model_list, std::istream &in, unsigned int *function_id) {
	if(in.eof()) {
		return true;
	}
	unsigned short cur_time = 0;
	bool first = true;
	bool end_proc = false;
	while(true) {
		char line[256];
		in.getline(line, sizeof(line));
		PARSE_FATAL_ASSERT(!in.bad(), "読み込みに失敗しました\n");
		PARSE_FATAL_ASSERT(in.good() || in.eof(), "1行が長すぎます。\n");
		PARSE_FATAL_ASSERT(first || !in.eof() || line[0] !='\0', "波括弧「{}」が閉じていません。\n");
		if(in.eof() && line[0] == '\0') {
			break;
		}
		DeleteSpace(line);
		if(line[0] == '\0' || line[0] == '#' || strncmp(line, "//", 2) == 0) {
			continue;
		}
		if(first) {
			PARSE_ASSERT(::strncmp(line, "function", 8) == 0, "不明なトークン(%c)\n", line[0]);
			PARSE_ASSERT(::strncmp(&line[8], "proc", 4) == 0, "不正な関数名です(%s)\n", &line[8]);
			PARSE_ASSERT(::isdigit(line[12]) != 0, "不明なトークン(%c)\n", line[12]);
			int temp = ::atoi(&line[12]);
			PARSE_ASSERT(function_id == NULL || *function_id == static_cast<unsigned int>(temp), "不正な関数名です(proc%d)\n", temp);
			unsigned int digit_num = 1;
			while((temp = temp/10) > 0) {
				digit_num++;
			}
			PARSE_ASSERT(line[12 + digit_num] == '{', "改行の前に{が必要です。\n");
			first = false;
			(*function_id)++;
			out.reset(new Script(model_list));
			continue;
		}
		if(line[0] == '}') {
			PARSE_ASSERT(line[1] == '\0', "}の後には改行が必要です。\n");
			if(!end_proc) { // 終端命令が記述されていなかったらデフォルトの終端イベントの挿入
				const std::shared_ptr<const CodeModel> model = model_list->FindDefaultEndProc();
				BOOST_ASSERT(model);
				out->GetProcList() += std::shared_ptr<Proc>(new Proc(model_list, cur_time, model));
			}
			break;
		}
		PARSE_ASSERT(!end_proc, "終端命令(%s)の後には処理を記述できません。\n", out->GetProcList().back()->GetModel()->GetProcName().c_str());
		std::shared_ptr<Proc> proc;
		const bool result = Proc::ParseText(proc, model_list, line, &cur_time);
		if(!result) {
			continue;
		}
		if(proc) {
			if(proc->GetModel()->IsEnd()) {
				end_proc = true;
			}
			out->GetProcList().push_back(proc);
		}
	}
	return true;
}

//static
bool Script::ParseBin(std::shared_ptr<Script> &out, std::shared_ptr<const ModelList> model_list, std::istream &in) {
	out.reset(new Script(model_list));
	while(true) {
		std::shared_ptr<Proc> proc;
		if(!Proc::ParseBin(proc, model_list, in)) {
			return false;
		}
		out->GetProcList().push_back(proc);
		if(proc->GetModel()->IsEnd()) {
			break;
		}
	}
	unsigned int end_signature;
	in.read(reinterpret_cast<char *>(&end_signature), sizeof(end_signature));
	PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました。\n");
	PARSE_FATAL_ASSERT(end_signature == 0x00000000, "終端識別子の値が不正です(%08x)\n", end_signature);
	return true;
}

bool Script::OutText(std::ostream &out, unsigned int proc_id, unsigned int tab) const {
	PrintTab(out, tab);
	out << "function proc" << proc_id << "{\n";
	unsigned int time = 0;
	for (std::shared_ptr<const Proc> proc : proc_list) {
		BOOST_ASSERT(proc);
		if(proc->GetTime() != time) {
			PrintTab(out, tab+1);
			out << "sleep(" << (proc->GetTime() - time) << ");" << std::endl << std::endl;
			time = proc->GetTime();
		}
		if(!proc->OutText(out, tab + 1)) {
			return false;
		}
	}
	PrintTab(out, tab);
	out << "}" << std::endl;
	if(!out.good()) {
		return false;
	}
	return true;
}

bool Script::OutBin(std::ostream &out) const {
	for (std::shared_ptr<const Proc> proc : proc_list) {
		BOOST_ASSERT(proc);
		if(!proc->OutBin(out)) {
			return false;
		}
	}
	const unsigned int end_signature = 0x00000000;
	out.write(reinterpret_cast<const char *>(&end_signature), sizeof(end_signature));
	if(!out.good()) {
		return false;
	}
	return true;
}

std::shared_ptr<const ModelList> Script::GetModelList(void) const {
	return model_list;
}

const std::vector<std::shared_ptr<const Proc> > &Script::GetProcList(void) const {
	return proc_list;
}

std::vector<std::shared_ptr<const Proc> > &Script::GetProcList(void) {
	return proc_list;
}

void Script::SetProcList(const std::vector<std::shared_ptr<const Proc> > proc_list) {
	this->proc_list = proc_list;
}

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Script> script) {
	BOOST_ASSERT(script);
	const bool result = script->OutBin(out);
	BOOST_ASSERT(result);
	return out;
}

std::istream &operator>>(std::istream &in, std::shared_ptr<Script> &script) {
	BOOST_ASSERT(script);
	std::shared_ptr<Script> temp;
	const bool result = Script::ParseBin(temp, script->GetModelList(), in);
	BOOST_ASSERT(result);
	BOOST_ASSERT(temp);
	*script = *temp;
	return in;
}



Msg &Msg::operator=(const Msg &obj) {
	BOOST_ASSERT(model_list == obj.model_list);
	script_list = obj.script_list;
	return *this;
}

Msg::Msg(std::shared_ptr<const ModelList> model_list) : model_list(model_list) {
}

unsigned int Msg::GetBinOutSize(void) const {
	unsigned int result = 4 + script_list.size() * 8;
	for (std::shared_ptr<const Script> script : script_list) {
		BOOST_ASSERT(script);
		result += script->GetBinOutSize();
	}
	return result;
}

char ToUpperCase(char var) {
	return static_cast<char>(::toupper(var));
}

//static
bool Msg::ParseText(std::shared_ptr<Msg> &out, std::istream &in) {
	char line[256];
	while(true) {
		in.getline(line, sizeof(line));
		PARSE_FATAL_ASSERT(!in.bad(), "読み込みに失敗しました\n");
		PARSE_FATAL_ASSERT(in.good() || in.eof(), "1行が長すぎます。\n");
		PARSE_FATAL_ASSERT(!in.eof(), "$MSG_TYPE文が見つかりませんでした。");
		DeleteSpace(line);
		if(line[0] == '\0' || line[0] == '#' || strcmp(line, "//") == 0) {
			continue;
		}
		break;
	}
	PARSE_FATAL_ASSERT(::strncmp(line, "$msg_type=", 10) == 0, "不明なトークン(%c)\n", line[0]);
  std::map<std::string, std::shared_ptr<const ModelList>(*)(void)> model_list_map;
#define ADD(proc) model_list_map.insert({proc()->GetMsgTypeName(), proc});
		ADD(ModelList::GetTH11MsgInstance)ADD(ModelList::GetTH12MsgInstance)ADD(ModelList::GetTH125MsgInstance)
    ADD(ModelList::GetTH128MsgInstance)ADD(ModelList::GetTH13MsgInstance)ADD(ModelList::GetTH143MsgInstance)
		ADD(ModelList::GetTH11EndingMsgInstance)ADD(ModelList::GetTH12EndingMsgInstance)ADD(ModelList::GetTH125EndingMsgInstance)
    ADD(ModelList::GetTH128EndingMsgInstance)ADD(ModelList::GetTH13EndingMsgInstance)ADD(ModelList::GetTH143EndingMsgInstance)
#undef ADD
	std::transform(&line[10], &line[STRLEN(line)], &line[10], ToUpperCase);
	std::map<std::string, std::shared_ptr<const ModelList>(*)(void)>::const_iterator it = model_list_map.find(&line[10]);
	PARSE_FATAL_ASSERT(it != model_list_map.end(), "不正なMSG_TYPEです(%s)\n", &line[11]);
	out.reset(new Msg(it->second()));

	unsigned int function_id = 0;
	while(true) {
		std::shared_ptr<Script> script;
		if(!Script::ParseText(script, out->GetModelList(), in, &function_id)) {
			return false;
		}
		if(!script) {
			break;
		}
		out->GetScriptList().push_back(script);
	}
	return true;
}

//static
bool Msg::ParseBin(std::shared_ptr<Msg> &out, std::shared_ptr<const ModelList> model_list, std::istream &in) {
	unsigned int script_count;
	in.read(reinterpret_cast<char *>(&script_count), 4);
  if (script_count == 0) {
    return false;
  }
	PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました\n");

	std::vector<unsigned int> addr_list(script_count);
	for(unsigned int i = 0; i < script_count; i++) {
		in.read(reinterpret_cast<char *>(&addr_list[i]), 4);
		PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました\n");
		unsigned int signature;
		in.read(reinterpret_cast<char *>(&signature), 4);
		PARSE_FATAL_ASSERT(in.good(), "読み込みに失敗しました\n");
		PARSE_FATAL_ASSERT(signature == 0x100, "識別子の値が不正です(%08x)\n", signature);
	}

	out.reset(new Msg(model_list));
	for (unsigned int addr : addr_list) {
		in.seekg(addr, std::istream::beg);
		std::shared_ptr<Script> script;
		if(!Script::ParseBin(script, model_list, in)) {
			return false;
		}
		BOOST_ASSERT(script);
		out->GetScriptList().push_back(script);
	}
	return true;
}

bool Msg::OutText(std::ostream &out, unsigned int tab) const {
	out << "$MSG_TYPE = " << model_list->GetMsgTypeName() << std::endl << std::endl;
	unsigned int proc_id = 0;
	for (std::shared_ptr<const Script> script : script_list) {
		BOOST_ASSERT(script);
		if(!script->OutText(out, proc_id, tab)) {
			return false;
		}
		proc_id++;
	}
	return true;
}

bool Msg::OutBin(std::ostream &out) const {
	const unsigned int script_count = script_list.size();
	out.write(reinterpret_cast<const char *>(&script_count), sizeof(script_count));
	if(!out.good()) {
		return false;
	}

	unsigned int script_address = 4 + script_list.size() * 8;
	for (std::shared_ptr<const Script> script : script_list) {
		BOOST_ASSERT(script);
		unsigned int header[2];
		header[0] = script_address;
		header[1] = 0x100; // よくわからない固定値
		out.write(reinterpret_cast<const char *>(header), sizeof(header));
		if(!out.good()) {
			return false;
		}
		script_address += script->GetBinOutSize();
	}
	
	for (std::shared_ptr<const Script> script : script_list) {
		BOOST_ASSERT(script);
		if(!script->OutBin(out)) {
			return false;
		}
	}
	return true;
}

std::shared_ptr<const ModelList> Msg::GetModelList(void) const {
	return model_list;
}

const std::vector<std::shared_ptr<const Script> > &Msg::GetScriptList(void) const {
	return script_list;
}

std::vector<std::shared_ptr<const Script> > &Msg::GetScriptList(void) {
	return script_list;
}

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Msg> msg) {
	BOOST_ASSERT(msg);
	const bool result = msg->OutBin(out);
	BOOST_ASSERT(result);
	return out;
}

std::istream &operator>>(std::istream &in, std::shared_ptr<Msg> &msg) {
	BOOST_ASSERT(msg);
	std::shared_ptr<Msg> temp;
	const bool result = Msg::ParseBin(temp, msg->GetModelList(), in);
	BOOST_ASSERT(result);
	BOOST_ASSERT(temp);
	*msg = *temp;
	return in;
}



template<std::shared_ptr<const ModelList> (*proc_ptr)(void)>
bool Msg2Txt(const char *in_filename, const char *out_filename) {
	if(in_filename == NULL || out_filename == NULL) {
		return false;
	}
	std::shared_ptr<const ModelList> model_list = proc_ptr();
	BOOST_ASSERT(model_list);
	std::ifstream in(in_filename, std::ifstream::binary);
	if(!in.is_open()) {
		return false;
	}
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseBin(msg, model_list, in)) {
		return false;
	}
	BOOST_ASSERT(msg);
	in.close();

	std::ofstream out(out_filename);
	if(!out.is_open()) {
		return false;
	}
	if(!msg->OutText(out)) {
		return false;
	}
	out.close();
	return true;
}
template<std::shared_ptr<const ModelList> (*proc_ptr)(void)>
bool Msg2Txt(const std::vector<unsigned char> &data, const char *out_filename) {
	if(out_filename == NULL || data.empty()) {
		return false;
	}
	std::shared_ptr<const ModelList> model_list = proc_ptr();
	BOOST_ASSERT(model_list);
	boost::iostreams::stream<boost::iostreams::array_source> in(reinterpret_cast<const char *>(&data.front()), data.size());
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseBin(msg, model_list, in)) {
		return false;
	}
	BOOST_ASSERT(msg);

	std::ofstream out(out_filename);
	if(!out.is_open()) {
		return false;
	}
	if(!msg->OutText(out)) {
		return false;
	}
	out.close();
	return true;
}
template<std::shared_ptr<const ModelList> (*proc_ptr)(void)>
bool Msg2Txt(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {
	if(!file_data || data.empty()) {
		return false;
	}
	std::shared_ptr<const ModelList> model_list = proc_ptr();
	BOOST_ASSERT(model_list);
	boost::iostreams::stream<boost::iostreams::array_source> in(reinterpret_cast<const char *>(&data.front()), data.size());
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseBin(msg, model_list, in)) {
		return false;
	}
	BOOST_ASSERT(msg);

	char out_filename[256] = "data/";
	STRCAT(out_filename, file_data->fn);
	char * const file_ext = ::PathFindExtensionA(out_filename);
	*file_ext = '\0';
	STRCAT(out_filename, ".txt");
	std::ofstream out(out_filename);
	if(!out.is_open()) {
		return false;
	}
	if(!msg->OutText(out)) {
		return false;
	}
	out.close();
	return true;
}
template<std::shared_ptr<const ModelList> (*proc_ptr)(void)>
bool Msg2Txt(const std::vector<unsigned char> &data, std::vector<unsigned char> &result) {
	if(data.empty()) {
		return false;
	}
	std::shared_ptr<const ModelList> model_list = proc_ptr();
	BOOST_ASSERT(model_list);
	boost::iostreams::stream<boost::iostreams::array_source> in(reinterpret_cast<const char *>(&data.front()), data.size());
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseBin(msg, model_list, in)) {
		return false;
	}
	BOOST_ASSERT(msg);

  result.clear();
  container_sink sink(result);
  boost::iostreams::stream<container_sink> stream(sink);
	if(!msg->OutText(stream)) {
		return false;
	}
	return true;
}



#define CREATE_MSG2TXT_FUNCTION(number)                                                                           \
bool TH##number##Msg2Txt(const char *in_filename, const char *out_filename) {                                     \
  return Msg2Txt<ModelList::GetTH##number##MsgInstance>(in_filename, out_filename);                               \
}                                                                                                                 \
bool TH##number##Msg2Txt(const std::vector<unsigned char> &data, const char *out_filename) {                      \
  return Msg2Txt<ModelList::GetTH##number##MsgInstance>(data, out_filename);                                      \
}                                                                                                                 \
bool TH##number##Msg2Txt(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {       \
  return Msg2Txt<ModelList::GetTH##number##MsgInstance>(file_data, data);                                         \
}                                                                                                                 \
bool TH##number##Msg2Txt(const std::vector<unsigned char> &data, std::vector<unsigned char> &result) {            \
  return Msg2Txt<ModelList::GetTH##number##MsgInstance>(data, result);                                            \
}                                                                                                                 \
bool TH##number##EndingMsg2Txt(const char *in_filename, const char *out_filename) {                               \
  return Msg2Txt<ModelList::GetTH##number##EndingMsgInstance>(in_filename, out_filename);                         \
}                                                                                                                 \
bool TH##number##EndingMsg2Txt(const std::vector<unsigned char> &data, const char *out_filename) {                \
  return Msg2Txt<ModelList::GetTH##number##EndingMsgInstance>(data, out_filename);                                \
}                                                                                                                 \
bool TH##number##EndingMsg2Txt(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data) {	\
  return Msg2Txt<ModelList::GetTH##number##EndingMsgInstance>(file_data, data);                                   \
}                                                                                                                 \
bool TH##number##EndingMsg2Txt(const std::vector<unsigned char> &data, std::vector<unsigned char> &result) {      \
  return Msg2Txt<ModelList::GetTH##number##EndingMsgInstance>(data, result);                                      \
}

CREATE_MSG2TXT_FUNCTION(10)
CREATE_MSG2TXT_FUNCTION(11)
CREATE_MSG2TXT_FUNCTION(12)
CREATE_MSG2TXT_FUNCTION(125)
CREATE_MSG2TXT_FUNCTION(128)
CREATE_MSG2TXT_FUNCTION(13)
CREATE_MSG2TXT_FUNCTION(143)

#undef CREATE_MSG2TXT_FUNCTION

bool Txt2Msg(const char *in_filename, const char *out_filename) {
	if(in_filename == NULL || out_filename == NULL) {
		return false;
	}
	std::ifstream in(in_filename);
	if(!in.is_open()) {
		return false;
	}
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseText(msg, in)) {
		return false;
	}
	BOOST_ASSERT(msg);
	in.close();

	std::ofstream out(out_filename, std::ofstream::binary);
	if(!out.is_open()) {
		return false;
	}
	if(!msg->OutBin(out)) {
		return false;
	}
	out.close();
	return true;
}

bool Txt2Msg(const std::vector<unsigned char> &data, const char *out_filename) {
	if(out_filename == NULL || data.empty()) {
		return false;
	}
	boost::iostreams::stream<boost::iostreams::array_source> in(reinterpret_cast<const char *>(&data.front()), data.size());
	std::shared_ptr<Msg> msg;
	if(!Msg::ParseText(msg, in)) {
		return false;
	}
	BOOST_ASSERT(msg);
	in.close();

	std::ofstream out(out_filename, std::ofstream::binary);
	if(!out.is_open()) {
		return false;
	}
	if(!msg->OutBin(out)) {
		return false;
	}
	out.close();
	return true;
}

} // Msg

} // Touhou

#pragma warning(pop)
