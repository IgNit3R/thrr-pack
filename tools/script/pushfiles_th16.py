# -*- coding: utf-8 -*-
"""pushfiles 作业 - th16 完整处理 (th09 同构: msg 是转换, 无二拆)
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tsa' / 'th16'
OUT_ROOT = ROOT / 'pushfiles' / 'th16'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'

tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))
D = tsa['th16']
CONV = D['conversions']
SECOND = D['second_level']
REL_BASE = ROOT / 'release' / 'tsa' / 'th16'
SRC_MAP = {'.anm': 'anm_png', '.ecl': 'ecl_txt', '.std': 'std_txt', '.end': 'end_txt', '.msg': 'msg_txt'}

def run(cmd, cwd):
    return subprocess.run(cmd, cwd=str(cwd), capture_output=True)

def extract(src_name, out, ver):
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / src_name
    r = run([str(THDAT), '-x', str(ver), str(src)], out)
    if r.returncode != 0:
        print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-400:])
        return None
    print('  拆包 %s: %d 文件' % (src_name, len([p for p in out.rglob('*') if p.is_file()])))
    return out

def find_source(out, rel, prefix):
    local = rel[len(prefix)+1:] if rel.startswith(prefix + '/') else rel
    return out / local, local

def convert_file(out, rel, prefix):
    src, local = find_source(out, rel, prefix)
    if not src.exists():
        print('  !! 源缺失:', local)
        return
    conv_list = CONV.get(rel, [])
    if not conv_list:
        return
    src_ext = pathlib.Path(rel).suffix.lower()
    sub = SRC_MAP.get(src_ext)
    if sub is None:
        print('  !! 未知转换类型:', rel)
        return
    base = REL_BASE / sub
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = out / local
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            dst = conv_dir / pathlib.Path(cpath).name
            shutil.copy2(cand, dst)
            n += 1
        else:
            hits = list(REL_BASE.rglob(pathlib.Path(cpath).name))
            if hits:
                shutil.copy2(hits[0], conv_dir / pathlib.Path(cpath).name)
                n += 1
    print('  转换 %s: %d 产物 -> %s/' % (rel, n, local) if n else '  !! %s 无产物' % rel)

def second_level(out, rel, prefix):
    src, local = find_source(out, rel, prefix)
    if not src.exists():
        print('  !! 源缺失:', local)
        return
    lvl2 = SECOND.get(rel, [])
    if not lvl2:
        return
    base = REL_BASE / 'msg_txt'
    if src.exists() and src.is_file():
        src.unlink()
    sl_dir = out / local
    sl_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in lvl2:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
            n += 1
        else:
            hits = list(REL_BASE.rglob(pathlib.Path(cpath).name))
            if hits:
                shutil.copy2(hits[0], sl_dir / pathlib.Path(cpath).name)
                n += 1
    print('  二拆 %s: %d 产物 -> %s/' % (rel, n, local) if n else '  !! %s 无产物' % rel)

def thbgm_split(out, rel):
    base = REL_BASE / 'bgm' / 'raw'
    conv_list = CONV.get(rel, [])
    if not conv_list:
        return
    conv_dir = out
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        cand = base / pathlib.Path(cpath).name
        if cand.exists() and cand.is_file():
            dst = conv_dir / 'raw' / pathlib.Path(cpath).name
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(cand, dst)
            n += 1
    print('  thbgm.dat: %d raw wav -> thbgm.dat/raw/' % n)
    fmt_src = REL_BASE / 'dat' / 'thbgm.fmt'
    if fmt_src.exists():
        shutil.copy2(fmt_src, conv_dir / 'thbgm.fmt')

def main():
    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)
    print('=== th16 拆包 ===')
    out_main = OUT_ROOT / 'th16.dat'
    extract('th16.dat', out_main, 16)
    out_bgm = OUT_ROOT / 'thbgm.dat'
    if out_bgm.exists():
        shutil.rmtree(out_bgm)
    out_bgm.mkdir(parents=True)
    print('=== th16 转换 ===')
    for rel in sorted(CONV):
        if rel == 'thbgm.dat':
            thbgm_split(out_bgm, rel)
        else:
            convert_file(out_main, rel, '')
    print('=== th16 二拆 ===')
    for rel in sorted(SECOND):
        second_level(out_main, rel, '')
    print('=== th16 完成 ===')

if __name__ == '__main__':
    main()
