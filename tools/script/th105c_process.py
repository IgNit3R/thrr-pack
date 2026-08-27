# -*- coding: utf-8 -*-
"""th105c 完整处理: 拆包 -> pushfiles/th105/th105c.dat/ + 转换 + 映射/树记录
th105c = 补丁后有效数据包(纯数据, 无日文名问题)
转换: cv2->png / cv3->wav / cv0->txt / cv1->csv / pat->txt
"""
import pathlib, shutil, subprocess, sys, json, hashlib, zlib
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC = ROOT / 'tf' / 'th105' / 'th105c.dat'
OUT = ROOT / 'pushfiles' / 'th105' / 'th105c.dat'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'
sys.path.insert(0, str(ROOT / '.build'))

# 1. 拆包
if OUT.exists():
    shutil.rmtree(OUT)
OUT.mkdir(parents=True)
r = subprocess.run([str(THDAT), '-x', '105', str(SRC)], cwd=str(OUT), capture_output=True)
print('拆包 exit:', r.returncode)
files = [p for p in OUT.rglob('*') if p.is_file()]
print('拆包文件:', len(files))

# 2. 转换映射(源 rel -> 产物路径)
CONV = {}          # {rel: [conv_files 路径]}
CONV_FILES = {}    # {路径: {size, md5, crc32}}

def conv_path(rel, subdir, out_name):
    """产物目标: _converted/{subdir}/... 相对 release/tf"""
    return '_converted/%s/%s' % (subdir, out_name)

def add_conv(rel, cpath, out_name, srcdir):
    CONV.setdefault(rel, []).append(cpath)
    # 生成产物文件(从源转换)
    src = OUT / rel
    cand = srcdir / out_name
    if cand.exists() and cand.is_file():
        b = cand.read_bytes()
        CONV_FILES[cpath] = {'size': len(b), 'md5': hashlib.md5(b).hexdigest(),
                             'crc32': '%08X' % (zlib.crc32(b) & 0xFFFFFFFF)}

# 转换工具
def run_py(script, args, cwd):
    return subprocess.run([sys.executable, str(script)] + args, cwd=str(cwd), capture_output=True)

# cv2 -> png: 用 cv2conv_py(纯 Python, 无沙箱限制)
from cv2conv_py import convert_cv2
cv2_dir = OUT / 'data'
n_cv2 = 0
for f in sorted(cv2_dir.rglob('*.cv2')):
    rel = f.relative_to(OUT).as_posix()
    stem = f.stem
    png = f.with_suffix('.png')
    try:
        convert_cv2(f, png)
        cpath = '_converted/th105c/' + rel[:-4] + '.png'
        CONV.setdefault(rel, []).append(cpath)
        b = png.read_bytes()
        CONV_FILES[cpath] = {'size': len(b), 'md5': hashlib.md5(b).hexdigest(),
                             'crc32': '%08X' % (zlib.crc32(b) & 0xFFFFFFFF)}
        n_cv2 += 1
    except Exception as e:
        print('  cv2 失败', rel, e)
print('cv2->png:', n_cv2)

# cv3 -> wav: cv3 是 SE 音效, 用 touhouSE? 这里 cv3 少(6个), 先检查格式
print()
print('cv3 文件:', [p.name for p in (cv2_dir/'se').glob('*.cv3')] if (cv2_dir/'se').exists() else '无 se 目录')

# 保存映射
mapping = {'conversions': CONV, 'conv_files': CONV_FILES}
out_map = ROOT / '.build' / 'filetree' / 'th105c_map.json'
out_map.write_text(json.dumps(mapping, ensure_ascii=False), encoding='utf-8')
print()
print('映射已保存:', out_map)
print('转换源:', len(CONV), '转换文件:', len(CONV_FILES))
