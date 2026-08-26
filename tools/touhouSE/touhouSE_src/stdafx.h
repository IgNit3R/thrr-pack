
//外部ライブラリーの警告は無効化しておく
#pragma warning(push)
#pragma warning(disable: 4061) // case定義されていない列挙子があります
#pragma warning(disable: 4100) // 宣言された引数を使用していません
#pragma warning(disable: 4127) // 条件式が定数です
#pragma warning(disable: 4180) // 関数ポインターに対して無効な装飾子を使用しています
#pragma warning(disable: 4189) // 変数に代入後参照されていません
#pragma warning(disable: 4201) // 非標準の拡張機能、無名の構造体/共用体を使用しています
#pragma warning(disable: 4263) // 仮想関数をオーバーライドしていますが、引数の型が違います
#pragma warning(disable: 4264) // 引数の型のみ違う同名関数が定義されたため、仮想関数にはアクセスできなくなります
#pragma warning(disable: 4266) // 仮想関数のすべてのオーバーロードをオーバーライドしていません
#pragma warning(disable: 4350) // constなしの参照渡しはリテラルを受け取ることができないため、別のコンストラクタが呼ばれます
#pragma warning(disable: 4365) // signed/unsignedが違う型変換が行われました
#pragma warning(disable: 4512) // 代入演算子を生成するために必要なコンストラクタがアクセスできません、代入演算子を作れませんでした
#pragma warning(disable: 4548) // 無効なカンマ式
#pragma warning(disable: 4555) // 副作用のない式
#pragma warning(disable: 4619) // 無効化を試みた警告番号は存在しません
#pragma warning(disable: 4625) // 基本クラスのコピーコンストラクタがアクセス不能なのでコピーコンストラクタが作れませんでした
#pragma warning(disable: 4626) // 基本クラスの代入演算子がアクセス不能なので代入演算子が作れませんでした
#pragma warning(disable: 4640) // staticなローカル変数の初期化がスレッドセーフではありません
#pragma warning(disable: 4668) // 定義されていないシンボルが#if/#elifで使用されました
#pragma warning(disable: 4738) // 浮動小数点の計算結果を32bitに格納しているためパフォーマンスが低下しています
#pragma warning(disable: 4820) // 構造体のパッティングが発生しました

// RELEASEビルド時のみ発生する警告の無効化
#ifndef _DEBUG
#pragma warning(disable: 4710) // inline宣言されている関数/メソッドをinline展開しませんでした
#pragma warning(disable: 4711) // inline宣言されていない関数/メソッドをinline展開しました
#endif

// ポインターイテレーターを使用するなどの警告を抑制
#define _SCL_SECURE_NO_WARNINGS 1

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>
#include <limits.h>
#include <locale.h>
#include <ctype.h>

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <numeric>
#include <array>
#include <string>
#include <memory>
#include <utility>
#include <map>
#include <sstream>
#include <regex>
#include <filesystem>
#include <functional>
#include <variant>
#include <optional>

#include <boost/config/warning_disable.hpp>
#include <boost/utility.hpp>
#include <boost/static_assert.hpp>
#include <boost/assert.hpp>
#include <boost/assign.hpp>
#include <boost/iostreams/stream.hpp>
#include <boost/spirit/home/support/detail/endian.hpp>
#include <boost/format.hpp>
#include <boost/utility/enable_if.hpp>
#include <boost/concept_check.hpp>
#include <boost/algorithm/string.hpp>
#include <boost/interprocess/streams/vectorstream.hpp>
#include <boost/range/irange.hpp>
#include <boost/range/iterator_range.hpp>
#include <boost/range/adaptor/reversed.hpp>
#include <boost/range/algorithm.hpp>

#include <png.h>
#include <zlib.h>

//wchar_tを既定の文字列として使用しない
//#define UNICODE

#include <ntstatus.h>
//NTSTATUSの定義が重複するため
#define WIN32_NO_STATUS
//std::minやstd::maxと定義が重複するため
#define NOMINMAX
#include <windows.h>
#include <Shlwapi.h>
#pragma comment(lib, "Shlwapi.lib")
#include <bcrypt.h>
#pragma comment (lib, "bcrypt.lib")

#ifndef NT_SUCCESS
#define NT_SUCCESS(status)  ((status) >= 0)
#endif

#pragma warning(pop)
//外部ライブラリーの警告無効ここまで

#pragma warning(disable: 4061) // case定義されていない列挙子があります
#pragma warning(disable: 4127) // 条件式が定数です
#pragma warning(disable: 4350) // constなしの参照渡しはリテラルを受け取ることができないため、別のコンストラクタが呼ばれます
#pragma warning(disable: 4373) // const/volatileの違いに限られるパラメーター違いメソッドをオーバーライドしています
#pragma warning(disable: 4458) // クラスメンバーが隠蔽されます
#pragma warning(disable: 4503) // 装飾名が4096文字を超えたため切り捨てられます
#pragma warning(disable: 4514) // 使用されていない関数/メソッドが削除されました
#pragma warning(disable: 4640) // staticなローカル変数の初期化がスレッドセーフではありません
#pragma warning(disable: 4710) // インライン関数として選択されましたがインライン展開できませんでした

// RELEASEビルド時のみ発生する警告の無効化
#ifndef _DEBUG
#pragma warning(disable: 4100) // 宣言された引数を使用していません
#pragma warning(disable: 4189) // 変数に代入後参照されていません
#pragma warning(disable: 4710) // inline宣言されている関数/メソッドをinline展開しませんでした
#pragma warning(disable: 4711) // inline宣言されていない関数/メソッドをinline展開しました
#endif

#define PRINT_MSG_ERROR 0

using namespace std::placeholders;

#include "mt.h"
#include "utility.h"
#include "numeric_limits.h"
#include "png.h"
#include "container_sink.h"
#include "pattern.h"
#include "main.h"
#include "dat_utility.h"
#include "msg.h"
#include "th075.h"
#include "th105.h"
#include "th11.h"
#include "th11_utility.h"
#include "th12.h"
#include "th125_utility.h"
#include "th13.h"
#include "thmj.h"
#include "tnb.h"
#include "npa.h"
#include "image_base.h"
#include "image_convertor_base.h"
#include "th_base.h"
#include "nfa0_v21.h"
#include "th135_utility.h"
#include "../cnut_converter/cnut.h"
#include "th135.h"
#include "th145pak.h"
#include "th145_file_list.h"
#include "th155_file_list.h"
#include "DxArchive.h"
