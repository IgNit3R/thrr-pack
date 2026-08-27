# th095 std 格式 STRUCTURE.md(降级产物)

> 任务 t78 · extractor-e2 · 2026-08-24
> 背景:thtk v12 `thstd.exe -d 95` 对 th095 全部 10 个 std 崩溃(0xC0000005);试 `-d 8/9` 亦崩;
> `-d 10`/`-d 11` 可解析其中 9 个,**仅 world10.std 崩溃**(0xC0000409 栈保护失败)。
> 按团队降级口径(工具崩溃即停,不硬刚):9 个成功件用 `thstd -d 10` 输出,world10 以本文件记录结构分析。

## 1. 总体布局(th095 std,与 th10 家族一致)

```
+0x00  u16  条目数 count
+0x02  u16  未知(各文件不同,如 world01=0x2E / world10=0x14)
+0x04  u32  未知(world01=1612 / world10=920)
+0x08  u32  未知(world01=2284 / world10=1144)
+0x0C  u32  恒 0
+0x10  char[32]  关联 ANM 名("data/worldXX.anm",NUL 填充)
+0x30  …   96B 全零填充
+0x90  4×count  条目偏移表(绝对文件偏移)
+…     条目区(定长?不,变长;见 §2)
+…     SCRIPT 区(0xFFFF… 填充后为指令流,见 §3)
```

头部实测(world10.std,1,736 B):
`06 00 | 14 00 | 98 03 00 00 | 78 04 00 00 | 00 00 00 00 | "data/world10.anm"`

## 2. 条目区(world10:6 条)

偏移表 @0x90:0xA8 / 0xE4 / 0x1E4 / 0x2E4 / 0x320 / 0x35C

| # | 偏移 | 长度 | 头字段(hex 推断,f32 布局) |
|---|---|---|---|
| 0 | 0xA8 | 0x3C (60B) | unknown=0,pos=(0.0,12.0,1536.0),宽=1536.0,高=0.0 |
| 1 | 0xE4 | 0x100 (256B) | unknown=1,pos 段含 QUAD/FACE 列表 |
| 2 | 0x1E4 | 0x100 (256B) | unknown=2 |
| 3 | 0x2E4 | 0x3C (60B) | unknown=3 |
| 4 | 0x320 | 0x3C (60B) | unknown=4 |
| 5 | 0x35C | 0x114 (276B) | unknown=5,含 QUAD/FACE,末以 0xFFFF… 填充过渡到 SCRIPT 区(0x470) |

条目头布局(对照可解析的 world01.txt 成功 dump 推断):
`u32 unknown + f32 pos.x/y/z + f32 width + f32 height + u32 depth(?) + QUAD(Type,Script_index,pos×3,pad,width,height)… + FACE(×N)…`

## 3. SCRIPT 区(world10)

0x470 起 0xFFFF… 填充(0x470–0x47F),0x484 起指令流:`u16 ins + u16 参数字节数 + 参数…`

| 偏移 | 指令 | 参数字节 | 说明 |
|---|---|---|---|
| 0x484 | ins_6 | 0x14 | |
| 0x490 | ins_7 | 0x0C | |
| 0x49C | ins_2 | 0x14 | ×2(0x49C/0x4AC) |
| 0x4BC | ins_8 | 0x14 | |
| 0x4CC | ins_2 | 0x14 | |
| 0x4DC | ins_4 | 0x14 | |
| 0x4EC | ins_9 | 0x1C | |
| 0x508 | **ins_10** | 0x34 | world01 无此指令 |
| 0x540 | **ins_11** | 0x34 | world01 无此指令 |
| … | ins_10/ins_11 交替 | 0x34 | 0x578/0x5B0/0x5E8/0x620/0x658/0x690 |
| 0x6A8 | ins_1 | 0x10 | 结尾 |

## 4. 崩溃判定与降级

- thtk 的 th095(v95)std 模块完全失效(10/10 崩溃);th10(th11)模块可解析 9/10;
- **world10.std 触发 thstd v10/v11 栈保护失败(0xC0000409)**:其条目结构本身与其余 9 个同型,差异在 SCRIPT 区含 `ins_10`/`ins_11`(各 52B 参数)指令,world01–09 均无;推断 thtk 该版本对这两个指令的参数解析存在缺陷(越界读)。已按「崩溃即停、不硬刚」停止重试。
- 降级:world01–09 采用 `thstd -d 10` 输出(与 `-d 11` 逐字节一致,语义可信);world10 以上述 hex 布局 + 偏移表 + 指令流表代替文本 dump,内容完整可复核。

## 5. 关联文件

- 成功 dump:std_txt\world01.txt – world09.txt(格式参考 world01.txt:ANM 名/ENTRY/QUAD/FACE/SCRIPT)
- 源:release\tsa\th095\dat\th095\world10.std(1,736 B,只读未改)

## t100 修复解码(2026-08-24,extractor-g2)

自研解析器已解码全部 10 个 std(world01–10)→ `std_txt\fixed\`(10/10 无崩溃;thtk -d 95 对全部 10 个均 0xC0000005,world10 全版本崩;旧 world01–09.txt 为 thtk 误读产物)。逐文件状态见 `release\_progress\t100_scan.csv`。

**根因与格式修正**:
1. **th095 头部实为 std_header_10_t(144B,anm_name@0x10='data/worldXX.anm'),偏移表@0x90**——thtk 把版本 95 映射成 v0(1168B 头部,偏移表@0x490)读错偏移表→越界崩溃。**这是 th095 全版本崩的直接根因**。
2. QUAD 变长记录同 v0 族:size=0x1c(28B),{unk,size,script_index,padding,5 floats};thtk 32B 步进漂移→崩溃。
3. 指令流 v1 语义(步进=size,参数=size−8);**ins_10/ins_11 size=52(44B 参数)**,thtk v1 表仅有 type10="SSfffffffff"(40B)且缺 type11→abort;本次按 {int32,int32,10×float} 渲染 ins_10/11(44B)。
