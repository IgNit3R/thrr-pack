# -*- coding: utf-8 -*-
"""二进制 pat -> 文本 (th135/145/155 v12/v16 动画脚本)
结构: version(1B) + 头部 + 帧列表 [len(4B) + 帧名 + 参数数字...]
输出: 帧名序列 + 可读字符串, 供人工阅读
"""
import pathlib, struct, re, sys

def analyze(path):
    b = path.read_bytes()
    ver = b[0] if b else -1
    # 提取帧名引用(bmp/png)
    names = re.findall(rb'[\x20-\x7e]{3,63}\.(?:bmp|png|dds)', b, re.I)
    names = [n.decode('ascii', 'replace') for n in names]
    # 帧名前的 len 字段(4B)
    frames = []
    for m in re.finditer(rb'([\x00-\xff]{4})([\x20-\x7e]{3,63}\.(?:bmp|png|dds))', b, re.I):
        ln = struct.unpack_from('<I', m.group(1))[0]
        if ln == len(m.group(2)):
            frames.append(m.group(2).decode('ascii', 'replace'))
    lines = []
    lines.append(f'# pat 动画脚本: {path.name} ({len(b)}B)')
    lines.append(f'# version: {ver}')
    lines.append(f'# 帧名引用: {len(names)}')
    lines.append(f'# 有序帧: {len(frames)}')
    for i, f in enumerate(frames):
        lines.append(f'  [{i:3d}] {f}')
    # 未匹配到帧名的原始字符串
    if not frames:
        lines.append('# (未解析出帧序列, 原始可读字符串:)')
        for n in names:
            lines.append(f'  {n}')
    return '\n'.join(lines)

def main():
    base = pathlib.Path(r'E:\GitWorkspace\thworks')
    out_root = base / 'release/tf/_converted/pat_txt'
    games = [
        ('th135', r'release\tf\th135\dat\th135\data'),
        ('th145', r'release\tf\th145\dat\th145\data'),
        ('th155', r'release\tf\th155\dat\th155\data'),
    ]
    total = 0
    for g, rel in games:
        data = base / rel
        pats = sorted(data.rglob('*.pat'))
        # 只处理二进制(非 JSON)
        gdir = out_root / g
        n = 0
        for p in pats:
            if p.read_bytes()[:1] == b'{':
                continue  # JSON pat 另处理
            txt = analyze(p)
            relp = p.relative_to(data)
            dst = gdir / relp.with_suffix('.pat.txt')
            dst.parent.mkdir(parents=True, exist_ok=True)
            dst.write_text(txt, encoding='utf-8')
            n += 1
            total += 1
        print(f'{g}: 二进制pat={n}')
    print(f'合计: {total} -> {out_root}')

if __name__ == '__main__':
    main()
