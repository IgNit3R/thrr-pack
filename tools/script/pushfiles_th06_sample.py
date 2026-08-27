# -*- coding: utf-8 -*-
"""pushfiles 拆包作业 - th06 样板: 拆 紅魔郷CM.DAT
输出: pushfiles/th06/紅魔郷CM.DAT/<一拆产物>
"""
import pathlib, shutil, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC = ROOT / 'tsa' / 'kouma' / '紅魔郷CM.DAT'
OUT = ROOT / 'pushfiles' / 'th06' / '紅魔郷CM.DAT'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'

print('源:', SRC, SRC.exists(), SRC.stat().st_size if SRC.exists() else 0)
if OUT.exists():
    shutil.rmtree(OUT)
OUT.mkdir(parents=True)

# thtk thdat 用法: thdat -x <ver> <in.dat> (输出到 CWD)
r = subprocess.run([str(THDAT), '-x', '6', str(SRC)], cwd=str(OUT), capture_output=True)
print('exit:', r.returncode)
print(r.stdout.decode('cp932', 'replace')[-1500:])
if r.stderr:
    print('stderr:', r.stderr.decode('cp932', 'replace')[-500:])

# 列出输出
files = sorted(p for p in OUT.rglob('*') if p.is_file())
print('输出文件数:', len(files))
for f in files[:20]:
    print('  ', f.relative_to(OUT).as_posix(), f.stat().st_size)
