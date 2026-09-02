# Session 1 final: attach -> find ECL -> guard-page traps -> sample interpreter IPs
import ctypes, ctypes.wintypes as wt, struct, subprocess, re, time, sys

k32 = ctypes.windll.kernel32
DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001
EXCEPTION_SINGLE_STEP = 0x80000004
STATUS_GUARD_PAGE = 0x80000001
WOW64_CONTEXT_ALL = 0x1003F

class WOW64_CONTEXT(ctypes.Structure):
    _fields_ = [
        ('ContextFlags', wt.DWORD),
        ('Dr0', wt.DWORD), ('Dr1', wt.DWORD), ('Dr2', wt.DWORD), ('Dr3', wt.DWORD),
        ('Dr6', wt.DWORD), ('Dr7', wt.DWORD),
        ('FloatSave', ctypes.c_byte * 112),
        ('SegGs', wt.DWORD), ('SegFs', wt.DWORD), ('SegEs', wt.DWORD), ('SegDs', wt.DWORD),
        ('Edi', wt.DWORD), ('Esi', wt.DWORD), ('Ebx', wt.DWORD), ('Edx', wt.DWORD),
        ('Ecx', wt.DWORD), ('Eax', wt.DWORD),
        ('Ebp', wt.DWORD), ('Eip', wt.DWORD), ('SegCs', wt.DWORD), ('EFlags', wt.DWORD),
        ('Esp', wt.DWORD), ('SegSs', wt.DWORD),
        ('ExtendedRegisters', ctypes.c_byte * 512)]

class DEBUG_EVENT(ctypes.Structure):
    class _U(ctypes.Union):
        _fields_ = [('raw', ctypes.c_byte * 160)]
    _fields_ = [('dwDebugEventCode', wt.DWORD), ('dwProcessId', wt.DWORD),
                ('dwThreadId', wt.DWORD), ('u', _U)]

class MBI64(ctypes.Structure):
    _fields_ = [('BaseAddress', ctypes.c_size_t), ('AllocationBase', ctypes.c_size_t),
                ('AllocationProtect', wt.DWORD), ('PartitionId', wt.DWORD),
                ('RegionSize', ctypes.c_size_t), ('State', wt.DWORD),
                ('Protect', wt.DWORD), ('Type', wt.DWORD), ('Reserved2', wt.DWORD)]

LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th10\session1_attach_log.txt'
_eclfile = open(r'E:\GitWorkspace\thworks\re_work\dyn\th10\stage01.ecl', 'rb').read()
SIGS = [_eclfile[0x1000:0x1010], _eclfile[0x2000:0x2010], _eclfile[0x4000:0x4010]]
TARGET_COUNT = 300

logf = open(LOG, 'w', encoding='utf-8')
def log(s):
    print(s, flush=True)
    logf.write(s + '\n'); logf.flush()

def rpm(hproc, addr, size):
    buf = ctypes.create_string_buffer(size)
    got = ctypes.c_size_t(0)
    if k32.ReadProcessMemory(hproc, ctypes.c_void_p(addr), buf, size, ctypes.byref(got)):
        return buf.raw[:got.value]
    return None

def get_ctx(hthread):
    c = WOW64_CONTEXT(); c.ContextFlags = WOW64_CONTEXT_ALL
    return c if k32.Wow64GetThreadContext(hthread, ctypes.byref(c)) else None

def enum_regions(hproc):
    out = []
    addr = 0
    mbi = MBI64()
    while addr < 0x7fff0000:
        if not k32.VirtualQueryEx(hproc, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
            break
        if mbi.State == 0x1000 and mbi.Protect in (0x04, 0x40) and mbi.RegionSize <= 0x10000000:
            out.append((mbi.BaseAddress, mbi.RegionSize))
        addr = mbi.BaseAddress + mbi.RegionSize
    return out

def find_ecl(hproc):
    hits = {}
    for (rb, rs) in enum_regions(hproc):
        blob = rpm(hproc, rb, rs)
        if not blob: continue
        for sig in SIGS:
            off = 0
            while True:
                off = blob.find(sig, off)
                if off < 0: break
                hits[(rb + off) & ~0xFFF] = 1
                off += 1
    return hits

GUARD_PROTECT = 0x104  # PAGE_READWRITE | PAGE_GUARD
def set_guard(hproc, pages):
    old = wt.DWORD()
    for p in pages:
        k32.VirtualProtectEx(hproc, ctypes.c_void_p(p), 0x1000, GUARD_PROTECT, ctypes.byref(old))

def find_pid():
    out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                         capture_output=True).stdout.decode('gbk', 'replace')
    m = re.search(r'"th10\.exe","(\d+)"', out)
    return int(m.group(1)) if m else 0

