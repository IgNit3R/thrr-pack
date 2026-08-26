
#include "stdafx.h"

namespace TouhouSE {

namespace TH135 {

namespace {

enum VarType {
  VT_INT = 0, VT_FLOAT = 1, VT_BOOL = 2, VT_STRING = 3, VT_INT2 = 5, VT_ARRAY = 5
};

constexpr std::array<VarType, 5> getAllVarType() {
  return{ VT_INT, VT_FLOAT, VT_BOOL, VT_STRING, VT_ARRAY };
}

bool containsVarType(const unsigned int type) {
  auto list = getAllVarType();
  return std::find(list.begin(), list.end(), type) != list.end();
}

std::string varTypeToString(const VarType type) {
  switch (type) {
  case VT_INT: return "int";
  case VT_FLOAT: return "float";
  case VT_BOOL: return "bool";
  case VT_STRING: return "string";
  case VT_ARRAY: return "array";
  default: return "unknown";
  }
}

std::optional<unsigned int> readInteger(std::istream &in) {
  unsigned int data;
  in.read(reinterpret_cast<char *>(&data), 4);
  if (!in.good()) {
    return{};
  }
  return data;
}

std::optional<std::string> readString(std::istream &in) {
  const std::optional<unsigned int> length = readInteger(in);
  if (!length) {
    return{};
  }
  std::string result;
  result.resize(*length);
  if (*length != 0) {
    in.read(&result.front(), *length);
    if (!in.good()) {
      return{};
    }
  }
  return result;
}

std::unique_ptr<std::vector<unsigned char> > readBinary(std::istream &in) {
  const std::optional<unsigned int> length = readInteger(in);
  if (!length) {
    return{};
  }
  std::unique_ptr<std::vector<unsigned char> > result = std::make_unique<std::vector<unsigned char> >(*length);
  if (*length != 0) {
    in.read(reinterpret_cast<char *>(&result->front()), *length);
    if (!in.good()) {
      return{};
    }
  }
  return result;
}

std::string indent(const unsigned int width) {
  std::string str;
  for (unsigned int i = 0; i < width; i++) {
    str += "  ";
  }
  return str;
}

std::string createAttachmentFileName(const unsigned int fileIndex) {
  return (boost::format("attachment%03d.cnut") % fileIndex).str();
}

std::string createAttachmentFileNameString(const unsigned int fileIndex) {
  return (boost::format("\"%s\"") % createAttachmentFileName(fileIndex)).str();
}

std::string escape(const std::string &str) {
  std::string result = str;
  const std::initializer_list<std::array<std::string, 2> > list = {
    { "\\", "\\\\" },
    { "/", "\\/" },
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

struct VarInfo {
public:
  std::string name;
  VarType type;

  static std::optional<VarInfo> read(std::istream &in) {
    std::optional<std::string> name = readString(in);
    if (!name) {
      return{};
    }
    const std::optional<unsigned int> type = readInteger(in);
    if (!type || !containsVarType(*type)) {
      return{};
    }
    return VarInfo{ *name, static_cast<VarType>(*type) };
  }
  bool operator ==(const VarInfo &other) const {
    return name == other.name && type == other.type;
  }
};

struct Variable {
public:
  VarInfo info;
  std::variant<int, float, bool, std::string, std::vector<int> > value;

  static std::optional<Variable> read(std::istream &in, const VarInfo &info) {
    switch (info.type) {
    case VT_INT:
    case VT_INT2: {
      int value;
      in.read(reinterpret_cast<char *>(&value), 4);
      if (!in.good()) {
        return{};
      }
      return Variable{ info, value };
    }
    case VT_FLOAT: {
      float value;
      in.read(reinterpret_cast<char *>(&value), 4);
      if (!in.good()) {
        return{};
      }
      return Variable{ info, value };
    }
    case VT_BOOL: {
      unsigned char value;
      in.read(reinterpret_cast<char *>(&value), 1);
      if (!in.good() || (value != 0 && value != 1)) {
        return{};
      }
      return Variable{ info, value != 0 };
    }
    case VT_STRING: {
      std::optional<std::string> name = readString(in);
      if (!in.good() || !name) {
        return{};
      }
      return Variable{ info, *name };
    }
    default:
      return{};
    }
  }

  int getInteger() const {
    return std::get<int>(value);
  }
  float getFloat() const {
    return std::get<float>(value);
  }
  bool getBoolean() const {
    return std::get<bool>(value);
  }
  const std::string &getString() const {
    return std::get<std::string>(value);
  }
  const std::vector<int> &getArray() const {
    return std::get<std::vector<int> >(value);
  }

  std::string valueToString() const {
    switch (info.type) {
    case VT_INT: return (boost::format("%d") % getInteger()).str();
    case VT_FLOAT: return (boost::format("%f") % getFloat()).str();
    case VT_BOOL: return (boost::format("%s") % (getBoolean() ? "true" : "false")).str();
    case VT_STRING: return (boost::format("\"%s\"") % escape(getString())).str();
    case VT_INT2: {
      if (value.index() == 0) {
        return (boost::format("%d") % getInteger()).str();
      }
      const std::vector<int> &src = getArray();
      std::vector<std::string> list(src.size());
      std::transform(src.begin(), src.end(), list.begin(), [](const int v) {return (boost::format("%d") % v).str(); });
      return (boost::format("[%s]") % boost::algorithm::join(list, ", ")).str();
    }
    default: return "unknown";
    }
  }

  bool operator ==(const Variable &other) const {
    return info == other.info && value == other.value;
  }
};

class KeyValueList : public boost::noncopyable {
public:
  unsigned char unknown;
  std::unique_ptr<std::vector<Variable> > list;

  KeyValueList(
    unsigned char unknown,
    std::unique_ptr<std::vector<Variable> > list)
    :
    unknown(unknown), list(std::move(list))
  {}

  static std::unique_ptr<KeyValueList> readWithoutArray(std::istream &in) {
    unsigned char unknown;
    in.read(reinterpret_cast<char *>(&unknown), 1);
    if (!in.good() || unknown != 1) {
      return{};
    }
    const std::optional<unsigned int> varListCount = readInteger(in);
    if (!varListCount) {
      return{};
    }
    std::vector<VarInfo> varInfoList(*varListCount);
    for (VarInfo &info : varInfoList) {
      const std::optional<VarInfo> result = VarInfo::read(in);
      if (!result) {
        return{};
      }
      info = *result;
    }
    std::unique_ptr<std::vector<Variable> > list = std::make_unique<std::vector<Variable> >(*varListCount);
    for (unsigned int i = 0; i < varListCount; i++) {
      const VarInfo &info = varInfoList[i];
      const std::optional<Variable> var = Variable::read(in, info);
      if (!var) {
        return{};
      }
      list->at(i) = *var;
    }
    return std::make_unique<KeyValueList>(unknown, std::move(list));
  }

  static std::unique_ptr<KeyValueList> readWithinArray(std::istream &in) {
    std::unique_ptr<KeyValueList> result = readWithoutArray(in);
    if (!result) {
      return{};
    }
    for (Variable &var : *result->list) {
      if (var.info.type != VT_ARRAY) {
        continue;
      }
      const unsigned int count = std::get<int>(var.value);
      var.value = std::vector<int>(count);
      for (int &value : std::get<std::vector<int> >(var.value)) {
        in.read(reinterpret_cast<char *>(&value), 4);
        if (!in.good()) {
          return{};
        }
      }
    }
    return result;
  }

  std::string toString(const unsigned int indentWidth = 0) const {
    std::stringstream ss;
    bool first = true;
    for (const Variable &var : *list) {
      if (first) {
        first = false;
      } else {
        ss << ",\n";
      }
      ss << indent(indentWidth) << boost::format("\"%s\": %s") % var.info.name % var.valueToString();
    }
    return ss.str();
  }

  std::optional<Variable> find(const std::string &key) const {
    const std::vector<Variable>::const_iterator it = std::find_if(list->begin(), list->end(), [&key](const Variable &var) {return var.info.name == key; });
    if (it == list->end()) {
      return{};
    }
    return *it;
  }

  std::optional<std::string> getString(const std::string &key) const {
    const std::optional<Variable> var = find(key);
    if (!var || var->info.type != VT_STRING) {
      return{};
    }
    return var->getString();
  }
};

class Array2D : public boost::noncopyable {
public:
  const std::vector<std::vector<unsigned char> > data;

  Array2D(std::vector<std::vector<unsigned char> > data) : data(std::move(data)) {
  }

  static std::unique_ptr<Array2D> read(std::istream &in) {
    const std::optional<unsigned int> size1 = readInteger(in);
    const std::optional<unsigned int> size2 = readInteger(in);
    if (!size1 || !size2) {
      return{};
    }
    std::vector<std::vector<unsigned char> > data(*size1);
    for (unsigned int i = 0; i < size1; i++) {
      data[i].resize(*size2);
      if (*size2 != 0) {
        in.read(reinterpret_cast<char *>(&data[i].front()), *size2);
        if (!in.good()) {
          return{};
        }
      }
    }
    return std::make_unique<Array2D>(std::move(data));
  }
  std::string toString(const unsigned int indentWidth = 0) const {
    std::vector<std::string> strList(data.size());
    for (unsigned int i = 0; i < data.size(); i++) {
      const std::vector<unsigned char> &src = data[i];
      std::vector<std::string> out(data[0].size());
      std::transform(src.begin(), src.end(), out.begin(), [](const unsigned char c) {return (boost::format("%d") % static_cast<unsigned int>(c)).str(); });
      strList[i] = (boost::format("[%s]") % boost::algorithm::join(out, ", ")).str();
    }
    std::stringstream ss;
    ss << "[\n";
    ss << indent(indentWidth + 1) << boost::algorithm::join(strList, (boost::format(",\n%s") % indent(indentWidth + 1)).str()) << std::endl;
    ss << indent(indentWidth) << "]";
    return ss.str();
  }
};

class Type0;
class Type1;
class Type2;
class Type3;
class Type4;
class Type5;
class Type6;
class Type7;

typedef std::variant<
  std::unique_ptr<const Type0>,
  std::unique_ptr<const Type1>,
  std::unique_ptr<const Type2>,
  std::unique_ptr<const Type3>,
  std::unique_ptr<const Type4>,
  std::unique_ptr<const Type5>,
  std::unique_ptr<const Type6>,
  std::unique_ptr<const Type7>
> AnyType;

bool isEmpty(const AnyType &type) {
  switch (type.index()) {
  case 0: return !std::get<std::unique_ptr<const Type0> >(type);
  case 1: return !std::get<std::unique_ptr<const Type1> >(type);
  case 2: return !std::get<std::unique_ptr<const Type2> >(type);
  case 3: return !std::get<std::unique_ptr<const Type3> >(type);
  case 4: return !std::get<std::unique_ptr<const Type4> >(type);
  case 5: return !std::get<std::unique_ptr<const Type5> >(type);
  case 6: return !std::get<std::unique_ptr<const Type6> >(type);
  case 7: return !std::get<std::unique_ptr<const Type7> >(type);
  default: return false;
  }
}

class TypeBase {
public:
  virtual std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const = 0;
  virtual unsigned int getAttachmentCount() const = 0;
  virtual const KeyValueList &getHeader() const = 0;
  virtual const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const = 0;
};

class Type0 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv1;
  const std::unique_ptr<const KeyValueList> kv2;
  const std::unique_ptr<const std::vector<unsigned char> > binary;
  const std::unique_ptr<std::vector<AnyType> > child1;
  const std::unique_ptr<std::vector<AnyType> > child2;

  Type0(
    std::unique_ptr<const KeyValueList> kv1,
    std::unique_ptr<const KeyValueList> kv2,
    std::unique_ptr<const std::vector<unsigned char> > binary,
    std::unique_ptr<std::vector<AnyType> > child1,
    std::unique_ptr<std::vector<AnyType> > child2)
    :
    kv1(std::move(kv1)), kv2(std::move(kv2)), binary(std::move(binary)), child1(std::move(child1)), child2(std::move(child2))
  {}

  static std::unique_ptr<Type0> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  bool existFile() const {
    return !binary->empty();
  }
  const KeyValueList &getHeader() const {
    return *kv1;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type1 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv1;
  const std::unique_ptr<const KeyValueList> kv2;
  const std::unique_ptr<const std::vector<unsigned char> > binary;

  Type1(
    std::unique_ptr<const KeyValueList> kv1,
    std::unique_ptr<const KeyValueList> kv2,
    std::unique_ptr<const std::vector<unsigned char> > binary)
    :
    kv1(std::move(kv1)), kv2(std::move(kv2)), binary(std::move(binary))
  {}

  static std::unique_ptr<Type1> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  bool existFile() const {
    return !binary->empty();
  }
  const KeyValueList &getHeader() const {
    return *kv1;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type2 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv1;
  const std::unique_ptr<std::vector<AnyType> > child1;
  const std::unique_ptr<std::vector<AnyType> > child2;
  const std::unique_ptr<const KeyValueList> kv2;
  const std::unique_ptr<const std::vector<unsigned char> > binary;

  Type2(
    std::unique_ptr<const KeyValueList> kv1,
    std::unique_ptr<std::vector<AnyType> > child1,
    std::unique_ptr<std::vector<AnyType> > child2,
    std::unique_ptr<const KeyValueList> kv2,
    std::unique_ptr<const std::vector<unsigned char> > binary)
    :
    kv1(std::move(kv1)), child1(std::move(child1)), child2(std::move(child2)), kv2(std::move(kv2)), binary(std::move(binary))
  {}

  static std::unique_ptr<Type2> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  bool existFile() const {
    return !binary->empty();
  }
  const KeyValueList &getHeader() const {
    return *kv1;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type3 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv;
  const std::unique_ptr<std::vector<AnyType> > child;

  Type3(std::unique_ptr<const KeyValueList> kv, std::unique_ptr<std::vector<AnyType> > child) : kv(std::move(kv)), child(std::move(child)) {
  }

  static std::unique_ptr<Type3> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  const KeyValueList &getHeader() const {
    return *kv;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type4 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv1;
  const std::unique_ptr<const KeyValueList> kv2;
  const std::unique_ptr<const Array2D> ary;

  Type4(
    std::unique_ptr<const KeyValueList> kv1,
    std::unique_ptr<const KeyValueList> kv2,
    std::unique_ptr<const Array2D> ary)
    :
    kv1(std::move(kv1)), kv2(std::move(kv2)), ary(std::move(ary))
  {}

  static std::unique_ptr<Type4> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  const KeyValueList &getHeader() const {
    return *kv1;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type5 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv;

  Type5(std::unique_ptr<const KeyValueList> kv) : kv(std::move(kv)) {
  }

  static std::unique_ptr<Type5> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  const KeyValueList &getHeader() const {
    return *kv;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type6 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv;

  Type6(std::unique_ptr<const KeyValueList> kv) : kv(std::move(kv)) {
  }

  static std::unique_ptr<Type6> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  const KeyValueList &getHeader() const {
    return *kv;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

class Type7 : public TypeBase, public boost::noncopyable {
public:
  const std::unique_ptr<const KeyValueList> kv;
  const std::unique_ptr<const Array2D> ary;

  Type7(
    std::unique_ptr<const KeyValueList> kv,
    std::unique_ptr<const Array2D> ary)
    :
    kv(std::move(kv)), ary(std::move(ary))
  {}

  static std::unique_ptr<Type7> read(std::istream &in);
  std::string toString(const unsigned int indentWidth, unsigned int &fileIndex) const;
  unsigned int getAttachmentCount() const;
  const KeyValueList &getHeader() const {
    return *kv;
  }
  const std::vector<unsigned char> *getAttachment(unsigned int &fileIndex) const;
};

const TypeBase &getTypeBase(const AnyType &type) {
  switch (type.index()) {
  case 0: return *std::get<std::unique_ptr<const Type0> >(type);
  case 1: return *std::get<std::unique_ptr<const Type1> >(type);
  case 2: return *std::get<std::unique_ptr<const Type2> >(type);
  case 3: return *std::get<std::unique_ptr<const Type3> >(type);
  case 4: return *std::get<std::unique_ptr<const Type4> >(type);
  case 5: return *std::get<std::unique_ptr<const Type5> >(type);
  case 6: return *std::get<std::unique_ptr<const Type6> >(type);
  case 7: return *std::get<std::unique_ptr<const Type7> >(type);
  default: throw;
  }
}

enum TypeSignature {
  TS_TYPE0, TS_TYPE1, TS_TYPE2, TS_TYPE3, TS_TYPE4, TS_TYPE5, TS_TYPE6, TS_TYPE7
};

std::map<unsigned int, TypeSignature> getTypeSignatureMap() {
  return{
    // 心綺楼
    { 0x00000000, TS_TYPE0 },
    { 0xDEADBEEF, TS_TYPE1 },
    { 0x79890BB2, TS_TYPE2 },
    { 0x16CD8498, TS_TYPE3 },
    { 0x9EDD843A, TS_TYPE4 },
    { 0xA597329B, TS_TYPE5 },
    { 0xBCD50C74, TS_TYPE6 },
    { 0xBBB44DB9, TS_TYPE6 },
    { 0xECD7EF7B, TS_TYPE6 },
    { 0x44C0E960, TS_TYPE6 },
    { 0x8CB4D3C0, TS_TYPE6 },
    // 収集荷取
    { 0xF4E12505, TS_TYPE6 },
    { 0x82A4162F, TS_TYPE7 },
  };
}

bool containsTypeSignature(const unsigned int type) {
  const std::map<unsigned int, TypeSignature> &map = getTypeSignatureMap();
  return map.find(type) != map.end();
}

AnyType readAnyType(std::istream &in) {
  const std::optional<unsigned int> type = readInteger(in);
  if (!type || !containsTypeSignature(*type)) {
    return{};
  }
  switch (getTypeSignatureMap().at(*type)) {
  case TS_TYPE0: return Type0::read(in);
  case TS_TYPE1: return Type1::read(in);
  case TS_TYPE2: return Type2::read(in);
  case TS_TYPE3: return Type3::read(in);
  case TS_TYPE4: return Type4::read(in);
  case TS_TYPE5: return Type5::read(in);
  case TS_TYPE6: return Type6::read(in);
  case TS_TYPE7: return Type7::read(in);
  default: return{};
  }
}

std::unique_ptr<std::vector<AnyType> > readAnyTypeArray(std::istream &in, const unsigned int count) {
  std::unique_ptr<std::vector<AnyType> > result = std::make_unique<std::vector<AnyType> >(count);
  for (AnyType &type : *result) {
    AnyType item = readAnyType(in);
    if (isEmpty(item)) {
      return{};
    }
    type = std::move(item);
  }
  return result;
}

std::unique_ptr<std::vector<AnyType> > readAnyTypeArray(std::istream &in) {
  const std::optional<unsigned int> count = readInteger(in);
  if (!count) {
    return{};
  }
  return readAnyTypeArray(in, *count);
}

std::unique_ptr<std::vector<AnyType> > readAnyTypeArray2(std::istream &in) {
  unsigned char count;
  in.read(reinterpret_cast<char *>(&count), 1);
  if (!in.good()) {
    return{};
  }
  return readAnyTypeArray(in, count);
}

std::unique_ptr<Type0> Type0::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv1 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const KeyValueList> kv2 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const std::vector<unsigned char> > binary = readBinary(in);
  std::unique_ptr<std::vector<AnyType> > child1 = readAnyTypeArray(in);
  std::unique_ptr<std::vector<AnyType> > child2 = readAnyTypeArray(in);
  if (!in.good() || !kv1 || !kv2 || !binary || !child1 || !child2) {
    return{};
  }
  return std::make_unique<Type0>(std::move(kv1), std::move(kv2), std::move(binary), std::move(child1), std::move(child2));
}

std::unique_ptr<Type1> Type1::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv1 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const KeyValueList> kv2 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const std::vector<unsigned char> > binary = readBinary(in);
  if (!in.good() || !kv1 || !kv2 || !binary) {
    return{};
  }
  return std::make_unique<Type1>(std::move(kv1), std::move(kv2), std::move(binary));
}

std::unique_ptr<Type2> Type2::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv1 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<std::vector<AnyType> > child1 = readAnyTypeArray(in);
  std::unique_ptr<std::vector<AnyType> > child2 = readAnyTypeArray(in);
  std::unique_ptr<const KeyValueList> kv2 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const std::vector<unsigned char> > binary = readBinary(in);
  if (!in.good() || !kv1 || !child1 || !child2 || !kv2 || !binary) {
    return{};
  }
  return std::make_unique<Type2>(std::move(kv1), std::move(child1), std::move(child2), std::move(kv2), std::move(binary));
}

std::unique_ptr<Type3> Type3::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv = KeyValueList::readWithoutArray(in);
  std::unique_ptr<std::vector<AnyType> > child = readAnyTypeArray2(in);
  if (!in.good() || !kv || !child) {
    return{};
  }
  return std::make_unique<Type3>(std::move(kv), std::move(child));
}

std::unique_ptr<Type4> Type4::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv1 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const KeyValueList> kv2 = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const Array2D> ary = Array2D::read(in);
  if (!in.good() || !kv1 || !kv2 || !ary) {
    return{};
  }
  return std::make_unique<Type4>(std::move(kv1), std::move(kv2), std::move(ary));
}

std::unique_ptr<Type5> Type5::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv = KeyValueList::readWithinArray(in);
  if (!in.good() || !kv) {
    return{};
  }
  return std::make_unique<Type5>(std::move(kv));
}

std::unique_ptr<Type6> Type6::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv = KeyValueList::readWithoutArray(in);
  if (!in.good() || !kv) {
    return{};
  }
  return std::make_unique<Type6>(std::move(kv));
}

std::unique_ptr<Type7> Type7::read(std::istream &in) {
  std::unique_ptr<const KeyValueList> kv = KeyValueList::readWithoutArray(in);
  std::unique_ptr<const Array2D> ary = Array2D::read(in);
  if (!in.good() || !kv || !ary) {
    return{};
  }
  return std::make_unique<Type7>(std::move(kv), std::move(ary));
}

std::string anyTypeToString(const AnyType &type, const unsigned int indentWidth, unsigned int &fileIndex) {
  return getTypeBase(type).toString(indentWidth, fileIndex);
}

std::string anyTypeArrayToString(const std::unique_ptr<std::vector<AnyType> > &ary, const unsigned int indentWidth, unsigned int &fileIndex) {
  std::stringstream ss;
  for (const AnyType &item : *ary) {
    ss << anyTypeToString(item, indentWidth, fileIndex);
    if (&item != &ary->back()) {
      ss << ",\n";
    }
  }
  return ss.str();
}

std::string Type0::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv1->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "}, {\n";
  ss << kv2->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "},\n";
  ss << indent(indentWidth + 1) << boost::format("@attachment(%s),\n") % (existFile() ? createAttachmentFileNameString(fileIndex) : "null");
  if (existFile()) {
    fileIndex++;
  };
  ss << indent(indentWidth + 1) << "[\n";
  ss << anyTypeArrayToString(child1, indentWidth + 2, fileIndex) << std::endl;
  ss << indent(indentWidth + 1) << "], [\n";
  ss << anyTypeArrayToString(child2, indentWidth + 2, fileIndex) << std::endl;
  ss << indent(indentWidth + 1) << "]\n";
  ss << indent(indentWidth) << "]";
  return ss.str();
}

std::string Type1::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv1->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "}, {\n";
  ss << kv2->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "},\n";
  ss << indent(indentWidth + 1) << boost::format("@attachment(%s)\n") % (existFile() ? createAttachmentFileNameString(fileIndex) : "null");
  ss << indent(indentWidth) << "]";
  if (existFile()) {
    fileIndex++;
  }
  return ss.str();
}

std::string Type2::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv1->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "}, [\n";
  ss << anyTypeArrayToString(child1, indentWidth + 2, fileIndex) << std::endl;
  ss << indent(indentWidth + 1) << "], [\n";
  ss << anyTypeArrayToString(child2, indentWidth + 2, fileIndex) << std::endl;
  ss << indent(indentWidth + 1) << "], {\n";
  ss << kv2->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "},\n";
  ss << indent(indentWidth + 1) << boost::format("@attachment(%s)\n") % (existFile() ? createAttachmentFileNameString(fileIndex) : "null");
  ss << indent(indentWidth) << "]";
  if (existFile()) {
    fileIndex++;
  }
  return ss.str();
}

std::string Type3::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "}, [\n";
  ss << anyTypeArrayToString(child, indentWidth + 2, fileIndex) << std::endl;
  ss << indent(indentWidth + 1) << "]\n";
  ss << indent(indentWidth) << "]";
  return ss.str();
}

std::string Type4::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv1->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "}, {\n";
  ss << kv2->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "},\n";
  ss << indent(indentWidth + 1) << ary->toString(indentWidth + 1) << std::endl;
  ss << indent(indentWidth) << "]";
  return ss.str();
}

