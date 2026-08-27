# 东方 Project thbgm.dat BGM 格式总报告(_bgm_report.md)

- 任务:t46 | 执行:extractor-a2 | 日期:2026-08-24
- 汇总源:`release\_progress\W3a-early.md`(t44,早期组 th07→th10)、`release\_progress\W3a-late.md`(t45,后期组 th11→th20)
- 适用对象:tsa 正作 th07→th20(21 作中 20 作;th06/kouma 为例外,见 §4)
- **本报告是 W3 全部 BGM 拆包任务(t47–t67)的规范依据,所有解析器/脚本必须按本报告实现。**

---

## 1. 存放情况:thbgm.dat 内部结构

### 1.1 总体结论(一句话)

**thbgm.dat 内无目录表,只有「16 字节 ZWAV 文件头 + 裸 PCM 数据顺排到 EOF」;权威目录表是各作 dat 包内拆出的 thbgm.fmt(N × 52 字节定长条目 + 17 字节全零尾)。**

### 1.2 ZWAV 文件头(20 作全系列统一)

```
偏移    大小    内容
0x00    4      魔数 "ZWAV"(5A 57 41 56)
0x04    4      version u32 = 0x00000001
0x08    1      zwavid_08(游戏识别字节 A)
0x09    1      zwavid_09(游戏识别字节 B)
0x0A    6      恒 0
```

hex 实测示例(首 16 字节):

| 游戏 | hex(0x00–0x0F) | zwavid_08(0x08) | zwavid_09(0x09) |
|---|---|---|---|
| th07 | `5A 57 41 56 01 00 00 00 00 07 00 00 00 00 00 00` | 0x00 | 0x07 |
| th10 | `5A 57 41 56 01 00 00 00 00 10 00 00 00 00 00 00` | 0x00 | 0x10 |
| th095 | `5A 57 41 56 01 00 00 00 50 09 00 00 00 00 00 00` | 0x50 | 0x09 |
| th13 | `5A 57 41 56 01 00 00 00 00 13 00 00 00 00 00 00` | 0x00 | 0x13 |
| th128 | `5A 57 41 56 01 00 00 00 80 12 00 00 00 00 00 00` | 0x80 | 0x12 |
| th20 | `5A 57 41 56 01 00 00 00 00 20 00 00 00 00 00 00` | 0x00 | 0x20 |

> ⚠️ 注意偏移:早期笔记(t44)曾误记为 0x06/0x07,经后期组 15 作实测修正为 **0x08/0x09**,与各作 `bgminfo\thXX.bgm` 的 `zwavid_08/zwavid_09` 配置 20/20 全符。解析时以 0x08/0x09 为准。

### 1.3 thbgm.fmt —— 权威目录表

来源:各作 dat 包内拆出(release 下已有全部 20 作;早期 5 作 329–1109B,后期 15 作见 §3.2)。

#### 1.3.1 总体结构

```
文件 = N × 52字节条目 + 17字节全零尾部
校验:(size − 17) % 52 == 0    ← 20/20 作成立
尾部 17 字节逐字节验证全零(nonzero 计数 = 0,20/20 作)
```

#### 1.3.2 条目布局(52 字节)

```
+0x00  char[16]  文件名(ASCII,NUL 填充,如 "th07_01.wav";b 变体 "th13_01b.wav";复用轨保留原名)
+0x10  u32       start   —— 绝对文件偏移(首轨=0x10=16,紧跟 16B ZWAV 头;无需再加 0x10)
+0x14  u32       x       —— 遗留字段,th13+ 恒 == len;th11–th128 为 len+Δ(语义未明);切片无需
+0x18  u32       loop    —— 循环起点,相对本轨 start(intro 段字节长度)
+0x1C  u32       len     —— 本轨总长(字节,含 intro)
+0x20  WAVEFORMATEX(18B):wFormatTag=1(PCM) nChannels=2 nSamplesPerSec=44100
                        nAvgBytesPerSec=176400 nBlockAlign=4 wBitsPerSample=16
+0x32  u16 + 2B  补零对齐到 52
```

entry#1 原始 hex(th07 fmt 前 52 字节):

```
74 68 30 37 5F 30 31 2E 77 61 76 00 00 00 00 00  "th07_01.wav"
10 00 00 00                                       start=0x10
DC 6D 9C 01                                       x=0x019C6DDC
00 93 12 00                                       loop=0x00129300
20 77 FC 00                                       len=0x00FC7720
01 00 02 00 44 AC 00 00 10 B1 02 00 04 00 10 00   WAVEFORMATEX(PCM/2ch/44100/16bit)
00 00 00 00                                       填充
```

