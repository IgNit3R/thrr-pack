import ctypes, ctypes.wintypes as wt, struct, subprocess, re

k32 = ctypes.windll.kernel32
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th075.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
pid = int(re.search(r'"th075\.exe","(\d+)"', out).group(1))
h = k32.OpenProcess(0x001F0FFF, False, pid)
print('pid', pid, 'handle', bool(h))

def rpm(addr, size):
    buf = ctypes.create_string_buffer(size)
    got = ctypes.c_size_t(0)
    if k32.ReadProcessMemory(h, ctypes.c_void_p(addr), buf, size, ctypes.byref(got)):
        return buf.raw[:got.value]
    print('  rpm fail @%08x err %d' % (addr, k32.GetLastError()))
    return None

for dll_base, nm in [(0x76850000, 'kernel32'), (0x76D50000, 'kernelbase')]:
    dos = rpm(dll_base, 0x40)
    e_lfanew = struct.unpack_from('<I', dos, 0x3c)[0]
    print(nm, 'e_lfanew', hex(e_lfanew))
    nth = rpm(dll_base + e_lfanew, 0x400)
    print(nm, 'PE sig', nth[:4])
    exp_rva = struct.unpack_from('<I', nth, 0x18 + 0x60)[0]
    exp_sz = struct.unpack_from('<I', nth, 0x18 + 0x64)[0]
    print(nm, 'exp dir rva', hex(exp_rva), 'size', hex(exp_sz))
    if not exp_rva:
        continue
    ed = rpm(dll_base + exp_rva, 40)
    n_names = struct.unpack_from('<I', ed, 0x18)[0]
    names_rva = struct.unpack_from('<I', ed, 0x20)[0]
    funcs_rva = struct.unpack_from('<I', ed, 0x1c)[0]
    ord_rva = struct.unpack_from('<I', ed, 0x24)[0]
    print(nm, 'names:', n_names)
    # scan names for CreateFile
    found = {}
    for i in range(n_names):
        prva = struct.unpack_from('<I', rpm(dll_base + names_rva + i * 4, 4), 0)[0]
        s = rpm(dll_base + prva, 32)
        if not s: continue
        nm2 = s.split(b'\x00')[0].decode('latin1')
        if nm2.startswith('CreateFile'):
            ordv = struct.unpack_from('<H', rpm(dll_base + ord_rva + i * 2, 2), 0)[0]
            frva = struct.unpack_from('<I', rpm(dll_base + funcs_rva + ordv * 4, 4), 0)[0]
            found[nm2] = dll_base + frva
    print(nm, 'found:', found)
