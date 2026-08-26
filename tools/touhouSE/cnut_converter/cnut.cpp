
#include "stdafx.h"

namespace TouhouSE {

namespace Squirrel3 {

namespace {

enum Type {
  OT_NULL =           0x01000001,
  OT_INTEGER =        0x05000002,
  OT_FLOAT =          0x05000004,
  OT_BOOL =           0x01000008,
  OT_STRING =         0x08000010,
  OT_TABLE =          0x0a000020,
  OT_ARRAY =          0x08000040,
  OT_USERDATA =       0x0a000080,
  OT_CLOSURE =        0x08000100,
  OT_NATIVECLOSURE =  0x08000200,
  OT_GENERATOR =      0x08000400,
  OT_USERPOINTER =    0x00000800,
  OT_THREAD =         0x08001000,
  OT_FUNCPROTO =      0x08002000,
  OT_CLASS =          0x08004000,
  OT_INSTANCE =       0x0a008000,
  OT_WEAKREF =        0x08010000,
  OT_OUTER =          0x08020000,
};

constexpr unsigned int ObjectIndexNull = 0;
constexpr unsigned int ObjectIndexString = 1;
constexpr unsigned int ObjectIndexInteger = 2;

std::optional<std::variant<nullptr_t, std::string, unsigned int> > readObject(std::istream &in) {
  unsigned int type;
  in.read(reinterpret_cast<char *>(&type), 4);
  if (!in.good() || (type != OT_STRING && type != OT_NULL && type != OT_INTEGER)) {
    return{};
  }
  switch (type) {
  case OT_STRING: {
    unsigned int length;
    in.read(reinterpret_cast<char *>(&length), 4);
    if (!in.good()) {
      return{};
    }
    if (length == 0) {
      return std::string();
    }
    std::string result;
    result.resize(length);
    in.read(&result.front(), length);
    return std::move(result);
  }
  case OT_NULL:
    return std::variant<nullptr_t, std::string, unsigned int>(nullptr);
  case OT_INTEGER: {
    unsigned int result;
    in.read(reinterpret_cast<char *>(&result), 4);
    if (!in.good()) {
      return{};
    }
    return result;
  }
  }
  return{};
}

bool isNull(const std::variant<nullptr_t, std::string, unsigned int> &object) {
  return object.index() == ObjectIndexNull;
}

bool isString(const std::variant<nullptr_t, std::string, unsigned int> &object) {
  return object.index() == ObjectIndexString;
}

bool isInteger(const std::variant<nullptr_t, std::string, unsigned int> &object) {
  return object.index() == ObjectIndexInteger;
}

std::optional<std::string> readString(std::istream &in) {
  const auto temp = readObject(in);
  if (!temp || !isString(*temp)) {
    return{};
  }
  return std::get<std::string>(*temp);
}
std::optional<std::string> readStringOrNull(std::istream &in) {
  const auto temp = readObject(in);
  if (!temp) {
    return{};
  }
  if (isString(*temp)) {
    return std::get<std::string>(*temp);
  }
  if (isNull(*temp)) {
    return std::string();
  }
  return{};
}

std::optional<unsigned int> readInteger(std::istream &in) {
  const auto temp = readObject(in);
  if (!temp) {
    return{};
  }
  if (!isInteger(*temp)) {
    return{};
  }
  return std::get<unsigned int>(*temp);
}

std::optional<unsigned int> readRawInteger(std::istream &in) {
  unsigned int data;
  in.read(reinterpret_cast<char *>(&data), 4);
  if (!in.good()) {
    return{};
  }
  return data;
}

std::optional<unsigned char> readRawChar(std::istream &in) {
  unsigned char data;
  in.read(reinterpret_cast<char *>(&data), 1);
  if (!in.good()) {
    return{};
  }
  return data;
}

std::optional<bool> readRawBoolean(std::istream &in) {
  unsigned char data;
  in.read(reinterpret_cast<char *>(&data), 1);
  if (!in.good()) {
    return{};
  }
  return data != 0;
}

template<typename T>
std::optional<std::vector<T> > readVector(std::istream &in, const unsigned int count, std::optional<T> (* const func)(std::istream &)) {
  std::vector<T> result;
  result.reserve(count);
  for (unsigned int i = 0; i < count; i++) {
    const std::optional<T> item = func(in);
    if (!item) {
      return{};
    }
    result.push_back(*item);
  }
  return std::move(result);
}

auto readStringVector(std::istream &in, const unsigned int count) {
  return readVector(in, count, readString);
}

bool checkPart(std::istream &in) {
  char signature[4];
  in.read(signature, 4);
  return in.good() && std::equal(&signature[0], &signature[_countof(signature)], "TRAP");
}

enum OpCode {
  OP_LINE = 0x00,
  OP_LOAD = 0x01,
  OP_LOADINT = 0x02,
  OP_LOADFLOAT = 0x03,
  OP_DLOAD = 0x04,
  OP_TAILCALL = 0x05,
  OP_CALL = 0x06,
  OP_PREPCALL = 0x07,
  OP_PREPCALLK = 0x08,
  OP_GETK = 0x09,
  OP_MOVE = 0x0A,
  OP_NEWSLOT = 0x0B,
  OP_DELETE = 0x0C,
  OP_SET = 0x0D,
  OP_GET = 0x0E,
  OP_EQ = 0x0F,
  OP_NE = 0x10,
  OP_ADD = 0x11,
  OP_SUB = 0x12,
  OP_MUL = 0x13,
  OP_DIV = 0x14,
  OP_MOD = 0x15,
  OP_BITW = 0x16,
  OP_RETURN = 0x17,
  OP_LOADNULLS = 0x18,
  OP_LOADROOT = 0x19,
  OP_LOADBOOL = 0x1A,
  OP_DMOVE = 0x1B,
  OP_JMP = 0x1C,
  OP_JCMP = 0x1D,
  OP_JZ = 0x1E,
  OP_SETOUTER = 0x1F,
  OP_GETOUTER = 0x20,
  OP_NEWOBJ = 0x21,
  OP_APPENDARRAY = 0x22,
  OP_COMPARITH = 0x23,
  OP_INC = 0x24,
  OP_INCL = 0x25,
  OP_PINC = 0x26,
  OP_PINCL = 0x27,
  OP_CMP = 0x28,
  OP_EXISTS = 0x29,
  OP_INSTANCEOF = 0x2A,
  OP_AND = 0x2B,
  OP_OR = 0x2C,
  OP_NEG = 0x2D,
  OP_NOT = 0x2E,
  OP_BWNOT = 0x2F,
  OP_CLOSURE = 0x30,
  OP_YIELD = 0x31,
  OP_RESUME = 0x32,
  OP_FOREACH = 0x33,
  OP_POSTFOREACH = 0x34,
  OP_CLONE = 0x35,
  OP_TYPEOF = 0x36,
  OP_PUSHTRAP = 0x37,
  OP_POPTRAP = 0x38,
  OP_THROW = 0x39,
  OP_NEWSLOTA = 0x3A,
  OP_GETBASE = 0x3B,
  OP_CLOSE = 0x3C,
};

std::string indent(const unsigned int count) {
  std::string result;
  for (unsigned int i = 0; i < count; i++) {
    result += "  ";
  }
  return std::move(result);
}

} // anonymous

std::optional<OuterValue> OuterValue::read(std::istream &in) {
  const std::optional<unsigned int> type = readRawInteger(in);
  const std::optional<unsigned int> src = readInteger(in);
  const std::optional<std::string> name = readString(in);
  if (!type || (*type != 0 && *type != 1) || !src || !name || name->empty()) {
    return{};
  }
  return OuterValue{ *type, *src, *name };
}

std::optional<LocalVarInfo> LocalVarInfo::read(std::istream &in) {
  const std::optional<std::string> name = readString(in);
  const std::optional<unsigned int> pos = readRawInteger(in);
  const std::optional<unsigned int> start = readRawInteger(in);
  const std::optional<unsigned int> end = readRawInteger(in);
  if (!name || !pos || !start || !end) {
    return{};
  }
  return LocalVarInfo{ *name, *pos, *start, *end };
}

std::optional<LineInfo> LineInfo::read(std::istream &in) {
  const std::optional<unsigned int> line = readRawInteger(in);
  const std::optional<unsigned int> op = readRawInteger(in);
  if (!line || !op) {
    return{};
  }
  return LineInfo{ *line, *op };
}

std::optional<DefaultParam> DefaultParam::read(std::istream &in) {
  const std::optional<unsigned int> stackIndex = readRawInteger(in);
  if (!stackIndex) {
    return{};
  }
  return DefaultParam{ *stackIndex };
}

std::optional<Instruction> Instruction::read(std::istream &in) {
  const std::optional<unsigned int> arg1 = readRawInteger(in);
  const std::optional<unsigned char> op = readRawChar(in);
  const std::optional<unsigned char> arg0 = readRawChar(in);
  const std::optional<unsigned char> arg2 = readRawChar(in);
  const std::optional<unsigned char> arg3 = readRawChar(in);
  if (!arg1 || !op || !arg0 || !arg2 || !arg3) {
    return{};
  }
  return Instruction{ *arg1, *op, *arg0, *arg2, *arg3 };
}

std::optional<Function> Function::read(std::istream &in) {
  const bool part1 = checkPart(in);
  const std::optional<std::string> srcFileName = readStringOrNull(in);
  const std::optional<std::string> name = readStringOrNull(in);
  const bool part2 = checkPart(in);
  const std::optional<unsigned int> literalCount = readRawInteger(in);
  const std::optional<unsigned int> parameterCount = readRawInteger(in);
  const std::optional<unsigned int> outerValueCount = readRawInteger(in);
  const std::optional<unsigned int> localVarInfoCount = readRawInteger(in);
  const std::optional<unsigned int> lineInfoCount = readRawInteger(in);
  const std::optional<unsigned int> defaultParamCount = readRawInteger(in);
  const std::optional<unsigned int> instructionCount = readRawInteger(in);
  const std::optional<unsigned int> founctionCount = readRawInteger(in);
  const bool part3 = checkPart(in);
  if (!part1 || !srcFileName || !name || !part2
    || !literalCount || !parameterCount || !outerValueCount || !localVarInfoCount
    || !lineInfoCount || !defaultParamCount || !instructionCount || !founctionCount
    || !part3)
  {
    return{};
  }
  const std::optional<std::vector<std::string> > literalList = readStringVector(in, *literalCount);
  const bool part4 = checkPart(in);
  const std::optional<std::vector<std::string> > parameterList = readStringVector(in, *parameterCount);
  const bool part5 = checkPart(in);
  const std::optional<std::vector<OuterValue> > outerValueList = readVector(in, *outerValueCount, &OuterValue::read);
  const bool part6 = checkPart(in);
  const std::optional<std::vector<LocalVarInfo> > localVarInfoList = readVector(in, *localVarInfoCount, &LocalVarInfo::read);
  const bool part7 = checkPart(in);
  const std::optional<std::vector<LineInfo> > lineInfoList = readVector(in, *lineInfoCount, &LineInfo::read);
  const bool part8 = checkPart(in);
  const std::optional<std::vector<DefaultParam> > defaultParamList = readVector(in, *defaultParamCount, &DefaultParam::read);
  const bool part9 = checkPart(in);
  const std::optional<std::vector<Instruction> > instructionList = readVector(in, *instructionCount, &Instruction::read);
  const bool part10 = checkPart(in);
  if (!literalList || !part4 || !parameterCount || !part5 || !outerValueList || !part6 || !localVarInfoList || !part7
    || !lineInfoCount || !part8 || !defaultParamList || !part9 || !instructionList || !part10)
  {
    return{};
  }
  const std::optional<std::vector<Function> > childList = readVector(in, *founctionCount, &Function::read);
  const std::optional<unsigned int> stackSize = readRawInteger(in);
  const std::optional<bool> isGenerator = readRawBoolean(in);
  const std::optional<unsigned int> varParamCount = readRawInteger(in);
  if (!childList || !stackSize || !isGenerator || !varParamCount) {
    return{};
  }
  return Function(
    *srcFileName,
    *name,
    *literalList,
    *parameterList,
    *outerValueList,
    *localVarInfoList,
    *lineInfoList,
    *defaultParamList,
    *instructionList,
    *childList,
    *stackSize,
    *isGenerator,
    *varParamCount);
}

std::string Function::infoToString(const unsigned int indentWidth) const {
  std::stringstream result;
  if (!srcFileName.empty()) {
    result << indent(indentWidth) << boost::format("// original filename: %s\n") % srcFileName;
  }
  if (!name.empty()) {
    result << indent(indentWidth) << boost::format("// entry point name: %s\n") % name;
  }
  result << indent(indentWidth) << boost::format("// parameterList:\n");
  for (const std::string &parameter : parameterList) {
    result << indent(indentWidth) << boost::format("//   %s\n") % parameter;
  }
  result << indent(indentWidth) << boost::format("// localVarInfoList:\n");
  for (unsigned int i = localVarInfoList.size(); i > 0; i--) {
    const LocalVarInfo &localVar = localVarInfoList[i - 1];
    result << indent(indentWidth) << boost::format("//   stack[%d] : %s\n") % localVar.pos % localVar.name;
  }
  result << indent(indentWidth) << boost::format("// generator: %s\n") % (isGenerator ? "true" : "false");
  result << indent(indentWidth) << boost::format("// variable param count: %d\n") % varParamCount;
  return result.str();
}

std::string escape(const std::string &str) {
  std::string result = str;
  const std::initializer_list<std::array<std::string, 2> > list = {
    { "\\", "\\\\" },
    { "\"", "\\\"" },
    { "\b", "\\b" },
    { "\f", "\\f" },
    { "\n", "\\n" },
    { "\r", "\\r" },
    { "\t", "\\t" },
  };
  for (const std::array<std::string, 2> &item : list) {
    boost::algorithm::replace_all(result, item[0], item[1]);
  }
  return result;
}

std::string Function::getDisplayLiteralString(const unsigned int index) const {
  return (boost::format("\"%s\"") % escape(literalList[index])).str();
}

std::string Function::instructionToString(unsigned int indentWidth) const {
  std::vector<std::string> codeList;
  std::vector<unsigned int> labelList;
  unsigned int index = -1;
  for (const Instruction &in : instructionList) {
    std::stringstream out;
    index++;
    out << indent(indentWidth);
    switch (in.op) {
    case OP_LINE: /*out << boost::format("// line %d\n") % in.arg1;*/ break; // diff‚ð‚Æ‚é‚Æ‚«‚ÉŽ×–‚‚È‚Ì‚Å“P‹Ž
    case OP_LOAD: out << boost::format("stack[%d] = %s;\n") % static_cast<unsigned int>(in.arg0) % getDisplayLiteralString(in.arg1); break;
    case OP_LOADINT: out << boost::format("stack[%d] = %d;\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_LOADFLOAT: out << boost::format("stack[%d] = %f;\n") % static_cast<unsigned int>(in.arg0) % *reinterpret_cast<const float *>(&in.arg1); break;
    case OP_DLOAD:
      out << boost::format("stack[%d] = %s;\n") % static_cast<unsigned int>(in.arg0) % getDisplayLiteralString(in.arg1);
      out << indent(indentWidth) << boost::format("stack[%d] = %s;\n") % static_cast<unsigned int>(in.arg2) % getDisplayLiteralString(in.arg3);
      break;
    case OP_TAILCALL:
    case OP_CALL: {
      std::vector<std::string> argList;
      for (unsigned int i = 0; i < in.arg3; i++) {
        argList.push_back((boost::format("stack[%d]") % (in.arg2 + i)).str());
      }
      if (in.arg0 != 0xFF) {
        out << boost::format("stack[%d] = ") % static_cast<unsigned int>(in.arg0);
      }
      out << boost::format("stack[%d](%s);\n") % in.arg1 % boost::algorithm::join(argList, ", ");
      break;
    }
    case OP_PREPCALL:
      out << boost::format("stack[%1$d] = stack[%2$d];\n%5$sstack[%3$d] = stack[%1$d][stack[%4$d]];\n")
        % static_cast<unsigned int>(in.arg3)
        % static_cast<unsigned int>(in.arg2)
        % static_cast<unsigned int>(in.arg0)
        % in.arg1
        % indent(indentWidth);
      break;
    case OP_PREPCALLK:
      out << boost::format("stack[%1$d] = stack[%2$d];\n%5$sstack[%3$d] = stack[%1$d][%4$s];\n")
        % static_cast<unsigned int>(in.arg3)
        % static_cast<unsigned int>(in.arg2)
        % static_cast<unsigned int>(in.arg0)
        % getDisplayLiteralString(in.arg1)
        % indent(indentWidth);
      break;
    case OP_GETK: out << boost::format("stack[%d] = stack[%d][%s];\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % getDisplayLiteralString(in.arg1); break;
    case OP_MOVE: out << boost::format("stack[%d] = stack[%d];\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_NEWSLOT:
      out << boost::format("stack[%d].newSlot(stack[%d], stack[%d]);\n") % in.arg1 % static_cast<unsigned int>(in.arg2) % static_cast<unsigned int>(in.arg3);
      if (in.arg0 != 0xFF) {
        out << indent(indentWidth) << boost::format("stack[%d] = stack[%d][stack[%d]];\n") % static_cast<unsigned int>(in.arg0) % in.arg1 % static_cast<unsigned int>(in.arg2);
      }
      break;
    case OP_DELETE: out << boost::format("stack[%d].delete(stack[%d]);\n") % in.arg1 % static_cast<unsigned int>(in.arg2); break;
    case OP_SET:
      out << boost::format("stack[%d][stack[%d]] = stack[%d];\n") % in.arg1 % static_cast<unsigned int>(in.arg2) % static_cast<unsigned int>(in.arg3);
      if (in.arg0 != 0xFF) {
        out << indent(indentWidth) << boost::format("stack[%d] = stack[%d][stack[%d]];\n") % static_cast<unsigned int>(in.arg0) % in.arg1 % static_cast<unsigned int>(in.arg2);
      }
      break;
    case OP_GET: out << boost::format("stack[%d] = stack[%d][stack[%d]];\n") % static_cast<unsigned int>(in.arg0) % in.arg1 % static_cast<unsigned int>(in.arg2); break;
    case OP_EQ:
      out << boost::format("stack[%d] = (stack[%d] == ") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2);
      if (in.arg3 != 0) {
        out << boost::format("%s") % getDisplayLiteralString(in.arg1);
      }
      else {
        out << boost::format("stack[%d]") % in.arg1;
      }
      out << ");\n";
      break;
    case OP_NE:
      out << boost::format("stack[%d] = (stack[%d] != ") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2);
      if (in.arg3 != 0) {
        out << boost::format("%s") % getDisplayLiteralString(in.arg1);
      }
      else {
        out << boost::format("stack[%d]") % in.arg1;
      }
      out << ");\n";
      break;
    case OP_ADD: out << boost::format("stack[%d] = (stack[%d] + stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_SUB: out << boost::format("stack[%d] = (stack[%d] - stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_MUL: out << boost::format("stack[%d] = (stack[%d] * stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_DIV: out << boost::format("stack[%d] = (stack[%d] / stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_MOD: out << boost::format("stack[%d] = (stack[%d] %% stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_BITW: {
      std::string op;
      switch (in.arg3) {
      case 0: op = "&"; break;
      case 2: op = "|"; break;
      case 3: op = "^"; break;
      case 4: op = "<<"; break;
      case 5: op = ">>"; break;
      case 6: op = ">>>"; break;
      default: continue;
      }
      out << boost::format("stack[%d] = (stack[%d] %s stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % op % in.arg1;
      break;
    }
    case OP_RETURN:
      out << "return";
      if (in.arg0 != 0xFF) {
        out << boost::format(" stack[%d]") % in.arg1;
      }
      out << ";\n";
      break;
    case OP_LOADNULLS:
      for (unsigned int i = 0; i < in.arg1; i++) {
        if (i != 0) {
          out << indent(indentWidth);
        }
        out << boost::format("stack[%d] = null;\n") % static_cast<unsigned int>(in.arg0 + i);
      }
      break;
    case OP_LOADROOT: out << boost::format("stack[%d] = getroottable();\n") % static_cast<unsigned int>(in.arg0); break;
    case OP_LOADBOOL: out << boost::format("stack[%d] = %s;\n") % static_cast<unsigned int>(in.arg0) % (in.arg1 == 0 ? "false" : "true"); break;
    case OP_DMOVE:
      out << boost::format("stack[%d] = stack[%d];\n") % static_cast<unsigned int>(in.arg0) % in.arg1;
      out << indent(indentWidth) << boost::format("stack[%d] = stack[%d];\n") % static_cast<unsigned int>(in.arg2) % static_cast<unsigned int>(in.arg3);
      break;
    case OP_JMP: {
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("goto label%d;\n") % labelIndex;
      labelList.push_back(labelIndex);
      break;
    }
    case OP_JCMP: {
      std::string op;
      switch (in.arg3) {
      case 0: op = ">"; break;
      case 2: op = ">="; break;
      case 3: op = "<"; break;
      case 4: op = "<="; break;
      case 5: op = "<=>"; break;
      default:continue;
      }
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("if (!(stack[%d] %s stack[%d])) {\n") % static_cast<unsigned int>(in.arg2) % op % static_cast<unsigned int>(in.arg0);
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % labelIndex;
      out << indent(indentWidth) << "}\n";
      labelList.push_back(labelIndex);
      break;
    }
    case OP_JZ: {
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("if (!stack[%d]) {\n") % static_cast<unsigned int>(in.arg0);
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % labelIndex;
      out << indent(indentWidth) << "}\n";
      labelList.push_back(labelIndex);
      break;
    }
    case OP_GETOUTER: out << boost::format("stack[%d] = getOuter(\"%s\");\n") % static_cast<unsigned int>(in.arg0) % outerValueList[in.arg1].name; break;
    case OP_SETOUTER:
      if (in.arg0 != 0xFF) {
        out << boost::format("stack[%d] = setOuter(\"%s\", stack[%d]);\n")
          % static_cast<unsigned int>(in.arg0)
          % outerValueList[in.arg1].name
          % static_cast<unsigned int>(in.arg2);
      } else {
        out << boost::format("setOuter(\"%s\", stack[%d]);\n")
          % outerValueList[in.arg1].name
          % static_cast<unsigned int>(in.arg2);
      }
      break;
    case OP_NEWOBJ:
      out << boost::format("stack[%d] = ") % static_cast<unsigned int>(in.arg0);
      switch (in.arg3) {
      case 0:
        out << "{}";
        break;
      case 1:
        out << "[]";
        break;
      case 2:
        out << "class";
        if (in.arg1 != 0xFFFFFFFF) {
          out << boost::format(" extends stack[%d]") % in.arg1;
        }
        // attribute
        out << " {}";
      }
      out << ";\n";
      break;
    case OP_APPENDARRAY: {
      std::string value;
      switch (in.arg2) {
      case 0: value = (boost::format("stack[%d]") % in.arg1).str(); break;
      case 1: value = (boost::format("%s") % getDisplayLiteralString(in.arg1)).str(); break;
      case 2: value = (boost::format("%d") % in.arg1).str(); break;
      case 3: value = (boost::format("%f") % *reinterpret_cast<const float *>(&in.arg1)).str(); break;
      case 4: value = (boost::format("%s") % (in.arg1 == 0 ? "false" : "true")).str(); break;
      default: continue;
      }
      out << boost::format("stack[%d].append(%s);\n") % static_cast<unsigned int>(in.arg0) % value;
      break;
    }
    case OP_COMPARITH: {
      std::string op;
      switch (in.arg3) {
      case '+': op = "+"; break;
      case '-': op = "-"; break;
      case '*': op = "*"; break;
      case '/': op = "/"; break;
      case '%': op = "%"; break;
      }
      out << boost::format("stack[%1$d] = (stack[%2$d][stack[%3$d]] = (stack[%2$d][stack[%3$d]] %4$s stack[%5$d]));\n")
        % static_cast<unsigned int>(in.arg0)
        % (in.arg1 >> 16)
        % static_cast<unsigned int>(in.arg2)
        % op
        % (in.arg1 & 0x0000FFFF);
      break;
    }
    case OP_INC: {
      std::string op;
      if (in.arg3 == 1) {
        op = "++";
      } else if (in.arg3 == 255) {
        op = "--";
      } else {
        continue;
      }
      out << boost::format("stack[%d] = (%sstack[%d][stack[%d]]);\n") % static_cast<unsigned int>(in.arg0) % op % in.arg1 % static_cast<unsigned int>(in.arg2);
      break;
    }
    case OP_INCL: {
      std::string op;
      if (in.arg3 == 1) {
        op = "++";
      } else if (in.arg3 == 255) {
        op = "--";
      } else {
        continue;
      }
      out << boost::format("stack[%d] = (%sstack[%d]);\n") % static_cast<unsigned int>(in.arg0) % op % in.arg1;
      break;
    }
    case OP_PINC: {
      std::string op;
      if (in.arg3 == 1) {
        op = "++";
      } else if (in.arg3 == 255) {
        op = "--";
      } else {
        continue;
      }
      out << boost::format("stack[%d] = (stack[%d][stack[%d]]%s);\n") % static_cast<unsigned int>(in.arg0) % in.arg1 % static_cast<unsigned int>(in.arg2) % op;
      break;
    }
    case OP_PINCL: {
      std::string op;
      if (in.arg3 == 1) {
        op = "++";
      } else if (in.arg3 == 255) {
        op = "--";
      } else {
        continue;
      }
      out << boost::format("stack[%d] = (stack[%d]%s);\n") % static_cast<unsigned int>(in.arg0) % in.arg1 % op;
      break;
    }
    case OP_CMP: {
      std::string op;
      switch (in.arg3) {
      case 0: op = ">"; break;
      case 2: op = ">="; break;
      case 3: op = "<"; break;
      case 4: op = "<="; break;
      case 5: op = "<=>"; break;
      default: continue;
      }
      out << boost::format("stack[%d] = (stack[%d] %s stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % op % in.arg1;
      break;
    }
    case OP_EXISTS: out << boost::format("stack[%d] = (stack[%d] in stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_INSTANCEOF: out << boost::format("stack[%d] = (stack[%d] instanceof stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2) % in.arg1; break;
    case OP_AND: {
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("if (!stack[%d]) {\n") % static_cast<unsigned int>(in.arg2);
      out << indent(indentWidth + 1) << boost::format("stack[%d] = stack[%d];\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2);
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % labelIndex;
      out << indent(indentWidth) << "}\n";
      labelList.push_back(labelIndex);
      break;
    }
    case OP_OR: {
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("if (stack[%d]) {\n") % static_cast<unsigned int>(in.arg2);
      out << indent(indentWidth + 1) << boost::format("stack[%d] = stack[%d];\n") % static_cast<unsigned int>(in.arg0) % static_cast<unsigned int>(in.arg2);
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % labelIndex;
      out << indent(indentWidth) << "}\n";
      labelList.push_back(labelIndex);
      break;
    }
    case OP_NEG: out << boost::format("stack[%d] = -stack[%d];\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_NOT: out << boost::format("stack[%d] = !stack[%d];\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_BWNOT: out << boost::format("stack[%d] = ~stack[%d];\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_CLOSURE: {
      const Function &child = childList[in.arg1];
      std::vector<std::string> argList;
      for (unsigned int i = 0; i < child.parameterList.size(); i++) {
        const std::string &param = child.parameterList[i];
        if (argList.size() == 0 && param == "this") {
          continue;
        }
        if (i < child.parameterList.size() - child.defaultParamList.size()) {
          argList.push_back(param);
          continue;
        }
        const unsigned int defaultParamIndex = i - (child.parameterList.size() - child.defaultParamList.size());
        argList.push_back((boost::format("%s = stack[%d]") % param % child.defaultParamList[defaultParamIndex].stackIndex).str());
      }
      const std::string argStr = boost::algorithm::join(argList, ", ");
      out << "// function info\n";
      out << child.infoToString(indentWidth);
      out << indent(indentWidth) << boost::format("stack[%d] = function (%s) {\n") % static_cast<unsigned int>(in.arg0) % argStr;
      out << child.instructionToString(indentWidth + 1);
      out << indent(indentWidth) << "}\n";
      break;
    }
    case OP_YIELD:
      out << boost::format("stackSave(%d);\n") % static_cast<unsigned int>(in.arg2);
      out << indent(indentWidth) << "yield";
      if (in.arg0 != 0xFF) {
        out << boost::format(" stack[%d]") % in.arg1;
      }
      out << ";\n";
      break;
    case OP_RESUME:
      out << boost::format("resume stack[%d];\n") % static_cast<unsigned int>(in.arg0);
      break;
    case OP_FOREACH: {
      const unsigned int errorLabelIndex = index + in.arg1 + 1;
      const unsigned int successLabelIndex = index + 1 + 1;
      out << boost::format("if (stack[%1$d], stack[%2$d], stack[%3$d] = next(stack[%4$d], stack[%3$d])) {\n")
        % static_cast<unsigned int>(in.arg2)
        % static_cast<unsigned int>(in.arg2 + 1)
        % static_cast<unsigned int>(in.arg2 + 2)
        % static_cast<unsigned int>(in.arg0);
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % successLabelIndex;
      out << indent(indentWidth) << "} else {\n";
      out << indent(indentWidth + 1) << boost::format("goto label%d;\n") % errorLabelIndex;
      out << indent(indentWidth) << "}\n";
      labelList.push_back(successLabelIndex);
      labelList.push_back(errorLabelIndex);
      break;
    }
    case OP_POSTFOREACH: out << "// POST_FOREACH\n"; break;
    case OP_CLONE: out << boost::format("stack[%d] = clone(stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_TYPEOF: out << boost::format("stack[%d] = typeof(stack[%d]);\n") % static_cast<unsigned int>(in.arg0) % in.arg1; break;
    case OP_PUSHTRAP: {
      const unsigned int labelIndex = index + in.arg1 + 1;
      out << boost::format("pushStoreExceptionStackIndex(%d);\n") % static_cast<unsigned int>(in.arg0);
      out << indent(indentWidth) << boost::format("pushExceptionCatchLabel(label%s);\n") % labelIndex;
      labelList.push_back(labelIndex);
      break;
    }
    case OP_POPTRAP:
      for (unsigned int i = 0; i < in.arg0; i++) {
        if (i != 0) {
          out << indent(indentWidth);
        }
        out << "popException;\n";
      }
      break;
    case OP_THROW: out << boost::format("throw(stack[%d]);\n") % static_cast<unsigned int>(in.arg0); break;
    case OP_NEWSLOTA: {
      constexpr unsigned int FLAG_ATTRIBUTE = 0x01;
      constexpr unsigned int FLAG_STATIC = 0x02;
      out << boost::format("stack[%d].newSlotA(stack[%d], stack[%d]);\n") % in.arg1 % static_cast<unsigned int>(in.arg2) % static_cast<unsigned int>(in.arg3);
      if ((in.arg0 & FLAG_ATTRIBUTE) != 0) {
        out << indent(indentWidth) << boost::format("stack[%d][stack[%d]].setAttribute(stack[%d]);\n")
          % in.arg1
          % static_cast<unsigned int>(in.arg2)
          % static_cast<unsigned int>(in.arg2 - 1);
      }
      out << indent(indentWidth) << boost::format("stack[%d][stack[%d]].setStatic(%s);\n")
        % in.arg1
        % static_cast<unsigned int>(in.arg2)
        % (((in.arg0 & FLAG_STATIC) != 0) ? "true" : "false");
      break;
    }
    case OP_GETBASE: out << boost::format("stack[%d] = base;\n") % static_cast<unsigned int>(in.arg0); break;
    case OP_CLOSE: out << boost::format("closeOuters(%d);\n") % in.arg1; break;
    default:
      std::wcout << boost::wformat(L"Error: squirrel reverse compile(op = %d).\n") % in.op;
      out << boost::format("// unknown op: %3d %3d %3d %3d %3d\n")
        % static_cast<unsigned int>(in.op)
        % static_cast<unsigned int>(in.arg0)
        % in.arg1
        % static_cast<unsigned int>(in.arg2)
        % static_cast<unsigned int>(in.arg3);
    }
    codeList.push_back(out.str());
  }
  std::sort(labelList.begin(), labelList.end());
  labelList.erase(std::unique(labelList.begin(), labelList.end()), labelList.end());
  std::stringstream result;
  for (unsigned int i = 0; i < codeList.size(); i++) {
    if (std::find(labelList.begin(), labelList.end(), i) != labelList.end()) {
      result << boost::format("label%d:\n") % i;
    }
    result << codeList[i];
  }
  return result.str();
}

std::string Function::toString(const unsigned int indentWidth) const {
  return infoToString(indentWidth) + instructionToString(indentWidth);
}

std::optional<CNut> CNut::read(std::istream &in, const unsigned long long int fileSize) {
#pragma pack(push, 1)
  struct {
    unsigned char binarySignature[2];
    char signature[4];
    unsigned int charSize;
    unsigned int intSize;
    unsigned int floatSize;
  } header;
#pragma pack(pop)
  if (!in.good()) {
    return{};
  }
  in.read(reinterpret_cast<char *>(&header), sizeof(header));
  if (!in.good() || header.binarySignature[0] != 0xFA || header.binarySignature[1] != 0xFA
    || !std::equal(&header.signature[0], &header.signature[_countof(header.signature)], "RIQS")
    || header.charSize != 1 || header.intSize != 4 || header.floatSize != 4)
  {
    return{};
  }
  const std::optional<Function> function = Function::read(in);
  if (!function) {
    return{};
  }
  char tailSignature[4];
  in.read(tailSignature, 4);
  if (!in.good() || !std::equal(&tailSignature[0], &tailSignature[_countof(tailSignature)], "LIAT")) {
    return{};
  }
  return CNut(*function);
}

std::string CNut::toString() const {
  return function.toString();
}

} // Squirrel3

} // TouhouSE