### 1.4 条目排布方式(实测规律)

- **无缝顺排**:第 k 轨 `start + len == 第 k+1 轨 start`,20/20 作 0 断点;
- 首轨 start 恒为 0x10(紧跟 ZWAV 头);
- 全部 start/loop/len 为 4 字节帧对齐(th20 恰好 16B 对齐);
- **物理顺序 ≠ 音乐室顺序**(bgminfo/musiccmt 序)——fmt 序才是数据排布序,解析不得假设三者同序;
- 同一曲目可被多作复用(详见 §3.4),各作 fmt 独立切片互不相干。

---

## 2. 如何拆包:解析/切分算法与 PCM 参数

### 2.1 伪代码(完整可执行流程)

```
function parse_thbgm(dat_path, fmt_path) -> list[Track]:
    dat = read_bytes(dat_path)
    fmt = read_bytes(fmt_path)
    fsize = len(dat)

    # ---- 1. 校验 ZWAV 头 ----
    assert dat[0:4] == "ZWAV"
    assert u32_le(dat[4:8]) == 1
    zwavid = (dat[8], dat[9])            # 仅作识别/记录,不影响切片

    # ---- 2. 解析 fmt 目录表 ----
    assert (len(fmt) - 17) % 52 == 0
    n = (len(fmt) - 17) // 52
    assert all(fmt[len(fmt)-17:] == 0)   # 17B 零尾
    tracks = []
    for i in 0..n-1:
        e = fmt[i*52 : (i+1)*52]
        name   = cstr(e[0:16])           # ASCII/NUL 截断
        start  = u32_le(e[16:20])
        x      = u32_le(e[20:24])        # 忽略(见 §3.3)
        loop   = u32_le(e[24:28])
        ln     = u32_le(e[28:32])
        wfx    = e[32:50]                # 18B WAVEFORMATEX,逐条目读!
        rate   = u16_le(wfx[4:6])        # 44100 或 22050(th13 b 变体)
        ch     = u16_le(wfx[2:4])        # 恒 2
        bits   = u16_le(wfx[14:16])      # 恒 16
        tracks.append({name, start, loop, len:ln, rate, ch, bits})

    # ---- 3. 校验连续性(可选,防御性) ----
    for k in 0..n-2:
        assert tracks[k].start + tracks[k].len == tracks[k+1].start   # 0 断点
    assert tracks[0].start == 0x10

    # ---- 4. 逐轨切片(绝对边界) ----
    # 重要: fmt.start 本身即绝对文件偏移(首轨=0x10=16, 紧跟 16B ZWAV 头)
    #       —— 不要加 0x10! 全系列 20 作实测 末轨 start+len == fsize(Δ=0)
    for t in tracks:
        abs_start = t.start
        abs_len   = min(t.len, fsize - abs_start)   # 防御性 min(实测恒不触发)
        abs_loop  = abs_start + t.loop              # 循环点(相对本轨)
        pcm       = dat[abs_start : abs_start + abs_len]
        write_wav(name, pcm, rate=rate, ch=ch, bits=bits)   # 生成标准 RIFF/WAVE
        record(name, abs_start, abs_len, abs_loop, rate, ch, bits)
    return tracks
```

### 2.2 切分公式(规范)

```
absolute_start = start                          # fmt.start 即绝对文件偏移(不加 0x10!)
absolute_end   = min(start + len, 文件大小)     # 防御性 min(实测恒不触发, Δ=0)
loop_point     = start + loop                   # 绝对字节
loop_seconds   = loop / (rate * ch * bits / 8)  # 循环点秒数(rate 按条目 WFX 读)
```

### 2.3 PCM 参数表

| 参数 | 值(20/20 作默认) | 例外 |
|---|---|---|
| 编码 | PCM(裸 16bit 小端) | — |
| 声道 | 2(立体声) | — |
| 采样率 | 44100 Hz | **th13 的 13 条 b 变体轨为 22050 Hz** |
| 帧大小 | 4 字节(2ch × 16bit) | — |
| 字节率 | 176,400 B/s(44100Hz 时) | 88,200 B/s(22050Hz 时) |
| 载荷容器 | **裸 PCM,非 OGG**(全 20 作 0 个 "OggS" 魔数;`[thvorbis]` 仅是 bgminfo 配置节标签) | — |
| 循环 | loop 字段为 intro 长度,循环点为 `start+loop` | — |

### 2.4 输出建议(W3 任务必做)

