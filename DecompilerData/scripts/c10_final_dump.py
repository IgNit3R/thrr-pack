import ctypes, ctypes.wintypes as wt, struct, subprocess, re

k32 = ctypes.windll.kernel32
psapi = ctypes.windll.psapi
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th20.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
m = re.search(r'"th20\.exe","(\d+)"', out)
pid = int(m.group(1)) if m else 0
print('pid', pid)
h = k32.OpenProcess(0x001F0FFF, False, pid)
arr = (wt.HMODULE * 256)()
needed = wt.DWORD()
psapi.EnumProcessModulesEx(h, ctypes.byref(arr), ctypes.sizeof(arr), ctypes.byref(needed), 3)
n = needed.value // ctypes.sizeof(wt.HMODULE)
mods = []
for i in range(n):
    hm = wt.HMODULE(arr[i])
    name = ctypes.create_unicode_buffer(260)
    psapi.GetModuleFileNameExW(h, hm, name, 260)
    class MI(ctypes.Structure):
        _fields_ = [('base', ctypes.c_void_p), ('size', wt.DWORD), ('ep', ctypes.c_void_p)]
    mi = MI()
    psapi.GetModuleInformation(h, hm, ctypes.byref(mi), ctypes.sizeof(mi))
    mods.append((mi.base or 0, mi.size, name.value.split('\\')[-1]))

base = [b for b, s, nm in mods if nm.lower() == 'th20.exe'][0]
buf = ctypes.create_string_buffer(0x200)
got = ctypes.c_size_t(0)
k32.ReadProcessMemory(h, ctypes.c_void_p(base + 0x1E6000), buf, 0x200, ctypes.byref(got))
print('th20 base', hex(base), 'pid', pid, 'read', got.value)

def owner(v):
    for b, s, nm in mods:
        if b <= v < b + s:
            return nm, v - b
    return None, None

for i in range(128):
    v = struct.unpack_from('<I', buf.raw, i * 4)[0]
    if v:
        nm, off = owner(v)
        print('[%3d] %08x -> %s +%-8x' % (i, v, nm or '?', off if off is not None else 0))
print('done')
