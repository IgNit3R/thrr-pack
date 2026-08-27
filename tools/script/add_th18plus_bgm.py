# -*- coding: utf-8 -*-
"""th18+ 补 thbgm.dat: raw/*.wav(原始切分) + thbgm.fmt"""
import pathlib, sys, shutil, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))

for code in ['th18', 'th185', 'th19', 'th20']:
    out_bgm = pathlib.Path(r'E:\GitWorkspace\thworks\pushfiles', code, 'thbgm.dat')
    out_bgm.mkdir(parents=True, exist_ok=True)
    conv = tsa[code]['conversions'].get('thbgm.dat', [])
    raw_src = ROOT / 'release' / 'tsa' / code / 'bgm' / 'raw'
    n = 0
    if raw_src.exists():
        for cpath in conv:
            cand = raw_src / pathlib.Path(cpath).name
            if cand.exists() and cand.is_file():
                dst = out_bgm / 'raw' / pathlib.Path(cpath).name
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(cand, dst)
                n += 1
    fmt_src = ROOT / 'release' / 'tsa' / code / 'dat' / 'thbgm.fmt'
    if fmt_src.exists():
        shutil.copy2(fmt_src, out_bgm / 'thbgm.fmt')
    print('%s: thbgm raw %d wav + fmt %s' % (code, n, (out_bgm/'thbgm.fmt').exists()))
