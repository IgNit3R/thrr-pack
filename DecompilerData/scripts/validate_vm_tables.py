# Validate threaded-VM candidates: check for jmp/call [reg*4 + table_va] byte pattern
import pefile, struct, sys, re

exe = sys.argv[1]
cands = eval(sys.argv[2])  # list of (va, count, host)
pe = pefile.PE(exe, fast_load=True)
data = open(exe, 'rb').read()
t = [s for s in pe.sections if s.Name.decode().rstrip(chr(0)) == '.text'][0]
tbase = 0x400000 + t.VirtualAddress
text = data[t.PointerToRawData:t.PointerToRawData + t.SizeOfRawData]

def validate(tva):
    tb = struct.pack('<I', tva)
    # find any FF 14/24 25|85|8d|95|b3... with disp32 == tva, or FF 14/24 <modrm> disp32
    hits = []
    for m in re.finditer(re.escape(tb), text):
        i = m.start()
        # look back 1-3 bytes for ff 14/24 with modrm
        for back in (3, 4):
            pre = text[i-back:i]
            if len(pre) >= 2 and pre[0] == 0xFF and pre[1] in (0x14, 0x24):
                hits.append((tbase + i - back, pre[1], back))
    return hits

for va, cnt, host in cands:
    h = validate(va)
    status = 'VALID' if h else 'false-positive'
    print('%08x n=%-4d host=%-12s %s %s' % (va, cnt, host, status, [('jmp' if b==0x24 else 'call', hex(a)) for a, _, b in h[:2]]))
