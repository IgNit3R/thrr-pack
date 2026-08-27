# 转换任务 MANIFEST — th15(绀珠传)anm/ecl/msg/std

- 任务:t87 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` + `release\_CONVENTIONS.md`
- 源(只读):`release\tsa\th15\dat\`(t18 拆包产物,48 anm / 23 ecl / 42 msg / 7 std)
- 工具:`tools\thtk\thtk-bin-12\{thanm,thecl,thmsg,thstd}.exe`(thtk release 12)
- 版本号:15(全工具支持列表确认)
- 源目录 `tsa\th15\` 零写入(仅读;th15.dat mtime 未变)

## 产物

| 目录 | 转换 | 结果 | 说明 |
|---|---|---|---|
| `anm_png\` | thanm -x | 48/48 成功,276 个 PNG,54.1 MB | 分组子目录 |
| `ecl_txt\` | thecl -d 15 | 23/23 成功,513.0 KB | 可读伪代码;命名 st01..st07/stXXbs/stXXmbs/stXXmbs2/default |
| `msg_txt\` | thmsg -d 15 | 42/42 成功,110.3 KB | 对话脚本(SJIS 文本串) |
| `std_txt\` | thstd -d 15 | 7/7 成功,25.0 KB | 舞台脚本;命名 stage01..stage07 |

总计:120 个源文件全部转换成功,0 失败,0 空输出。

## 逐文件日志
- `release\_progress\t87_anm.log`(48 行)/ `t87_ecl.log`(23 行)/ `t87_msg.log`(42 行)/ `t87_std.log`(7 行),每行 `[<file>] exit=0`

## 说明
1. thanm 输出跟随 CWD,已按规范先 cd 到 anm_png\ 再执行;
2. th15 无 .end 文件(非 MIDI 时代,符合 PENDING 文档);
3. msg 文本为 SJIS 字节,控制台直显乱码属正常,文件内容完整。

## 核验
- 各目录文件数/大小如上;0 空文件;0 非零退出码;源目录零写入。
