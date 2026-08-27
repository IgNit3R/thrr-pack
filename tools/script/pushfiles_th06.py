# -*- coding: utf-8 -*-
"""pushfiles 作业 - th06 完整处理
结构: pushfiles/th06/<源档案名>/
  - 一拆: thtk thdat -x 6 拆包到源档案目录
  - 转换: anm/ecl/std/end -> <转换前文件名>/ 子文件夹, 产物放进去, 删原文件(规则5b)
  - 二拆: msgN.dat -> msgN.dat/ 子文件夹, 产物放进去, 删原 dat(规则5a)
规则顺序: 先 b(转换) 后 a(二拆)
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tsa' / 'kouma'
OUT_ROOT = ROOT / 'pushfiles' / 'th06'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'
THANM = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thanm.exe'
THECL = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thecl.exe'
THSTD = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thstd.exe'
THMSG = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thmsg.exe'

# 转换映射(源相对路径 -> [产物文件名]) 来自 tsa_tree_data
tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))
D = tsa['kouma']
CONV = D['conversions']   # {'紅魔郷CM/eff00.anm': ['eff00/eff00.png'], ...}
SECOND = D['second_level']  # {'紅魔郷ST/msg1.dat': ['msg1.txt'], ...}

DATS = ['紅魔郷CM.DAT','紅魔郷ED.DAT','紅魔郷IN.DAT','紅魔郷MD.DAT','紅魔郷ST.DAT','紅魔郷TL.DAT']

def run(cmd, cwd):
    r = subprocess.run(cmd, cwd=str(cwd), capture_output=True)
    return r

def extract_dat(dat_name):
    """拆一个 DAT 到 pushfiles/th06/<dat_name>/"""
    out = OUT_ROOT / dat_name
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / dat_name
    r = run([str(THDAT), '-x', '6', str(src)], out)
    if r.returncode != 0:
        print('  !! 拆包失败', dat_name, r.stdout.decode('cp932','replace')[-500:])
        return None
    files = [p.relative_to(out).as_posix() for p in out.rglob('*') if p.is_file()]
    print('  拆包 %s: %d 文件' % (dat_name, len(files)))
    return out

def convert_file(out, rel, local):
    """转换一个文件: 建 <文件名>/ 子文件夹, 产物放进去, 删原文件
    th06 特殊: anm 不内嵌纹理(引用 dat 外部图), 转换产物与 dat 原图重复
    -> anm 直接保存(规则3a), 不建文件夹不删原文件; ecl/std/end 照常转换"""
    # 源文件(拆包平铺: out/<local>)
    src = out / local
    if not src.exists():
        print('  !! 源缺失:', local)
        return
    # th06 特殊: anm 跳过转换(直接保存)
    if pathlib.Path(rel).suffix.lower() == '.anm':
        print('  特殊: %s 直接保存(anm 无内嵌纹理)' % rel)
        return
    # 转换产物列表(tsa_tree_data 中记录的 conv_files 路径)
    conv_list = CONV.get(rel, [])
    if not conv_list:
        return
    # 产物来源目录推断: ecl->ecl_txt, std->std_txt, end->end_txt
    src_ext = pathlib.Path(rel).suffix.lower()
    src_map = {'.ecl': 'ecl_txt', '.std': 'std_txt', '.end': 'end_txt'}
    sub = src_map.get(src_ext)
    base = ROOT / 'release' / 'tsa' / 'kouma' / (sub or '')
    # 建转换文件夹: <文件名>/ (保留扩展名, 如 ecldata1.ecl/)
    # 注意: 源文件占同名路径, 先删源文件再建文件夹(产物从 release 复制)
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = out / local
    conv_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in conv_list:
        # 产物文件: 复制自 release 对应目录
        cand = base / cpath
        if cand.exists() and cand.is_file():
            dst = conv_dir / pathlib.Path(cpath).name
            shutil.copy2(cand, dst)
            n += 1
        else:
            # 兜底: 搜 release kouma 下同 basename
            hits = list((ROOT / 'release' / 'tsa' / 'kouma').rglob(pathlib.Path(cpath).name))
            if hits:
                shutil.copy2(hits[0], conv_dir / pathlib.Path(cpath).name)
                n += 1
    if n:
        print('  转换 %s: %d 产物 -> %s/' % (rel, n, rel))
    else:
        # 无产物, 不删
        print('  !! %s 无转换产物, 保留' % rel)

def second_level(out, rel, local):
    """二拆一个 dat: 建 <文件名>.dat/ 子文件夹, 产物放进去, 删原 dat"""
    src = out / local
    if not src.exists():
        print('  !! 源缺失:', local)
        return
    lvl2 = SECOND.get(rel, [])
    if not lvl2:
        return
    base = ROOT / 'release' / 'tsa' / 'kouma' / 'msg_txt'
    sl_dir = out / local  # msg1.dat/
    # 源 dat 占同名路径, 先删再建文件夹
    if src.exists() and src.is_file():
        src.unlink()
    sl_dir.mkdir(parents=True, exist_ok=True)
    n = 0
    for cpath in lvl2:
        cand = base / cpath
        if cand.exists() and cand.is_file():
            shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
            n += 1
        else:
            hits = list((ROOT / 'release' / 'tsa' / 'kouma').rglob(pathlib.Path(cpath).name))
            if hits:
                shutil.copy2(hits[0], sl_dir / pathlib.Path(cpath).name)
                n += 1
    if n:
        print('  二拆 %s: %d 产物 -> %s/' % (rel, n, rel))
    else:
        print('  !! %s 二拆无产物, 保留' % rel)

def main():
    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)
    # 1. 拆包所有 DAT
    print('=== th06 拆包 ===')
    outs = {}
    for dat in DATS:
        o = extract_dat(dat)
        if o:
            outs[dat] = o
    # 转换任务(先 b): anm 特殊保存, ecl/std/end 转换
    for dat, out in outs.items():
        prefix = dat[:-4] + '/'
        for rel in sorted(CONV):
            if not rel.startswith(prefix):
                continue
            # 拆包平铺: 源文件在 out/<basename>, 去掉前缀
            local = rel[len(prefix):]
            convert_file(out, rel, local)
    # 二拆任务(后 a): msgN.dat
    for dat, out in outs.items():
        prefix = dat[:-4] + '/'
        for rel in sorted(SECOND):
            if not rel.startswith(prefix):
                continue
            local = rel[len(prefix):]
            second_level(out, rel, local)
    print('=== th06 完成 ===')
    # 统计
    total = sum(len([p for p in o.rglob('*') if p.is_file()]) for o in outs.values())
    print('pushfiles/th06 文件总数:', total)

if __name__ == '__main__':
    main()
