# th09(花映塚) 格式转换 README — t77

- 任务:t77 | 执行:extractor-d2 | 日期:2026-08-24
- 源(只读):`release\tsa\th09\dat\th09\`(t8 拆包产物);工具:`tools\thtk\thtk-bin-12\`
- 源目录零写入;工具输出全部落 release 侧

## 产物目录
| 目录 | 数量 | 内容/方法 |
|---|---|---|
| `anm_png\` | 865 PNG | 59 个 .anm × `thanm.exe -x`;**每 anm 一子目录 `anm_png\<anm基名>\`**(2026-08-24 规范更新);全部合法 PNG 头 |
| `ecl_txt\` | 17 txt | 17 个 .ecl × `thecl.exe -d 9`(可读伪代码) |
| `msg_txt\` | 30 txt | 30 个 .msg × `thmsg.exe -d 9`(pl00..pl15 + 各 _match 对战版;CP932 文本) |
| `std_txt\` | 3 txt + _partial\3 + STRUCTURE.md | 见下方 std 说明 |
| `end_txt\` | 15 txt + deps.csv | 15 个 .end 纯文本转存(CP932→UTF-8,NUL 分隔 token 逐行)+ 依赖清单 |

## anm 输出规范(2026-08-24 更新,碰撞修正)
- 初版平铺输出(855 PNG)经子目录结构重提后恢复为 **865 PNG**:检测出 10 处跨 anm 内部路径碰撞(pl07/07b 等 5 组 b 变体 + result00/title01)。
- 9 处碰撞对内容逐字节相同(pl0X vs pl0Xb 的 eff02/cdbg 图,覆盖无损失);**1 处内容不同:result02.png(result00 版 31,096B vs title01 版 30,686B)——平铺时真实丢失一个版本**,子目录结构已完整保留。
- 现行结构:`anm_png\<anm基名>\<anm 内部路径>`,无任何覆盖。
- 说明:capture/resulttext/text 三个 anm 无 PNG 输出(不含图像条目,正常)。

## std 转换情况(重点)
- th09 的 .std 全部为 `world*.std`(15 个,对战舞台背景脚本)。
- thtk v12 `thstd.exe -d 9` 对多数文件 **dump 崩溃(0xC0000005 访问冲突)**:仅 3 个完整输出(world07/world09m/world12),3 个截断(world03/04/09,移至 `_partial\`),9 个无输出。
- 头部前 16B 与 thtk `std_header_06_t` 前段吻合(nb_objects/nb_faces/faces_offset/script_offset/unknown),但 offset 0x10 起的 128B×9 字符串区实测为 `64 6D 00 00`('dm') 等,与 thtk 预期的 stage_name/song 名布局不符 → 疑为解析越界崩溃根因。
- 按团队口径(工具崩溃即停)不重试、不硬刚;已产出 `std_txt\STRUCTURE.md`(头部结构 + 15 文件字段表 + 状态)。完整解码需自研解析器,建议 W8 登记。

## end 格式(.end)
纯文本脚本,NUL 分隔 token 流,每 token 一行。指令:
- `@m<id>` / `@M<id>`:BGM;`@s<id>`:音效;`@bdata/end/<name>.jpg`:背景图;`@c<color>`:文字色;`@w<ms>`:等待;`@F<path>`:跳转其他 end;`@z`:结束;其余为台词文本(CP932)。
- 依赖清单:`end_txt\deps.csv`(media_paths/music_refs 列)。

## 方法备注
- thanm 输出跟随 CWD,已固定 CWD=anm_png\ 防源目录副作用。
- msg/ecl/std 均显式指定输出路径到 release 侧。
- 版本号统一用 9(th09 作品号)。
