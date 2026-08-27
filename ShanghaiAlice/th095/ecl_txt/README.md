# th095 ecl_txt 目录说明

> 任务 t78 · extractor-e2 · 2026-08-24

## 来源与工具
- 源:`release\tsa\th095\dat\th095\*.ecl`(85 个,th095.dat 拆包产物,只读)
- 工具:thtk v12 `thecl.exe -d 95 <in> <out>`(版本号 95)

## 产物
- **85/85 个 .txt 全部转换成功**(ecl1_a.ecl → ecl1_a.txt 等),总计 291,091 B
- 输出为可读伪代码:Sub 子程 + ins_* 指令序列(例:ecl1_a.txt 含 Sub0: ins_80(3); ins_109(-1); ins_105(); …)

## 关联
- 进度:`release\_progress\t78.md`
