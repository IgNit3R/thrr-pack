# -*- coding: utf-8 -*-
"""cv2 -> PNG 转换器 (纯 Python)"""
import pathlib
import struct
import zlib
import sys


def png_chunk(tag, payload):
    return struct.pack('>I', len(payload)) + tag + payload + struct.pack('>I', zlib.crc32(tag + payload) & 0xFFFFFFFF)


def write_png(path, w, h, rgba_rows):
    """rgba_rows: list of bytearray 行(BGRA 或 RGBA 统一转 RGBA), 每行 len = w*4"""
    raw = b''.join(b'\x00' + bytes(r) for r in rgba_rows)

    def chunk(tag, data):
        c = tag + data
        return struct.pack('>I', len(data)) + c + struct.pack('>I', zlib.crc32(c) & 0xFFFFFFFF)

    ihdr = struct.pack('>IIBBBBB', w, h, 8, 6, 0, 0, 0)
    png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', ihdr)
    compressed = zlib.compress(raw, 6)
    png += chunk(b'IDAT', compressed)
    png += chunk(b'IEND', b'')
    path.write_bytes(png)


def convert_cv2(src: pathlib.Path, dst: pathlib.Path):
    b = src.read_bytes()
    if len(b) < 17:
        raise ValueError('too small')
    bpp = b[0]
    width, height, pwidth, _res = struct.unpack('<iiiI', b[1:17])
    if pwidth < width:
        raise ValueError('bad header')
    pix = b[17:]

    if bpp == 32:
        bytes_pp = 4
        row_len = pwidth * 4
    elif bpp == 24:
        bytes_pp = 4          # 官方工具: 24bit 也占 4 字节 (ARGB 布局)
        row_len = pwidth * 4
    elif bpp == 16:
        bytes_pp = 2
        row_len = pwidth * 2
    elif bpp == 8:
        raise ValueError('8bpp 调色板不支持(无随档调色板)')
    else:
        raise ValueError(f'未知 bpp {bpp}')

    need = height * row_len
    if len(pix) < need:
        raise ValueError(f'像素不足 {len(pix)}<{need}')

    rows = []
    for y in range(height):
        row = bytearray(width * 4)
        base = y * row_len
        for x in range(width):
            o = base + x * bytes_pp
            if bpp == 32:
                a, r, g, bb = pix[o], pix[o + 1], pix[o + 2], pix[o + 3]
                # 存储序为 A<<24|R<<16|G<<8|B 小端 => 内存顺序 B,G,R,A
                B, G, R, A = pix[o], pix[o + 1], pix[o + 2], pix[o + 3]
            elif bpp == 24:
                # 同样 4 字节槽位
                Bv, Gv, Rv, Av = pix[o], pix[o + 1], pix[o + 2], pix[o + 3]
                B, G, R, A = Bv, Gv, Rv, Av
            else:  # 16 RGB565
                v = pix[o] | (pix[o + 1] << 8)
                R = ((v >> 11) & 0x1F) << 3
                G = ((v >> 5) & 0x3F) << 2
                B = (v & 0x1F) << 3
                A = 255
            row[x * 4 + 0] = R
            row[x * 4 + 1] = G
            row[x * 4 + 2] = B
            row[x * 4 + 3] = A
        rows.append(row)
    write_png(dst, width, height, rows)
    return width, height, bpp


if __name__ == '__main__':
    outdir = pathlib.Path(r'E:\GitWorkspace\thworks\.build\cv2_test')
    outdir.mkdir(exist_ok=True)
    targets = [
        pathlib.Path(r'E:\GitWorkspace\thworks\release\tf\th105\dat\th105a\data\menu\musicroom\Musicroom.cv2'),
        pathlib.Path(r'E:\GitWorkspace\thworks\release\tf\th105\dat\th105a\data\scene\select\bg\bg_music.cv2'),
        pathlib.Path(r'E:\GitWorkspace\thworks\release\tf\th123\dat\th123a\data\menu\musicroom\Musicroom.cv2'),
    ]
    for t in targets:
        try:
            w, h, bpp = convert_cv2(t, outdir / (t.stem + '.png'))
            print(f'{t.name}: {w}x{h} bpp={bpp} -> OK')
        except Exception as e:
            print(f'{t.name}: 失败 {e}')
