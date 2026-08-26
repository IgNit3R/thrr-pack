# std_txt — eiya(th08) 关卡配置转换产物

- 源:`release\tsa\eiya\dat\th08\*.std`(18 个:stage1–8 主线 + stageN_s 子关,只读)
- 工具:`tools\thtk\thtk-bin-12\thstd.exe -d 8 <std> <out>`
- 结果:**13/18 转换成功**;5 个失败为工具崩溃(见下)

## 降级记录(thstd 崩溃,按分析文档口径不重试)
| 文件 | 现象 | 处置 |
|---|---|---|
| stage4a.std / stage4a_s.std / stage4b.std / stage4b_s.std | thstd 崩溃 0xC0000005(访问冲突),0 字节产物已删除 | 未转换,保留源文件于 dat\th08\ |
| stage5.std | 同上,但留下 4096B 部分产物(头字段可读:Stage/Song1-4/Path1-4) | 保留 `stage5.txt` 部分产物并标注 |

**完整结构分析见 `STRUCTURE.md`**(受影响文件清单+头布局 hex+崩溃点定位:stage5 崩于 ENTRY 段解析、
stage4a/4b 更早;与 th09 world*.std 崩溃疑似同源 thstd v12 解析 bug)。
转换驱动:`release\_progress\t76_convert.py`
