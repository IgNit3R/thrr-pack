# -*- coding: utf-8 -*-
"""
th075_se_extractor.py — carves PCM sound effects out of th075 inner wave\\*.dat
sound banks (self-built parser, format reverse-engineered by hex analysis).

Inner sound bank format (little-endian):
    u16  field@0 (value 50/100; NOT a block count — meaning unknown, likely first slot id)
    then a sequence of sound blocks back-to-back:
        u16 xid      (misc per-sound field; observed 0x0000..0xffff)
        u8  flag     (observed always 0x01)
        u32 pcm_size (bytes of PCM data that follow the fmt chunk)
        16-byte WAVE fmt chunk (PCM: tag=1, ch=1|2, rate<=48k, bits=8|16)
        pcm_size bytes of raw signed PCM
    file tail: zero padding.

Extraction strategy: anchor on every valid fmt chunk found globally (immune to
1-2 byte size quirks between blocks), validate the preceding 7-byte header,
emit each block as an independent playable .wav.

Usage: python th075_se_extractor.py <dir_with_wave_dats> <out_dir>
"""
import struct, sys, os

def find_fmt_chunks(data):
    out = []
    for off in range(len(data) - 16):
        tag, ch = struct.unpack_from('<HH', data, off)
        rate, brate = struct.unpack_from('<II', data, off + 4)
        align, bits = struct.unpack_from('<HH', data, off + 12)
        if tag == 1 and ch in (1, 2) and 4000 <= rate <= 48000 and bits in (8, 16):
            if brate == rate * ch * bits // 8 and align == ch * bits // 8:
                out.append((off, ch, rate, bits))
    return out

def main(src_dir, out_dir):
    os.makedirs(out_dir, exist_ok=True)
    total = 0
    for fn in sorted(os.listdir(src_dir)):
        if not fn.endswith('.dat'):
            continue
        path = os.path.join(src_dir, fn)
        data = open(path, 'rb').read()
        base = fn[:-4]
        cursor = 2
        k = 0
        for o, ch, rate, bits in find_fmt_chunks(data):
            if o < cursor:
                continue
            hdr = data[o - 7:o]
            flag = hdr[2]
            size = struct.unpack('<I', hdr[3:7])[0]
            xid = struct.unpack('<H', hdr[0:2])[0]
            if flag != 1 or size == 0 or o + 16 + size > len(data):
                continue
            pcm = data[o + 16:o + 16 + size]
            w = b'RIFF' + struct.pack('<I', 36 + len(pcm)) + b'WAVE'
            w += b'fmt ' + struct.pack('<IHHIIHH', 16, 1, ch, rate,
                                       rate * ch * bits // 8, ch * bits // 8, bits)
            w += b'data' + struct.pack('<I', len(pcm)) + pcm
            with open(os.path.join(out_dir, f'{base}_{k:03d}_x{xid:04x}.wav'), 'wb') as f:
                f.write(w)
            cursor = o + 16 + size
            k += 1
            total += 1
        print(f'{fn}: {k} sounds')
    print(f'TOTAL: {total} wav files -> {out_dir}')

if __name__ == '__main__':
    main(sys.argv[1], sys.argv[2])
