
namespace Touhou { namespace Msg {

class Proc;
class ModelList;

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class CodeModel : boost::noncopyable, public std::enable_shared_from_this<CodeModel> {
public:
	enum VAR_TYPE {
		VAR_TYPE_STRING,
		VAR_TYPE_CRYPT_STRING,
		VAR_TYPE_NUMBER,
		VAR_TYPE_SYMBOL,
		VAR_TYPE_BOOL,
		VAR_TYPE_FLOAT,
		VAR_TYPE_COLOR,
	};
	CodeModel(const std::string &proc_name, unsigned char code, bool is_print = true, bool is_end = false);
	CodeModel &operator()(VAR_TYPE var_type);
	CodeModel &operator()(VAR_TYPE var_type, const std::string &symbol);
	const std::string &GetProcName(void) const;
	unsigned char GetCode(void) const;
	bool IsPrint(void) const;
	bool IsEnd(void) const;
	const std::vector<VAR_TYPE> &GetParamTypeList(void) const;
	const std::string &GetSymbol(void) const;
	bool ParseText(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, unsigned short *cur_time, const std::vector<std::string> &param_list) const;
	bool ParseBin(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, unsigned short time, const std::vector<unsigned char> &param) const;
protected:
	const std::string proc_name;
	const unsigned char code;
	const bool is_print;
	const bool is_end;
	unsigned char padding[1]; // unused
	std::vector<VAR_TYPE> param_type_list;
	std::string symbol;
};
#pragma warning(pop)
#pragma pack(pop)

#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class ModelList : boost::noncopyable, public std::vector<std::shared_ptr<const CodeModel> >, public std::enable_shared_from_this<ModelList> {
public:
	ModelList(const std::string &msg_type_name);
	static std::shared_ptr<const ModelList> GetTH10MsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH11MsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH12MsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH125MsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH128MsgInstance(void);
  static std::shared_ptr<const ModelList> GetTH13MsgInstance(void);
  static std::shared_ptr<const ModelList> GetTH143MsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH10EndingMsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH11EndingMsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH12EndingMsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH125EndingMsgInstance(void);
	static std::shared_ptr<const ModelList> GetTH128EndingMsgInstance(void);
  static std::shared_ptr<const ModelList> GetTH13EndingMsgInstance(void);
  static std::shared_ptr<const ModelList> GetTH143EndingMsgInstance(void);
	std::shared_ptr<const CodeModel> FindCode(unsigned char code) const;
	std::shared_ptr<const CodeModel> FindDefaultEndProc(void) const;
	std::shared_ptr<const CodeModel> FindProcName(const std::string &proc_name, const std::string &symbol = std::string()) const;
	bool ParseText(std::shared_ptr<Proc> &out, unsigned short *cur_time, const std::string &proc_name, const std::vector<std::string> &param_list) const;
	bool ParseBin(std::shared_ptr<Proc> &out, unsigned short time, unsigned char code, const std::vector<unsigned char> &param) const;

