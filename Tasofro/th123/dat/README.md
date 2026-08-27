# tf/th123 非想天则 — dat 拆包说明 (t28)

来源: `tf\th123\` 下 3 个档案,由 t28 拆解(自研 Python 解析器,thtk thdat105.c 算法移植)。

## 档案一览

| 档案 | 条目数 | 解出文件数 | 解出大小 | 内容概览 |
|---|---|---|---|---|
| th123a.dat (1,009,499,638 B) | 10625 | 10625 | 1,009,029,234 B | 主资源包:`data/weather/effect/*.cv2` 天气符卡特效(数千)、`data/background/bg*/` 背景、`data/character/` 角色、`.pal` 调色板、`.pat` 图案定义、少量 `.psd` 源图 |
| th123b.dat (52,280,423 B) | 49 | 49 | 52,279,142 B | BGM 包:`data/bgm/*.ogg`(25 首)+ 配套 `*.sfl`(RIFF/SFPL 循环点,24 个) |
| th123c.dat (59,554,674 B) | 989 | 989 | 59,510,387 B | 音效+角色数据包:`data/se/<角色>/NNN.cv3` 语音/音效、`data/character/` 角色 pat/cv2 |

## 格式逆向结论 (th105/th123 族,与绯想天同代)

- 表头: `u16 entry_count` + `u32 header_size`
- 目录表(header_size 字节)双重解密:
  1. MT19937(seed = `6 + header_size`) 逐字节 XOR
  2. 滚动 XOR: k=0xc5, step1=0x83, step2=0x53(每字节 `data ^= k; k += step1; step1 += step2`)
- 条目: `u32 offset` + `u32 size` + `u8 name_len` + `name[CP932]`,无压缩
- 文件数据: 整块 XOR, key = `((offset>>1) | 0x23) & 0xff`
- 全部条目 `data/...` 路径前缀,无需二次解压

## 工具与备选路线

- **brightmoon CLI 自动探测失败**:Marisa 实现只做 MT 层、fallback XOR 参数 (0xc5,0x89,0x49) 与 thtk (0xc5,0x83,0x53) 不同 → 无法识别
- **thdat.exe -x/-l 123 可用**(t27 情报证实后复核):版本表含 123;`-l` 的 `(error is NULL)` 是 stderr 噪音(每条目一行),stdout 列表本身完整;`-x 123` 实测 exit 0
- 正式产物采用**自研 `release\_progress\t28_extract.py`**(纯 Python,含 MT19937 实现),并用 thdat -x 123 全量重拆做了双实现交叉验证(见下)

## 双实现交叉验证(thdat C 实现 vs 自研 Python 移植)

- 三档均用 thdat.exe -x 123 重拆,与自研产物逐文件 SHA256 比对:
  - th123b: 49/49 文件名+内容字节级一致
  - th123c: 989/989 一致
  - th123a: 10543/10625 完全一致;剩余 82 个**内容一致、文件名不同**(见下)
- 结论:解密算法(表双层解密 + 数据 XOR)与 thtk 官方实现完全一致,格式逆向无误

### 82 个文件名差异(CP932 vs 系统 ANSI/GBK 解读)

- 差异集中在 `data/character/<角色>/stand/*.cv2`——9 个单汉字立绘表情文件名(SJIS 双字节)
- 自研产物按 **CP932 语义解码**:嬉(U+5B09) 怒(U+6012) 普(U+666E) 負(U+8CA0) 余(U+4F59) 惑(U+60D1) 決(U+6C7A) 驚(U+9A5A) 等,即游戏内真实文件名
- thdat.exe 是 C 窄字符 API 落盘,在中文系统(ANSI=GBK)下把 SJIS 字节按 GBK 误读,落盘为「娋」「寛」「榝」「梋」等无意义汉字
- **本产物保留 CP932 语义解码**(正确);若需与 thdat 产物文件名逐字一致,需在日文系统(CP932)下重跑 thdat

## 校验

- 条目数 == 落盘文件数(每档各含 1 个 MANIFEST.md)
- 末条 offset+size == 档案大小(表/数据区无空洞)
- BGM: 25/25 ogg 魔数 `OggS` 且文件结构完整;sfl 为合法 RIFF/SFPL
- cv2/cv3/pat 为 tasofro 自有格式,头部结构自洽
- 重名条目: 无(3 档 0 重复)
- 源目录 `tf\th123` 零写入(提取全程只读源、写 release),SHA256 基线复验一致
