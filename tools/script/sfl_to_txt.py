# -*- coding: utf-8 -*-
"""sfl -> 文本转换 (th135/145/155 bgm)
sfl = mini-RIFF 'SFPL': cue(chunk) 起点 + LIST-adtl ltxt 长度 + 可选 labl Region 文本
输出: 同名 .sfl.txt 含 循环起点/终点/时长(秒) + Region 文本 + 原始 hex
"""
import pathlib, struct, re, sys

def parse_sfl(b):
    """返回 dict: cue_pos, ltxt_len, labl_texts"""
    out = {'cue': None, 'ltxt': None, 'labl': []}
    off = 12
    while off + 8 <= len(b):
        cid = b[off:off+4]
        ln = struct.unpack('<I', b[off+4:off+8])[0]
        pl = b[off+8:off+8+ln]
        if cid == b'cue ' and len(pl) >= 28:
            n = struct.unpack('<I', pl[:4])[0]
            if n >= 1:
                _n, pos, _f, _c, _b, s = struct.unpack('<II4sIII', pl[4:28])
                out['cue'] = pos
        elif cid == b'LIST' and pl[:4] == b'adtl':
            j = 4
            while j + 8 <= len(pl):
                sub = pl[j:j+4]; sln = struct.unpack('<I', pl[j+4:j+8])[0]
                sp = pl[j+8:j+8+sln]
                if sub == b'labl':
                    out['labl'].append(sp[4:].decode('ascii', 'replace'))
                elif sub == b'ltxt' and sln >= 12:
                    out['ltxt'] = struct.unpack('<I', sp[4:8])[0]
                j += 8+sln+(sln&1)
        off += 8+ln+(ln&1)
    return out

def convert(path):
    b = path.read_bytes()
    d = parse_sfl(b)
    rate = 44100
    lines = []
    lines.append(f'# sfl 循环点文件: {path.name}')
    lines.append(f'# 文件大小: {len(b)}B')
    if d['cue'] is not None:
        lines.append(f'循环起点: {d["cue"]} 样本 = {d["cue"]/rate:.6f} 秒')
    if d['ltxt'] is not None:
        lines.append(f'循环长度: {d["ltxt"]} 样本 = {d["ltxt"]/rate:.6f} 秒')
    if d['cue'] is not None and d['ltxt'] is not None:
        end = d['cue'] + d['ltxt']
        lines.append(f'循环终点: {end} 样本 = {end/rate:.6f} 秒')
    for i, t in enumerate(d['labl']):
        lines.append(f'Region 文本[{i}]: {t}')
    lines.append(f'# 原始 hex: {b.hex()}')
    return '\n'.join(lines)

def main():
    base = pathlib.Path(r'E:\GitWorkspace\thworks')
    out_root = base / 'release/tf/_converted/sfl_txt'
    total = 0
    # 主转换源: 产物平铺到 sfl_txt/{game}/{stem}.sfl.txt
    # 补丁包: 产物按包分目录 sfl_txt/{game}/{pack}/{stem}.sfl.txt(与主包同名但内容不同, 避免覆盖)
    games = [
        ('th135', r'release\tf\th135\dat\th135\data\bgm', None),
        ('th145', r'release\tf\th145\dat\th145\data\bgm', None),
        ('th155', r'release\tf\th155\dat\th155\data\bgm', None),
        ('th105', r'release\tf\th105\dat\th105b\data\bgm', None),
        ('th123', r'release\tf\th123\dat\th123b\data\bgm', None),
        ('th135', r'release\tf\th135\dat\th135b\data\bgm', 'th135b'),
        ('th155', r'release\tf\th155\dat\th155b\data\bgm', 'th155b'),
    ]
    for g, rel, pack in games:
        bgm = base / rel
        if not bgm.exists():
            print(f'{g}: 无 {rel}')
            continue
        sfls = sorted(bgm.glob('*.sfl'))
        for p in sfls:
            txt = convert(p)
            if pack is None:
                dst = out_root / g / (p.stem + '.sfl.txt')
            else:
                dst = out_root / g / pack / (p.stem + '.sfl.txt')
            dst.parent.mkdir(parents=True, exist_ok=True)
            dst.write_text(txt, encoding='utf-8')
            total += 1
        print(f'{g}[{pack or "主"}]: {len(sfls)}')
    print(f'sfl->文本: 共 {total} 个 -> {out_root}')

if __name__ == '__main__':
    main()
