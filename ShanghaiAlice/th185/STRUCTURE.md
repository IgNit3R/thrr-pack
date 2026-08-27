# STRUCTURE — release\tsa\th185 转换降级结构分析(anm/ecl/msg/std)

- 任务:t92 | 执行:extractor-b2 | 日期:2026-08-24
- 依据:release\_progress\PENDING-anm_ecl_end_analysis.md「th18+ 降级口径」(工具不支持/崩溃即停 → STRUCTURE.md)
- 源(只读):`release\tsa\th185\dat\`(55 anm / 114 ecl / 4 msg / 9 std,brightmoon Kanako 拆包产物)

## 工具可用性实测(thtk-bin-12)
| 工具 | th185 行为 | 处置 |
|---|---|---|
| thanm | **49/55 可转换**,6 个崩溃(0xC0000005):boss03/boss12/boss21/notice/title/world02 | 可转的已落盘 anm_png\<基名>\,崩溃的列入 _CRASHED.txt |
| thecl | `version 185 is unsupported`(exit 1) | 降级:SCPT 结构分析 |
| thmsg | `version 185 is unsupported`(exit 1) | 降级:结构分析 |
| thstd | `version 185 is unsupported`(exit 1) | 降级:结构分析 |

## 一、ANM 结构(样本 ascii.anm / boss01.anm)
```
[0x00] u32 magic = 8            (0x00000008,Kanako 系 ANM 格式标识)
[0x04] u32 资源引用/尺寸字段     (ascii=917824,boss01=196609=0x30001)
[0x08] u32 = 0x01000000        (恒定)
[0x0C] u32 = 0x00050100        (格式版本/子类型)
[0x10] u32 字符串表偏移或计数    (ascii=1456,boss01=92)
[0x18] u32 sprite/条目计数      (ascii=11,boss01=0)
[0x1C] u32 脚本数据偏移          (ascii=14588,boss01=504)
[0x20] u32 = 1                 (恒定?)
[0x40+] u32 偏移表(条目指针,ascii 中 1472/1492/1512/... 步进 20B)
```
- 资源路径字符串明文嵌入(如 `ascii/ascii.png`、`stgenm/en01/cardbg0.png`、`stgenm/en01/enm1.png`),非加密。
- 崩溃 6 个 anm 疑含 thanm 不认识的子格式/大尺寸纹理(title.anm 22.4MB);结构上无异常魔数(均为 magic=8),判定为 thanm 版本边界问题。

## 二、ECL 结构(样本 boss01.ecl / world01.ecl)— SCPT v1 明文格式
```
[0x00] char[4] magic "SCPT"
[0x04] u8      version = 1
[0x05] 变长    表区,含以下命名段(明文 ASCII):
  "ANIM" + u32 count + count 个 NUL 结尾 anm 名  (如 enemy.anm, boss01.anm)
  "ECLI" + u32 count + count 个 NUL 结尾 ecl 名  (如 default.ecl, wave01.ecl)
  "ECLH" → 脚本块头,后跟标签名(Boss01 Start, Goutokuzi Mike, BossEscape, ...)
```
- **全明文、无加密/压缩**:标签名、Boss 名、引用资源可直接读取。
- 脚本指令主体为结构化二进制(指令码+参数),未逐指令解码(降级边界)。
- 114 个 ecl 的 ANIM/ECLI 引用与标签已提取至 `ecl_txt\ecl_index.tsv`。

## 三、MSG 结构(样本 world04.msg,2384B)— 结构化二进制,无明文
```
[0x00] u32 count/版本 = 2
[0x04] u32 = 20
[0x08] u32 = 256
[0x0C] u32 = 1428
[0x10] u32 = 256
...    (后续为对话数据区,无 ASCII 字符串,疑为压缩/编码文本)
```
- 与早期作的 thmsg 格式不同(Kanako 系新布局);对话文本未明文暴露,需 RE 或工具支持。

## 四、STD 结构(样本 world01.std,1844B)
```
[0x00] u32 = 4 / 0x0A / 0x238 / 0x3C8  (头部参数)
[0x10] char[16] 引用 anm 名 "world01.anm" (NUL 填充)
[0x??] 数据区:浮点/整数参数对(尾部可见 0x00006044 等 float 字段)
```
- 头含舞台背景 anm 引用(world01.anm),后接结构化脚本参数;无明文指令文本。

## 五、交付清单
- `anm_png\<anm基名>\`:49 个 anm 转换产物(468 文件:467 PNG + _CRASHED.txt),每 anm 一子目录(新规范),内部碰撞 0,PNG 魔数全合法
- `anm_png\_CRASHED.txt`:6 个崩溃 anm 清单(boss03/boss12/boss21/notice/title/world02)
- `ecl_txt\ecl_index.tsv`:114 个 ecl 的 ANIM/ECLI 引用与标签索引(SCPT 明文解析)
- 本 STRUCTURE.md

## 六、建议(供后续)
- 崩溃 6 anm:可对比 th18/th19/th20 同源文件确认是否全作崩溃(格式边界共性)。
- ecl 若需完整反编译:SCPT v1 指令集需专项 RE(thtk thecl 无 v185 模块)。
- msg 对话提取:需 Kanako msg 格式 RE 或 thtk 更新。
