import ctypes, ctypes.wintypes as wt

psapi = ctypes.windll.psapi
k32 = ctypes.windll.kernel32
pid = 29060
h = k32.OpenProcess(0x0410, False, pid)
arr = (wt.HMODULE * 512)()
needed = wt.DWORD()
psapi.EnumProcessModulesEx(h, ctypes.byref(arr), ctypes.sizeof(arr), ctypes.byref(needed), 3)
n = needed.value // ctypes.sizeof(wt.HMODULE)
target = 0x762411ac

class MODULEINFO(ctypes.Structure):
    _fields_ = [('lpBaseOfDll', ctypes.c_void_p), ('SizeOfImage', wt.DWORD),
                ('EntryPoint', ctypes.c_void_p)]

for i in range(n):
    hm = wt.HMODULE(arr[i])
    name = ctypes.create_unicode_buffer(260)
    psapi.GetModuleFileNameExW(h, hm, name, 260)
    mi = MODULEINFO()
    psapi.GetModuleInformation(h, hm, ctypes.byref(mi), ctypes.sizeof(mi))
    base = mi.lpBaseOfDll or 0
    if base <= target < base + mi.SizeOfImage:
        short = name.value.split('\\')[-1]
        print('0x762411ac in %s (base %s, offset +%x)' % (short, hex(base), target - base))
        break
else:
    print('not found in module list')
