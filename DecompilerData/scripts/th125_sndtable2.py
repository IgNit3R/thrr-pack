import struct
import pefile

data = open(r'E:\GitWorkspace\thworks\tsa\th125\th125.exe', 'rb').read()
pe = pefile.PE(data=data, fast_load=True)

def readstr(v):
    rva = v - 0x400000
    for s2 in pe.sections:
        if s2.VirtualAddress <= rva < s2.VirtualAddress + s2.Misc_VirtualSize:
            ro = s2.PointerToRawData + (rva - s2.VirtualAddress)
            return data[ro:ro+32].split(b'\x00')[0].decode('cp932', 'replace')
    return None

# find table base: walk back from shutter ptr while entries look like string pointers
shutter_ptr_off = 0xabcac
sec = None
for s in pe.sections:
    if s.PointerToRawData <= shutter_ptr_off < s.PointerToRawData + s.SizeOfRawData:
        sec = s
base_va = 0x400000 + sec.VirtualAddress + (shutter_ptr_off - sec.PointerToRawData)

# scan back while entries point to 'se_' strings
idx = shutter_ptr_off
n = 0
while True:
    v = struct.unpack_from('<I', data, idx - 4)[0]
    s = readstr(v) if 0x401000 <= v < 0x4b0000 else None
    if s and (s.startswith('se_') or s.startswith('bgm/')):
        idx -= 4
        n += 1
    else:
        break
table_base_off = idx
table_base_va = 0x400000 + sec.VirtualAddress + (table_base_off - sec.PointerToRawData)
print('table base VA:', hex(table_base_va), 'entries before shutter:', n)

# enumerate forward: count entries until non-string
i = table_base_off
entries = []
while True:
    v = struct.unpack_from('<I', data, i)[0]
    s = readstr(v) if 0x401000 <= v < 0x4b0000 else None
    if s and (s.startswith('se_') or s.startswith('bgm')):
        entries.append(s)
        i += 4
    else:
        break
print('total entries:', len(entries))
shutter_index = entries.index('se_shutter.wav') if 'se_shutter.wav' in entries else -1
print('se_shutter.wav index:', shutter_index)
print('first 8:', entries[:8])
print('focus family:', [(k, e) for k, e in enumerate(entries) if 'focus' in e or 'nice' in e or 'shutter' in e])
