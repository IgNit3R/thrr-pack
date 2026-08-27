# -*- coding: utf-8 -*-
"""pushfiles 作业 - th123 (a/b/c)
源档案: th123a.dat / th123b.dat / th123c.dat
转换: cv2->png / cv3->wav / cv0->txt / cv1->csv / sfl->txt / pat->txt (产物从 release _converted 复制)
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tf' / 'th123'
OUT_ROOT = ROOT / 'pushfiles' / 'th123'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'
CONV_ROOT = ROOT / 'release' / 'tf'

tf = json.loads((ROOT/'.build'/'filetree'/'tf_tree_data.json').read_text(encoding='utf-8'))

def run(cmd, cwd):
    return subprocess.run(cmd, cwd=str(cwd), capture_output=True)

def garbled_seg(seg):
    try:
        return seg.encode('cp932').decode('gbk') if any(ord(c) > 0x2E80 for c in seg) else seg
    except (UnicodeEncodeError, UnicodeDecodeError):
        return seg

def extract(pack, src_name):
    out = OUT_ROOT / src_name
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / src_name
    r = run([str(THDAT), '-x', '123', str(src)], out)
    if r.returncode != 0:
        print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-300:])
        return None
    print('  拆包 %s: %d 文件' % (src_name, len([p for p in out.rglob('*') if p.is_file()])))
    return out

def find_src(out, rel):
    """定位源文件: 先精确, 后乱码回退"""
    src = out / rel
    if src.exists():
        return src, rel
    garbled = '/'.join(garbled_seg(seg) for seg in rel.split('/'))
    if garbled != rel:
        s2 = out / garbled
        if s2.exists():
            return s2, garbled
    return None, None

def convert_file(out, rel, pack):
    src, actual = find_src(out, rel)
    if src is None:
        print('  !! 源缺失:', rel)
        return
    data = tf['th123'].get(pack, {})
    conv_list = data.get('conversions', {}).get(rel, [])
    if not conv_list:
        return
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = src  # 转换前文件名(actual)建目录
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        cand = CONV_ROOT / cpath
        if cand.exists() and cand.is_file():
            dst = conv_dir / pathlib.Path(cpath).name
            shutil.copy2(cand, dst)
            n += 1
    print('  转换 %s: %d 产物' % (rel, n) if n else '  !! %s 无产物' % rel)

def second_level(out, rel, pack):
    src, actual = find_src(out, rel)
    if src is None:
        return
    data = tf['th123'].get(pack, {})
    lvl2 = data.get('second_level', {}).get(rel, [])
    if not lvl2:
        return
    if src.exists() and src.is_file():
        src.unlink()
    sl_dir = src
    sl_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in lvl2:
        cand = CONV_ROOT / cpath
        if cand.exists() and cand.is_file():
            shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
            n += 1
    print('  二拆 %s: %d' % (rel, n))

def main():
    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)
    for pack, src_name in [('th123a', 'th123a.dat'), ('th123b', 'th123b.dat'), ('th123c', 'th123c.dat')]:
        out = extract(pack, src_name)
        if not out:
            continue
        data = tf['th123'].get(pack, {})
        for rel in sorted(data.get('conversions', {})):
            convert_file(out, rel, pack)
        for rel in sorted(data.get('second_level', {})):
            second_level(out, rel, pack)
    print('=== th123 完成 ===')

if __name__ == '__main__':
    main()
