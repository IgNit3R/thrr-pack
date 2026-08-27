# -*- coding: utf-8 -*-
"""pushfiles 作业 - th075 (th075.dat / th075b.dat / th075bgm.dat)
th075 特殊: 内层 dat(background/BG*.dat, wave/se*.dat, character) 二拆/转换
转换产物从 release _converted 复制
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tf' / 'th075'
OUT_ROOT = ROOT / 'pushfiles' / 'th075'
BRIGHTMOON = ROOT / '_scan_results' / 'bin' / 'brightmoon.exe'
# th075 产物 cpath 两种格式: '_converted/th075/...' 或 'th075/dat/...'
CONV_ROOT = ROOT / 'release' / 'tf' / '_converted'
TF_ROOT = ROOT / 'release' / 'tf'

def locate(cpath):
    """兼容两种 cpath 格式"""
    for base in [CONV_ROOT, TF_ROOT]:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            return cand
        # 若 cpath 以 th075/ 开头且 base=_converted, 试 _converted/th075/
        if base is CONV_ROOT and cpath.startswith('th075/'):
            cand2 = CONV_ROOT / cpath
            if cand2.exists() and cand2.is_file():
                return cand2
    return None

tf = json.loads((ROOT/'.build'/'filetree'/'tf_tree_data.json').read_text(encoding='utf-8'))

def run_cmd(cmd, cwd):
    log = cwd / '_run.log'
    with open(log, 'w', encoding='utf-8') as f:
        r = subprocess.run(cmd, cwd=str(cwd), stdout=f, stderr=subprocess.STDOUT)
    txt = log.read_text(encoding='utf-8', errors='replace')
    return r.returncode, txt

def extract(pack, src_name):
    out = OUT_ROOT / src_name
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / src_name
    rc, log = run_cmd([str(BRIGHTMOON), '-x', '-p', '-o', str(out), str(src)], out)
    if rc != 0:
        print('  !! 拆包失败', src_name, log[-300:])
        return None
    (out / '_run.log').unlink(missing_ok=True)
    print('  拆包 %s: %d 文件' % (src_name, len([p for p in out.rglob('*') if p.is_file()])))
    return out

def convert_file(out, rel, pack):
    """转换: musicroom.dat->csv, sce->txt 等"""
    src = out / rel
    if not src.exists():
        print('  !! 源缺失:', rel)
        return
    data = tf['th075'].get(pack, {})
    conv_list = data.get('conversions', {}).get(rel, [])
    if not conv_list:
        return
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = out / rel
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        cand = locate(cpath)
        if cand:
            dst = conv_dir / pathlib.Path(cpath).name
            shutil.copy2(cand, dst)
            n += 1
    print('  转换 %s: %d 产物' % (rel, n) if n else '  !! %s 无产物' % rel)

def second_level(out, rel, pack):
    """二拆: background/BG*.dat->png, wave/se*.dat->wav 等"""
    src = out / rel
    if not src.exists():
        print('  !! 源缺失:', rel)
        return
    data = tf['th075'].get(pack, {})
    lvl2 = data.get('second_level', {}).get(rel, [])
    if not lvl2:
        return
    if src.exists() and src.is_file():
        src.unlink()
    sl_dir = out / rel
    sl_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in lvl2:
        cand = locate(cpath)
        if cand:
            dst = sl_dir / pathlib.Path(cpath).name
            shutil.copy2(cand, dst)
            n += 1
    print('  二拆 %s: %d' % (rel, n) if n else '  !! %s 无产物' % rel)

def main():
    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)
    for pack, src_name in [('th075', 'th075.dat'), ('th075b', 'th075b.dat'), ('th075bgm', 'th075bgm.dat')]:
        out = extract(pack, src_name)
        if not out:
            continue
        data = tf['th075'].get(pack, {})
        for rel in sorted(data.get('conversions', {})):
            convert_file(out, rel, pack)
        for rel in sorted(data.get('second_level', {})):
            second_level(out, rel, pack)
    print('=== th075 完成 ===')

if __name__ == '__main__':
    main()
