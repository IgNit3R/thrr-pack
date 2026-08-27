# STRUCTURE — th19(兽王园)std 格式降级结构分析

任务 t93 · extractor-f2 · 源:`release\tsa\th19\dat\*.std`(17 个,只读)

## 降级背景

`thstd -d 19` → "version 19 is unsupported"(exit 1,干净报错,非崩溃)。按降级口径做结构分析。

## 样本分析

### world01.std(1,844 B)

```
0x00  u16  4                    (版本/子版本?)
0x02  u16  10                   (子块数/参数计数?)
0x04  u32  0x238 = 568          (数据偏移?)
0x08  u32  0x3C8 = 968          (数据长度?)
0x0C  全 0
0x14  "world01.anm"             (引用的舞台 anm 名,后随 0 填充)
```

## 结论

th19 std = 引用型关卡脚本容器(头部计数 + 引用舞台 anm 名),与 th13+ 时代 std 结构同族,
版本号超出 thtk 工具表 → 需扩展 thstd 或自研解析。

## 说明

- thstd 未崩溃(干净 unsupported 报错);数据完好(与源 dat 条目逐字节一致)。
