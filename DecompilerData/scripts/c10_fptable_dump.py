# C10: dump th20 .fptable from a running process, map entries to functions
import ctypes, ctypes.wintypes as wt, subprocess, re, struct, time, sys

k32 = ctypes.windll.kernel32
psapi = ctypes.windll.psapi

LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th20\c10_fptable_dump.txt'
FPTABLE_RVA = 0x1E6000
FPTABLE_SIZE = 0x200

logf = open(LOG, 'w', encoding='utf-8')
def log(s):
    print(s, flush=True)
    logf.write(s + '\n'); logf.flush()

def find_pid():
    out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th20.exe', '/FO', 'CSV'],
                         capture_output=True).stdout.decode('gbk', 'replace')
    m = re.search(r'"th20\.exe","(\d+)"', out)
    return int(m.group(1)) if m else 0

def get_module_base(hproc, pid):
    arr = (wt.HMODULE * 64)()
    needed = wt.DWORD()
    if not psapi.EnumProcessModulesEx(hproc, ctypes.byref(arr), ctypes.sizeof(arr), ctypes.byref(needed), 3):
        return None
    n = needed.value // ctypes.sizeof(wt.HMODULE)
    for i in range(n):
        hm = wt.HMODULE(arr[i])
        name = ctypes.create_unicode_buffer(260)
        psapi.GetModuleFileNameExW(hproc, hm, name, 260)
        if name.value.lower().endswith('th20.exe'):
            class MODULEINFO(ctypes.Structure):
                _fields_ = [('lpBaseOfDll', ctypes.c_void_p), ('SizeOfImage', wt.DWORD),
                            ('EntryPoint', ctypes.c_void_p)]
            mi = MODULEINFO()
            psapi.GetModuleInformation(hproc, hm, ctypes.byref(mi), ctypes.sizeof(mi))
            return mi.lpBaseOfDll, name.value
    return None

def main():
    pid = 0
    for _ in range(100):
        pid = find_pid()
        if pid: break
        time.sleep(3)
    if not pid:
        log('no th20 appeared'); return
    log('th20 pid=%d' % pid)
    hproc = k32.OpenProcess(0x001F0FFF, False, pid)
    if not hproc:
        log('open failed err=%d' % k32.GetLastError()); return

    base = None
    for _ in range(10):
        r = get_module_base(hproc, pid)
        if r: base = r[0]; break
        time.sleep(2)
    if base is None:
        log('module base not found'); return
    log('th20.exe base = %s' % hex(base))

    def dump(tag):
        buf = ctypes.create_string_buffer(FPTABLE_SIZE)
        got = ctypes.c_size_t(0)
        ok = k32.ReadProcessMemory(hproc, ctypes.c_void_p(base + FPTABLE_RVA), buf, FPTABLE_SIZE, ctypes.byref(got))
        vals = [struct.unpack_from('<I', buf.raw, i)[0] for i in range(0, got.value, 4)]
        nz = [(i, v) for i, v in enumerate(vals) if v]
        log('[%s] entries=%d nonzero=%d' % (tag, len(vals), len(nz)))
        for i, v in nz:
            log('  [%3d] %08x (module+%08x)' % (i, v, v - base if v >= base else 0))
        return vals

    # map function ranges from th20 functions.csv
    funcs = []
    try:
        import csv
        with open(r'E:\GitWorkspace\thworks\re_work\decomp\th20\functions.csv', encoding='utf-8') as f:
            for row in csv.DictReader(f):
                try:
                    a = int(row['entry'], 16); s = int(row['size'])
                    funcs.append((a, a + s, row['name']))
                except Exception:
                    pass
        funcs.sort()
    except Exception:
        pass

    def which_func(rva):
        va = 0x400000 + rva  # decomp assumed base 0x400000
        import bisect
        lo, hi = 0, len(funcs) - 1
        while lo <= hi:
            mid = (lo + hi) // 2
            a, b, n = funcs[mid]
            if va < a: hi = mid - 1
            elif va >= b: lo = mid + 1
            else: return n
        return None

    v1 = dump('title-time dump 1')
    time.sleep(20)
    v2 = dump('dump 2 (+20s)')
    time.sleep(20)
    v3 = dump('dump 3 (+40s)')

    log('=== C10 RESULT ===')
    log('changed entries between dumps:')
    for i, (a, b, c) in enumerate(zip(v1, v2, v3)):
        if a != b or b != c:
            fn = which_func(c - base) if c else None
            log('  [%3d] %s -> %s -> %s  func=%s' % (i, hex(a), hex(b), hex(c), fn or '?'))
    nz3 = [(i, v) for i, v in enumerate(v3) if v]
    log('final nonzero entries and functions:')
    for i, v in nz3:
        fn = which_func(v - base) if v >= base else None
        log('  [%3d] %08x module+%08x func=%s' % (i, v, v - base, fn or '?'))
    logf.close()

if __name__ == '__main__':
    main()