std::string Type5::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "{\n";
  ss << kv->toString(indentWidth + 1) << std::endl;
  ss << indent(indentWidth) << "}";
  return ss.str();
}

std::string Type6::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "{\n";
  ss << kv->toString(indentWidth + 1) << std::endl;
  ss << indent(indentWidth) << "}";
  return ss.str();
}

std::string Type7::toString(const unsigned int indentWidth, unsigned int &fileIndex) const {
  std::stringstream ss;
  ss << indent(indentWidth) << "[\n";
  ss << indent(indentWidth + 1) << "{\n";
  ss << kv->toString(indentWidth + 2) << std::endl;
  ss << indent(indentWidth + 1) << "},\n";
  ss << indent(indentWidth + 1) << ary->toString(indentWidth + 1) << std::endl;
  ss << indent(indentWidth) << "]";
  return ss.str();
}

unsigned int getAnyTypeAttachmentCount(const AnyType &type) {
  return getTypeBase(type).getAttachmentCount();
}
unsigned int getAnyTypeArrayAttachmentCount(const std::vector<AnyType> &list) {
  unsigned int result = 0;
  for (const AnyType &type : list) {
    result += getAnyTypeAttachmentCount(type);
  }
  return result;
}

unsigned int Type0::getAttachmentCount() const {
  return (existFile() ? 1 : 0) + getAnyTypeArrayAttachmentCount(*child1) + getAnyTypeArrayAttachmentCount(*child2);
}

