import ctypes, struct, time

k32 = ctypes.windll.kernel32
DBG_CONTINUE = 0x00010002
DBG_EXCEPTION_NOT_HANDLED = 0x80010001

class DEBUG_EVENT(ctypes.Structure):
    class _U(ctypes.Union):
        _fields_ = [('raw', ctypes.c_byte * 160)]
    _fields_ = [('dwDebugEventCode', ctypes.DWORD), ('dwProcessId', ctypes.DWORD),
                ('dwThreadId', ctypes.DWORD), ('u', _U)]

targets = [int(x) for x in sys.argv[1:]] if len(sys.argv) > 1 else [8796, 16368, 29148, 4444]
import sys
for pid in targets:
    if not k32.DebugActiveProcess(ctypes.c_uint(pid)):
        print(pid, 'attach failed err=%d' % k32.GetLastError())
        continue
    print(pid, 'attached, draining events...')
    ev = DEBUG_EVENT()
    n = 0
    # drain: continue all events until no more arrive (short timeout)
    while True:
        if not k32.WaitForDebugEvent(ctypes.byref(ev), 500):
            break
        n += 1
        k32.ContinueDebugEvent(ev.dwProcessId, ev.dwThreadId, DBG_CONTINUE)
        if n > 200:
            break
    print(pid, 'drained %d events' % n)
    # now kill it
    h = k32.OpenProcess(0x0001, False, pid)
    if h:
        ok = k32.TerminateProcess(h, 1)
        k32.CloseHandle(h)
        print(pid, 'terminate ->', bool(ok), 'err=%d' % k32.GetLastError())
    k32.DebugActiveProcessStop(ctypes.c_uint(pid))
print('cleanup pass done')
