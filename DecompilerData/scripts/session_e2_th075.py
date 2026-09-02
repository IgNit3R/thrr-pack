# E2: th075 CreateFileA/W monitor - log file open order
import ctypes, ctypes.wintypes as wt, struct, time, threading

k32 = ctypes.windll.kernel32
u32 = ctypes.windll.user32

DEBUG_ONLY_THIS_PROCESS = 2
DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001
EXCEPTION_BREAKPOINT = 0x80000003
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

EXE = r'E:\GitWorkspace\thworks\tf\th075\th075.exe'
CWD = r'E:\GitWorkspace\thworks\tf\th075'
LOG = r'E:\GitWorkspace\thworks\re_work\dyn\th075\e2_log.txt'
TIMEOUT = 420

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

def wpm(hproc, addr, data):
    got = ctypes.c_size_t(0)
    return bool(k32.WriteProcessMemory(hproc, ctypes.c_void_p(addr), data, len(data), ctypes.byref(got)))

def get_ctx(ht):
    c = WOW64_CONTEXT(); c.ContextFlags = WOW64_CONTEXT_ALL
    return c if k32.Wow64GetThreadContext(ht, ctypes.byref(c)) else None

def set_ctx(ht, c):
    return bool(k32.Wow64SetThreadContext(ht, ctypes.byref(c)))

def resolve_export(hproc, dll_base, func_name):
    # parse PE exports of loaded dll in debuggee
    dos = rpm(hproc, dll_base, 0x40)
    if not dos or dos[:2] != b'MZ': return None
    e_lfanew = struct.unpack_from('<I', dos, 0x3c)[0]
    nth = rpm(hproc, dll_base + e_lfanew, 0x400)
    if not nth or len(nth) < 0x100 or nth[:2] != b'PE': return None
    opt_rva_off = 0x18
    exp_dir_rva = struct.unpack_from('<I', nth, opt_rva_off + 0x60)[0]
    exp_dir_size = struct.unpack_from('<I', nth, opt_rva_off + 0x64)[0]
    if not exp_dir_rva: return None
    ed = rpm(hproc, dll_base + exp_dir_rva, 40)
    if not ed or len(ed) < 40: return None
    n_names = struct.unpack_from('<I', ed, 0x18)[0]
    names_rva = struct.unpack_from('<I', ed, 0x20)[0]
    ord_rva = struct.unpack_from('<I', ed, 0x24)[0]
    funcs_rva = struct.unpack_from('<I', ed, 0x1c)[0]
    for i in range(n_names):
        nm_rva = struct.unpack_from('<I', rpm(hproc, dll_base + names_rva + i * 4, 4), 0)[0]
        s = rpm(hproc, dll_base + nm_rva, 40)
        if not s: continue
        name = s.split(b'\x00')[0].decode()
        if name == func_name:
            ordinal = struct.unpack_from('<H', rpm(hproc, dll_base + ord_rva + i * 2, 2), 0)[0]
            f_rva = struct.unpack_from('<I', rpm(hproc, dll_base + funcs_rva + ordinal * 4, 4), 0)[0]
            return dll_base + f_rva
    return None

def enum_modules(hproc, pid):
    class MODULEENTRY32(ctypes.Structure):
        _fields_ = [('dwSize', wt.DWORD), ('th32ModuleID', wt.DWORD), ('th32ProcessID', wt.DWORD),
            ('GlblcntUsage', wt.DWORD), ('ProccntUsage', wt.DWORD), ('modBaseAddr', ctypes.c_void_p),
            ('modBaseSize', wt.DWORD), ('hModule', wt.HMODULE), ('szModule', ctypes.c_char * 256),
            ('szExePath', ctypes.c_char * 260)]
    TH32CS_SNAPMODULE = 0x8; TH32CS_SNAPMODULE32 = 0x10
    snap = k32.CreateToolhelp32Snapshot(TH32CS_SNAPMODULE | TH32CS_SNAPMODULE32, pid)
    out = []
    me = None
    for sz_try in (ctypes.sizeof(MODULEENTRY32), 568, 1088, 1064):
        me = MODULEENTRY32(); me.dwSize = sz_try
        if k32.Module32First(snap, ctypes.byref(me)):
            break
        me = None
    if me is None:
        k32.CloseHandle(snap); return out
    if k32.Module32First(snap, ctypes.byref(me)):
        while True:
            out.append((me.szModule.decode('gbk', 'replace').lower(), me.modBaseAddr or 0, me.modBaseSize))
            if not k32.Module32Next(snap, ctypes.byref(me)):
                break
    k32.CloseHandle(snap)
    return out

