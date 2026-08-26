# MANIFEST — th12(星蓮船)ecl / msg / std 文本转换

任务 t81 · extractor-f2 · 源:`release\tsa\th12\dat\*.ecl|*.msg|*.std`(拆包产物,只读)

## 工具与命令(thtk-bin-12,版本号 12)

- ecl:`thecl.exe -d 12 <in> <out>`
- msg:`thmsg.exe -d 12 <in> <out>`
- std:`thstd.exe -d 12 <in> <out>`

## 产物

| 目录 | 文件数 | 字节 | 内容 |
|---|---|---|---|
| `ecl_txt\` | 9 | 579,652 B | 可读伪代码(anim/ecli 引用、函数/指令流) |
| `msg_txt\` | 55 | 121,256 B | 对话脚本(entry 块/文本行) |
| `std_txt\` | 7 | 28,354 B | 关卡脚本(std 数据转文本) |

## 验证

- 9/9 ecl、55/55 msg、7/7 std 转换 exit 0;0 个空文件;
- 抽样:ecl_txt\stage01.txt 含 `anim { "enemy.anm"; ... }` 与 `void BGirl00()` 函数体;msg_txt 为 `entry N (size)` 块结构。

## 备注

- th12 无 .end 文件(MIDI 时代四作 kouma/youmu/eiya/th09 才有),不产出 end_txt;
- 版本号 12 在 thtk 支持表内(th18+ 不支持,本作不受影响)。
