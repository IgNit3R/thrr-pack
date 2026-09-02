import re, sys
sys.stdout.reconfigure(encoding='utf-8')
txt = open(r'E:\GitWorkspace\thworks\re_work\task2_backlog.md', encoding='utf-8').read()
out = []
for line in txt.split('\n'):
    m = re.match(r'\| ([BCD]\d+) \| (🔄|⬜) \|(.*)', line)
    if m:
        status = 'RUNNING' if m.group(2) == '🔄' else 'PENDING'
        desc = m.group(3).split('｜')[0].split('|')[0].strip()
        out.append('%s %s [%s] %s' % (m.group(2), m.group(1), status, desc[:90]))
with open(r'E:\GitWorkspace\thworks\re_work\remaining_items.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(out))
print('written', len(out))
