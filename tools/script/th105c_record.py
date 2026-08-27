# -*- coding: utf-8 -*-
"""th105c 映射 + 树状结构记录生成"""
import pathlib, sys, json
sys.stdout.reconfigure(encoding='utf-8')

ROOT = pathlib.Path(r'E:\GitWorkspace\thworks')
OUT = ROOT / 'pushfiles' / 'th105' / 'th105c.dat'
MAP = json.loads((ROOT/'.build'/'filetree'/'th105c_map.json').read_text(encoding='utf-8'))
DOC = ROOT / 'pushfiles' / 'th105' / 'th105c_映射与树状结构.md'

conv = MAP['conversions']
conv_files = MAP['conv_files']
dat_files = MAP['dat_files']

lines = []
lines.append('# th105c.dat 映射与树状结构记录')
lines.append('')
lines.append('> 生成日期: 2026-08-27')
lines.append('> 源档案: `tf\\th105\\th105c.dat`(13,268,665 B, 补丁后有效文件)')
lines.append('> 拆包工具: thtk thdat v12 `-x 105`; 转换工具: touhouSE(cv2/cv3) + 自研(cv0/cv1/pat)')
lines.append('> pushfiles 输出: `pushfiles\\th105\\th105c.dat\\`')
lines.append('')

# 统计
lines.append('## 统计')
lines.append('')
lines.append('| 项 | 数量 |')
lines.append('|---|---|')
lines.append('| 拆包文件 | %d |' % len(dat_files))
lines.append('| 转换源 | %d |' % len(conv))
lines.append('| 转换产物 | %d |' % len(conv_files))
src_ext = {}
for k in conv:
    e = k.split('.')[-1].lower()
    src_ext[e] = src_ext.get(e, 0) + 1
prod_ext = {}
for k in conv_files:
    e = k.split('.')[-1].lower()
    prod_ext[e] = prod_ext.get(e, 0) + 1
lines.append('| 转换源类型 | %s |' % src_ext)
lines.append('| 转换产物类型 | %s |' % prod_ext)
lines.append('')

# 树状结构(按实际落盘目录树)
lines.append('## 树状结构')
lines.append('')
lines.append('```')
lines.append('th105c.dat/')
def render_dir(d, prefix, is_last_path):
    items = sorted(d.iterdir(), key=lambda x: (not x.is_dir(), x.name))
    for i, item in enumerate(items):
        last = (i == len(items) - 1)
        conn = '└─ ' if last else '├─ '
        lines.append(prefix + conn + item.name + ('/' if item.is_dir() else ''))
        if item.is_dir():
            child_prefix = prefix + ('    ' if last else '│   ')
            render_dir(item, child_prefix, last)
render_dir(OUT, '', True)
lines.append('```')
lines.append('')

# 映射表
lines.append('## 转换映射(源 -> 产物)')
lines.append('')
lines.append('| 源文件 | 转换产物 |')
lines.append('|---|---|')
for rel in sorted(conv):
    prods = conv[rel]
    for p in prods:
        lines.append('| %s | %s |' % (rel, p))
lines.append('')

DOC.write_text('\n'.join(lines), encoding='utf-8')
print('已生成:', DOC)
print('行数:', len(lines))
