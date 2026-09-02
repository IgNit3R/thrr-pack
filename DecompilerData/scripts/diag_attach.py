import ctypes, ctypes.wintypes as wt, subprocess, re
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
pid = int(re.search(r'"th10\.exe","(\d+)"', out).group(1))
k32 = ctypes.windll.kernel32
print('pid', pid)
ok = k32.DebugActiveProcess(ctypes.c_uint(pid))
print('attach:', bool(ok), 'err', k32.GetLastError())
h = k32.OpenProcess(0x001F0FFF, False, pid)
buf = ctypes.create_string_buffer(64); got = ctypes.c_size_t(0)
ok = k32.ReadProcessMemory(h, ctypes.c_void_p(0x466000), buf, 64, ctypes.byref(got))
print('read @0x466000:', ok, 'got', got.value, 'err', k32.GetLastError())
print('content:', buf.raw[:40])
# scan image region while attached
class MBI64(ctypes.Structure):
    _fields_ = [('BaseAddress', ctypes.c_size_t), ('AllocationBase', ctypes.c_size_t),
                ('AllocationProtect', wt.DWORD), ('PartitionId', wt.DWORD),
                ('RegionSize', ctypes.c_size_t), ('State', wt.DWORD),
                ('Protect', wt.DWORD), ('Type', wt.DWORD), ('Reserved2', wt.DWORD)]
needle = b'Mountain of Faith'
mbi = MBI64(); addr = 0; hits = 0; regions = 0
while addr < 0x7fff0000:
    if not k32.VirtualQueryEx(h, ctypes.c_void_p(addr), ctypes.byref(mbi), ctypes.sizeof(mbi)):
        break
    if mbi.State == 0x1000:
        regions += 1
        if mbi.RegionSize <= 0x10000000:
            blob = ctypes.create_string_buffer(mbi.RegionSize)
            got = ctypes.c_size_t(0)
            if k32.ReadProcessMemory(h, ctypes.c_void_p(mbi.BaseAddress), blob, mbi.RegionSize, ctypes.byref(got)):
                if needle in blob.raw[:got.value]:
                    print('title in region', hex(mbi.BaseAddress), 'type', hex(mbi.Type), 'prot', hex(mbi.Protect))
                    hits += 1
    addr = mbi.BaseAddress + mbi.RegionSize
print('attached-scan: regions', regions, 'title hits', hits)
k32.DebugActiveProcessStop(ctypes.c_uint(pid))