1. 每轨输出标准 RIFF/WAVE 文件(带 WFX 头),文件名用 fmt 内 name;
2. 附清单列:`name, absolute_start, len, loop_point(绝对), loop_seconds, rate, ch, bits`;
3. 复用轨建议加 `(game, trackname)` 前缀或提供 MD5 去重提示(同一轨跨作字节级一致);
4. th13 的 `*b.wav`(22050Hz 变体)与 th19 的 `th19_90/91.wav`(编号外 bonus 曲)单独标注;
5. 每作输出后按本报告 §3.2 的条目数表核对数量。

### 2.5 渲染模式(--render,用户定稿规格 2026-08-24)

参考解析器 `release\_progress\_bgm_split.py` 支持渲染模式,产出可试听版本:

```
python _bgm_split.py <game> --out <dir> --render
```

渲染规格(用户定稿:raw 完整一遍 + 15s 续播尾 + 末尾 8s 淡出):

1. **渲染结构** = 原始 raw **完整播一遍**(loop 循环完成,即整个 intro+循环体)→ 追加 **15 秒续播尾**(素材=循环点延续,循环段不足 15s 则回绕补足)→ 末尾最后 **8 秒线性淡出**(幅度 1→0),续播尾前 7 秒不衰减;
2. **续播尾语义**:raw 播完后音乐继续(如同游戏内循环播放)再延续 15s,其中最后 8s 淡出到静音——衔接处即循环点,音乐天然连续(无咔哒);
3. **渲染时长 = 原轨长 + 15.000s**:44100Hz = +2,646,000 B;22050Hz 半速 = +1,323,000 B(实测全 20 作 0 偏差);
4. **逐条目使用自身 WFX**:th13 的 22050Hz 半速 b 变体按 fmt 记录,续播尾/淡出样本数按各自采样率计算(实测 th13_01b/th13_22b 22050Hz 正确);
5. 命名与 raw 一致(fmt 内原名),序号与 tracklist.csv 对齐(建议命名 `<game>_<序号>_<曲名>.wav` 由 W3 任务自行映射);
6. 输出结构:`<out>\raw\*.wav`(原始分段)+ `<out>\rendered\*.wav`(渲染版)+ `<out>\tracklist.csv`(含 rendered_seconds 列 = 原轨秒数 + 15.000);
7. 保留 raw 模式行为不变:不带 `--render` 时输出 `<out>\<name> + tracks.csv`,与 t46 交付时完全一致。

实现参数(脚本常量):`TAIL_SEC = 15.0`(续播尾时长)、`FADE_SEC = 8.0`(末尾淡出时长)。

实测验证(全 20 作,队长 verify_bgm_all.py 重生成核验):wav 头 wave 模块可读、rate/ch/bits 与 fmt 一致;渲染时长 = 原轨 + 15.000s(0 偏差);续播尾衔接处即循环点无咔哒;末尾 8s RMS 线性衰减;th13 31 轨含 13 条 22050Hz b 变体全部正确。

---

## 3. 共同性结论:跨作品一致字段与变体矩阵

### 3.1 全系列一致的字段(20/20 作)

| 字段 | 值 | 验证 |
|---|---|---|
| ZWAV 魔数/版本 | "ZWAV" + u32 1 | 20/20 |
| 头长 | 16 字节,之后即 PCM | 20/20 |
| fmt 条目定长 | 52B/条 + 17B 零尾 | 20/20 |
| 条目字段布局 | name[16]+start+x+loop+len+WFX(18B)+2B 补零 | 20/20 |
| 首轨 start | 0x10 | 20/20 |
| 无缝顺排 | start+len == 下一轨 start | 20/20 |
| 帧对齐 | 4 字节 | 20/20 |
| WFX 默认 | PCM/2ch/44100Hz/16bit | 20/20(除 th13 b 变体) |
| 载荷 | 裸 PCM | 20/20(0 OggS) |

### 3.2 各作条目数矩阵

| 游戏 | fmt 条目数 | bgminfo 曲目数 | 说明 |
|---|---|---|---|
| th07 | 20 | 20 | — |
| th08 | 21 | 21 | — |
| th09 | 19 | 19 | — |
| th095 | 6 | 6 | 外传(花映塚式 0x50) |
| th10 | 18 | 18 | — |
| th11 | 18 | 18 | — |
| th12 | 18 | 17 | bgminfo 漏列 th12_01.wav |
| th125 | 7 | 7 | 外传 |
| th128 | 10 | 10 | 外传 |
| th13 | 31 | 31 | 含 13 条 22050Hz b 变体 |
| th14 | 18 | 18 | — |
| th143 | 10 | 9 | bgminfo 漏列 th128_08.wav |
| th15 | 18 | 18 | — |
| th16 | 18 | 18 | — |
| th165 | 8 | 8 | 外传 |
| th17 | 18 | 18 | — |
| th18 | 18 | 18 | — |
| th185 | 10 | 10 | 外传 |
| th19 | 24 | 24 | 含 th19_90/91 bonus |
| th20 | 19 | 19 | — |

