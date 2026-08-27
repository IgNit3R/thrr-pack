# th18 msg 对话解码 — t97(逆向完成)

## 破解结论

**th18 msg 的"高熵对话体"是 XOR 加密的 SJIS 文本,非压缩**:

```
算法: 滚动 XOR(key=0x77, step1=7, step2=16)  ← thtk 源码 util_xor
格式: msg 流 = u16 time + u8 type + u8 len + data[len]
文本载体: type=3(每条 16 字节数据块)
```

解密: 对 type 3 的 data 逐字节 `data[i] ^= key; key += 7; step1 += 16`(8bit 回绕) → 得 SJIS 明文对话。

## 头部结构

```
0x00  u32 entry_count(子块数)
0x04  u32[2×entry_count] 子块偏移表(偏移+参数)
之后  资源引用区: anm 引用("e01.anm")、bgm 引用("bgm/th18_15" 无扩展名)、颜色参数(RGBA)
之后  msg 流(自偏移 0x44 起典型值, 经引用区后)
```

## 指令 type 语义(实测归纳)

| type | 内容 | 说明 |
|---|---|---|
| 3 | 16B XOR 文本 | **对话正文** |
| 5 | 4B | 显示时长 |
| 6 | 4B | 显示时长(变体) |
| 8 | 12B | 位置/布局参数 |
| 9 | 4B | 颜色(RGBA) |
| 10 | 12B | BGM 引用字符串 |
| 12 | 12B | 子 msg 引用(staff.msg 等) |
| 14 | 4B | 未知 |

## 产出

- `decoded\*.txt` — 44 个 msg 全部解码(UTF-8, 403 行对话文本, 含引用注释)
- 解析器: `release\_progress\t97_decode_all.py`

## 验证

- 解码文本为完整日文对话(例: `　　「博麗神社。」`、`魅須丸「……陰陽玉ですね」`)
- 44/44 文件全部成功, 0 失败
