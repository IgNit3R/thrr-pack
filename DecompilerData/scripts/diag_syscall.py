import ctypes, struct, subprocess, re

k32 = ctypes.windll.kernel32
out = subprocess.run(['tasklist', '/FI', 'IMAGENAME eq th10.exe', '/FO', 'CSV'],
                     capture_output=True).stdout.decode('gbk', 'replace')
pid = int(re.search(r'"th10\.exe","(\d+)"', out).group(1))
h = k32.OpenProcess(0x0010, False, pid)  # VM_READ
buf = ctypes.create_string_buffer(16)
got = ctypes.c_size_t(0)
k32.ReadProcessMemory(h, ctypes.c_void_p(0x762411a0), buf, 16, ctypes.byref(got))
print('bytes @0x762411a0:', buf.raw[:16].hex())
if buf.raw[3] == 0xB8:
    print('syscall id:', hex(struct.unpack_from('<I', buf.raw, 4)[0]))