> 数值冲突仲裁:bgminfo 与 fmt 三元组 (start,loop,len) 数值集合全匹配(除上表 2 处 bgminfo 漏列);早期组 3 处边界冲突经 PCM 边界 RMS 仲裁(音乐级 10²–10⁴ vs 数字静音 0–2)全部判定 **fmt 正确**。**位置数值一律以 fmt 为准;bgminfo 仅用于曲名/注释/音乐室排序。**

### 3.3 变体矩阵:zwavid 识别字节与 x 字段

zwavid_08/09 编码规律(正作=(0x00, 作品号);外传 byte8=0x50 为花映塚系,th128=0x80、th143=0x30 特例;byte9=母体作品号):

| 游戏 | 08 | 09 | 游戏 | 08 | 09 |
|---|---|---|---|---|---|
| th07 | 00 | 07 | th13 | 00 | 13 |
| th08 | 00 | 08 | th14 | 00 | 14 |
| th09 | 00 | 09 | th143 | 30 | 14 |
| th095 | 50 | 09 | th15 | 00 | 15 |
| th10 | 00 | 10 | th16 | 00 | 16 |
| th11 | 00 | 11 | th165 | 50 | 16 |
| th12 | 00 | 12 | th17 | 00 | 17 |
| th125 | 50 | 12 | th18 | 00 | 18 |
| th128 | 80 | 12 | th185 | 50 | 18 |
| | | | th19 | 00 | 19 |
| | | | th20 | 00 | 20 |

x 字段(+0x14)演化:

| 区间 | 行为 | 条目数 |
|---|---|---|
| th07–th10 | 语义未明(≠len+loop、非有效指针、跨作不同),按 reserved 忽略 | 84 |
| th11–th128 | x = len + Δ,Δ 轨道固有(如 th10_17.wav 在 th11/th12 中 Δ 均 = 0x1C19B4) | 53 |
| th13–th20 | 恒 x == len(退化) | 148 |

**切片一律不使用 x 字段。**

### 3.4 跨作复用轨

| 复用轨 | 出现于 |
|---|---|
| th10_17.wav | th11, th12 |
| th128_08.wav | th128(本家), th13, th14, th15, th16, th17, th18, th20 |
| th14_03/10/12.wav, th125_06.wav, th128_08.wav | th143 |
| th15_07.wav, th16_12.wav | th165 |
| th18_13/14/16.wav, th165_06.wav | th185 |

- 复用轨在目标作 fmt 中以原名出现、start 各自独立,按各作 fmt 独立切片即可,不冲突;
- th128_08.wav 跨作字节级一致(64KB 头比对 + 文件尾相同)。

### 3.5 末轨边界与 start 字段语义(t65 勘误后定稿)

> ⚠️ **勘误记录(2026-08-24, t65)**:早期笔记(t44/t45)将切片公式写作 `absolute_start = 0x10 + start`,并据此推断"后期 15 作末轨声明比文件大 16B 需截断"。**该结论错误**——经 t65 全 20 作逐作核验(见下),`fmt.start` 字段**本身就是绝对文件偏移**(首轨 start=0x10=16,紧跟 16B ZWAV 头之后即 PCM),**不需要再加 0x10**。

**全系列 20 作核验结果(末轨 `start + len` vs thbgm.dat 大小):**

| 区间 | 行为 | Δ(start+len − fsize) |
|---|---|---|
| th07–th20(全部 20 作) | **末轨 start+len == 文件大小 精确成立** | **0(全部)** |

- 铁证链:①首轨 start=0x10(16)=ZWAV 头长度,数据紧跟其后;②bgminfo position 三元组与 fmt 字段数值直接对应(th08_01: position=`0x10,0xf1ac0,0xc20500` == fmt start/loop/len),若需 +0x10 则 position 应记 0x20;③修正 len 字段偏移后(早期核验脚本误读 x@0x14 为 len@0x1C)20/20 作 Δ=0。
- **切分规范: `absolute_start = start`(不加 0x10),无需截断**;代码保留 `min(len, 文件剩余)` 仅作防御性保护(实测恒不触发)。
- 早期"后期 +16B"误判成因:公式多加了 0x10,导致 `0x10+start+len == fsize+16` 被误读为"文件少 16B"。
- 该勘误不影响已交付产物正确性(见 §2.5 与各作 tracklist:tracklist.csv 的 abs_start 列均按 start 绝对偏移记录;若个别早期产物按 0x10+start 生成,见 t49/t65 说明)。

