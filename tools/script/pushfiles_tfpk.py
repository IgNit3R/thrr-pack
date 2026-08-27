# -*- coding: utf-8 -*-
"""pushfiles 作业 - TFPK 引擎(th135/th145/th155/th175)
拆包: 135tk th135arc/th145arc/th175arc
转换: TFBM(bmp/png)->png, nut->txt, csv, sfl, pl, pat, mob_position dat 二拆
产物从 release _converted 复制
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
OUT_ROOT = ROOT / 'pushfiles'
CONV_ROOT = ROOT / 'release' / 'tf' / '_converted'
TF_ROOT = ROOT / 'release' / 'tf'

tf = json.loads((ROOT/'.build'/'filetree'/'tf_tree_data.json').read_text(encoding='utf-8'))

def locate(cpath):
    for base in [CONV_ROOT, TF_ROOT]:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            return cand
    return None

def extract_arc(tool, src, out, game, src_name):
    """135tk arc 拆包: 复制 pak 到沙箱工作区解包(避免写入源目录), 再就位到 pushfiles"""
    # 沙箱工作区
    work = ROOT / '.build' / 'arc_work' / game
    if work.exists():
        shutil.rmtree(work)
    work.mkdir(parents=True)
    shutil.copy2(src, work / src_name)
    # th145arc/th175arc 从 CWD 读 fileslist.txt 做路径映射, 复制到沙箱
    for fl in [ROOT / 'tools/135tk/135tk/fileslist.txt', ROOT / 'tools/135tk/135tk/fileslist.js']:
        if fl.exists():
            shutil.copy2(fl, work / fl.name)
    # 在沙箱内解包(CWD=沙箱)
    if 'th175arc' in tool.name:
        # th175arc: -x <pak> <outdir>, 从 CWD 读 fileslist.js
        outdir = work / 'extracted'
        cmd = [str(tool), '-x', str(work / src_name), str(outdir)]
        r = subprocess.run(cmd, cwd=str(work), capture_output=True)
        if r.returncode != 0:
            print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-200:])
            return None
        unpack = outdir
    else:
        cmd = [str(tool)]
        if 'th135arc-alt' in tool.name:
            cmd += ['-x', str(work / src_name)]
        else:
            cmd += ['/x', str(work / src_name)]
        r = subprocess.run(cmd, cwd=str(work), capture_output=True)
        if r.returncode != 0:
            print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-200:])
            return None
        # 找输出(th135arc 输出到 <stem>/ 子目录)
        unpack = work / pathlib.Path(src_name).stem
        if not unpack.exists() or not unpack.is_dir():
            unpack = work / src_name
        if not unpack.exists() or not unpack.is_dir():
            cands = [p for p in work.iterdir() if p.is_dir() and p.name != '_work']
            unpack = cands[0] if cands else None
    if not unpack or not unpack.exists():
        print('  !! 找不到解包输出', src_name)
        return None
    # 就位到 pushfiles
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    shutil.copytree(unpack, out, dirs_exist_ok=True)
    files = [p for p in out.rglob('*') if p.is_file()]
    print('  拆包 %s: %d 文件' % (src_name, len(files)))
    return out

def find_src(out, rel):
    src = out / rel
    if src.exists():
        return src
    return None

def convert_file(out, rel, game, pack):
    src = find_src(out, rel)
    if src is None:
        print('  !! 源缺失:', rel)
        return
    data = tf[game].get(pack, {})
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

def second_level(out, rel, game, pack):
    src = find_src(out, rel)
    if src is None:
        return
    data = tf[game].get(pack, {})
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
            shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
            n += 1
    print('  二拆 %s: %d' % (rel, n) if n else '')

def do_game(game, packs, tool, src_ext):
    gdir = OUT_ROOT / game
    if gdir.exists():
        shutil.rmtree(gdir)
    gdir.mkdir(parents=True)
    for pack, src_name in packs:
        src = ROOT / 'tf' / game / src_name
        out = gdir / src_name
        o = extract_arc(tool, src, out, game, src_name)
        if not o:
            continue
        data = tf[game].get(pack, {})
        for rel in sorted(data.get('conversions', {})):
            convert_file(o, rel, game, pack)
        for rel in sorted(data.get('second_level', {})):
            second_level(o, rel, game, pack)
    print('=== %s 完成 ===' % game)

if __name__ == '__main__':
    import pathlib as _p
    jobs = {
        'th135': (ROOT / 'tools/135tk/135tk/th135arc-alt.exe',
                  [('th135', 'th135.pak'), ('th135b', 'th135b.pak')]),
        'th145': (ROOT / 'tools/135tk/135tk/th145arc.exe',
                  [('th145', 'th145.pak'), ('th145b', 'th145b.pak')]),
        'th155': (ROOT / 'tools/135tk/135tk/th145arc.exe',
                  [('th155', 'th155.pak'), ('th155b', 'th155b.pak')]),
        'th175': (ROOT / 'tools/135tk/135tk/th175arc.exe',
                  [('data.cga', 'data.cga'), ('data.cgb', 'data.cgb')]),
    }
    which = sys.argv[1] if len(sys.argv) > 1 else 'th135'
    tool, packs = jobs[which]
    do_game(which, packs, tool, None)
