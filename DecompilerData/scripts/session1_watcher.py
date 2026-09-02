# Session 1 watcher: wait for th10 -> attach -> wait for ECL -> arm -> sample -> report
import ctypes, ctypes.wintypes as wt, struct, subprocess, re, time

k32 = ctypes.windll.kernel32
DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001
EXCEPTION_SINGLE_STEP = 0x80000004
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
SIG = open(r'E:\GitWorkspace\thworks\re_work\dyn\th10\stage01.ecl', 'rb').read()[0x20:0x58]

logf = open(LOG, 'w', encoding='utf-8')
def log(s):
    print(s, flush=True)
    logf.write(s + '\n'); logf.flush()

def find_pid():
    out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                         capture_output=True).stdout.decode('gbk', 'replace')
    m = re.search(r'"th10\.exe","(\d+)"', out)
    return int(m.group(1)) if m else 0

def rpm(hproc, addr, size):
    chunks = []
    off = 0
    CH = 4 * 1024 * 1024
    while off < size:
        n = min(CH, size - off)
        buf = ctypes.create_string_buffer(n)
        got = ctypes.c_size_t(0)
        if not k32.ReadProcessMemory(hproc, ctypes.c_void_p(addr + off), buf, n, ctypes.byref(got)):
            return None if off == 0 else b''.join(chunks)
        chunks.append(buf.raw[:got.value])
        if got.value < n:
            break
        off += n
    return b''.join(chunks)

def get_ctx(hthread):
    c = WOW64_CONTEXT(); c.ContextFlags = WOW64_CONTEXT_ALL
    return c if k32.Wow64GetThreadContext(hthread, ctypes.byref(c)) else None

def set_ctx(hthread, c):
    return bool(k32.Wow64SetThreadContext(hthread, ctypes.byref(c)))

def arm_scpt(hthread, sites):
    c = get_ctx(hthread)
    if not c: return False
    c.Dr1 = sites[0] + 0x34
    c.Dr2 = sites[0] + 0x44
    c.Dr3 = sites[0] + 0x100
    c.Dr7 = (c.Dr7 & ~0x000F000E) | 0x0015000A
    return set_ctx(hthread, c)

