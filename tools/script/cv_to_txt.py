# -*- coding: utf-8 -*-
"""cv0/cv1 -> 文本/CSV 解密转换 (th105/th123)
滚动 XOR: k0=0x8B, t0=0x71, k+=t, t+=0x95
cv0 = 剧本/台词文本(Label/Face/End 结构) -> .cv0.txt
cv1 = CSV 数据表(符卡/曲名/牌组等)      -> .cv1.csv
产物: _converted/cv_txt/{game}/{conv_rel}.txt|.csv (conv_rel = 去 data/ 前缀的相对路径)
"""
import pathlib, sys

BASE = pathlib.Path(r'E:\GitWorkspace\thworks')
OUT_ROOT = BASE / 'release/tf/_converted/cv_txt'


def decrypt(data, k0=0x8B, t0=0x71, dt=0x95):
    k, t = k0, t0
    out = bytearray()
    for c in data:
        out.append(c ^ k)
        k = (k + t) & 0xFF
        t = (t + dt) & 0xFF
    return bytes(out)


def convert(path):
    b = path.read_bytes()
    return decrypt(b)


def main():
    games = [
        ('th105', 'th105a'),
        ('th123', 'th123a'),
    ]
    total = 0
    for game, pack in games:
        pd = BASE / 'release' / 'tf' / game / 'dat' / pack
        if not pd.exists():
            print('%s: 无 %s' % (game, pd))
            continue
        n0 = n1 = 0
        for ext, out_ext in [('.cv0', '.txt'), ('.cv1', '.csv')]:
            for p in sorted(pd.rglob('*' + ext)):
                if not p.is_file():
                    continue
                rel = p.relative_to(pd).as_posix()
                conv_rel = rel[5:] if rel.startswith('data/') else rel
                out = convert(p)
                dst = OUT_ROOT / game / (conv_rel + out_ext)
                dst.parent.mkdir(parents=True, exist_ok=True)
                dst.write_bytes(out)  # 保持 cp932 原始字节
                if ext == '.cv0':
                    n0 += 1
                else:
                    n1 += 1
                total += 1
        print('%s/%s: cv0=%d cv1=%d' % (game, pack, n0, n1))
    print('cv0/cv1->文本: 共 %d 个 -> %s' % (total, OUT_ROOT))


if __name__ == '__main__':
    main()
