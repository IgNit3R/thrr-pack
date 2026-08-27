# 转换任务 MANIFEST — th14(辉针城)anm/ecl/msg/std

- 任务:t85 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` + `release\_CONVENTIONS.md`
- 源(只读):`release\tsa\th14\dat\`(t16 拆包产物,57 anm / 24 ecl / 55 msg / 7 std)
- 工具:`tools\thtk\thtk-bin-12\{thanm,thecl,thmsg,thstd}.exe`(thtk release 12)
- 版本号:14(全工具支持列表确认)
- 源目录 `tsa\th14\` 零写入(仅读;th14.dat mtime 未变)

## 产物

| 目录 | 转换 | 结果 | 说明 |
|---|---|---|---|
| `anm_png\` | thanm -x | 57/57 成功,275 个 PNG,66.1 MB | 分组子目录(含 st0Xenm/st0Xlogo/plXX 等) |
| `ecl_txt\` | thecl -d 14 | 24/24 成功,495.1 KB | 可读伪代码;命名 st01..st07/stXXbs/stXXmbs/default |
| `msg_txt\` | thmsg -d 14 | 55/55 成功,106.9 KB | 对话脚本(SJIS 文本串) |
| `std_txt\` | thstd -d 14 | 7/7 成功,38.7 KB | 舞台脚本;命名 stage01..stage07 |

总计:143 个源文件全部转换成功,0 失败,0 空输出。

## 逐文件日志
- `release\_progress\t85_anm.log`(57 行)/ `t85_ecl.log`(24 行)/ `t85_msg.log`(55 行)/ `t85_std.log`(7 行),每行 `[<file>] exit=0`

## 说明
1. thanm 输出跟随 CWD,已按规范先 cd 到 anm_png\ 再执行;
2. th14 无 .end 文件(非 MIDI 时代,符合 PENDING 文档);
3. msg 文本为 SJIS 字节,控制台直显乱码属正常,文件内容完整。

## 核验
- 各目录文件数/大小如上;0 空文件;0 非零退出码;源目录零写入。
