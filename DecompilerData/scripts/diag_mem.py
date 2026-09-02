import ctypes, ctypes.wintypes as wt, subprocess, re
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
m = re.search(r'"th10\.exe","(\d+)"', out)
pid = int(m.group(1)) if m else 0
print('pid:', pid)
k32 = ctypes.windll.kernel32

class MBI64(ctypes.Structure):
    _fields_ = [('BaseAddress', ctypes.c_size_t), ('AllocationBase', ctypes.c_size_t),
                ('AllocationProtect', wt.DWORD), ('PartitionId', wt.DWORD),
                ('RegionSize', ctypes.c_size_t), ('State', wt.DWORD),
                ('Protect', wt.DWORD), ('Type', wt.DWORD), ('Reserved2', wt.DWORD)]

h = k32.OpenProcess(0x001F0FFF, False, pid)
print('open:', bool(h), 'err', k32.GetLastError())
buf = ctypes.create_string_buffer(2); got = ctypes.c_size_t(0)
ok = k32.ReadProcessMemory(h, ctypes.c_void_p(0x400000), buf, 2, ctypes.byref(got))
print('read MZ:', ok, buf.raw, 'err', k32.GetLastError())
mbi = MBI64(); addr = 0; total = 0; n = 0
while addr < 0x7fff0000:
    if not k32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
        print('query failed at', hex(addr), 'err', k32.GetLastError()); break
    if mbi.State == 0x1000:
        total += mbi.RegionSize; n += 1
    addr = mbi.BaseAddress + mbi.RegionSize
print('committed regions:', n, 'total MB:', round(total / 1048576, 1))
# find title string anywhere
needle = 'Mountain of Faith'.encode('ascii')
mbi = MBI64(); addr = 0; hits = 0
while addr < 0x7fff0000:
    if not k32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
        break
    if mbi.State == 0x1000 and mbi.RegionSize <= 0x10000000:
        blob = ctypes.create_string_buffer(mbi.RegionSize)
        got = ctypes.c_size_t(0)
        if k32.ReadProcessMemory(h, ctypes.c_void_p(mbi.BaseAddress), blob, mbi.RegionSize, ctypes.byref(got)):
            if needle in blob.raw:
                print('title string found in region', hex(mbi.BaseAddress), 'type', hex(mbi.Type), 'prot', hex(mbi.Protect))
                hits += 1
    addr = mbi.BaseAddress + mbi.RegionSize
print('title hits:', hits)
