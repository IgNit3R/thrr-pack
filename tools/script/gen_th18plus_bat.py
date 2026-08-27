# -*- coding: utf-8 -*-
"""生成 th18+ 官方工具批处理脚本(由提权 pwsh 执行)"""
import pathlib, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
TOOL_BIN = ROOT / '.build' / 'thtk-install' / 'bin'
tsa = json.loads((ROOT/'.build'/'filetree'/'tsa_tree_data.json').read_text(encoding='utf-8'))
VER = {'th18': 18, 'th185': 185, 'th19': 19, 'th20': 20}
TOOLS = {'.anm': 'thanm.exe', '.ecl': 'thecl.exe', '.std': 'thstd.exe', '.msg': 'thmsg.exe'}
TOOL_ARGS = {  # (选项, 是否需要显式输出)
    '.anm': ('-x', False),   # thanm -x VERSION ARCHIVE(输出到 CWD 子目录)
    '.ecl': ('-d', True),    # thecl -d VERSION INPUT OUTPUT
    '.std': ('-d', True),    # thstd -d VERSION INPUT OUTPUT
    '.msg': ('-d', True),    # thmsg -d VERSION INPUT OUTPUT
}

def gen_bat(code):
    D = tsa[code]
    CONV = D['conversions']
    out_main = ROOT / 'pushfiles' / code / (code + '.dat')
    L = []
    L.append('@echo off')
    L.append('setlocal')
    L.append('set PATH=' + str(TOOL_BIN) + ';%PATH%')
    L.append('set OUT=' + str(out_main))
    L.append('if exist "%OUT%" rmdir /s /q "%OUT%"')
    L.append('mkdir "%OUT%"')
    src = ROOT / 'tsa' / code / (code + '.dat')
    L.append('cd /d "%OUT%"')
    L.append('thdat.exe -x %d "%s"' % (VER[code], src))
    for rel in sorted(CONV):
        if rel == 'thbgm.dat':
            continue
        ext = pathlib.Path(rel).suffix.lower()
        tool = TOOLS.get(ext)
        if tool is None:
            continue
        work = '_work_' + rel.replace('/', '_').replace('.', '_')
        L.append('if exist "%OUT%\\' + work + '" rmdir /s /q "%OUT%\\' + work + '"')
        L.append('mkdir "%OUT%\\' + work + '"')
        L.append('copy /y "%OUT%\\' + rel + '" "%OUT%\\' + work + '\\' + rel + '" >nul')
        L.append('cd /d "%OUT%\\' + work + '"')
        opt, need_out = TOOL_ARGS[ext]
        # 命名规则: ecl/std -> <stem>.<ext>.txt (与 release 一致); msg -> <stem>.txt
        if ext == '.ecl':
            out_name = pathlib.Path(rel).stem + '.ecl.txt'
        elif ext == '.std':
            out_name = pathlib.Path(rel).stem + '.std.txt'
        elif ext == '.msg':
            out_name = pathlib.Path(rel).stem + '.txt'
        else:
            out_name = None
        if need_out and out_name:
            L.append('%s %s %d %s %s' % (tool, opt, VER[code], rel, out_name))
        else:
            L.append('%s %s %d %s' % (tool, opt, VER[code], rel))
        L.append('cd /d "%OUT%"')
        L.append('del /q "%OUT%\\' + rel + '"')
        L.append('del /q "%OUT%\\' + work + '\\' + rel + '"')
        L.append('mkdir "%OUT%\\' + rel + '"')
        L.append('xcopy /e /y /q "%OUT%\\' + work + '\\*" "%OUT%\\' + rel + '\\" >nul')
        L.append('rmdir /s /q "%OUT%\\' + work + '"')
    L.append('echo === %s 转换完成 ===' % code)
    bat = ROOT / '.build' / 'filetree' / ('_run_%s.bat' % code)
    bat.write_text('\r\n'.join(L), encoding='utf-8')
    print('生成', bat)

if __name__ == '__main__':
    for code in ['th18', 'th185', 'th19', 'th20']:
        gen_bat(code)