	const std::string &GetMsgTypeName(void) const;
protected:
	const std::string msg_type_name;
};
#pragma warning(pop)

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Proc : boost::noncopyable {
protected:
	friend std::istream &operator>>(std::istream &in, std::shared_ptr<Proc> &proc);
	Proc &operator=(const Proc &obj);
public:
	Proc(std::shared_ptr<const ModelList> model_list, unsigned short time, std::shared_ptr<const CodeModel> model, const std::vector<unsigned char> &param = std::vector<unsigned char>());
	Proc(std::shared_ptr<const ModelList> model_list);
	static bool ParseText(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, const std::string &text, unsigned short *cur_time);
	static bool ParseBin(std::shared_ptr<Proc> &out, std::shared_ptr<const ModelList> model_list, std::istream &in);
	unsigned int GetBinOutSize(void) const;
	bool OutText(std::ostream &out, unsigned int tab = 0) const;
	bool OutBin(std::ostream &out) const;

	std::shared_ptr<const ModelList> GetModelList(void) const;
	unsigned short GetTime(void) const;
	void SetTime(unsigned short time);
	std::shared_ptr<const CodeModel> GetModel(void) const;
	void SetModel(std::shared_ptr<const CodeModel> model);
	const std::vector<unsigned char> GetParam(void) const;
	std::vector<unsigned char> GetParam(void);
	void SetParam(const std::vector<unsigned char> &param);
protected:
	const std::shared_ptr<const ModelList> model_list;
	unsigned short time;
	unsigned char padding[2]; // unused
	std::shared_ptr<const CodeModel> model;
	std::vector<unsigned char> param;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Proc> proc);
std::istream &operator>>(std::istream &in, std::shared_ptr<Proc> &proc);

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Script : boost::noncopyable {
protected:
	friend std::istream &operator>>(std::istream &in, std::shared_ptr<Script> &script);
	Script &operator=(const Script &obj);
public:
	Script(std::shared_ptr<const ModelList> model_list);
	unsigned int GetBinOutSize(void) const;
	static bool ParseText(std::shared_ptr<Script> &out, std::shared_ptr<const ModelList> model_list, std::istream &in, unsigned int *function_id = NULL);
	static bool ParseBin(std::shared_ptr<Script> &out, std::shared_ptr<const ModelList> model_list, std::istream &in);
	bool OutText(std::ostream &out, unsigned int proc_id, unsigned int tab = 0) const;
	bool OutBin(std::ostream &out) const;

	std::shared_ptr<const ModelList> GetModelList(void) const;
	const std::vector<std::shared_ptr<const Proc> > &GetProcList(void) const;
	std::vector<std::shared_ptr<const Proc> > &GetProcList(void);
	void SetProcList(const std::vector<std::shared_ptr<const Proc> > proc_list);
protected:
	std::vector<std::shared_ptr<const Proc> > proc_list;
	const std::shared_ptr<const ModelList> model_list;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Script> script);
std::istream &operator>>(std::istream &in, std::shared_ptr<Script> &script);

#pragma pack(push, 4)
#pragma warning(push)
#pragma warning(disable: 4625)
#pragma warning(disable: 4626)
class Msg : boost::noncopyable {
protected:
	friend std::istream &operator>>(std::istream &in, std::shared_ptr<Msg> &msg);
	Msg &operator=(const Msg &obj);
public:
	Msg(std::shared_ptr<const ModelList> model_list);
	unsigned int GetBinOutSize(void) const;
	static bool ParseText(std::shared_ptr<Msg> &out, std::istream &in);
	static bool ParseBin(std::shared_ptr<Msg> &out, std::shared_ptr<const ModelList> model_list, std::istream &in);
	bool OutText(std::ostream &out, unsigned int tab = 0) const;
	bool OutBin(std::ostream &out) const;

	std::shared_ptr<const ModelList> GetModelList(void) const;
	const std::vector<std::shared_ptr<const Script> > &GetScriptList(void) const;
	std::vector<std::shared_ptr<const Script> > &GetScriptList(void);
protected:
	std::vector<std::shared_ptr<const Script> > script_list;
	const std::shared_ptr<const ModelList> model_list;
};
#pragma warning(pop)
#pragma pack(pop)

std::ostream &operator<<(std::ostream &out, std::shared_ptr<const Msg> msg);
std::istream &operator>>(std::istream &in, std::shared_ptr<Msg> &msg);

#define CREATE_MSG2TXT_PROTOTYPE(number)                                                                          \
bool TH##number##Msg2Txt(const char *in_filename, const char *out_filename);                                      \
bool TH##number##Msg2Txt(const std::vector<unsigned char> &data, const char *out_filename);                       \
bool TH##number##Msg2Txt(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data);        \
bool TH##number##Msg2Txt(const std::vector<unsigned char> &data, std::vector<unsigned char> &result);             \
bool TH##number##EndingMsg2Txt(const char *in_filename, const char *out_filename);                                \
bool TH##number##EndingMsg2Txt(const std::vector<unsigned char> &data, const char *out_filename);                 \
bool TH##number##EndingMsg2Txt(std::shared_ptr<const LIST> file_data, const std::vector<unsigned char> &data);  \
bool TH##number##EndingMsg2Txt(const std::vector<unsigned char> &data, std::vector<unsigned char> &result);

CREATE_MSG2TXT_PROTOTYPE(10)
CREATE_MSG2TXT_PROTOTYPE(11)
CREATE_MSG2TXT_PROTOTYPE(12)
CREATE_MSG2TXT_PROTOTYPE(125)
CREATE_MSG2TXT_PROTOTYPE(128)
CREATE_MSG2TXT_PROTOTYPE(13)
CREATE_MSG2TXT_PROTOTYPE(143)
bool Txt2Msg(const char *in_filename, const char *out_filename);
bool Txt2Msg(const std::vector<unsigned char> &data, const char *out_filename);


} // Msg

} // Touhou