def read_dbg_str(hproc, addr, wide):
    if wide:
        raw = rpm(hproc, addr, 520)
        if not raw: return '?'
        return raw.decode('utf-16-le', 'replace').split('\x00')[0]
    else:
        raw = rpm(hproc, addr, 520)
        if not raw: return '?'
        return raw.split(b'\x00')[0].decode('cp932', 'replace')

def main():
    si = STARTUPINFOW(); si.cb = ctypes.sizeof(si)
    pi = PROCESS_INFORMATION()
    if not k32.CreateProcessW(EXE, None, None, None, False, DEBUG_ONLY_THIS_PROCESS,
                              None, CWD, ctypes.byref(si), ctypes.byref(pi)):
        log('spawn failed err=%d' % k32.GetLastError()); return
    hproc = pi.hProcess; pid = pi.dwProcessId
    log('spawned pid=%d' % pid)

    ev = DEBUG_EVENT()
    bps = {}         # addr -> (name, orig_byte)
    armed = False
    in_step = {}     # addr(bool) rearm pending per thread? simple: track step state
    step_thread = None
    opens = []
    t0 = time.time()
    done = False

    while not done:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 3000):
            if time.time() - t0 > TIMEOUT:
                log('timeout'); break
            continue
        code = ev.dwDebugEventCode
        status = DBG_CONTINUE

        if code == 3:
            log('create-process')
        elif code == 6:
            hfile = struct.unpack_from('<Q', bytes(ev.u.raw), 0)[0]
            if hfile: k32.CloseHandle(ctypes.c_void_p(hfile))
            if not armed:
                mods = enum_modules(hproc, pid)
                log('enum modules: %d found' % len(mods))
                k32mod = [b for (n, b, s) in mods if n in ('kernel32.dll', 'kernelbase.dll')]
                log('k32 mods: %s' % ['%08x' % b for b in k32mod])
                if k32mod:
                    fa = fw = None
                    for b in k32mod:
                        fa = fa or resolve_export(hproc, b, 'CreateFileA')
                        fw = fw or resolve_export(hproc, b, 'CreateFileW')
                    log('resolve: A=%s W=%s' % (fa, fw))
                    if fa and fw:
                        for a, nm in [(fa, 'CreateFileA'), (fw, 'CreateFileW')]:
                            ob = rpm(hproc, a, 1)
                            if ob:
                                bps[a] = (nm, ob[0])
                                wpm(hproc, a, b'\xcc')
                        armed = True
                        log('CreateFileA @%08x, CreateFileW @%08x armed' % (fa, fw))
        elif code == 5:
            log('exit-process'); done = True
        elif code == 1:
            exc = struct.unpack_from('<I', bytes(ev.u.raw), 0)[0]
            addr = struct.unpack_from('<Q', bytes(ev.u.raw), 16)[0] & 0xffffffff
            ht = k32.OpenThread(0x001F03FF, False, ev.dwThreadId)
            if exc == EXCEPTION_BREAKPOINT and addr in bps:
                nm, ob = bps[addr]
                c = get_ctx(ht)
                if c:
                    sp = c.Esp
                    ret = rpm(hproc, sp, 4)
                    argp = struct.unpack('<I', rpm(hproc, sp + 4, 4))[0]
                    fn = read_dbg_str(hproc, argp, nm.endswith('W'))
                    opens.append((nm, fn))
                    log('[%s] %s' % (nm, fn))
                    wpm(hproc, addr, bytes([ob]))
                    c.Eip = addr
                    c.EFlags |= 0x100
                    set_ctx(ht, c)
                    step_thread = (ev.dwThreadId, addr)
                    if len(opens) >= 120:
                        log('120 opens captured, stopping')
                        for a2, (nm2, ob2) in bps.items():
                            cur = rpm(hproc, a2, 1)
                            if cur and cur[0] == 0xCC: wpm(hproc, a2, bytes([ob2]))
                        bps.clear()
                status = DBG_CONTINUE
            elif exc == EXCEPTION_SINGLE_STEP and step_thread and ev.dwThreadId == step_thread[0]:
                a = step_thread[1]
                if a in bps:
                    wpm(hproc, a, b'\xcc')
                step_thread = None
                status = DBG_CONTINUE
            else:
                status = DBG_EXCEPTION_NOT_HANDLED
            if ht: k32.CloseHandle(ht)

        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, status)
        if time.time() - t0 > TIMEOUT:
            log('timeout'); break

    log('=== RESULT ===')
    log('total opens: %d' % len(opens))
    log('cardlist opens in order:')
    for nm, fn in opens:
        if 'cardlist' in fn.lower():
            log('  [%s] %s' % (nm, fn))
    logf.close()

if __name__ == '__main__':
    try:
        main()
    except Exception:
        import traceback
        log('FATAL: ' + traceback.format_exc())
