import struct
import pefile

data = open(r'E:\GitWorkspace\thworks\tsa\th125\th125.exe', 'rb').read()
pe = pefile.PE(data=data, fast_load=True)
off = 0xabcac
sec = None
for s in pe.sections:
    if s.PointerToRawData <= off < s.PointerToRawData + s.SizeOfRawData:
        sec = s
        break
va = 0x400000 + sec.VirtualAddress + (off - sec.PointerToRawData)
print('section:', sec.Name.decode().rstrip(chr(0)), 'ptr VA:', hex(va))

def readstr(v):
    rva = v - 0x400000
    for s2 in pe.sections:
        if s2.VirtualAddress <= rva < s2.VirtualAddress + s2.Misc_VirtualSize:
            ro = s2.PointerToRawData + (rva - s2.VirtualAddress)
            return data[ro:ro+32].split(b'\x00')[0].decode('cp932', 'replace')
    return '?'

base = off - 0x80
for k in range(0, 0x140, 4):
    v = struct.unpack_from('<I', data, base + k)[0]
    mark = '  <== shutter' if base + k == off else ''
    if 0x401000 <= v < 0x4b0000:
        print(f'+{k-0x80:03x} {hex(v)} {readstr(v)!r}{mark}')
    else:
        print(f'+{k-0x80:03x} {hex(v)}{mark}')
