
class Pattern {
protected:
   std::wstring normalizePath(const std::filesystem::path &path) const {
      std::wstring result = path.wstring();
      std::replace(result.begin(), result.end(), L'\\', L'/');
      return result;
   }
public:
   virtual bool match(const std::wstring &str) const = 0;
   virtual bool match(const std::filesystem::path &path) const {
      return match(normalizePath(path)) || match(path.filename().wstring());
   }
   virtual std::wstring toString() const = 0;
};

class RegexPattern : public Pattern {
private:
   const std::wregex pattern;
   const std::wstring patternStr;

public:
   RegexPattern(const std::wstring &pattern) : pattern(pattern), patternStr(pattern) {
   }
   virtual bool match(const std::wstring &str) const {
      return std::regex_search(str, pattern);
   }
   virtual std::wstring toString() const {
      return (boost::wformat(L"RegexPattern(%s)") % patternStr).str();
   }
};

class PlainPattern : public Pattern {
private:
   const std::wstring pattern;

public:
   PlainPattern(const std::wstring &pattern) : pattern(pattern) {
   }
   virtual bool match(const std::wstring &str) const {
      return str == pattern;
   }
   virtual std::wstring toString() const {
      return (boost::wformat(L"PlainPattern(%s)") % pattern).str();
   }
};

class GlobPattern : public Pattern {
private:
   const std::wstring pattern;

   static bool matchInner(std::wstring::const_iterator patternBegin, std::wstring::const_iterator patternEnd, std::wstring::const_iterator strBegin, std::wstring::const_iterator strEnd) {
      while (patternBegin != patternEnd && strBegin != strEnd) {
         if (*patternBegin == L'*') {
            patternBegin++;
            if (patternBegin == patternEnd) {
               return true;
            }
            for (; strBegin != strEnd; strBegin++) {
               if (matchInner(patternBegin, patternEnd, strBegin, strEnd)) {
                  return true;
               }
            }
            return false;
         }
         if (*patternBegin == L'?') {
            patternBegin++;
            strBegin++;
            continue;
         }
         if (*patternBegin == L'[') {
            patternBegin++;
            const std::wstring::const_iterator it = std::find(patternBegin, patternEnd, L']');
            if (it == patternEnd || std::distance(patternBegin, it) < 1) {
               return false;
            }
            const bool not = (*patternBegin == L'!');
            if (not) {
               patternBegin++;
            }
            if (std::distance(patternBegin, it) < 1) {
               return false;
            }
            if (*(patternBegin + 1) != L'-') { // [abc]
               const std::wstring::const_iterator findIt = std::find(patternBegin, it, *strBegin);
               if ((!not && findIt == it) || (not && findIt != it)) {
                  return false;
               }
            } else { // [a-z]
               if (std::distance(patternBegin, it) != 3) {
                  return false;
               }
               const wchar_t begin = *patternBegin;
               const wchar_t end = *(patternBegin + 2);
               if (begin >= end) {
                  return false;
               }
               if (
                  (!not && (*strBegin < begin || end < *strBegin))
                  || (not && begin <= *strBegin && *strBegin <= end)
               ) {
                  return false;
               }
            }
            patternBegin = it + 1;
            strBegin++;
            continue;
         }
         if (*patternBegin != *strBegin) {
            return false;
         }
         patternBegin++;
         strBegin++;
      }
      return patternBegin == patternEnd && strBegin == strEnd;
   }
public:
   GlobPattern(const std::wstring &pattern) : pattern(pattern) {
   }
   virtual bool match(const std::wstring &str) const {
      return matchInner(pattern.begin(), pattern.end(), str.begin(), str.end());
   }
   virtual std::wstring toString() const {
      return (boost::wformat(L"GlobPattern(%s)") % pattern).str();
   }
};