unsigned int Type1::getAttachmentCount() const {
  return existFile() ? 1 : 0;
}

unsigned int Type2::getAttachmentCount() const {
  return (existFile() ? 1 : 0) + getAnyTypeArrayAttachmentCount(*child1) + getAnyTypeArrayAttachmentCount(*child2);
}

unsigned int Type3::getAttachmentCount() const {
  return getAnyTypeArrayAttachmentCount(*child);
}

unsigned int Type4::getAttachmentCount() const {
  return 0;
}

unsigned int Type5::getAttachmentCount() const {
  return 0;
}

unsigned int Type6::getAttachmentCount() const {
  return 0;
}

unsigned int Type7::getAttachmentCount() const {
  return 0;
}

const std::vector<unsigned char> *getAnyTypeArrayAttachment(const std::vector<AnyType> &list, unsigned int &fileIndex) {
  for (const AnyType &type : list) {
    const std::vector<unsigned char> * const result = getTypeBase(type).getAttachment(fileIndex);
    if (result != nullptr) {
      return result;
    }
  }
  return{};
}

const std::vector<unsigned char> *Type0::getAttachment(unsigned int &fileIndex) const {
  if (existFile()) {
    if (fileIndex == 0) {
      return &*binary;
    }
    fileIndex--;
  }
  const std::vector<unsigned char> * const attachment1 = getAnyTypeArrayAttachment(*child1, fileIndex);
  if (attachment1) {
    return attachment1;
  }
  return getAnyTypeArrayAttachment(*child2, fileIndex);
}

