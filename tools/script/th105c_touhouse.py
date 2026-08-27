# -*- coding: utf-8 -*-
"""th105c 用 touhouSE 转换(cv2->png / cv3->wav)"""
import pathlib, shutil, subprocess, sys
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
TOOL = ROOT / 'tools' / 'touhouSE' / 'touhouSE.exe'
WORK = ROOT / '.build' / 'touhouse_conv_work_105c'
SRC = ROOT / 'tf' / 'th105' / 'th105c.dat'

if WORK.exists():
    shutil.rmtree(WORK)
WORK.mkdir(parents=True)
shutil.copy2(TOOL, WORK / 'touhouSE.exe')

r = subprocess.run([str(WORK / 'touhouSE.exe'), '-c', str(SRC)], cwd=str(WORK), capture_output=True)
print(r.stdout.decode('cp932', 'replace')[-1500:])

work_data = WORK / 'data'
if work_data.exists():
    n_png = len(list(work_data.rglob('*.png')))
    n_wav = len(list(work_data.rglob('*.wav')))
    print('touhouSE 输出: PNG=%d WAV=%d' % (n_png, n_wav))
    # 结构样例
    for p in sorted(work_data.rglob('*'))[:8]:
        print('  ', p.relative_to(work_data).as_posix())
else:
    print('无 data 输出')
