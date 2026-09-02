import re, hashlib, sys
from collections import defaultdict

def load(path):
    txt = open(path, encoding='utf-8', errors='replace').read()
    funcs = {}
    for m in re.finditer(r'// ===== FUNC (\S+) @ ([0-9a-f]+) \(size=(\d+)\) =====\n(.*?)(?=// ===== FUNC |\Z)', txt, re.S):
        name, addr, size, body = m.group(1), m.group(2), int(m.group(3)), m.group(4)
        # normalize: strip addresses, FUN_ names, whitespace
        b = re.sub(r'FUN_[0-9a-f]{7}', 'F', body)
        b = re.sub(r'DAT_[0-9a-f]{7}', 'D', b)
        b = re.sub(r'LAB_[0-9a-f]{7}', 'L', b)
        b = re.sub(r'0x[0-9a-f]{6,8}', 'A', b)
        b = re.sub(r'\s+', '', b)
        h = hashlib.md5(b.encode('utf-8', 'ignore')).hexdigest()
        funcs[addr] = (name, size, h, b)
    return funcs

a = load(sys.argv[1])
b = load(sys.argv[2])
ha = defaultdict(list)
for addr, (n, s, h, body) in a.items():
    if s >= 64:
        ha[h].append((addr, n, s))
matched = 0
matched_bytes = 0
total_bytes = sum(s for (n, s, h, body) in b.values() if s >= 64)
samples = []
for addr, (n, s, h, body) in b.items():
    if s >= 64 and h in ha:
        matched += 1
        matched_bytes += s
        if len(samples) < 5 and s > 500:
            samples.append((n, hex(addr), s, ha[h][0][1], ha[h][0][0]))
print(f'B-side funcs(>=64B): {len([1 for (n,s,h,bo) in b.values() if s>=64])}, matched(exact-normalized): {matched}')
print(f'byte coverage: {matched_bytes}/{total_bytes} = {matched_bytes/total_bytes*100:.1f}%')
print('sample matches (th123 -> th105):')
for s in samples: print('  ', s)
