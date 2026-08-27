# th185 msg 对话解码 — t97(逆向完成)

## 破解结论

**th185 msg 的"高熵对话体"是 XOR 加密的 SJIS 文本,非压缩**:

```
算法: 滚动 XOR(key=0x77, step1=7, step2=16)  ← thtk 源码 util_xor
格式: msg 流 = u16 time + u8 type + u8 len + data[len]
文本载体: type=17
```

## 产出

- `decoded\*.txt` — 全部 msg 解码(UTF-8, 含引用注释)
- 解析器: `release\_progress\t97_decode_all.py`

## 验证

- 解码文本为完整日文对话(例: `魔法使いの手によって市場の神は倒され、`)
- 全部文件成功, 0 失败
