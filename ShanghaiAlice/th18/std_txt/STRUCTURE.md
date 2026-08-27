# th18 std 结构分析报告(降级任务)

- 任务:t91 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` 降级口径
- 源(只读):`release\tsa\th18\dat\*.std`(7 个,thtk 拆包产物)
- 工具:`tools\thtk\thtk-bin-12\thstd.exe`(thtk release 12)

## 结论先行

**th18 std thtk 不支持**(`thstd.exe -d 18` → "version 18 is unsupported",exit=1,明确报错非崩溃)。7 个 std 头部结构一致:`u16×2 头 + 尺寸对 + 16B 处 anm 文件名引用`,与旧版 std 同族但字段位置有差异。按降级口径做结构分析如下。

## 1. 文件头结构(7/7 一致)

```
偏移    大小    内容
0x00    2      u16 未知标志(3/4/3/3/3/1/5,逐关卡不同)
0x02    2      u16 未知标志(3/10/4/7/14/8/23)
0x04    4      u32 尺寸 1(如 0x150/0x238/0x190/0x1E8…,与关卡相关)
0x08    4      u32 尺寸 2(如 0x2E0/0x3C8/0x2D0/0x2B0…,约为尺寸1 的 1.5–2 倍)
0x0C    4      0
0x10    16     舞台背景 anm 引用 "st0Xwl.anm\0" (white/立绘层,16B 定长)
0x20    之后    0 填充 + 条目数据(QUAD 类舞台指令区,全文件熵 2.6 结构化)
```

实测(7 个头部):

| 文件 | u16@0 | u16@2 | u32@4 | u32@8 | anm 引用 |
|---|---|---|---|---|---|
| st01.std | 3 | 3 | 0x150 | 0x2E0 | st01wl.anm |
| st02.std | 4 | 10 | 0x238 | 0x3C8 | st02wl.anm |
| st03.std | 4 | 4 | 0x190 | 0x2D0 | st03wl.anm |
| st04.std | 3 | 7 | 0x1E8 | 0x2B0 | st04wl.anm |
| st05.std | 3 | 14 | 0x138 | 0x2E0 | st05wl.anm |
| st06.std | 1 | 8 | 0x1E0 | 0x2E0 | st06wl.anm |
| st07.std | 5 | 23 | 0x138 | 0x2E0 | st07wl.anm |

## 2. 与旧版对比

| 属性 | th11–th17(旧) | th18 |
|---|---|---|
| 头部 | ANM: 行 + Std_unknown 字段 + ENTRY/QUAD 文本 | u16×2 头 + u32 尺寸对 + 16B anm 引用 |
| anm 引用 | 首行 `ANM: stage0X.anm`(可变长) | 定长 16B 字段 @0x10 |
| 舞台对象 | ENTRY/QUAD/Script_index 文本块 | 0x20 后数据区(疑同族 QUAD 序列) |
| thtk 支持 | thstd -d <11..17> ✓ | ✗ (unsupported) |

旧版(可转换)对应物:th17 的 `st0X.std` 首行即 `ANM: st0Xwl.anm`,与 th18 的 16B 字段引用同一类背景资源——**th18 std 疑为旧格式的字段重排版**(anm 引用从文本首行移入定长头,QUAD 条目区仍在)。

## 3. 可识别内容

- 舞台背景资源引用明文:`st01wl.anm`…`st07wl.anm`(白/立绘背景层,与旧版命名一致);
- 尺寸对(u32@4/u32@8)逐关卡变化,疑为舞台尺寸/条目数描述;
- 全文件熵 2.6(结构化指令区,无压缩/加密迹象)。

## 4. 未解事项

- u16×2 与 u32×2 字段精确语义;QUAD 条目区在 th18 的编码变体(整体结构同旧版,字段宽度可能变化)。

## 5. 产物

- 本目录:7 个 std 的结构分析报告(无 .txt 转换产物,thtk 不支持);
- 分析脚本:`release\_progress\t91_eclmsgstd_struct.py / t91_deep_struct.py / t91_stats.py`;
- 原始文件仍在 `release\tsa\th18\dat\`,未做任何修改。
