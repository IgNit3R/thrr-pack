# th16(東方天空璋)anm/ecl/msg/std 转换产物说明

- 任务:t88 | 执行:extractor-g2 | 日期:2026-08-24
- 工具:thtk-bin-12(thanm/thecl/thmsg/thstd),版本号 16
- 源(只读):`release\tsa\th16\dat\`(W2 拆包产物);源目录 `tsa\th16\` 零写入
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` + 队长规范更新(anm 逐档案子目录)

## 产物总览

| 目录 | 内容 | 数量 | 总字节 |
|---|---|---|---|
| `anm_png\` | thanm -x 逐档案解出图像(每档案一子目录) | 54 档案 / 353 PNG | — |
| `ecl_txt\` | thecl -d 16 伪代码(default + st01–07 + bs/mbs 变体) | 22 | 495,573 |
| `msg_txt\` | thmsg -d 16 对话脚本(40:e01–e08 结局用 -e,st01a-d..st07a-d,staff1-4) | 40 | 113,462 |
| `std_txt\` | thstd -d 16 脚本(st01–07) | 7 | 33,140 |

## anm_png 说明(54 档案 / 353 图像)

- **布局(新规范)**:`anm_png\<anm基名>\<条目路径>\`,每档案独立子目录,54/54 exit 0。
- **同档案内同名条目 = 分块拼合,非重复数据(重要)**:
  - th16(THA1 格式)中多个档案存在同名条目对(如 `ending/e01a.png` 两块:1024×960 主图 + 256×960 侧栏),条目以 x/y 偏移拼合成**完整图像**,thanm 自动合成输出(实测 e01a.png=1280×960、sig1280.png=1280×960、title_bk00.png=1280×960)。
  - 受影响档案:e01–e08(ending/* ×2)、front(balloon_1024)、pl00sub–pl04sub(pl00.png)、sig(loading/sig1280)、st01logo–st07logo(logo)、title(title_bk00)、st0Xenm(face/dummy ×2–7,内容一致的小占位)。
  - 结论:353 文件为合成后的完整图像,**零数据丢失**;417 条图像条目 → 353 唯一文件名(64 条为拼合面板)。
- 跨档案同名(如各 st0Xenm 的 `face/dummy.png`):逐档案子目录隔离,天然无覆盖问题。

## msg_txt 说明

- 结局对话 **e01–e08(8 个)用 `thmsg -e -d 16`**(含 bgm/anm 引用,如 `10;bgm/th16_14`);普通对话 st01a-d..st07a-d(28)+staff1-4(4)用 `-d 16`。
- 输出编码 CP932(SJIS);staff1-4 为 181B 小型脚本(引用式 staff roll)。

## 文件命名

- ecl_txt / msg_txt / std_txt 内:原文件名 + `.txt`(如 `st01bs.ecl.txt`、`e01.msg.txt`、`st01.std.txt`)。