---

## 4. kouma(th06)例外说明

- **th06 无 thbgm.dat、无 thbgm.fmt**——BGM 不在此格式族内;
- kouma 的 BGM 为**双形态**:
  1. **MIDI 为主格式**:`紅魔郷MD.DAT`(306,003 B)内含 **17 个 MIDI(`th06_01.mid`–`th06_17.mid`)+ 17 个循环点(`th06_01.pos`–`th06_17.pos`)+ musiccmt.txt + ver0102.dat**;musiccmt.txt 的 `@bgm/` 行引用的正是 `.mid`(游戏实际播放 MIDI)。拆包产物已由 t5 落盘 `release\tsa\kouma\dat\紅魔郷MD\`。
  2. **散装 WAV 替换版**:`tsa\kouma\bgm\` 下 17 个 wav(`th06_01.wav`–`th06_17.wav`),为独立散装文件。
- **W3 对 kouma 只记录元数据清单,不复制文件**(红线:禁止写入源目录)。散装 wav 清单(文件名 / 字节数):

| # | 文件 | 字节数 |
|---|---|---|
| 1 | th06_01.wav | 11,206,778 |
| 2 | th06_02.wav | 15,368,324 |
| 3 | th06_03.wav | 9,945,206 |
| 4 | th06_04.wav | 15,532,158 |
| 5 | th06_05.wav | 15,859,834 |
| 6 | th06_06.wav | 24,838,280 |
| 7 | th06_07.wav | 18,858,116 |
| 8 | th06_08.wav | 21,527,454 |
| 9 | th06_09.wav | 23,160,042 |
| 10 | th06_10.wav | 32,237,314 |
| 11 | th06_11.wav | 16,613,542 |
| 12 | th06_12.wav | 10,633,346 |
| 13 | th06_13.wav | 29,065,494 |
| 14 | th06_14.wav | 27,967,616 |
| 15 | th06_15.wav | 22,642,824 |
| 16 | th06_16.wav | 10,174,588 |
| 17 | th06_17.wav | 19,267,718 |

合计:17 文件 / **324,898,634 B**。均为标准 WAV 容器(RIFF/WAVE)。MIDI 侧清单(17 mid + 17 pos)见 `release\tsa\kouma\dat\紅魔郷MD\MANIFEST.md`(t5 产物),此处不重复列表。

---

## 5. 遗留问题(不影响执行)

1. x 字段在 th11–th128 代的 Δ 语义(th10_17/th128_08 恰同 Δ=0x1C19B4,或与同源母带相关);
2. th128(0x80)/th143(0x30)的 zwavid 变体编码规则;
3. th19_90/91 曲目身份(bonus);
4. th075(萃梦想)走 packmethod 3(wav 打包档案),不属于本格式族,由 tf 线覆盖(已完成,见 release\tf\th075\dat\_FORMAT_REPORT_th075.md)。

---

## 附:分析脚本与数据(已落盘,可复跑)

- **`release\_progress\_bgm_split.py` — 参考实现解析器**(规范配套,W3 各作任务可直接调用):
  - `python _bgm_split.py <game> --out <dir>` — raw 模式:切分写 WAV + tracks.csv
  - `python _bgm_split.py <game> --out <dir> --render` — 渲染模式:raw\ + rendered\(raw 完整一遍 + 15s 续播尾 + 末尾 8s 淡出,TAIL_SEC=15/FADE_SEC=8)+ tracklist.csv
  - `python _bgm_split.py <game> --dry-run` — 只打印清单不写文件
  - 已实测:全 20 作(队长 verify_bgm_all.py)按本报告规则切分/渲染,raw==dat[start:start+len] 逐字节核验 0 异常,渲染时长=原轨+15.000s 0 偏差
- `release\_progress\t45_late.py` — 后期组综合分析(纯读取,含 fmt/bgminfo 解析与交叉验证)
- `release\_progress\t45_fmt_all.csv` — 后期 15 作 fmt 全表(game,idx,name,start,x,loop,len,rate,ch,bits)
- `release\_progress\t45_late_scan.json` — 后期 15 作全量机器扫描结果
- `release\_progress\W3a-early.md` / `W3a-late.md` — 两阶段原始笔记
