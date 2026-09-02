# Find threaded-VM dispatch tables in a decomp target: runs of >=N consecutive
# .text pointers that all point INSIDE a single function (mid-function labels).
import pefile, struct, re, sys

exe, decomp = sys.argv[1], sys.argv[2]
pe = pefile.PE(exe, fast_load=True)
data = open(exe, 'rb').read()

# function ranges from functions.csv (entry,size)
funcs = []
import csv
with open(decomp, encoding='utf-8') as f:
    rd = csv.DictReader(f)
    for row in rd:
        try:
            a = int(row['entry'], 16); s = int(row['size'])
        except (ValueError, TypeError):
            continue
        funcs.append((a, a + s, row['name']))
funcs.sort()

def in_func(va):
    # binary search
    lo, hi = 0, len(funcs) - 1
    while lo <= hi:
        mid = (lo + hi) // 2
        a, b, n = funcs[mid]
        if va < a: hi = mid - 1
        elif va >= b: lo = mid + 1
        else: return n
    return None

t = [s for s in pe.sections if s.Name.decode().rstrip(chr(0)) == '.text'][0]
lo, hi = 0x400000 + t.VirtualAddress, 0x400000 + t.VirtualAddress + t.Misc_VirtualSize
base = t.PointerToRawData
sz = t.SizeOfRawData

# scan for runs of consecutive pointers into .text that map into a single function
runs = []
i = 0
while i < sz - 4:
    v = struct.unpack_from('<I', data, base + i)[0]
    if lo <= v < hi:
        fn = in_func(v)
        if fn:
            j = i
            cnt = 0
            last = None
            while j < sz - 4:
                v2 = struct.unpack_from('<I', data, base + j)[0]
                if not (lo <= v2 < hi): break
                f2 = in_func(v2)
                if f2 != fn: break
                cnt += 1
                last = v2
                j += 4
            if cnt >= 10:
                va = 0x400000 + t.VirtualAddress + (i - base)
                runs.append((va, cnt, fn))
            i = j
            continue
    i += 4

print('threaded-VM candidate tables (>=10 entries, single function):')
for va, cnt, fn in sorted(runs, key=lambda x: -x[1]):
    print('  table VA %08x  entries=%-4d  host function=%s' % (va, cnt, fn))
