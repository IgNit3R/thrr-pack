# Session 1 attach mode: attach to running th10, find SCPT, arm data BPs on
# existing threads, sample EIPs.
import ctypes, ctypes.wintypes as wt, struct, sys, time, threading

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

LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th10\session1_attach_log.txt'
TIMEOUT = 120

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

def set_ctx(hthread, c):
    return bool(k32.Wow64SetThreadContext(hthread, ctypes.byref(c)))

def arm_scpt(hthread, sites):
    c = get_ctx(hthread)
    if not c: return False
    c.Dr1 = sites[0] if len(sites) > 0 else 0
    c.Dr2 = sites[1] if len(sites) > 1 else 0
    c.Dr3 = sites[2] if len(sites) > 2 else 0
    c.Dr7 = (c.Dr7 & ~0x000F000E) | 0x0015000A  # L1-L3 enable, RW=11, LEN=00
    return set_ctx(hthread, c)

class MBI64(ctypes.Structure):
    _fields_ = [('BaseAddress', ctypes.c_size_t), ('AllocationBase', ctypes.c_size_t),
                ('AllocationProtect', wt.DWORD), ('PartitionId', wt.DWORD),
                ('RegionSize', ctypes.c_size_t), ('State', wt.DWORD),
                ('Protect', wt.DWORD), ('Type', wt.DWORD), ('Reserved2', wt.DWORD)]

def enum_private_rw(hproc):
    out = []
    addr = 0
    mbi = MBI64()
    while addr < 0x7fff0000:
        if not k32.VirtualQueryEx(hproc, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
            break
        base, size, state, protect, typ = mbi.BaseAddress, mbi.RegionSize, mbi.State, mbi.Protect, mbi.Type
        if state == 0x1000 and protect in (0x02, 0x04, 0x08, 0x20, 0x40, 0x80) and size <= 0x10000000:
            out.append((base, size))
        addr = base + size
    return out

def find_scpt(hproc):
    hits = {}
    sanity = 0
    SIG = open(r'E:\GitWorkspace\thworks\re_work\dyn\th10\stage01.ecl', 'rb').read()[0x20:0x58]
    nreg = 0; tot = 0
    for (rb, rs) in enum_private_rw(hproc):
        blob = rpm(hproc, rb, rs)
        if not blob: continue
        nreg += 1; tot += len(blob)
        if b'Mountain of Faith' in blob: sanity += 1
        off = 0
        while True:
            off = blob.find(SIG, off)
            if off < 0: break
            hits[rb + off - 0x20] = hits.get(rb + off - 0x20, 0) + 1
            off += 1
    log('sanity: %d, regions scanned: %d, bytes: %d' % (sanity, nreg, tot))
    return hits

def thread_ids(pid):
    # snapshot via CreateToolhelp32Snapshot
    TH32CS_SNAPTHREAD = 4
    class THREADENTRY32(ctypes.Structure):
        _fields_ = [('dwSize', wt.DWORD), ('cntUsage', wt.DWORD), ('th32ThreadID', wt.DWORD),
                    ('th32OwnerProcessID', wt.DWORD), ('tpDeltaPri', ctypes.c_long),
                    ('dwFlags', wt.DWORD)]
    snap = k32.CreateToolhelp32Snapshot(TH32CS_SNAPTHREAD, 0)
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
    pid = int(sys.argv[1])
    if not k32.DebugActiveProcess(ctypes.c_uint(pid)):
        log('attach failed err=%d' % k32.GetLastError()); return
    log('attached to %d' % pid)
    hproc = k32.OpenProcess(0x001F0FFF, False, pid)
    if not hproc:
        log('open proc failed'); return

    # find SCPT sites
    hits = {}
    for attempt in range(36):
        hits = find_scpt(hproc)
        if hits: break
        log('no SCPT yet (attempt %d), waiting 5s...' % attempt)
        k32.DebugActiveProcessStop(ctypes.c_uint(pid))
        time.sleep(5)
        if not k32.DebugActiveProcess(ctypes.c_uint(pid)):
            log('reattach failed'); return
    if not hits:
        log('no SCPT found — user not in a stage? aborting (detached)')
        k32.DebugActiveProcessStop(ctypes.c_uint(pid)); return
    log('SCPT sites: ' + ', '.join('%s(%d)' % (hex(k), v) for k, v in sorted(hits.items())))

    sites = sorted(hits)[:3]
    # arm on all threads
    for tid in thread_ids(pid):
        ht = k32.OpenThread(0x001F03FF, False, tid)
        if ht:
            arm_scpt(ht, sites)
            k32.CloseHandle(ht)
    log('armed on threads: ' + ', '.join(str(t) for t in thread_ids(pid)))

    ev = DEBUG_EVENT()
    t0 = time.time()
    ips = []
    done = False
    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > TIMEOUT:
                log('sampling window ended')
                break
            continue
        code = ev.dwDebugEventCode
        status = DBG_CONTINUE
        if code == 1:
            exc = ev.u.Exception.ExceptionCode
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
                    log('sampling complete: %d' % len(ips)); done = True
                status = DBG_CONTINUE
            else:
                status = DBG_EXCEPTION_NOT_HANDLED
        elif code == 2:  # new thread: arm it too
            ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
            if ht:
                arm_scpt(ht, sites); k32.CloseHandle(ht)
            status = DBG_CONTINUE
        elif code == 5:
            log('process exiting'); done = True
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)

    k32.DebugActiveProcessStop(ctypes.c_uint(pid))
    log('=== RESULT ===')
    log('samples: %d' % len(ips))
    from collections import Counter
    for ip, n in Counter(ips).most_common(40):
        log('  EIP %08x x%d' % (ip, n))
    logf.close()

if __name__ == '__main__':
    main()
