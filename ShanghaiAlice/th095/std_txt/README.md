# th095 std_txt 目录说明

> 任务 t78 · extractor-e2 · 2026-08-24

## 来源与工具
- 源:`release\tsa\th095\dat\th095\world01.std – world10.std`(10 个,th095.dat 拆包产物,只读)
- 工具:thtk v12 `thstd.exe`

## 产物
- `world01.txt – world09.txt`(9 个):**降级用 `thstd -d 10` 转换**(详见下),格式含 ANM 名/ENTRY/QUAD/FACE/SCRIPT(示例 world01.txt)
- `STRUCTURE.md`:world10.std 的结构分析(降级产物)

## 降级决策(重要)
1. `thstd -d 95` 对全部 10 个 std **崩溃(0xC0000005)**——thtk 的 v95 std 模块失效(`-d 8/9` 亦崩);
2. `-d 10`/`-d 11` 可解析 9 个且输出逐字节一致(判 th095 std 布局属 th10 家族)→ 采用 `-d 10`;
3. **world10.std 连 v10/v11 也崩(0xC0000409 栈保护失败)**:结构同型,差异在 SCRIPT 区含 `ins_10`/`ins_11`(52B 参数)指令,world01–09 无;推断 thtk 对这两个指令解析缺陷。按「崩溃即停、不硬刚」停止重试,world10 以 STRUCTURE.md 记录 hex 布局+条目偏移表+指令流表。

## 关联
- 进度:`release\_progress\t78.md`
