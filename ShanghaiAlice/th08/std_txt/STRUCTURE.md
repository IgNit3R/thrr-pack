# STRUCTURE — eiya(th08) 无法用 thstd -d 8 转换的 STD 文件结构分析

- 任务:t76 | 执行:extractor-c2 | 日期:2026-08-24
- 背景:thtk v12 `thstd -d 8` 对 eiya 18 个 .std 中 **5 个崩溃**(0xC0000005 访问冲突),
  按分析文档降级口径(不重试、不硬刚)改为结构报告;其余 13 个转换成功(见 ecl_txt 同目录 README)。
- 与 th09 world*.std 崩溃(thstd -d 9)疑似同源:thstd v12 对特定 std 子格式的解析 bug。

## 1. 受影响文件清单

| 文件 | 大小 | 症状 | 处置 |
|---|---|---|---|
| stage4a.std | 5,332 B | thstd 崩溃 0xC0000005,无任何输出(0 字节) | 保留源文件;无 dump |
| stage4a_s.std | 4,012 B | 同上 | 同上 |
| stage4b.std | 5,332 B | 同上 | 同上 |
| stage4b_s.std | 4,012 B | 同上 | 同上 |
| stage5.std | 4,516 B | 崩溃,但先输出 4,096B 部分 dump(见 `stage5.txt`) | 保留部分产物并标注 |
| (对照) stage5_s.std | 3,636 B | **成功** dump(221 行) | `stage5_s.txt` |
| (对照) stage1–8(其余 12 个) | — | 全部成功 | — |

> stage4a/4b = 永夜抄第 4 面路线分歧(4a 幻视の夜/4b 黄金の夜);stage5 = 第 5 面(竹林)。
> stage5 与其子关 stage5_s 头部与主体高度一致(前 666B 逐字节相同),但 stage5 崩溃而 stage5_s 成功
> —— 崩溃由文件主体(ENTRY 段)具体内容触发,非文件级格式差异。

## 2. STD v8 文件头布局(hex 实测,与成功 dump 交叉印证)

```
偏移      类型        字段            实测值
0x00      u16        段/字段计数?     03(stage1/4a/4b) | 05(stage5)
0x02      u16                       0x2E(46)/0x31(49)/0x12(18)
0x04      u32                       0x0A04/0x0B38/0x073C
0x08      u32                       0x0DB4/0x0E58/0x0D1C
0x0C      8B         恒 0
0x10      char[16]   Stage 名        "dm"(本作统一)
0x20..0x8F            填充/预留(0x90 前)
0x90      char[16]   Song1 名        "dm"
0x??      char[16]   Path1           "bgm/th08_11.mid"(stage5) / "bgm/th08_13_b.mid"(stage5_s)
0x??      char[16]   Song2/Path2     stage5: "dm"+"bgm/th08_12.mid"(双 BGM 关)
…         …          Song3/4+Path3/4(可为空)
…         u32        Std_unknown     0
```

## 3. dump 结构(以成功的 stage5_s.txt 为参照,thstd 解析顺序)

```
Stage: dm
Song1: dm
Path1: bgm/th08_13_b.mid      ← 每个 Song/Path 对
Song2: dm / Path2:(空)
Song3:  / Path3:
Song4:  / Path4:
Std_unknown: 0
ENTRY:                          ← 主体:实体/脚本记录列表
    Unknown: 1
    Position: -64 -192 -240     ← 3×f32
    Depth: 128 / Width: 640 / Height: 576
    QUAD:
        Type: 0
        …
    FACE: 256 -192 8704 0       ← 贴图面记录(多行)
    …
```

## 4. 崩溃点定位

- **stage5.std**:部分 dump 停在 `ENTRY:` 行之后(4,096B = 头部 + "ENTRY:" 前缀)——崩溃发生在
  **ENTRY 内部记录解析**(QUAD/FACE 段);stage5 为双 BGM 主关(Path1/Path2 均有值),主体含特定
  QUAD/FACE 数据组合触发 thstd 越界读。
- **stage4a/4a_s/4b/4b_s**:0 字节输出——崩溃在 dump 更早阶段(头部字段解析后、写出前),
  或首条 ENTRY 记录即触发;4a/4b 为路线分歧面,头字段计数(03)与 stage1 相同但主体布局不同。

## 5. 结论与建议

- 5 个文件的结构差异在主体 ENTRY 段,头部与正常文件同构;建议:
  - W8 已知事项收录「thstd v12 对 th08 stage4a/4b/5 主体崩溃」;
  - 如需完整 std 内容,可考虑用 thtk 源码中 thstd 对应模块(thecl/thstd 共用解析)自行修复后重跑,
    或对照同面 `_s` 子关(成功)推测主体结构;
  - 游戏内 std 仅影响关卡配置呈现,不影响其余 13 个文件的转换有效性。

## t100 修复解码(2026-08-24,extractor-g2)

自研解析器已解码全部 18 个 std(stage1–8 + _s)→ `std_txt\fixed\`(18/18 无崩溃;此前崩溃/空输出:stage4a/4a_s/4b/4b_s/stage5/stage6/7/8,stage5*.txt 旧输出为 thtk 崩溃前 4096B 残片)。逐文件状态见 `release\_progress\t100_scan.csv`。

**根因与格式修正**:
1. 头部 = std_header_06_t(1168B),偏移表@0x490;字符串区含 'dm' 与 bgm/th08_xx.mid(真实内容)。
2. **QUAD 变长记录**:{u16 unknown, u16 size=0x1c(28), u16 script_index, u16 padding, 5 floats};thtk 32B 步进漂移→找不到 0x0004FFFF→越界(0xC0000005/0xC0000409)。按 size 驱动后全部命中结束码。
3. 指令流 v0 语义(size+8 步进,参数 12B);eiya 脚本含类型 29/31/32/33/34(thtk 表外)→ 原始 hex 输出。
