# -*- coding: utf-8 -*-
"""pushfiles 作业 - th105 样板 (th105a/b/c)
源档案: th105a.dat / th105b.dat / th105c.dat
规则: 拆包 -> th105a.dat/ 目录(保持 data/ 结构); 转换(先b) -> 转换前文件名建文件夹, 产物复制, 删源
"""
import pathlib, shutil, subprocess, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
SRC_DIR = ROOT / 'tf' / 'th105'
OUT_ROOT = ROOT / 'pushfiles' / 'th105'
THDAT = ROOT / 'tools' / 'thtk' / 'thtk-bin-12' / 'thdat.exe'
CONV_ROOT = ROOT / 'release' / 'tf'

tf = json.loads((ROOT/'.build'/'filetree'/'tf_tree_data.json').read_text(encoding='utf-8'))

def run(cmd, cwd):
    return subprocess.run(cmd, cwd=str(cwd), capture_output=True)

def extract(pack, src_name, ver):
    """拆包 th105X.dat 到 pushfiles/th105/th105X.dat/"""
    out = OUT_ROOT / src_name
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    src = SRC_DIR / src_name
    r = run([str(THDAT), '-x', str(ver), str(src)], out)
    if r.returncode != 0:
        print('  !! 拆包失败', src_name, r.stdout.decode('cp932','replace')[-300:])
        return None
    print('  拆包 %s: %d 文件' % (src_name, len([p for p in out.rglob('*') if p.is_file()])))
    return out

def convert_file(out, rel, pack):
    """转换: 建 <转换前文件名>/ 文件夹放产物, 删源(规则5b)"""
    src = out / rel
    if not src.exists():
        # 乱码名回退: 修复名 -> 乱码名 (如 余.cv2 -> 梋.cv2, thdat GBK 系统问题)
        try:
            garbled_rel = '/'.join(seg.encode('cp932').decode('gbk') if any(ord(c) > 0x2E80 for c in seg) else seg
                                   for seg in rel.split('/'))
        except (UnicodeEncodeError, UnicodeDecodeError):
            garbled_rel = None
        if garbled_rel and garbled_rel != rel:
            src = out / garbled_rel
            if not src.exists():
                print('  !! 源缺失(含乱码回退):', rel, '/', garbled_rel)
                return
        else:
            print('  !! 源缺失:', rel)
            return
    data = tf['th105'].get(pack, {})
    conv_list = data.get('conversions', {}).get(rel, [])
    if not conv_list:
        return
    # 建转换文件夹(与源同名)
    if src.exists() and src.is_file():
        src.unlink()
    conv_dir = src  # src 即转换前文件名路径, 删文件后建目录
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
    """二拆(后a)"""
    src = out / rel
    if not src.exists():
        return
    data = tf['th105'].get(pack, {})
    lvl2 = data.get('second_level', {}).get(rel, [])
    if not lvl2:
        return
    if src.exists() and src.is_file():
        src.unlink()
    sl_dir = out / rel
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
    # 拆包(先 a/b 样板; c 待补转换映射)
    for pack, src_name in [('th105a', 'th105a.dat'), ('th105b', 'th105b.dat')]:
        out = extract(pack, src_name, 105)
        if not out:
            continue
        data = tf['th105'].get(pack, {})
        conv = data.get('conversions', {})
        second = data.get('second_level', {})
        # 转换(先b)
        for rel in sorted(conv):
            convert_file(out, rel, pack)
        # 二拆(后a)
        for rel in sorted(second):
            second_level(out, rel, pack)
    print('=== th105 完成 ===')

if __name__ == '__main__':
    main()
