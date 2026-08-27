# 转换任务 MANIFEST — th165(Violet Detector)anm/ecl/msg/std

- 任务:t89 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` + `release\_CONVENTIONS.md`
- 源(只读):`release\tsa\th165\dat\`(t20 拆包产物,79 anm / 134 ecl / 11 msg / 18 std)
- 工具:`tools\thtk\thtk-bin-12\{thanm,thecl,thmsg,thstd}.exe`(thtk release 12)
- 版本号:165(全工具支持列表确认)
- 源目录 `tsa\th165\` 零写入(仅读;th165.dat mtime 未变)

## 产物

| 目录 | 转换 | 结果 | 说明 |
|---|---|---|---|
| `anm_png\` | thanm -x | 79/79 成功,310 个 PNG,43.7 MB | 分组子目录 |
| `ecl_txt\` | thecl -d 165 | 134/134 成功,371.4 KB | 可读伪代码;命名 ec_XXXX(天关+符卡编号)+ default |
| `msg_txt\` | thmsg -d 165 | 11/11 成功,20.3 KB | 对话脚本(SJIS 文本串);命名 msg01..msg22d |
| `std_txt\` | thstd -d 165 | 18/18 成功,64.4 KB | 舞台脚本;命名 day01..day18(每日关卡) |

总计:242 个源文件全部转换成功,0 失败,0 空输出。

## 逐文件日志
- `release\_progress\t89_anm.log`(79 行)/ `t89_ecl.log`(134 行)/ `t89_msg.log`(11 行)/ `t89_std.log`(18 行),每行 `[<file>] exit=0`

## 说明
1. thanm 输出跟随 CWD,已按规范先 cd 到 anm_png\ 再执行;
2. th165 无 .end 文件(非 MIDI 时代,符合 PENDING 文档);
3. msg 文本为 SJIS 字节,控制台直显乱码属正常,文件内容完整;
4. 外传结构:ecl=每日符卡战脚本(ec_0101..ec_XXXX),std=每日关卡舞台(day01..day18)。

## 核验
- 各目录文件数/大小如上;0 空文件;0 非零退出码;源目录零写入。
