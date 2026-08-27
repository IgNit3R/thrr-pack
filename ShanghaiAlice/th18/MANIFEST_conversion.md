# 转换任务 MANIFEST(降级)— th18(虹龙洞)anm/ecl/msg/std

- 任务:t91 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` 降级口径(工具不支持即停,不重试崩溃工具)
- 源(只读):`release\tsa\th18\dat\`(t22 拆包产物,56 anm / 22 ecl / 44 msg / 7 std)
- 工具:`tools\thtk\thtk-bin-12\{thanm,thecl,thmsg,thstd}.exe`(thtk release 12)
- 源目录 `tsa\th18\` 零写入(仅读)

## 工具支持实测结果

| 工具 | 版本 18 行为 | 处置 |
|---|---|---|
| thanm | **部分崩溃**(51/56 成功,5 个 0xC0000005) | 成功 51 个照常提取;崩溃 5 个不重试,出结构报告 |
| thecl | `version 18 is unsupported`(exit=1,明确报错) | 降级:结构分析 |
| thmsg | `version 18 is unsupported`(exit=1) | 降级:结构分析 |
| thstd | `version 18 is unsupported`(exit=1) | 降级:结构分析 |

## 产物

| 目录 | 内容 |
|---|---|
| `anm_png\` | **51 个 anm 提取的 440 个 PNG**(可用)+ `STRUCTURE.md`(含 5 个崩溃 anm 头部结构/根因) |
| `ecl_txt\` | `STRUCTURE.md`(SCPT 新格式:22/22 魔数"SCPT"、ANIM/ECLI 引用块、子程序名表) |
| `msg_txt\` | `STRUCTURE.md`(4 类头部模式、anm/bgm 引用、文本高熵压缩/加密) |
| `std_txt\` | `STRUCTURE.md`(u16×2 头 + 尺寸对 + 16B anm 引用,旧格式重排版) |

## 关键发现(供 W8/后续)

1. **th18 anm 实为「大部分可提取」**:PENDING 预判「th18 直接崩溃」不准确——51/56 成功;崩溃 5 个与文件级结构无关(st01logo vs st02logo 头部逐字节一致,仅内嵌 PNG 名不同),系 thanm 对版本 8 特定图像条目的 bug;
2. **th18 ecl 换用 SCPT 魔数容器**(22/22),与 th11–th17 旧格式完全不同;th18+ 的 ecl 需新解析器;
3. **th18 msg 文本高熵**(压缩/加密),头部 4 类子块模式 + anm/bgm 引用明文;
4. th18 std 为旧格式字段重排版(anm 引用入定长头),QUAD 区仍在。

## 逐文件日志

- `release\_progress\t91_anm.log`(56 行;51×exit=0,5×exit=-1073741819)

## 核验

- anm_png 440 PNG 全部为合法文件(thanm 提取);4 份 STRUCTURE.md 基于实测 hex;
- 源目录零写入;崩溃工具未重试(每文件仅试 1 次)。
