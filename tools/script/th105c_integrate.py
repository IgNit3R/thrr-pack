# -*- coding: utf-8 -*-
"""th105c 完整整合: 拆包 + 转换(cv2/cv3/cv0/cv1/pat) + 映射/树记录
规则: 转换完成删源(先b), 转换前文件名建文件夹放产物
"""
import pathlib, shutil, subprocess, sys, json, hashlib, zlib
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
OUT = ROOT / 'pushfiles' / 'th105' / 'th105c.dat'
WORK = ROOT / '.build' / 'touhouse_conv_work_105c' / 'data'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'
sys.path.insert(0, str(ROOT / '.build'))

# 0. 拆包
if OUT.exists():
    shutil.rmtree(OUT)
OUT.mkdir(parents=True)
r = subprocess.run([str(THDAT), '-x', '105', str(ROOT / 'tf' / 'th105' / 'th105c.dat')],
                   cwd=str(OUT), capture_output=True)
print('拆包 exit:', r.returncode)
print('拆包文件:', len([p for p in OUT.rglob('*') if p.is_file()]))

CONV = {}        # rel -> [conv_files 路径]
CONV_FILES = {}  # 路径 -> info

def add_conv_file(cpath, src_path):
    if src_path.exists() and src_path.is_file():
        b = src_path.read_bytes()
        CONV_FILES[cpath] = {'size': len(b), 'md5': hashlib.md5(b).hexdigest(),
                             'crc32': '%08X' % (zlib.crc32(b) & 0xFFFFFFFF)}

# 1. cv2/cv3 转换产物(touhouSE 已生成到 WORK, 输出无 data/ 前缀)
for f in sorted(OUT.rglob('*.cv2')):
    rel = f.relative_to(OUT).as_posix()
    work_rel = rel[5:] if rel.startswith('data/') else rel
    png_src = WORK / (work_rel[:-4] + '.png')
    if png_src.exists():
        # 建转换目录(与源同名), 复制 png, 删源
        f.unlink()
        cdir = OUT / rel
        cdir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(png_src, cdir / png_src.name)
        cpath = '_converted/th105c/' + rel[:-4] + '.png'
        CONV.setdefault(rel, []).append(cpath)
        add_conv_file(cpath, cdir / png_src.name)
print('cv2 转换完成')

for f in sorted(OUT.rglob('*.cv3')):
    rel = f.relative_to(OUT).as_posix()
    work_rel = rel[5:] if rel.startswith('data/') else rel
    wav_src = WORK / (work_rel[:-4] + '.wav')
    if wav_src.exists():
        f.unlink()
        cdir = OUT / rel
        cdir.mkdir(parents=True, exist_ok=True)
        shutil.copy2(wav_src, cdir / wav_src.name)
        cpath = '_converted/th105c/' + rel[:-4] + '.wav'
        CONV.setdefault(rel, []).append(cpath)
        add_conv_file(cpath, cdir / wav_src.name)
print('cv3 转换完成')

# 2. cv0/cv1 -> txt/csv (cv_to_txt)
from cv_to_txt import decrypt as cv_decrypt
for f in sorted(OUT.rglob('*.cv0')):
    rel = f.relative_to(OUT).as_posix()
    out_bytes = cv_decrypt(f.read_bytes())
    f.unlink()
    cdir = OUT / rel
    cdir.mkdir(parents=True, exist_ok=True)
    out_name = f.stem + '.cv0.txt'
    (cdir / out_name).write_bytes(out_bytes)
    cpath = '_converted/cv_txt/th105/' + rel[:-4] + '.cv0.txt'
    CONV.setdefault(rel, []).append(cpath)
    add_conv_file(cpath, cdir / out_name)
print('cv0 转换完成')

for f in sorted(OUT.rglob('*.cv1')):
    rel = f.relative_to(OUT).as_posix()
    out_bytes = cv_decrypt(f.read_bytes())
    f.unlink()
    cdir = OUT / rel
    cdir.mkdir(parents=True, exist_ok=True)
    out_name = f.stem + '.cv1.csv'
    (cdir / out_name).write_bytes(out_bytes)
    cpath = '_converted/cv_txt/th105/' + rel[:-4] + '.cv1.csv'
    CONV.setdefault(rel, []).append(cpath)
    add_conv_file(cpath, cdir / out_name)
print('cv1 转换完成')

# 3. pat -> txt (pat_to_txt.analyze)
sys.path.insert(0, str(ROOT / '.build'))
from pat_to_txt import analyze as pat_analyze
for f in sorted(OUT.rglob('*.pat')):
    rel = f.relative_to(OUT).as_posix()
    txt = pat_analyze(f)
    f.unlink()
    cdir = OUT / rel
    cdir.mkdir(parents=True, exist_ok=True)
    out_name = f.stem + '.pat.txt'
    (cdir / out_name).write_text(txt, encoding='utf-8')
    cpath = '_converted/pat_txt/th105/' + rel[:-4] + '.pat.txt'
    CONV.setdefault(rel, []).append(cpath)
    add_conv_file(cpath, cdir / out_name)
print('pat 转换完成')

# 4. 保存映射
mapping = {
    'conversions': CONV,
    'conv_files': CONV_FILES,
    'dat_files': [{'path': p.relative_to(OUT).as_posix(), 'size': p.stat().st_size}
                  for p in OUT.rglob('*') if p.is_file()],
}
out_map = ROOT / '.build' / 'filetree' / 'th105c_map.json'
out_map.write_text(json.dumps(mapping, ensure_ascii=False), encoding='utf-8')
print()
print('映射保存:', out_map)
print('转换源:', len(CONV), '转换文件:', len(CONV_FILES))
print('pushfiles/th105/th105c.dat 文件数:', len([p for p in OUT.rglob('*') if p.is_file()]))
