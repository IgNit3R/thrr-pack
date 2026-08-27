# -*- coding: utf-8 -*-
"""pushfiles 作业 - th07 完整处理
源档案: th07.dat + thbgm.dat
结构: pushfiles/th07/th07.dat/ 与 pushfiles/th07/thbgm.dat/
  - 拆包: thtk thdat -x 7
  - 转换(先b): anm(内嵌纹理真转)/ecl/std/end -> <文件名>/ 子文件夹; thbgm.dat -> raw/*.wav
  - 二拆(后a): msgN.dat -> msgN.dat/ 子文件夹
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tsa' / 'youmu'
OUT_ROOT = ROOT / 'pushfiles' / 'th07'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'

tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))
D = tsa['youmu']
CONV = D['conversions']    # 'th07/ascii.anm': ['ascii/data/ascii/ascii.png', ...]
SECOND = D['second_level'] # 'th07/msg1.dat': ['msg1.txt']

# 产物来源目录
REL_BASE = ROOT / 'release' / 'tsa' / 'youmu'
SRC_MAP = {'.anm': 'anm_png', '.ecl': 'ecl_txt', '.std': 'std_txt', '.end': 'end_txt'}

def run(cmd, cwd):
    return subprocess.run(cmd, cwd=str(cwd), capture_output=True)

def extract(src_name, out, ver, sub_prefix):
    """拆包 th07.dat 或 thbgm.dat; sub_prefix 指示产物是否在子目录(th07/)"""
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / src_name
    r = run([str(THDAT), '-x', str(ver), str(src)], out)
    if r.returncode != 0:
        print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-400:])
        return None
    # 确定一拆产物目录(可能带子前缀)
    files = [p for p in out.rglob('*') if p.is_file()]
    print('  拆包 %s: %d 文件' % (src_name, len(files)))
    return out

def find_source(out, rel, prefix):
    """定位源文件: rel 如 'th07/ascii.anm', 拆包后实际在 out/th07/ascii.anm 或 out/ascii.anm"""
    # prefix='th07' 时, rel 去掉 'th07/' 前缀
    local = rel[len(prefix)+1:] if rel.startswith(prefix + '/') else rel
    cand = out / local
    return cand, local

def convert_file(out, rel, prefix):
    src, local = find_source(out, rel, prefix)
    if not src.exists():
        print('  !! 源缺失:', local, '(rel:', rel + ')')
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
    # 建转换文件夹: <文件名>/ (与源同名)
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = out / local
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            # 产物可能带子路径(ascii/data/ascii/ascii.png) -> 展开到转换文件夹
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

def thbgm_split(out, rel, prefix):
    """thbgm.dat: 切分 raw/*.wav(原始切分, 不做 render)"""
    # 产物已在 release bgm/raw/
    base = REL_BASE / 'bgm' / 'raw'
    conv_list = CONV.get(rel, [])  # ['raw/th07_01.wav', ...]
    if not conv_list:
        return
    conv_dir = out  # thbgm.dat/
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

def main():
    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)
    print('=== th07 拆包 ===')
    # th07.dat
    out_main = OUT_ROOT / 'th07.dat'
    extract('th07.dat', out_main, 7, 'th07')
    # thbgm.dat: 无目录表(ZWAV 裸 PCM), 不拆包, 直接建目录由转换放 raw/*.wav
    out_bgm = OUT_ROOT / 'thbgm.dat'
    if out_bgm.exists():
        shutil.rmtree(out_bgm)
    out_bgm.mkdir(parents=True)

    # 转换(先b)
    print('=== th07 转换 ===')
    for rel in sorted(CONV):
        if rel.startswith('th07/'):
            convert_file(out_main, rel, 'th07')
        elif rel == 'thbgm.dat':
            thbgm_split(out_bgm, rel, 'thbgm')
    # 二拆(后a)
    print('=== th07 二拆 ===')
    for rel in sorted(SECOND):
        if rel.startswith('th07/'):
            second_level(out_main, rel, 'th07')
    print('=== th07 完成 ===')

if __name__ == '__main__':
    main()