const std::vector<unsigned char> *Type1::getAttachment(unsigned int &fileIndex) const {
  if (existFile()) {
    if (fileIndex == 0) {
      return &*binary;
    }
    fileIndex--;
  }
  return{};
}

const std::vector<unsigned char> *Type2::getAttachment(unsigned int &fileIndex) const {
  const std::vector<unsigned char> * const attachment1 = getAnyTypeArrayAttachment(*child1, fileIndex);
  if (attachment1) {
    return attachment1;
  }
  const std::vector<unsigned char> * const attachment2 = getAnyTypeArrayAttachment(*child2, fileIndex);
  if (attachment2) {
    return attachment2;
  }
  if (existFile()) {
    if (fileIndex == 0) {
      return &*binary;
    }
    fileIndex--;
  }
  return{};
}

const std::vector<unsigned char> *Type3::getAttachment(unsigned int &fileIndex) const {
  return getAnyTypeArrayAttachment(*child, fileIndex);
}

const std::vector<unsigned char> *Type4::getAttachment(unsigned int &fileIndex) const {
  return{};
}

const std::vector<unsigned char> *Type5::getAttachment(unsigned int &fileIndex) const {
  return{};
}

const std::vector<unsigned char> *Type6::getAttachment(unsigned int &fileIndex) const {
  return{};
}

