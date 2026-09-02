# Session 1 v3: hardware-exec-breakpoint based (no int3 patching)
import ctypes, ctypes.wintypes as wt, struct, sys, time, threading

k32 = ctypes.windll.kernel32
u32 = ctypes.windll.user32

DEBUG_ONLY_THIS_PROCESS = 0x00000002
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

class STARTUPINFOW(ctypes.Structure):
    _fields_ = [('cb', wt.DWORD), ('lpReserved', wt.LPWSTR), ('lpDesktop', wt.LPWSTR),
        ('lpTitle', wt.LPWSTR), ('dwX', wt.DWORD), ('dwY', wt.DWORD), ('dwXSize', wt.DWORD),
        ('dwYSize', wt.DWORD), ('dwXCountChars', wt.DWORD), ('dwYCountChars', wt.DWORD),
        ('dwFillAttribute', wt.DWORD), ('dwFlags', wt.DWORD), ('wShowWindow', wt.WORD),
        ('cbReserved2', wt.WORD), ('lpReserved2', ctypes.c_void_p), ('hStdInput', wt.HANDLE),
        ('hStdOutput', wt.HANDLE), ('hStdError', wt.HANDLE)]

class PROCESS_INFORMATION(ctypes.Structure):
    _fields_ = [('hProcess', wt.HANDLE), ('hThread', wt.HANDLE),
                ('dwProcessId', wt.DWORD), ('dwThreadId', wt.DWORD)]

class DEBUG_EVENT(ctypes.Structure):
    class _U(ctypes.Union):
        _fields_ = [('raw', ctypes.c_byte * 160)]
    _fields_ = [('dwDebugEventCode', wt.DWORD), ('dwProcessId', wt.DWORD),
                ('dwThreadId', wt.DWORD), ('u', _U)]

EXE = r'E:\GitWorkspace\thworks\tsa\th10\th10.exe'
CWD = r'E:\GitWorkspace\thworks\tsa\th10'
LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th10\session1_log.txt'
FRAME_ADDR = 0x439390
TIMEOUT = 600

logf = open(LOG, 'w', encoding='utf-8')
def log(s):
    print(s, flush=True)
    logf.write(s + '\n'); logf.flush()

def send_z():
    u32.keybd_event(0x5A, 0, 0, 0); time.sleep(0.03); u32.keybd_event(0x5A, 0, 2, 0)

def key_loop(stop):
    while not stop.is_set():
        send_z(); time.sleep(1.2)

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

def arm_frame_on_thread(hthread):
    c = get_ctx(hthread)
    if not c: return False
    c.Dr0 = FRAME_ADDR
    c.Dr7 = (c.Dr7 & ~0xF0003) | 0x00001  # L0 enable, RW0=00 (exec), LEN0=00
    return set_ctx(hthread, c)

def arm_scpt_on_thread(hthread, sites):
    c = get_ctx(hthread)
    if not c: return False
    s0 = sites[0] + 0x34
    c.Dr1 = s0
    c.Dr2 = sites[0] + 0x44
    c.Dr3 = sites[0] + 0x100
    # L0 exec (RW=00 LEN=00), L1-L3 data read/write 1 byte (RW=11 LEN=00)
    dr7 = (c.Dr7 & ~0x000F0003) | 0x000001 | 0x00150000
    c.Dr7 = dr7
    return set_ctx(hthread, c)

def enum_private_rw(hproc):
    out = []
    addr = 0
    mbi = (ctypes.c_uint * 7)()
    while addr < 0x7fff0000:
        if not k32.VirtualQueryEx(hproc, ctypes.c_void_p(addr), ctypes.byref(mbi), 28):
            break
        base, size, state, protect, typ = mbi[0], mbi[3], mbi[4], mbi[5], mbi[6]
        if state == 0x1000 and typ == 0x20000 and protect in (0x04, 0x40) and size <= 0x10000000:
            out.append((base, size))
        addr = base + size
    return out

