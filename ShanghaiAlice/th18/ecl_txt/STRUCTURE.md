# th18 ecl 结构分析报告(降级任务)

- 任务:t91 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` 降级口径
- 源(只读):`release\tsa\th18\dat\*.ecl`(22 个,thtk 拆包产物)
- 工具:`tools\thtk\thtk-bin-12\thecl.exe`(thtk release 12)

## 结论先行

**th18 ecl 为「SCPT」魔数新格式,thtk thecl 不支持**(`thecl.exe -d 18` → "version 18 is unsupported",exit=1,明确报错非崩溃)。22 个 ecl 头部魔数 **22/22 为 `SCPT`**,与 th11–th17 的旧式 ecl(无魔数、直接指令流)完全不同 → **th18 换用了新脚本容器格式**。按降级口径做结构分析如下。

## 1. 文件头结构(SCPT 容器)

```
偏移    大小    内容
0x00    4      魔数 "SCPT"(53 43 50 54)
0x04    4      版本/标志(实测 0x004C0001 或 0x00100001;低 16 位=1 疑版本,高 16 位=块表偏移 0x4C/0x10)
0x08    4      块表偏移(0x24=36,指向首个子块 "ANIM")
0x0C    4      0
0x10    4      子程序表偏移/计数(如 st01=0x53=83)
0x14..0x20    0 填充(16B)
0x24    N      "ANIM" 子块:魔数+u32 数量+引用文件名字符串(如 "enemy.anm\0st01enm.anm\0")
0x2C+   N      "ECLI" 子块:魔数+u32 数量+引用 ecl 文件名字符串(如 "default.ecl\0st01bs.ecl\0st01mbs.ecl\0")
之后          子程序名表 + 指令码流(含 "Boss"/"BossItem"/"DeadAttack1" 等子程序名)
```

实测 st01.ecl 头部 hex:

```
00000000  53 43 50 54 01 00 4C 00 24 00 00 00 00 00 00 00   SCPT..L.$.......
00000010  53 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00   S...............
00000020  00 00 00 00 41 4E 49 4D 02 00 00 00 65 6E 65 6D   ....ANIM....enem
00000030  79 2E 61 6E 6D 00 73 74 30 31 65 6E 6D 2E 61 6E   y.anm.st01enm.an
00000040  6D 00 00 00 45 43 4C 49 03 00 00 00 64 65 66 61   m...ECLI....defa
00000050  75 6C 74 2E 65 63 6C 00 73 74 30 31 62 73 2E 65   ult.ecl.st01bs.e
00000060  63 6C 00 73 74 30 31 6D 62 73 2E 65 63 6C 00 00   cl.st01mbs.ecl..
00000070  1C 05 00 00 C4 06 00 00 20 0A 00 00 7C 0D 00 00   ....... ...|....
```

## 2. 结构与旧版对比

| 属性 | th11–th17(旧) | th18(SCPT) |
|---|---|---|
| 头部 | 无魔数,直接 anim{} 块 | **"SCPT" 魔数** + 块表 |
| 资源引用 | `anim { "enemy.anm"; }` 文本段 | "ANIM"/"ECLI" 子块 + 计数字段 |
| 子程序 | void 函数 + ins_* 指令 | 子程序名表(Boss/BossItem/DeadAttack1…)+ 指令码流 |
| thtk 支持 | thecl -d <11..17> ✓ | ✗ (unsupported) |

## 3. 可识别内容(供未来解析器)

- 资源引用完整可读:`anim 2 → enemy.anm, st01enm.anm;ecli 3 → default.ecl, st01bs.ecl, st01mbs.ecl`(与旧版 ecl 头声明一致);
- 子程序名:default.ecl 含 `Boss / BossItem / BossItemPhase / BossItemPhase2 / BossItemPhase3 / DeadAttack1 / Boss1 / Boss1_at / Boss1_at_et / Boss2` 等;
- 指令码流区:0x70 起为 u32 偏移表(如 0x51C/0x6C4/0xA20/0xD7C),疑子程序入口偏移表;
- 全文件熵 2.8(结构化,非加密压缩)。

## 4. 未解事项

- SCPT 块表/指令码的完整解码需自研解析器或等待 thtk 上游支持 th18(当前 release 12 未含);
- 0x04 版本字段高低 16 位语义。

## 5. 产物

- 本目录:22 个 ecl 的**结构分析报告**(无 .txt 转换产物,thtk 不支持);
- 分析脚本:`release\_progress\t91_eclmsgstd_struct.py / t91_deep_struct.py / t91_stats.py`;
- 原始文件仍在 `release\tsa\th18\dat\`,未做任何修改。

---

# 更新(t96,2026-08-24):指令级反编译完成

**t96 已实现 th18/185/19/20 ecl 指令级反编译**,自研纯 Python 解析器(读 thtk 源码 thecl10.c + expr.c + value.c 实现),输出见 `decompiled\*.txt`(22/22 全量)。

- 格式:SCPT 容器 + th10 系指令集(详见 `decompiled\README.md` 与 `release\_progress\t96_ecl\` 源码);
- 指令格式表:从 thtk 源码自动提取(th10..th20 全版本继承链,th18 增量 3 条);
- 输出:`anim/ecli` 头 + `void sub()` + 指令序列,参数完全解码(字符串 cp932/浮点/栈引用 $/标签 @name_off),rank 语义化(!E/N/H/L/X/O);
- 验证:与官方 thtk(th17)交叉验证逐指令一致;四作 200/200 解析 0 失败;
- 未做:表达式合并/助记符(goto/async)级语义化——输出原始指令行+操作数表(任务允许口径)。

源文件与脚本:
- `release\_progress\t96_ecl\t96_ecl_decomp.py`(主程序)
- `release\_progress\t96_ecl\ecl_fmts.py`(格式表,自动提取)
- `release\_progress\t96_ecl\insn_sem.py`(语义映射,备用)
