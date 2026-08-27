# -*- coding: utf-8 -*-
"""
th075_suica_parser.py — self-built parser for Touhou IaMP (th075) outer .dat archives
("Suica" format, verified against brightmoon/go-brightmoon pkg/pbgarc/suica.go).

Format (little-endian):
    u16  entry_count
    entry_count x 108-byte records, whole table obfuscated with rolling XOR keystream:
        k = 0x64, t = 0x64
        for each byte: plain ^= k; k += t; t += 0x4D   (all mod 256)
    each record: name[100] (NUL-padded, CP932), u32 size @ +0x64, u32 abs_offset @ +0x68
Entry data region: raw (uncompressed), starts right after the table.

Usage: python th075_suica_parser.py <archive.dat> [out_csv]
"""
import struct, sys, os

def suica_keystream(n):
    k = t = 0x64
    ks = bytearray()
    for _ in range(n):
        ks.append(k & 0xFF)
        k = (k + t) & 0xFFFFFFFF
        t = (t + 0x4D) & 0xFFFFFFFF
    return bytes(ks)

def parse_suica(path):
    fsize = os.path.getsize(path)
    with open(path, 'rb') as f:
        cnt = struct.unpack('<H', f.read(2))[0]
        list_size = cnt * 0x6C
        if list_size + 2 > fsize:
            raise ValueError('invalid entry count or list size')
        buf = bytearray(f.read(list_size))
        ks = suica_keystream(list_size)
        for i in range(list_size):
            buf[i] ^= ks[i]
        entries = []
        for i in range(cnt):
            p = i * 0x6C
            name_len = 0
            for j in range(0x64):
                if buf[p + j] == 0:
                    break
                name_len += 1
            if name_len == 0:
                raise ValueError(f'invalid entry name at record {i}')
            name = bytes(buf[p:p + name_len]).decode('cp932', errors='replace')
            size = struct.unpack_from('<I', buf, p + 0x64)[0]
            off = struct.unpack_from('<I', buf, p + 0x68)[0]
            if off > fsize or size > fsize - off:
                raise ValueError(f'entry {i} ({name}) offset/size out of range')
            entries.append({'index': i, 'name': name, 'size': size, 'offset': off})
    return entries, list_size + 2

if __name__ == '__main__':
    arc = sys.argv[1]
    entries, table_end = parse_suica(arc)
    print(f'{os.path.basename(arc)}: {len(entries)} entries, table ends at {table_end}')
    out_csv = sys.argv[2] if len(sys.argv) > 2 else None
    if out_csv:
        with open(out_csv, 'w', encoding='utf-8-sig') as w:
            w.write('index,name,size,offset\n')
            for e in entries:
                w.write(f"{e['index']},{e['name']},{e['size']},{e['offset']}\n")
        print(f'entry table -> {out_csv}')
