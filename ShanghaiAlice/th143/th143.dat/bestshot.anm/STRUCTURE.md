# STRUCTURE — bestshot.anm(th143,弹幕天邪鬼)降级结构说明

任务 t86 · extractor-f2 · 源:`release\tsa\th143\dat\bestshot.anm`(15,140 B,只读)

## 状态

`thanm -x` 与 `thanm -l` 均崩溃(exit 0xC0000005,访问违例)——与 PENDING 分析文档记载的 thanm
崩溃签名一致。按规范**不重试、不硬刚**,改产出本 STRUCTURE.md(hex 布局+条目表+可识别字段)。
th143 其余 56/56 个 anm 全部提取成功(见 anm_png\MANIFEST.md),bestshot 是唯一异常件。

## hex 布局

```
0x00  u32  version = 8               (th13+ 时代条目版本;同作 title.anm 亦为 8)
0x04  u32  0x00520020                 (疑似 (副字段<<16)|count:0x0020=32)
0x08  u32  0
0x0C  u32  0x00010000
0x10  u32  0x350 = 848                → 指向条目表(见下)
0x14  u32  0
0x18  u32  0
0x1C..0x5F  全 0                     (16 个 u32 零区)
0x60  条目偏移表:0x360,0x374,0x388,0x39C,0x3B0,0x3C4,0x3D8,0x3EC,…
      步长 0x14(20B),至少 8 条 → 每条为 20B 定长记录(疑似 sprite 定义)
```

## 条目表(0x350 起,20B/条,至少 8 条)

| 条目 | 偏移 | 内容(hex) |
|---|---|---|
| 0 | 0x360 | 见文件 0x350 处 8×u32 偏移表,指向 0x360 起的连续 20B 记录 |
| 1 | 0x374 | … |
| … | … | 步长 0x14 连续排列,至 EOF 附近(15,140 B) |

## 可识别字段

- 无 ASCII 字符串(≥4 字符);无 "THTX" 标记 → **不含常规精灵图数据**
  (同作正常 anm 均含 THTX 与条目名,如 title.anm 28 MB 含大量精灵);
- 条目名 offset 缺失(nameoffset 语义字段为 0)→ thanm 在 anm_get_name 处访问违例(崩溃原因推测);
- 该文件为 th143 最小 anm(15,140 B),推测为「bestshot 最佳拍照」功能的**纯脚本/占位容器**,
  实际精灵在运行期由游戏从其他资源引用。

## 结论

bestshot.anm 数据完好(与源 dat 内条目逐字节一致),仅 thanm 无法解析;内容判定为无精灵图的
脚本/占位 anm。如需进一步解码,须逆向 th143.exe 对该容器的加载路径。
