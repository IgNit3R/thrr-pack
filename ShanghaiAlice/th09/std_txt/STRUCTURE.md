# th09 std(花映塚 world*.std)结构说明与转换状态

- 工具:thtk v12 thstd.exe -d 9;任务 t77
- 结论:**thstd 与 th09 world*.std 不兼容,多数文件 dump 崩溃(0xC0000005)**;按团队口径(工具崩溃即停)不重试,改产出本结构说明 + 可识别字段。

## 头部结构(前 16B 与 thtk std_header_06_t 前段吻合)

| 偏移 | 大小 | 字段 | 说明 |
|---|---|---|---|
| 0x00 | 2 | nb_objects | 对象数 u16 |
| 0x02 | 2 | nb_faces | 面数 u16 |
| 0x04 | 4 | faces_offset | 面数据偏移 u32 |
| 0x08 | 4 | script_offset | 脚本数据偏移 u32 |
| 0x0C | 4 | unknown | 恒 0 |
| 0x10 | 128×9 | 字符串区 | thtk 按 stage_name[128]+song1-4 name/path 各 [128] 解析;实测首 4B 为 `64 6D 00 00`('dm'),非场景名——**布局与 thtk 预期不符,疑为崩溃根因** |

## 各文件头部字段与 dump 状态

| 文件 | 大小 | nb_obj | nb_face | faces_off | script_off | unk | 首16B后4B | dump 状态 |
|---|---|---|---|---|---|---|---|---|
| world00.std | 5148 | 3 | 54 | 3012 | 3508 | 0 | 'dm' | 崩溃 (无输出) |
| world01.std | 5312 | 3 | 49 | 2872 | 3672 | 0 | 'dm' | 崩溃 (无输出) |
| world03.std | 5676 | 8 | 29 | 2268 | 4876 | 0 | 'dm' | 截断 (移 _partial) |
| world04.std | 4516 | 5 | 18 | 1852 | 3356 | 0 | 'dm' | 截断 (移 _partial) |
| world05.std | 3460 | 1 | 6 | 1372 | 1820 | 0 | 'dm' | 崩溃 (无输出) |
| world06.std | 2428 | 4 | 11 | 1620 | 1988 | 0 | 'dm' | 崩溃 (无输出) |
| world07.std | 6356 | 5 | 47 | 2664 | 5576 | 0 | 'dm' | 完整 (保留) |
| world09.std | 2892 | 2 | 23 | 1884 | 2332 | 0 | 'dm' | 截断 (移 _partial) |
| world09m.std | 2852 | 2 | 23 | 1884 | 2332 | 0 | 'dm' | 完整 (保留) |
| world10.std | 2932 | 9 | 16 | 1940 | 2292 | 0 | 'dm' | 崩溃 (无输出) |
| world11.std | 2388 | 1 | 6 | 1372 | 1868 | 0 | 'dm' | 崩溃 (无输出) |
| world11m.std | 2368 | 1 | 6 | 1372 | 1868 | 0 | 'dm' | 崩溃 (无输出) |
| world12.std | 2912 | 4 | 19 | 1844 | 2612 | 0 | 'dm' | 完整 (保留) |
| world13.std | 3228 | 6 | 20 | 1944 | 2168 | 0 | 'dm' | 崩溃 (无输出) |
| world13m.std | 3188 | 6 | 20 | 1944 | 2168 | 0 | 'dm' | 崩溃 (无输出) |

## 说明
- 完整 dump 3 个(world07/world09m/world12),已保留于本目录;截断 3 个(world03/04/09)移至 _partial\;其余 9 个空输出。
- 各文件头部计数/偏移字段可读(nb_objects 3–8、nb_faces 29–54),但字符串区布局异常,thtk 解析越界崩溃。
- 如需完整解码 th09 std,需自研解析器(超出本任务范围,建议 W8 汇总时登记)。

## t100 修复解码(2026-08-24,extractor-g2)

自研 Python 解析器(`release\_progress\t100_std_decode.py`)已按真实格式解码全部 15 个 std → `std_txt\fixed\`(15/15 无崩溃;其中 12 个此前 thtk 崩溃/截断,3 个"完整"输出亦被更正确解码覆盖)。逐文件状态见 `release\_progress\t100_scan.csv`。

**根因与格式修正(相对 thtk 源码 thstd.c)**:
1. 头部 = std_header_06_t(1168B),偏移表@0x490 ✓ 与 thtk 一致;0x10 起字符串区为 stage_name/song1-4(实测 'dm'+bgm/th08_xx.mid,系文件真实内容,非布局错位)。
2. **QUAD 记录为变长**:{u16 unknown, u16 size, u16 script_index, u16 padding, float x,y,z,width,height},size=0x1c(28B);th09 另含 size=0x24(36B,多 2 浮点)记录。**thtk 固定 32B 步进导致漂移→越界崩溃**——本次按 size 字段驱动,全部结束码(0x0004FFFF)命中。
3. 指令流 {time u32, type u16, size u16},步进=size+8,参数 12B;th09 脚本含类型 14–23/29/31–33(thtk v0 表外)→ 本次输出原始 hex 标注。
