# kouma(th06) 转换产物说明 — t74

来源: `release\tsa\kouma\dat\` 拆包产物(t5),转换自 `tsa\kouma` 原始 dat 档案内文件。

## 产物总览

| 目录 | 数量 | 内容 | 工具 |
|---|---|---|---|
| anm_png\ | 83 目录/147 png | th06 anm 引用的图像(按 anm 分组) + anm_index.csv + STRUCTURE.md | 自研解析(见下) |
| ecl_txt\ | 7 | ecldata1-7.txt 可读伪代码(弹幕/敌机脚本) | thecl -d 6 |
| msg_txt\ | 7 | msg1-7.txt 对话文本(CP932) | thmsg -d 6 |
| std_txt\ | 7 | stage1-7.txt 关卡配置(Stage/Song/MIDI 路径) | thstd -d 6 |
| end_txt\ | 7 | end00-11/staff00 结局脚本 + README(依赖清单) | 文本转存 |

## anm 重要说明(th06 特例)

- **th06 的 anm 是 VERSION 0 最老格式,不含内嵌纹理**——83 个 anm 全部为动画指令脚本(2-6KB)
- anm 通过 `data/<name>.png` 引用**外部 PNG**,图像文件在 dat 包内独立存在(142 个,0 缺失)
- 预编译 thanm.exe(thtk v12)对 VERSION 0 静默失败,无法编译新源码(环境限制),故按引用关系自研转换:
  每个 anm → anm_png\<anm名>\ 下复制其引用的 png;anm_index.csv 记录引用清单
- 详见 `anm_png\STRUCTURE.md`

## 编码

- msg/std/ecl 输出为 CP932(thtk 工具保留日文原样),end 转存为 UTF-8
- 直接读取日文文本请用 CP932 解码

## 备注

- kouma 对话文件为 `msgN.dat` 命名(th06 特例,非 .msg 扩展名),已按 msg 处理
- 源目录 `tsa\kouma` 零写入;所有输出均在 release 侧
