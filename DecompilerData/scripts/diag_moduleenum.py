import ctypes, ctypes.wintypes as wt, subprocess, re

k32 = ctypes.windll.kernel32
class MODULEENTRY32(ctypes.Structure):
    _fields_ = [('dwSize', wt.DWORD), ('th32ModuleID', wt.DWORD), ('th32ProcessID', wt.DWORD),
        ('GlblcntUsage', wt.DWORD), ('ProccntUsage', wt.DWORD), ('modBaseAddr', ctypes.c_void_p),
        ('modBaseSize', wt.DWORD), ('hModule', wt.HMODULE), ('szModule', ctypes.c_char * 256),
        ('szExePath', ctypes.c_char * 260)]
print('sizeof', ctypes.sizeof(MODULEENTRY32))
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th075.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
m = re.search(r'"th075\.exe","(\d+)"', out)
if not m:
    print('no th075 running'); raise SystemExit
pid = int(m.group(1))
print('pid', pid)
snap = k32.CreateToolhelp32Snapshot(0x8 | 0x10, pid)
print('snap', bool(snap), 'err', k32.GetLastError())
for sz in (ctypes.sizeof(MODULEENTRY32), 568, 1088, 1064, 948):
    me = MODULEENTRY32(); me.dwSize = sz
    ok = k32.Module32First(snap, ctypes.byref(me))
    print('dwSize', sz, '->', ok, 'err', k32.GetLastError())
    if ok:
        n = 0
        while True:
            n += 1
            if not k32.Module32Next(snap, ctypes.byref(me)):
                break
        print('modules enumerated:', n)
        break