def enum_regions(hproc):
    out = []
    addr = 0
    mbi = MBI64()
    while addr < 0x7fff0000:
        if not k32.VirtualQueryEx(hproc, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
            break
        if mbi.State == 0x1000 and mbi.Protect in (0x02, 0x04, 0x08, 0x20, 0x40, 0x80) and mbi.RegionSize <= 0x10000000:
            out.append((mbi.BaseAddress, mbi.RegionSize))
        addr = mbi.BaseAddress + mbi.RegionSize
    return out

def find_ecl(hproc):
    hits = {}
    for (rb, rs) in enum_regions(hproc):
        blob = rpm(hproc, rb, rs)
        if not blob: continue
        off = 0
        while True:
            off = blob.find(SIG, off)
            if off < 0: break
            hits[rb + off - 0x20] = 1
            off += 1
    return hits

def thread_ids(pid):
    class THREADENTRY32(ctypes.Structure):
        _fields_ = [('dwSize', wt.DWORD), ('cntUsage', wt.DWORD), ('th32ThreadID', wt.DWORD),
                    ('th32OwnerProcessID', wt.DWORD), ('tpDeltaPri', ctypes.c_long),
                    ('dwFlags', wt.DWORD), ('pad', ctypes.c_byte * 4)]
    snap = k32.CreateToolhelp32Snapshot(4, 0)
    te = THREADENTRY32(); te.dwSize = ctypes.sizeof(te)
    out = []
    if k32.Thread32First(snap, ctypes.byref(te)):
        while True:
            if te.th32OwnerProcessID == pid:
                out.append(te.th32ThreadID)
            if not k32.Thread32Next(snap, ctypes.byref(te)):
                break
    k32.CloseHandle(snap)
    return out

def main():
    # phase 1: wait for the game to appear
    pid = 0
    for _ in range(100):
        pid = find_pid()
        if pid: break
        time.sleep(3)
    if not pid:
        log('no th10 appeared'); return
    log('game found pid=%d' % pid)

    # phase 2: attach
    ok = False
    for _ in range(10):
        if k32.DebugActiveProcess(ctypes.c_uint(pid)):
            ok = True; break
        time.sleep(3)
    if not ok:
        log('attach failed'); return
    log('attached')
    ev = DEBUG_EVENT()
    hproc = k32.OpenProcess(0x001F0FFF, False, pid)
    # CRITICAL: drain initial breakpoint so the game resumes running
    ev0 = DEBUG_EVENT()
    drained = 0
    while True:
        if k32.WaitForDebugEvent(ctypes.byref(ev0), 1000):
            drained += 1
            if ev0.dwDebugEventCode == 6:
                hfile = struct.unpack_from('<Q', bytes(ev0.u.raw), 0)[0]
                if hfile: k32.CloseHandle(ctypes.c_void_p(hfile))
            k32.ContinueDebugEvent(ev0.dwProcessId, ev0.dwThreadId, DBG_CONTINUE)
        else:
            break
    log('drained %d events - game resumed' % drained)

    # phase 3: wait for ECL in memory (user enters stage)
    sites = []
    for attempt in range(240):
        # pump debug events (loading thread may throw first-chance exceptions
        # that MUST be continued or the game deadlocks)
        if k32.WaitForDebugEvent(ctypes.byref(ev), 0):
            ec0 = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            st = DBG_CONTINUE if ec0 in (0x80000003, 0x80000004, 0x4000001f) else DBG_EXCEPTION_NOT_HANDLED
            # first-chance C++/AV exceptions in the loader: pass to game SEH
            k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, st)
        hits = find_ecl(hproc)
        if hits:
            sites = sorted(hits)
            break
        if attempt % 8 == 0:
            log('waiting for stage load... (%d)' % attempt)
        time.sleep(0.4)
    if not sites:
        log('no ECL found within window; detach')
        k32.DebugActiveProcessStop(ctypes.c_uint(pid)); return
    log('ECL buffers: ' + ', '.join(hex(s) for s in sites))

    # phase 4: arm all threads
    for tid in thread_ids(pid):
        ht = k32.OpenThread(0x001F03FF, False, tid)
        if ht:
            k32.SuspendThread(ht)
            arm_scpt(ht, sites)
            k32.ResumeThread(ht)
            k32.CloseHandle(ht)
    log('armed on %d threads' % len(thread_ids(pid)))

    # phase 5: sample
    ev = DEBUG_EVENT()
    t0 = time.time()
    ips = []
    done = False
    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > 180:
                log('sample window ended')
                break
            continue
        code = ev.dwDebugEventCode
        status = DBG_CONTINUE
        if code == 1:
            exc = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            if exc == EXCEPTION_SINGLE_STEP:
                ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
                if ht:
                    c = get_ctx(ht)
                    if c:
                        ips.append(c.Eip)
                        c.Dr6 = 0
                        set_ctx(ht, c)
                    k32.CloseHandle(ht)
                if len(ips) >= 4000:
                    log('sampled 4000'); done = True
                status = DBG_CONTINUE
            else:
                status = DBG_EXCEPTION_NOT_HANDLED
        elif code == 2:
            ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
            if ht:
                k32.SuspendThread(ht)
                arm_scpt(ht, sites)
                k32.ResumeThread(ht)
                k32.CloseHandle(ht)
            status = DBG_CONTINUE
        elif code == 5:
            log('game exited while sampling'); done = True
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)

    k32.DebugActiveProcessStop(ctypes.c_uint(pid))
    log('=== RESULT ===')
    log('ECL sites: ' + ', '.join(hex(s) for s in sites))
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