const std::vector<unsigned char> *Type7::getAttachment(unsigned int &fileIndex) const {
  return{};
}

class Act : public boost::noncopyable {
private:
  const std::unique_ptr<std::vector<AnyType> > body;

public:
  Act(std::unique_ptr<std::vector<AnyType> > body) : body(std::move(body)) {
  }

  static std::unique_ptr<Act> read(std::istream &in, const unsigned long long int fileSize) {
    unsigned char signature[4];
    in.read(reinterpret_cast<char *>(signature), _countof(signature));
    if (!in.good() || !std::equal(&signature[0], &signature[_countof(signature)], "ACT1")) {
      return{};
    }
    std::unique_ptr<std::vector<AnyType> > body = readAnyTypeArray(in);
    if (!in.good() || !body) {
      return{};
    }
    return std::make_unique<Act>(std::move(body));
  }

  std::string toString(const unsigned int indentWidth, unsigned int fileIndex) const {
    return anyTypeArrayToString(body, indentWidth, fileIndex);
  }

  std::string getName() const {
    if (body->empty()) {
      return{};
    }
    const std::optional<std::string> name = getTypeBase(body->at(0)).getHeader().getString("stName");
    if (!name) {
      return{};
    }
    return *name;
  }

  unsigned int getAttachmentCount() const {
    return getAnyTypeArrayAttachmentCount(*body);
  }

