# th075(東方萃夢想 / IaMP)档案格式结构报告

任务 t26 · extractor-e · 拆包对象: `tf\th075\{th075,th075b,th075c,th075bgm}.dat`(全部只读)

## 1. 外层容器 —— "Suica" 格式(brightmoon 内部代号;文件名推断为 "Kanako" 不适用)

四个档案同属一种格式。方法:brightmoon `-l` 探测 + 自研 Python 解析器复验
(解析器交付件:`dat\th075_suica_parser.py`;探测中顺带确认其上游实现为
github.com/shiroemons/go-brightmoon `pkg/pbgarc/suica.go`,与逆向结果一致)。

```
[u16 entry_count]                     LE
[entry_count × 0x6C (108) 字节条目表]  整表经滚动 XOR 流混淆:
                                        k = 0x64, t = 0x64
                                        逐字节: plain ^= k; k += t; t += 0x4D (mod 256)
每条记录:
  +0x00  name[100]   NUL 结尾/填充,CP932 路径(如 data\system\title.dat)
  +0x64  u32 size    原始大小(=压缩大小,Suica 不压缩)
  +0x68  u32 offset 文件内绝对偏移
数据区紧跟条目表之后(offset == 108*n + 2),各条目连续无缝、原样存储。
```

实测(自研解析器输出,brightmoon 列表一致):

| 档案 | 条目 | 表尾=数据起点 | 数据字节 |
|---|---|---|---|
| th075.dat (749,862,735 B) | 215 | 23,222 | 749,839,513 |
| th075b.dat (149,693,705 B) | 37 | 3,998 | 149,689,707 |
| th075c.dat (349,795,026 B) | 122 | 13,178 | 349,781,848 |
| th075bgm.dat (428,003,126 B) | 34 | 3,674 | 427,999,452 |

注:表头首两字节即 count 的 LE 表示(如 th075 首字节 0xD7=215),故裸看十六进制时
"首字节=条目数" 是该格式最易识别的特征。

## 2. 内层格式(th075 引擎自有子格式,brightmoon 不识别)

### 2.1 音效库 wave\se*.dat —— ✅ 完全破解并已提取
见 `dat\th075_wave_extracted\MANIFEST.md` 与 `dat\th075_se_extractor.py`。
`[u16 槽位基址][若干块: [u16 xid][u8 01][u32 pcm_size][16B WAVE fmt][PCM]]`+零填充尾部。
产出 232 个可播放 WAV(44.1kHz/16bit 为主)。

### 2.2 图像档(data\system|background|character\*.dat)—— 结构已判明,像素编码未解
- 文件以图像头开始:`[00][u32 width][u32 height][u32 stride]`(stride≥width 且通常 4 对齐)
- 单文件可含多幅图像(title.dat 多头;battle.dat 4 头;character\00.dat 观测到 ~125 个
  128×128 精灵头,间隔约 3.5KB ≪ 原始尺寸 → 像素数据经过压缩,RLE 类,具体算法未逆)
- 样本判定:window.dat 571×78(stride 572)、BG00a.dat 1400×900、battle.dat 首图 1024×256
- 未解压像素:无调色板信息随档可见,需进一步逆向 th075.exe 渲染路径才能成图

### 2.3 未解格式(已知限制,供终版报告引用)

> **结论**:以下内层格式本期不做引擎级解密,不另开任务;原始文件已 100% 原样保留在
> 提取产物中,满足「拆出资源」要求。若未来需要可读内容,须逆向 th075.exe 的密钥流程。

- `*.sce`(角色剧本)、`*.pat`(动作/模式)、`cardlist.dat`(符卡表)、`musicroom.dat`
  ——均为高熵数据;已排除单字节 XOR 与 Suica 滚动流两种简单方案,判定使用引擎密钥流
  或更复杂变换,**需逆向 th075.exe 的密钥初始化/解密流程方可解密**。
- 图像像素编码(§2.2):图像头 `[00][u32 width][u32 height][u32 stride]` 已判明,
  但像素数据经压缩且无随档调色板,**同样需逆向 th075.exe 渲染路径才能成图**。
- 现状:上述文件均以原始字节完整落盘于 `th075\`、`th075b\`、`th075c\` 产物目录,
  条目表(entries.csv)可精确定位其 offset/size,后续解密工作可直接在产物上进行,
  无需再触碰源档案。

## 3. 提取产物汇总(release\tf\th075\dat\)

| 目录 | 内容 | 数量 | 大小 |
|---|---|---|---|
| th075\ | th075.dat 全条目 | 215 文件 | 715.10 MB |
| th075b\ | th075b.dat 全条目 | 37 文件 | 142.76 MB |
| th075c\ | th075c.dat 全条目 | 122 文件 | 333.58 MB |
| th075bgm\ | th075bgm.dat 全条目(BGM PCM,合法 WAV) | 34 文件 | 408.17 MB |
| th075_wave_extracted\ | SE 二次解析 WAV | 232 文件 | 46.09 MB |

合计 640 文件 ≈ 1.65 GB。源目录零写入。
