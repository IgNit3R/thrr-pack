# -*- coding: utf-8 -*-
"""pushfiles 作业 - th18/th185/th19/th20 (Kanako, brightmoon 拆包)
转换产物从 release 复制(官方 master thanm/thecl 已生成)
"""
import pathlib, shutil, subprocess, sys, json, os
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
BRIGHTMOON = ROOT / '_scan_results' / 'bin' / 'brightmoon.exe'

def run_cmd(cmd, cwd):
    """cmd 重定向到文件执行(cygwin 程序管道限制)"""
    log = cwd / '_run.log'
    with open(log, 'w', encoding='utf-8') as f:
        r = subprocess.run(cmd, cwd=str(cwd), stdout=f, stderr=subprocess.STDOUT)
    txt = log.read_text(encoding='utf-8', errors='replace')
    return r.returncode, txt

def do_game(code, ver):
    import json as _json
    tsa = _json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))
    D = tsa[code]
    CONV = D['conversions']
    SECOND = D['second_level']
    REL_BASE = ROOT / 'release' / 'tsa' / code
    SRC_MAP = {'.anm': 'anm_png', '.ecl': 'ecl_txt', '.std': 'std_txt', '.end': 'end_txt', '.msg': 'msg_txt'}
    OUT_ROOT = ROOT / 'pushfiles' / code

    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)

    # 拆包
    out_main = OUT_ROOT / (code + '.dat')
    out_main.mkdir(parents=True)
    src = ROOT / 'tsa' / code / (code + '.dat')
    rc, log = run_cmd([str(BRIGHTMOON), '-x', '-p', '-o', str(out_main), str(src)], out_main)
    if rc != 0:
        print('  !! 拆包失败', code, log[-300:])
        return
    print('  拆包 %s.dat: %d 文件' % (code, len([p for p in out_main.rglob('*') if p.is_file()])))

    # ⚠️ 翻案关键: brightmoon 拆包的 anm 有 510 字节差异(损坏);
    # anm 源文件用 release 官方 thdat 正确版覆盖
    rel_dat = REL_BASE / 'dat'
    n_anm = 0
    for f in out_main.glob('*.anm'):
        official = rel_dat / f.name
        if official.exists() and official.is_file():
            try:
                shutil.copy2(official, f)
                n_anm += 1
            except PermissionError:
                # 旧文件可能只读, 先删再拷
                try:
                    f.unlink()
                    shutil.copy2(official, f)
                    n_anm += 1
                except Exception as e:
                    print('  !! anm 覆盖失败', f.name, e)
    print('  anm 官方版覆盖: %d 个' % n_anm)

    # thbgm
    out_bgm = OUT_ROOT / 'thbgm.dat'
    out_bgm.mkdir(parents=True)

    # 转换(先b)
    for rel in sorted(CONV):
        if rel == 'thbgm.dat':
            # raw wav
            base = REL_BASE / 'bgm' / 'raw'
            for cpath in CONV[rel]:
                cand = base / pathlib.Path(cpath).name
                if cand.exists():
                    dst = out_bgm / 'raw' / pathlib.Path(cpath).name
                    dst.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(cand, dst)
            fmt = REL_BASE / 'dat' / 'thbgm.fmt'
            if fmt.exists():
                shutil.copy2(fmt, out_bgm / 'thbgm.fmt')
            print('  thbgm.dat: %d raw wav' % len(CONV[rel]))
            continue
        # 平铺: local = rel
        local = rel
        src_f = out_main / local
        if not src_f.exists():
            print('  !! 源缺失:', local)
            continue
        conv_list = CONV[rel]
        ext = pathlib.Path(rel).suffix.lower()
        sub = SRC_MAP.get(ext)
        if sub is None:
            print('  !! 未知类型:', rel)
            continue
        base = REL_BASE / sub
        if src_f.exists() and src_f.is_file():
            src_f.unlink()
        conv_dir = out_main / local
        conv_dir.mkdir(parents=True, exist_ok=True)
        n = 0
        for cpath in conv_list:
            cand = base / cpath
            if cand.exists() and cand.is_file():
                shutil.copy2(cand, conv_dir / pathlib.Path(cpath).name)
                n += 1
            else:
                hits = list(REL_BASE.rglob(pathlib.Path(cpath).name))
                if hits:
                    shutil.copy2(hits[0], conv_dir / pathlib.Path(cpath).name)
                    n += 1
        print('  转换 %s: %d 产物' % (rel, n) if n else '  !! %s 无产物' % rel)

    # 二拆(后a)
    for rel in sorted(SECOND):
        local = rel
        src_f = out_main / local
        if not src_f.exists():
            continue
        lvl2 = SECOND[rel]
        base = REL_BASE / 'msg_txt'
        if src_f.exists() and src_f.is_file():
            src_f.unlink()
        sl_dir = out_main / local
        sl_dir.mkdir(parents=True, exist_ok=True)
        n = 0
        for cpath in lvl2:
            cand = base / cpath
            if cand.exists() and cand.is_file():
                shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
                n += 1
        print('  二拆 %s: %d 产物' % (rel, n) if n else '')

    print('=== %s 完成 ===' % code)

if __name__ == '__main__':
    do_game(sys.argv[1] if len(sys.argv) > 1 else 'th18', None)
