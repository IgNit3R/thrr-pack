# C7: th13 0xBC8 pool attribution - HW access BPs spread across the pool
import ctypes, ctypes.wintypes as wt, struct, subprocess, re, time, sys

k32 = ctypes.windll.kernel32
DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001
EXCEPTION_SINGLE_STEP = 0x80000004
WOW64_CONTEXT_ALL = 0x1003F

class WOW64_CONTEXT(ctypes.Structure):
    _fields_ = [('ContextFlags', wt.DWORD), ('Dr0', wt.DWORD), ('Dr1', wt.DWORD),
        ('Dr2', wt.DWORD), ('Dr3', wt.DWORD), ('Dr6', wt.DWORD), ('Dr7', wt.DWORD),
        ('FloatSave', ctypes.c_byte * 112), ('SegGs', wt.DWORD), ('SegFs', wt.DWORD),
        ('SegEs', wt.DWORD), ('SegDs', wt.DWORD), ('Edi', wt.DWORD), ('Esi', wt.DWORD),
        ('Ebx', wt.DWORD), ('Edx', wt.DWORD), ('Ecx', wt.DWORD), ('Eax', wt.DWORD),
        ('Ebp', wt.DWORD), ('Eip', wt.DWORD), ('SegCs', wt.DWORD), ('EFlags', wt.DWORD),
        ('Esp', wt.DWORD), ('SegSs', wt.DWORD), ('ExtendedRegisters', ctypes.c_byte * 512)]

class DEBUG_EVENT(ctypes.Structure):
    class _U(ctypes.Union):
        _fields_ = [('raw', ctypes.c_byte * 160)]
    _fields_ = [('dwDebugEventCode', wt.DWORD), ('dwProcessId', wt.DWORD),
                ('dwThreadId', wt.DWORD), ('u', _U)]

LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th13\c7_log.txt'
TIMEOUT = 240

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

def get_ctx(ht):
    c = WOW64_CONTEXT(); c.ContextFlags = WOW64_CONTEXT_ALL
    return c if k32.Wow64GetThreadContext(ht, ctypes.byref(c)) else None

def set_ctx(ht, c):
    return bool(k32.Wow64SetThreadContext(ht, ctypes.byref(c)))

def find_pid():
    out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th13.exe', '/FO', 'CSV'],
                         capture_output=True).stdout.decode('gbk', 'replace')
    m = re.search(r'"th13\.exe","(\d+)"', out)
    return int(m.group(1)) if m else 0

def main():
    pid = int(sys.argv[1])
    if not k32.DebugActiveProcess(ctypes.c_uint(pid)):
        log('attach failed err=%d' % k32.GetLastError()); return
    log('attached %d' % pid)
    # extend arena wait: poll up to 180s (user enters stage at their pace)
    old_wait = None
    hproc = k32.OpenProcess(0x001F0FFF, False, pid)
    ev = DEBUG_EVENT()
    # drain
    while True:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 1000):
            break
        if ev.dwDebugEventCode == 6:
            hf = struct.unpack_from('<Q', bytes(ev.u.raw), 0)[0]
            if hf: k32.CloseHandle(ctypes.c_void_p(hf))
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, DBG_CONTINUE)
    log('drained; game running')

    # read arena pointer
    arena = None
    for _ in range(60):
        raw = rpm(hproc, 0x4DC688, 4)
        if raw:
            arena = struct.unpack('<I', raw)[0]
            if 0x10000 < arena < 0x7fff0000: break
            arena = None
        # pump events while waiting
        if k32.WaitForDebugEvent(ctypes.byref(ev), 0):
            k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, DBG_CONTINUE)
        time.sleep(2)
    if not arena:
        log('arena null - not in stage?'); k32.DebugActiveProcessStop(pid); return
    log('arena = %08x' % arena)
    pool_base = arena + 0x14
    pool_size = 0xA58 * 0xBC8
    log('pool %08x - %08x (0xBC8 x 0xA58)' % (pool_base, pool_base + pool_size))

    # arm 4 HW access BPs spread across the pool
    watch = [pool_base + 0x10000, pool_base + 0x200000, pool_base + 0x400000, pool_base + 0x600000]
    ips = []
    t0 = time.time()

    def arm(ht):
        c = get_ctx(ht)
        if not c: return
        for i, a in enumerate(watch):
            setattr(c, 'Dr%d' % i, a)
        c.Dr6 = 0
        c.Dr7 = 0xF00F0F  # L0-L3, RW=11 (read/write), LEN=00
        set_ctx(ht, c)

    # arm existing threads
    class TE32(ctypes.Structure):
        _fields_ = [('dwSize', wt.DWORD), ('cntUsage', wt.DWORD), ('th32ThreadID', wt.DWORD),
                    ('th32OwnerProcessID', wt.DWORD), ('tpDeltaPri', ctypes.c_long),
                    ('dwFlags', wt.DWORD), ('pad', ctypes.c_byte * 4)]
    snap = k32.CreateToolhelp32Snapshot(4, 0)
    te = TE32(); te.dwSize = ctypes.sizeof(te)
    if k32.Thread32First(snap, ctypes.byref(te)):
        while True:
            if te.th32OwnerProcessID == pid:
                ht = k32.OpenThread(0x001F03FF, False, te.th32ThreadID)
                if ht:
                    k32.SuspendThread(ht)
                    arm(ht)
                    k32.ResumeThread(ht)
                    k32.CloseHandle(ht)
            if not k32.Thread32Next(snap, ctypes.byref(te)):
                break
    k32.CloseHandle(snap)
    log('armed 4 watchpoints on all threads')

    done = False
    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > TIMEOUT:
                log('window ended'); break
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
                if len(ips) >= 300:
                    log('sampled 300'); done = True
                status = DBG_CONTINUE
            else:
                status = DBG_EXCEPTION_NOT_HANDLED
        elif code == 2:  # new thread: arm it
            ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
            if ht:
                arm(ht); k32.CloseHandle(ht)
            status = DBG_CONTINUE
        elif code == 5:
            log('game exited'); done = True
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)

    try: k32.DebugActiveProcessStop(ctypes.c_uint(pid))
    except Exception: pass
    log('=== C7 RESULT ===')
    log('samples: %d' % len(ips))
    from collections import Counter
    for ip, n in Counter(ips).most_common(25):
        log('  EIP %08x x%d' % (ip, n))
    logf.close()

if __name__ == '__main__':
    try:
        main()
    except Exception:
        import traceback
        log('FATAL: ' + traceback.format_exc())
