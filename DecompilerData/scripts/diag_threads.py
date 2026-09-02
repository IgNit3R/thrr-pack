import ctypes, ctypes.wintypes as wt, subprocess, re, time

k32 = ctypes.windll.kernel32
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

out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
pid = int(re.search(r'"th10\.exe","(\d+)"', out).group(1))

class THREADENTRY32(ctypes.Structure):
    _fields_ = [('dwSize', wt.DWORD), ('cntUsage', wt.DWORD), ('th32ThreadID', wt.DWORD),
                ('th32OwnerProcessID', wt.DWORD), ('tpDeltaPri', ctypes.c_long),
                ('dwFlags', wt.DWORD)]
snap = k32.CreateToolhelp32Snapshot(4, 0)
te = THREADENTRY32(); te.dwSize = ctypes.sizeof(te)
tids = []
if k32.Thread32First(snap, ctypes.byref(te)):
    while True:
        if te.th32OwnerProcessID == pid:
            tids.append(te.th32ThreadID)
        if not k32.Thread32Next(snap, ctypes.byref(te)):
            break
k32.CloseHandle(snap)
print('pid', pid, 'threads:', tids)

for tid in tids:
    h = k32.OpenThread(0x001F03FF, False, tid)
    if not h:
        print(tid, 'open failed'); continue
    eips = []
    susp = k32.SuspendThread(h)
    for _ in range(3):
        c = WOW64_CONTEXT(); c.ContextFlags = WOW64_CONTEXT_ALL
        if k32.Wow64GetThreadContext(h, ctypes.byref(c)):
            eips.append(c.Eip)
        time.sleep(0.2)
    if susp <= 0:
        k32.ResumeThread(h)
    k32.CloseHandle(h)
    print('tid %d suspend=%d eips=%s' % (tid, susp, [hex(e) for e in eips]))
