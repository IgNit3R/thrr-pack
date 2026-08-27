# STRUCTURE — th20(錦上京)MSG 结构分析(降级)

- 任务:t94 | 执行:extractor-c2 | 日期:2026-08-24
- 背景:`thmsg -d 20` 实测返回 "version 20 is unsupported"(rc=1,graceful);87 个 .msg(结局 e* 系 18 个 +
  关卡 stXXm/stXXr 系 69 个)无法工具转换,按降级口径产出结构分析。
- 样例:e00a0.msg(3,108B,结局对话)、st01m0.msg(关卡对话)
- hex 侧车:本目录 `*.msg.hex`(512B)

## 1. 文件头与引用(e00a0.msg 实测)

```
偏移      大小    内容
0x00      u32     = 1
0x04      u32     = 0x0C(12)
0x08      u32     = 0x100(256)
0x0C      u32     = 0x10070000
0x10      char[]  "e00a0.anm"      ← 对话场景引用的 ANM(结局演出画面)
0x1C      u8[?]   场景参数区(0x0C 0x00 0x00 0x00…)
0x2C      char[]  "bgm/th20_15"    ← 引用的 BGM(无扩展名)
0x38      u8[]    颜色区:c0 c0 d0 ff / 50 50 50 ff(RGBA 调色/文字色?)
0x4C+     u8[]    高熵数据(疑似压缩对话文本,非明文)
```

## 2. 与 th10+ msg 的对比

- 经典 msg(th10–th17)为 `entry N / @time / 文本行` 明文结构;th20 msg **文本区为高熵字节
  (LZSS/自定义压缩),无法直接读明文**;
- 头部的 anm/bgm 引用为可识别字段(结局 e* 系引用同名 e*.anm + 对应 BGM;关卡 st* 系引用对应舞台 anm);
- 命名规律:87 个 msg = `eXXaY.msg`(结局对话,18 个)+ `stXXm0-3.msg`(中盘对话?)/`stXXr0-3.msg`(关卡结尾对话?,69 个)。

## 3. 结论

- th20 msg = 头部(计数/尺寸)+ 场景 anm 引用 + BGM 引用 + 颜色参数 + **压缩对话体**;
- 引用表可直接提取(anm/bgm 依赖清单),对话文本需先破压缩(算法未知);
- **建议**:等 thtk 更新;或先从 th20 exe 字符串定位压缩例程(与 ecl/anm 同族新引擎)。
