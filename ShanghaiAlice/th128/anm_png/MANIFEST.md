# MANIFEST — th128(妖精大战争)anm / ecl / msg / std 转换

任务 t83 · extractor-f2 · 源:`release\tsa\th128\dat\*`(拆包产物,只读)· thtk-bin-12,版本号 128

## 产物

| 目录 | 数量 | 字节 | 工具 |
|---|---|---|---|
| `anm_png\` | 53 子目录 / 222 PNG | 24,247,746 B | `thanm -x`(每 anm 一子目录) |
| `ecl_txt\` | 33 | 1,037,904 B | `thecl -d 128` |
| `msg_txt\` | 22 | 39,026 B | `thmsg -d 128` |
| `std_txt\` | 10 | 34,429 B | `thstd -d 128` |

th128 无 .end(MIDI 时代四作才有),不建 end_txt。

## 结构口径(沿用 t81 决策)

anm 按**每 anm 一子目录**(anm_png\<基名>\)提取,避免 anm 内部 sprite 重名互相覆盖
(t81 实测平铺提取会丢失内容不同的重名变体;详见 t81 报告与 anm_png\MANIFEST.md 同款说明)。
222 个 sprite 零丢失,来源可溯源。

## 验证

- 53/53 anm、33/33 ecl、22/22 msg、10/10 std 转换 exit 0;
- 0 空文件;anm_png 内无非 PNG 杂物(除 MANIFEST.md);
- 抽样:msg_txt\e00.txt 为 `entry N (size)` 块结构;ecl_txt 为可读伪代码。