  const std::vector<unsigned char> *getAttachment(unsigned int fileIndex) const {
    return getAnyTypeArrayAttachment(*body, fileIndex);
  }
};

} // anonymous

class ActOwner : public ExtractorBase {
private:
  const std::unique_ptr<Act> act;
  const std::filesystem::path dir;

public:
  ActOwner(std::unique_ptr<Act> act) : act(std::move(act)), dir(this->act->getName()) {
  }

  static std::shared_ptr<ActOwner> Open(std::istream &in, const unsigned long long int fileSize) {
    std::unique_ptr<Act> act = Act::read(in, fileSize);
    if (!act) {
      return{};
    }
    const std::filesystem::path path = act->getName();
    return std::make_shared<ActOwner>(std::move(act));
  }

  bool Extract(const unsigned int index, std::vector<unsigned char> &result) {
    if (index > 0) {
      const std::vector<unsigned char> &data = *act->getAttachment(index - 1);
      result.resize(data.size());
      std::copy(data.begin(), data.end(), result.begin());
      return true;
    }
    const std::string str = boost::algorithm::replace_all_copy(act->toString(0, 1), "\n", "\r\n");
    result.clear();
    result.assign(str.begin(), str.end());
    return true;
  }

  unsigned int GetSize() const {
    return act->getAttachmentCount() + 1;
  }

  std::filesystem::path GetFileName(unsigned int index) const {
    return dir / (index == 0 ? "info.txt" : createAttachmentFileName(index));
  }

  std::wstring GetName() const {
    return L"心綺楼独自フォーマットAct1";
  }
};

ADD_DAT_EXTRACTOR(ActOwner);

} // TH135

} // TouhouSE