def main():
    pid = 0
    for _ in range(150):
        pid = find_pid()
        if pid: break
        time.sleep(3)
    if not pid:
        log('no game'); return
    if not k32.DebugActiveProcess(ctypes.c_uint(pid)):
        log('attach failed err=%d' % k32.GetLastError()); return
    log('attached to %d' % pid)
    hproc = k32.OpenProcess(0x001F0FFF, False, pid)
    ev = DEBUG_EVENT()

    # drain initial events so the game keeps running
    while True:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 1000):
            break
        if ev.dwDebugEventCode == 6:
            hfile = struct.unpack_from('<Q', bytes(ev.u.raw), 0)[0]
            if hfile: k32.CloseHandle(ctypes.c_void_p(hfile))
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, DBG_CONTINUE)
    log('drained; game running')

    # find ECL
    sites = []
    for attempt in range(240):
        hits = find_ecl(hproc)
        if hits:
            sites = sorted(hits)
            break
        if k32.WaitForDebugEvent(ctypes.byref(ev), 0):
            k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, DBG_CONTINUE)
        if attempt % 8 == 0:
            log('waiting for stage... (%d)' % attempt)
        time.sleep(0.4)
    if not sites:
        log('no ECL found; detach'); k32.DebugActiveProcessStop(ctypes.c_uint(pid)); return
    site = sites[0]
    log('ECL buffer: %s' % hex(site))

    # set guard pages inside the ECL body (instruction stream area)
    import struct as _s
    sz = _s.unpack_from('<I', open(r'E:\\GitWorkspace\\thworks\\re_work\\dyn\\th10\\stage01.ecl','rb').read(), 0)[0] if False else 0xBB34
    pages = list(range((site + 0x1000) & ~0xFFF, ((site + 0xBB34) & ~0xFFF) + 1, 0x1000))
    old = wt.DWORD()
    okv = []
    for pg in pages:
        r = k32.VirtualProtectEx(hproc, ctypes.c_void_p(pg), 0x1000, 0x104, ctypes.byref(old))
        okv.append((hex(pg), bool(r), hex(old.value)))
        if not r:
            k32.VirtualProtectEx(hproc, ctypes.c_void_p(pg), 0x1000, old.value, ctypes.byref(old))
    log('guard: ' + str(okv))
    if not any(o[1] for o in okv):
        log('guard setup failed'); k32.DebugActiveProcessStop(ctypes.c_uint(pid)); return

    # sample loop
    ips = []
    t0 = time.time()
    done = False
    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > 240:
                log('sample window ended')
                break
            continue
        code = ev.dwDebugEventCode
        status = DBG_CONTINUE
        if code == 1:
            exc = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            if exc == STATUS_GUARD_PAGE:
                ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
                if ht:
                    c = get_ctx(ht)
                    if c:
                        ips.append(c.Eip)
                    k32.CloseHandle(ht)
                set_guard(hproc, pages)  # re-arm (kernel auto-clears)
                if len(ips) >= TARGET_COUNT:
                    log('sampled %d' % len(ips)); done = True
                status = DBG_CONTINUE
            elif exc in (EXCEPTION_SINGLE_STEP, 0x80000003, 0x4000001f):
                status = DBG_CONTINUE
            else:
                status = DBG_EXCEPTION_NOT_HANDLED
        elif code == 5:
            ec = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            log('game exited code=%08x' % ec); done = True
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)

    try: k32.DebugActiveProcessStop(ctypes.c_uint(pid))
    except Exception: pass
    log('=== RESULT ===')
    log('samples: %d' % len(ips))
    from collections import Counter
    for ip, n in Counter(ips).most_common(40):
        log('  EIP %08x x%d' % (ip, n))
    logf.close()

if __name__ == '__main__':
    try:
        main()
    except Exception:
        import traceback
        log('FATAL: ' + traceback.format_exc())
