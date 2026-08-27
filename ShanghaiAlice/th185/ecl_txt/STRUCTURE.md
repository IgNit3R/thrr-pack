# STRUCTURE — th185(虹龙洞) ecl 格式结构与反编译说明

任务 t96 · pe-analyst2 · 源:`release\tsa\th185\dat\*.ecl`(114 个,只读)

## 降级背景

`thecl -d 185` → "version 185 is unsupported"(exit 1,干净报错)。th185 为 th18 同代引擎(ecl 与 th18 同构 SCPT 容器)。

## t96 结果:指令级反编译完成

基于 thtk 源码(thecl10.c/expr.c/value.c)自研纯 Python 解析器,**114/114 全量反编译** → `decompiled\*.txt`(含 README.md)。

## 格式要点(th185)

```
header: "SCPT" u16 u16 include_len u32 include_offset u32 zero u32 sub_count u32 zero[4]
include: "ANIM"/"ECLI" 引用块
sub: "ECLH" + 指令流
指令: u32 time u16 id u16 size u16 param_mask u8 rank u8 pcount u32 zero + data
```

- 指令格式表 = th10..th18 继承 + **th185 增量 23 条**(5xx 弹幕系 + 10xx 关卡/演出系):
  - `{535,"SSSSSSSSS"} {536,"fffffffff"}` 等弹幕参数
  - `{1001,"S"}…{1026,"S"}` 关卡控制(周目/难度相关)
- **数字难度 rank**:th185/19 为 is_numeric_difficulty_version,rank 掩码为 0-7 数字难度位(非 E/N/H/L),默认 0x00;
- 反编译输出与 th18 同格式(见 decompiled\README.md)。

## 验证

- 114/114 解析 0 失败;参数解码(字符串/浮点/栈引用/标签)与 thtk 交叉验证一致;
- ecl_index.tsv(任务前产物)与 decompiled 覆盖一致。

解析器:`release\_progress\t96_ecl\t96_ecl_decomp.py` + `ecl_fmts.py`。
