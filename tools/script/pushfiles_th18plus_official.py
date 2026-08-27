# -*- coding: utf-8 -*-
"""pushfiles 作业 - th18/th185/th19/th20 官方工具完整执行
工具: 官方 thtk master(cygwin, 需提权): thdat/thanm/thecl/thstd/thmsg
流程(遵守规则):
  1. 官方 thdat 拆包 -> thxx.dat/ 目录(一拆产物)
  2. 转换(先b): thanm(anm->png)/thecl(ecl->txt)/thstd(std->txt)/thmsg(msg->txt)
     -> 每个源文件建 <文件名>/ 子文件夹放转换产物, 删原文件
  3. 二拆(后a): (th18+ 无二拆)
  4. thbgm.dat: 官方切片 raw/*.wav(仅原始切分, 不做 render)
"""
import pathlib, shutil, subprocess, sys, json, os
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
TOOL_BIN = ROOT / '.build' / 'thtk-install' / 'bin'
tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))

def run_tool(args, cwd, logname='_tool.log'):
    """cmd /c 运行 cygwin 工具(重定向到文件)"""
    cmd = 'cd /d "%s" && set PATH=%s;%%PATH%% && %s > %s 2>&1' % (
        cwd, TOOL_BIN, ' '.join(args), logname)
    r = subprocess.run(['cmd', '/c', cmd], capture_output=True)
    log = (cwd / logname).read_text(encoding='utf-8', errors='replace') if (cwd / logname).exists() else ''
    return r.returncode, log

def do_game(code, ver):
    D = tsa[code]
    CONV = D['conversions']
    SECOND = D['second_level']
    OUT_ROOT = ROOT / 'pushfiles' / code

    if OUT_ROOT.exists():
        shutil.rmtree(OUT_ROOT)
    OUT_ROOT.mkdir(parents=True)

    # 1. thdat 拆包
    out_main = OUT_ROOT / (code + '.dat')
    out_main.mkdir(parents=True)
    src = ROOT / 'tsa' / code / (code + '.dat')
    rc, log = run_tool(['thdat.exe', '-x', str(ver), str(src)], out_main)
    if rc != 0:
        print('  !! thdat 失败', code, log[-300:])
        return
    # 清理工具日志
    (out_main / '_tool.log').unlink(missing_ok=True)
    print('  拆包 %s.dat: %d 文件' % (code, len([p for p in out_main.rglob('*') if p.is_file()])))

    # 2. 转换(先b)
    for rel in sorted(CONV):
        if rel == 'thbgm.dat':
            continue
        ext = pathlib.Path(rel).suffix.lower()
        local = rel  # 平铺
        src_f = out_main / local
        if not src_f.exists():
            print('  !! 源缺失:', local)
            continue
        tool = {'.anm': 'thanm.exe', '.ecl': 'thecl.exe', '.std': 'thstd.exe', '.msg': 'thmsg.exe'}.get(ext)
        if tool is None:
            print('  !! 未知类型:', rel)
            continue
        # 在独立临时目录跑工具, 避免输出冲突
        work = out_main / ('_work_' + local.replace('/', '_'))
        work.mkdir(parents=True, exist_ok=True)
        shutil.copy2(src_f, work / local)
        rc, log = run_tool([tool, '-x', str(ver), local], work)
        # 收集输出文件(保留子路径, 与官方 thanm 输出层级一致)
        conv_dir = out_main / local  # <文件名>/
        if rc == 0:
            if src_f.exists() and src_f.is_file():
                src_f.unlink()  # 规则5b: 删源
            conv_dir.mkdir(parents=True, exist_ok=True)
            n = 0
            for f in work.rglob('*'):
                if f.is_file() and f.name != '_tool.log':
                    rel_out = f.relative_to(work).as_posix()
                    dst = conv_dir / rel_out
                    dst.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(f, dst)
                    n += 1
            print('  转换 %s: %d 产物' % (rel, n) if n else '  !! %s 工具无输出' % rel)
        else:
            print('  !! %s 转换失败: %s' % (rel, log[-200:]))
        shutil.rmtree(work, ignore_errors=True)

    # 3. thbgm.dat: 官方切片 raw/*.wav
    out_bgm = OUT_ROOT / 'thbgm.dat'
    out_bgm.mkdir(parents=True)
    # thbgm 用现有切片(raw 在 release bgm/raw 已由官方规范切分)
    raw_src = ROOT / 'release' / 'tsa' / code / 'bgm' / 'raw'
    conv_list = CONV.get('thbgm.dat', [])
    n = 0
    if raw_src.exists():
        for cpath in conv_list:
            cand = raw_src / pathlib.Path(cpath).name
            if cand.exists() and cand.is_file():
                dst = out_bgm / 'raw' / pathlib.Path(cpath).name
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(cand, dst)
                n += 1
    fmt_src = ROOT / 'release' / 'tsa' / code / 'dat' / 'thbgm.fmt'
    if fmt_src.exists():
        shutil.copy2(fmt_src, out_bgm / 'thbgm.fmt')
    print('  thbgm.dat: %d raw wav' % n)

    # 4. 二拆(后a)
    for rel in sorted(SECOND):
        local = rel
        src_f = out_main / local
        if not src_f.exists():
            continue
        # th18+ 二拆少, 用 release 产物兜底
        lvl2 = SECOND[rel]
        if src_f.exists() and src_f.is_file():
            src_f.unlink()
        sl_dir = out_main / local
        sl_dir.mkdir(parents=True, exist_ok=True)
        base = ROOT / 'release' / 'tsa' / code / 'msg_txt'
        for cpath in lvl2:
            cand = base / cpath
            if cand.exists() and cand.is_file():
                shutil.copy2(cand, sl_dir / pathlib.Path(cpath).name)
        print('  二拆 %s' % rel)

    print('=== %s 完成 ===' % code)

if __name__ == '__main__':
    do_game(sys.argv[1], {'th18': 18, 'th185': 185, 'th19': 19, 'th20': 20}.get(sys.argv[1], 18))
