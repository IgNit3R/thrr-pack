# 转换任务 MANIFEST — th125(DS文花帖)anm/ecl/msg/std

- 任务:t82 | 执行:pe-analyst2 | 日期:2026-08-24
- 依据:`release\_progress\PENDING-anm_ecl_end_analysis.md` + `release\_CONVENTIONS.md`
- 源(只读):`release\tsa\th125\dat\`(t13 拆包产物,58 anm / 109 ecl / 2 msg / 14 std)
- 工具:`tools\thtk\thtk-bin-12\{thanm,thecl,thmsg,thstd}.exe`(thtk release 12)
- 版本号:125(全工具支持列表确认)
- 源目录 `tsa\th125\` 零写入(仅读;th125.dat/thbgm.dat mtime 未变)

## 产物

| 目录 | 转换 | 结果 | 说明 |
|---|---|---|---|
| `anm_png\` | thanm -x | 58/58 成功,234 个 PNG,20.6 MB | 10 分组子目录:ascii/background/bullet/enemy/enm/face/front/loading/player/title |
| `ecl_txt\` | thecl -d 125 | 109/109 成功,706.7 KB | 可读伪代码;命名 ecl1_a..ecl36 等(按天/难度变体)+ default |
| `msg_txt\` | thmsg -d 125 | 2/2 成功,42.1 KB | 对话脚本(SJIS 文本串);**mission.msg 需 -e 选项**(TH125 特例,README 已注明) |
| `std_txt\` | thstd -d 125 | 14/14 成功,69.8 KB | 舞台脚本;命名 world01..world14 |

总计:183 个源文件全部转换成功,0 失败,0 空输出。

## 逐文件日志
- `release\_progress\t82_anm.log`(58 行)/ `t82_ecl.log`(109 行)/ `t82_msg.log`(2 行)/ `t82_std.log`(14 行),每行 `[<file>] exit=0`

## 说明与发现
1. **mission.msg 必须加 `-e`**:thmsg README 明确「for the mission.msg file in TH125」;不带 -e 退出码 1,加 -e 后 exit=0 输出正常;
2. thanm 输出跟随 CWD,已按规范先 cd 到 anm_png\ 再执行;
3. ecl 命名 eclN_X(天关编号+难度变体),std 命名 worldNN(关卡舞台),均为外传结构;
4. msg 文本为 SJIS 字节,控制台直显乱码属正常,文件内容完整;
5. 无 .end 文件(th125 非 MIDI 时代,符合 PENDING 文档)。

## 核验
- 各目录文件数/大小如上;0 空文件;0 非零退出码(mission.msg 初次失败已用 -e 修正并复验 exit=0);源目录零写入。
