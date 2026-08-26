# release\tsa\youmu 转换产物(anm/ecl/msg/std/end)— t75

- 任务:t75 | 执行:extractor-b2 | 日期:2026-08-24
- 源(只读):`release\tsa\youmu\dat\th07\`(th07.dat 拆包产物,63 anm / 8 ecl / 8 msg*.dat / 8 std / 10 end)
- 工具:thtk-bin-12(thanm/thecl/thmsg/thstd);**全程未执行任何游戏程序,源目录零写入**
- 依据:release\_progress\PENDING-anm_ecl_end_analysis.md

## 产物目录
| 目录 | 内容 | 数量 |
|---|---|---|
| `anm_png\<anm基名>\` | thanm -x 输出,**每 anm 一子目录**(新规范,防内部 sprite 重名覆盖) | 63 子目录 / 98 文件 / 12.78 MB |
| `ecl_txt\` | thecl -d 7 伪代码(8 个 ecldataN.ecl) | 8 文件 |
| `msg_txt\` | thmsg -d 7 对话脚本(8 个 msgN.dat) | 8 文件 |
| `std_txt\` | thstd -d 7 舞台脚本(8 个 stageN.std) | 8 文件 |
| `end_txt\` | end 文本脚本 10 个 + dependencies.txt 依赖清单 | 11 文件 |

## 方法与要点
1. **anm**(新规范,2026-08-24 更新):`cd anm_png\<anm基名>` 后逐个 `thanm -x <绝对路径>`(输出跟随 CWD),**每 anm 独立子目录**。th07 平铺检测到 3 组跨 anm 路径碰撞(face_02_00/face_07_00 → data/face/st02/face_02_00.png;face_05_00/face_06_00 → face_05_01.png;face_07_00/face_08_00 → face_07_01.png),内容字节级一致(同一 sprite 多 anm 引用),但按新规范仍改子目录重提,消除歧义。63/63 rc=0,98 文件;`capture`/`text` 两个 anm 无 sprite 输出(纯动画定义型),子目录为空属正常。
2. **ecl/msg/std**:工具 `-d 7`(作品号 7)+ `[out]` 参数直接写文件(CP932 原始字节),后统一转 UTF-8 并清理 NUL。注意:th07 对话数据扩展名为 **msgN.dat**(非 .msg),thmsg 按内容解析正常。
3. **end**:纯文本脚本(CP932),含 `@mbgm/<mid>`(音乐)、`@bdata/end/<jpg>`(图片)、`@Fdata/staff00.end`(引用)等 @ 指令;已转 UTF-8 并生成 dependencies.txt 依赖清单(引用大小写保持源格式:Fdata/bdata/mbgm)。【修复记录】end_txt 曾因修复脚本双重编码(UTF-8→按 CP932 解码)产生乱码,已从源 .end 一次性 CP932→UTF-8 重转,10/10 验证 CJK 正常。
4. **thmsg `-e` 检查(队长提醒)**:th07 无 e 开头 .msg 文件(结局对话在 .end);msg1-8.dat 均为普通对话(普通 `-d` 输出 3400-12663B 完整,`-e` 仅 13B 指令壳)——**无需 `-e` 重 dump**。

## end 依赖清单摘要
- 音乐:staff00.end 用 `th07_15.mid`;其余 9 个 end 用 `th07_14.mid`
- 图片:各 end 引用 `bdata/end/endXX.jpg`(end00b→end00b.jpg 等);staff00→staff00.jpg
- 引用:全部 10 个 end 引用 `Fdata/staff00.end`
- 全部依赖文件已在 dat 拆包产物中(31 jpg / 21 mid)

## 验证
- anm 63/63 rc=0;98 文件(每 anm 一子目录),内部碰撞 0;PNG 魔数全合法
- 碰撞组复检:face_02_00/face_07_00/face_05_00/face_06_00/face_08_00 各自独立子目录,内容完整
- ecl/msg/std/end 文本 UTF-8 可读(日文对话/伪代码/舞台脚本正常)
- 源目录零写入;进度 release\_progress\t75.md [DONE]
