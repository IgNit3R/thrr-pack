
namespace TouhouSE {

namespace Squirrel3 {

struct OuterValue {
  const unsigned int type;
  const unsigned int src;
  const std::string name;

  static std::optional<OuterValue> read(std::istream &in);
};

struct LocalVarInfo {
  const std::string name;
  const unsigned int pos;
  const unsigned int start;
  const unsigned int end;

  static std::optional<LocalVarInfo> read(std::istream &in);
};

struct LineInfo {
  const unsigned int line;
  const unsigned int op;

  static std::optional<LineInfo> read(std::istream &in);
};

struct DefaultParam {
  const unsigned int stackIndex;

  static std::optional<DefaultParam> read(std::istream &in);
};

struct Instruction {
  const unsigned int arg1;
  const unsigned char op;
  const unsigned char arg0;
  const unsigned char arg2;
  const unsigned char arg3;

  static std::optional<Instruction> read(std::istream &in);
};

class Function {
private:
  const std::string srcFileName;
  const std::string name;
  const std::vector<std::string> literalList;
  const std::vector<std::string> parameterList;
  const std::vector<OuterValue> outerValueList;
  const std::vector<LocalVarInfo> localVarInfoList;
  const std::vector<LineInfo> lineInfoList;
  const std::vector<DefaultParam> defaultParamList;
  const std::vector<Instruction> instructionList;
  const std::vector<Function> childList;
  const unsigned int stackSize;
  const bool isGenerator;
  const unsigned int varParamCount;
public:
  Function(
    const std::string srcFileName,
    const std::string name,
    const std::vector<std::string> literalList,
    const std::vector<std::string> parameterList,
    const std::vector<OuterValue> outerValueList,
    const std::vector<LocalVarInfo> localVarInfoList,
    const std::vector<LineInfo> lineInfoList,
    const std::vector<DefaultParam> defaultParamList,
    const std::vector<Instruction> instructionList,
    const std::vector<Function> childList,
    const unsigned int stackSize,
    const bool isGenerator,
    const unsigned int varParamCount)
    :
    srcFileName(std::move(srcFileName)),
    name(std::move(name)),
    literalList(std::move(literalList)),
    parameterList(std::move(parameterList)),
    outerValueList(std::move(outerValueList)),
    localVarInfoList(std::move(localVarInfoList)),
    lineInfoList(std::move(lineInfoList)),
    defaultParamList(std::move(defaultParamList)),
    instructionList(std::move(instructionList)),
    childList(std::move(childList)),
    stackSize(stackSize),
    isGenerator(isGenerator),
    varParamCount(varParamCount)
  {}
  Function(Function && a) :
    srcFileName(std::move(a.srcFileName)),
    name(std::move(a.name)),
    literalList(std::move(a.literalList)),
    parameterList(std::move(a.parameterList)),
    outerValueList(std::move(a.outerValueList)),
    localVarInfoList(std::move(a.localVarInfoList)),
    lineInfoList(std::move(a.lineInfoList)),
    defaultParamList(std::move(a.defaultParamList)),
    instructionList(std::move(a.instructionList)),
    childList(std::move(a.childList)),
    stackSize(a.stackSize),
    isGenerator(a.isGenerator),
    varParamCount(a.varParamCount)
  {}
  Function(const Function & a) :
    srcFileName(a.srcFileName),
    name(a.name),
    literalList(a.literalList),
    parameterList(a.parameterList),
    outerValueList(a.outerValueList),
    localVarInfoList(a.localVarInfoList),
    lineInfoList(a.lineInfoList),
    defaultParamList(a.defaultParamList),
    instructionList(a.instructionList),
    childList(a.childList),
    stackSize(a.stackSize),
    isGenerator(a.isGenerator),
    varParamCount(a.varParamCount)
  {}

  static std::optional<Function> read(std::istream &in);
  std::string infoToString(const unsigned int indentWidth) const;
  std::string instructionToString(unsigned int indentWidth = 0) const;
  std::string toString(const unsigned int indentWidth = 0) const;
  std::string getDisplayLiteralString(const unsigned int index) const;
};

class CNut {
private:
  const Function function;
public:
  CNut(Function function) : function(std::move(function)) {}
  static std::optional<CNut> read(std::istream &in, const unsigned long long int fileSize);
  std::string toString() const;
};

} // Squirrel3

} // TouhouSE