def main():
    si = STARTUPINFOW(); si.cb = ctypes.sizeof(si)
    pi = PROCESS_INFORMATION()
    if not k32.CreateProcessW(EXE, None, None, None, False, DEBUG_ONLY_THIS_PROCESS,
                              None, CWD, ctypes.byref(si), ctypes.byref(pi)):
        log('CreateProcess failed err=%d' % k32.GetLastError()); return
    hproc = pi.hProcess; pid = pi.dwProcessId
    log('spawned pid=%d' % pid)

    stop_keys = threading.Event()
    # user plays manually; no blind key loop

    armed_threads = set()
    scpt_found = False
    dr_armed = False
    frame_count = 0
    ips = []
    scpt_hits = {}
    ev = DEBUG_EVENT()
    t0 = time.time()
    done = False

    def arm_current_thread(tid):
        if tid in armed_threads: return
        ht = k32.OpenThread(0x001F03FF, False, tid)
        if ht:
            if arm_frame_on_thread(ht):
                armed_threads.add(tid)
            k32.CloseHandle(ht)

    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > TIMEOUT:
                log('timeout')
                break
            continue
        code = ev.dwDebugEventCode
        status = DBG_CONTINUE

        if code == 3:
            log('create-process event')
        if code != 1 and ev.dwDebugEventCode in (2, 4, 6, 7) and frame_count < 3:
            log('event code=%d tid=%d' % (code, ev.dwThreadId))
            arm_current_thread(ev.dwThreadId)
        elif code == 2:  # create thread
            if scpt_found:
                ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
                if ht:
                    arm_scpt_on_thread(ht, list(scpt_hits)[:3])
                    k32.CloseHandle(ht)
            else:
                arm_current_thread(ev.dwThreadId)
        elif code == 6:  # load dll
            hfile = struct.unpack_from('<Q', bytes(ev.u.raw), 0)[0]
            if hfile: k32.CloseHandle(ctypes.c_void_p(hfile))
        elif code == 5:
            ec = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            log('exit-process code=%08x' % ec); done = True
        elif code == 1:
            exc = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            addr = struct.unpack_from('<Q', bytes(ev.u.raw), 16)[0] & 0xffffffff
            if exc == EXCEPTION_SINGLE_STEP and not dr_armed and addr == FRAME_ADDR:
                frame_count += 1
                if frame_count == 1:
                    log('frame BP first hit - main loop reached')
                if frame_count % 45 == 0 and not scpt_found:
                    for (rb, rs) in enum_private_rw(hproc):
                        blob = rpm(hproc, rb, rs)
                        if not blob: continue
                        off = 0
                        while True:
                            off = blob.find(b'SCPT\\x01\\x004\\x00', off)
                            if off < 0: break
                            scpt_hits[rb + off] = 1
                            off += 1
                    if scpt_hits:
                        scpt_found = True
                        log('ECL buffers found: ' + ', '.join(hex(k) for k in sorted(scpt_hits)))
                status = DBG_CONTINUE
            elif exc == EXCEPTION_SINGLE_STEP and dr_armed:
                c = get_ctx(hthread)
                if c:
                    ips.append(c.Eip)
                    c.Dr6 = 0
                    set_ctx(hthread, c)
                    if len(ips) >= 4000:
                        log('sampling complete: %d' % len(ips))
                        k32.TerminateProcess(hproc, 0); done = True
                status = DBG_CONTINUE
            elif exc == EXCEPTION_SINGLE_STEP:
                # frame BP hit on a thread we haven't armed yet, or post-arm race
                arm_current_thread(ev.dwThreadId)
                if not dr_armed:
                    frame_count += 1
                    if frame_count % 60 == 0 and not scpt_found:
                        for (rb, rs) in enum_private_rw(hproc):
                            blob = rpm(hproc, rb, rs)
                            if not blob: continue
                            off = 0
                            while True:
                                off = blob.find(b'SCPT', off)
                                if off < 0: break
                                scpt_hits[rb + off] = scpt_hits.get(rb + off, 0) + 1
                                off += 1
                        if scpt_hits:
                            scpt_found = True
                status = DBG_CONTINUE
            elif exc == 0x80000003:
                log('foreign BP at %08x -> continue' % addr)
                status = DBG_CONTINUE
            else:
                # AV etc: let the game's SEH handle it
                status = DBG_EXCEPTION_NOT_HANDLED

        if scpt_found and not dr_armed:
            dr_armed = True
            stop_keys.set()
            keys = sorted(scpt_hits)[:3]
            log('SCPT sites armed: ' + ', '.join(hex(k) for k in keys))
            for tid in list(armed_threads):
                ht = k32.OpenThread(0x001F03FF, False, tid)
                if ht:
                    arm_scpt_on_thread(ht, keys)
                    k32.CloseHandle(ht)

        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)

        if time.time() - t0 > TIMEOUT and not done:
            log('timeout %ds' % TIMEOUT)
            if scpt_hits:
                log('SCPT sites: ' + ', '.join('%s:%d' % (hex(k), v) for k, v in sorted(scpt_hits.items())))
            k32.TerminateProcess(hproc, 0)
            break

    log('=== RESULT ===')
    log('scpt sites: ' + ', '.join(hex(k) for k in sorted(scpt_hits)))
    log('ip samples: %d' % len(ips))
    from collections import Counter
    for ip, n in Counter(ips).most_common(40):
        log('  EIP %08x x%d' % (ip, n))
    logf.close()
    try: k32.TerminateProcess(hproc, 0)
    except Exception: pass

if __name__ == '__main__':
    try:
        main()
    except Exception:
        import traceback
        logf.write('FATAL: ' + traceback.format_exc())
        logf.flush()
        print(traceback.format_exc(), flush=True)
