# STRUCTURE — th20(錦上京)ECL 结构分析(降级)

- 任务:t94 | 执行:extractor-c2 | 日期:2026-08-24
- 背景:`thecl -d 20` 实测返回 "version 20 is unsupported"(rc=1,graceful 非崩溃);21 个 .ecl 无法工具转换,
  按降级口径产出结构分析。
- 样例:common.ecl(2,572B)、st01.ecl(35,300B)、st07mbs.ecl(15,072B)
- hex 侧车:本目录 `*.ecl.hex`(512B)

## 1. 魔数与头(新格式,非经典 ecl 版本号)

```
偏移      大小    内容                           common.ecl     st01.ecl      st07mbs.ecl
0x00      char[4] 魔数 "SCPT"                     53 43 50 54    同            同
0x04      u16     ?                               0x0001         0x0001        0x0001
0x06      u16     ?                               0x0110         0x004C        0x0010
0x08      u32     头大小                          = 0x24(36)     0x24          0x24
0x0C      u32     恒 0                            0              0             0
0x10      u32     子脚本(入口)数?                  2              0x43(67)      0x0D(13)
0x14..0x1F        恒 0
0x20      tag     "ANIM" 段:u32 数量 + NUL 分隔的 .anm 文件名
0x??      tag     "ECLI" 段:u32 数量 + NUL 分隔的 .ecl 子脚本文件名
0x??      u32[]   脚本偏移表(st01: 0x448, 0x644, 0x874, 0xA90… 递增)
0x??      tag     "ECLH"(结尾段,st07mbs 可见)
```

## 2. 段内容(实测)

- **ANIM 段**:common.ecl 无 anm;st01.ecl 引用 `enemy.anm`、`st01enm.anm`(自机/敌人精灵档);
- **ECLI 段**:common.ecl 引用 `wave01.ecl…wave09f.ecl` 等 18+ 个子脚本(波次脚本);
  st01.ecl 引用 `default.ecl`、`st01bs.ecl`、`st01mbs.ecl`(本作 ecl 为**分层引用结构**:st01 → bs/mbs 子脚本);
- **偏移表**:st01 从 0x70 起约 67 个递增 u32 偏移(对应 0x10 的入口数);
- **标签字符串**:st07mbs.ecl 内含 `MBoss`、`MBoss1-3`、`MBossCard1-3(_at)`、`MBossDead`、`MBossEscape` 等
  符卡/演出标签(精灵表引用);st01.ecl 含 `GirlA01`、`GirlA01_at` 标签。

## 3. 结论

- th20 ecl = "SCPT" 魔数容器:头(0x24)+ ANIM/ECLI 引用段 + 脚本偏移表 + ECLH 尾段;
- 结构清晰可解析(引用表+偏移表均为可识别字段),但指令集为 th20 新定义,thecl 不支持;
- **建议**:等 thtk 更新;或按 SCPT 容器自行实现「引用表/偏移表提取」(指令反汇编需新版本指令表)。

---

## 4. 更新(t96,2026-08-24):指令级反编译完成

t96 已基于 thtk 源码(thecl10.c/expr.c/value.c)自研纯 Python 解析器完成 **th20 ecl 指令级反编译**,21/21 全量 → `decompiled\*.txt`(含 README.md)。参数完全解码(字符串 cp932/浮点/栈引用/标签),rank 语义化,ins_11 类新指令(m*D + thecl_sub_param_t 8B)正确解析。与官方 thtk(th17)交叉验证逐指令一致。解析器: `release\_progress\t96_ecl\t96_ecl_decomp.py` + `ecl_fmts.py`(格式表,thtk 源码自动提取,含 th20 增量 25 条)。