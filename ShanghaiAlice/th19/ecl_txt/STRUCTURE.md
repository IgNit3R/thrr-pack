# STRUCTURE — th19(兽王园)ecl 格式降级结构分析

任务 t93 · extractor-f2 · 源:`release\tsa\th19\dat\*.ecl`(43 个,只读)

## 降级背景

`thecl -d 19` → "version 19 is unsupported"(exit 1,干净报错,非崩溃)。按降级口径做结构分析。

## 样本分析

### common.ecl(2,572 B)

```
0x00  magic "SCPT" (0x53435054)
0x04  u32  0x01100001             (版本/头长复合字段,th13+ SCPT 容器)
0x08  u32  0x24 = 36              (头/偏移)
0x10  u32  0x02                   (块计数?)
0x24  "ANIM"                      (子块标记 1:动画引用)
0x2C  "ECLI" + u16 0x16           (子块标记 2:指令块,0x16=块长?)
0x34  "wave01.ecl" 等字符串        (指令引用外部 ecl 文件)
```

### default.ecl(28,772 B)

```
同 "SCPT" 容器头;块计数 0x41 = 65;
含大量函数/标签名符号:BossDead、BossEscape、BossInterval、BossItem、
BossItemPhase、BossStartInit、DeadAttack1 …(共 189 个可读字符串)
```

## 结论

th19 ecl = **"SCPT" 容器格式**(th13+ 同族),内含 "ANIM"/"ECLI" 子块与符号名表,
指令可引用外部 ecl(wave01.ecl 等)与内置函数。与 thecl 支持的 th13-th17 结构同构,
仅版本号超出工具表 → 后续可基于 thtk thecl 源码(th13+ 分支)扩展支持。

## 说明

- thecl 未崩溃(干净 unsupported 报错);数据完好(与源 dat 条目逐字节一致)。

---

## 更新(t96,2026-08-24):指令级反编译完成

t96 已基于 thtk 源码(thecl10.c/expr.c/value.c)自研纯 Python 解析器完成 **th19 ecl 指令级反编译**,43/43 全量 → `decompiled\*.txt`(含 README.md)。参数完全解码(字符串 cp932/浮点/栈引用/标签),rank 语义化。与官方 thtk(th17)交叉验证逐指令一致。解析器: `release\_progress\t96_ecl\t96_ecl_decomp.py` + `ecl_fmts.py`(格式表,thtk 源码自动提取)。
