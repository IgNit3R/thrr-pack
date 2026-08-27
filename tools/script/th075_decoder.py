# -*- coding: utf-8 -*-
"""th075 图像/文本解码器 — 移植 touhouSE th075.cpp 逻辑
- 图像: [u8 palette_count][palette×512B(5551)][循环: u32 w + u32 h + u8 cn + RLE像素]
- 调色板: 每色 2B 5551 -> RGBA (b=(v0&0x1F)<<3, g=((v0&0xE0)>>2)+((v1&3)<<6), r=(v1&0x7C)<<1, a=((v1>>7))*0xFF)
- RLE: cn=32/24: u32 len + len×(4/3)B像素; cn=16: u16 len + len×2B; cn=8: u8 len + u8值
- 加密: th075_convert(out,buf,size,a,b,c) 滚动 XOR: out[i]=buf[i]^a; a+=b; b+=c
"""
import pathlib, struct, sys

def rolling_xor(data, a, b, c):
    out = bytearray(len(data))
    for i in range(len(data)):
        out[i] = data[i] ^ a
        a = (a + b) & 0xFF
        b = (b + c) & 0xFF
    return bytes(out)

def load_pal(data):
    """data: 512B(256色 × 2B 5551) -> 1024B RGBA"""
    pal = []
    for i in range(256):
        v0, v1 = data[i*2], data[i*2+1]
        b = (v0 & 0x1F) << 3
        g = ((v0 & 0xE0) >> 2) + ((v1 & 0x03) << 6)
        r = (v1 & 0x7C) << 1
        a = ((v1 >> 7) & 1) * 0xFF
        pal.append((r, g, b, a))
    return pal

def load_col(data, p, cn, w, h):
    """RLE 解码像素, 返回 (col, new_p)"""
    col_count = w * h
    if col_count == 0:
        return b'', p
    if cn in (32, 24):
        out = bytearray()
        bpp = 4 if cn == 32 else 3
        while len(out) < col_count * 4:
            length = struct.unpack_from('<I', data, p)[0]
            p += 4
            if p + length * 4 > len(data):
                return None, p
            out += data[p:p+length*4]
            p += length * 4
        return bytes(out), p
    elif cn == 16:
        out = bytearray()
        while len(out) < col_count * 2:
            length = struct.unpack_from('<H', data, p)[0]
            p += 2
            if p + length * 2 > len(data):
                return None, p
            out += data[p:p+length*2]
            p += length * 2
        return bytes(out), p
    elif cn == 8:
        out = bytearray()
        while len(out) < col_count:
            length = data[p]
            p += 1
            if p >= len(data):
                return None, p
            val = data[p]
            p += 1
            out += bytes([val]) * length
        return bytes(out), p
    else:
        return None, p

def decode_image(data):
    """解码 th075 图像 dat -> [(w,h,cn,img_bytes)]"""
    if len(data) < 1:
        return []
    palette_count = data[0]
    pals = []
    p = 1
    for i in range(palette_count):
        pals.append(load_pal(data[p:p+512]))
        p += 512
    images = []
    idx = 0
    while p + 17 <= len(data):
        w = struct.unpack_from('<I', data, p)[0]
        h = struct.unpack_from('<I', data, p+4)[0]
        cn = data[p+12]
        # 头17B: [u32 w][u32 h][u32 stride][u8 cn][4B ?]
        p += 17
        if w == 0 or h == 0 or w > 8192 or h > 8192 or cn not in (8, 16, 24, 32):
            break
        col, p = load_col(data, p, cn, w, h)
        if col is None:
            break
        images.append((w, h, cn, col))
        idx += 1
    return images

def save_png(w, h, cn, pix, path):
    """保存为 PNG (8bit 用调色板, 其他直写)"""
    import zlib
    # 解析像素为 RGBA 或索引
    if cn == 8:
        # pix 是调色板索引
        raw = bytearray()
        for y in range(h):
            raw.append(0)  # filter none
            row = pix[y*w:(y+1)*w]
            raw += row
        # 用 PIL? 无; 手写 PNG 调色板
        return save_png_indexed(w, h, pix, path)
    elif cn == 16:
        # 5551 -> RGBA
        rgba = bytearray()
        for i in range(0, len(pix), 2):
            v0, v1 = pix[i], pix[i+1]
            b = (v0 & 0x1F) << 3
            g = ((v0 & 0xE0) >> 2) + ((v1 & 0x03) << 6)
            r = (v1 & 0x7C) << 1
            a = ((v1 >> 7) & 1) * 0xFF
            rgba += bytes([r, g, b, a])
        return save_png_rgba(w, h, bytes(rgba), path)
    elif cn in (24, 32):
        # 24/32 均为 4B/像素输出(24 的 alpha 槽固定 0xff)
        rgba = bytearray(pix)
        if cn == 24:
            # 每4B槽 alpha 置 ff
            for i in range(3, len(rgba), 4):
                rgba[i] = 0xFF
        return save_png_rgba(w, h, bytes(rgba), path)
    return False

def save_png_rgba(w, h, rgba, path):
    import zlib
    raw = bytearray()
    for y in range(h):
        raw.append(0)
        raw += rgba[y*w*4:(y+1)*w*4]
    def chunk(tag, data):
        c = struct.pack('>I', len(data)) + tag + data
        return c + struct.pack('>I', zlib.crc32(tag + data) & 0xFFFFFFFF)
    png = b'\x89PNG\r\n\x1a\n'
    png += chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 6, 0, 0, 0))
    png += chunk(b'IDAT', zlib.compress(bytes(raw)))
    png += chunk(b'IEND', b'')
    pathlib.Path(path).write_bytes(png)
    return True

def save_png_indexed(w, h, idx, path):
    import zlib
    raw = bytearray()
    for y in range(h):
        raw.append(0)
        raw += idx[y*w:(y+1)*w]
    def chunk(tag, data):
        c = struct.pack('>I', len(data)) + tag + data
        return c + struct.pack('>I', zlib.crc32(tag + data) & 0xFFFFFFFF)
    png = b'\x89PNG\r\n\x1a\n'
    png += chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 3, 0, 0, 0))
    png += chunk(b'PLTE', b'')
    png += chunk(b'IDAT', zlib.compress(bytes(raw)))
    png += chunk(b'IEND', b'')
    pathlib.Path(path).write_bytes(png)
    return True

if __name__ == '__main__':
    p = pathlib.Path(sys.argv[1])
    data = p.read_bytes()
    imgs = decode_image(data)
    print(f'{p.name}: {len(imgs)} 幅图像')
    for i, (w, h, cn, col) in enumerate(imgs[:5]):
        print(f'  [{i}] {w}x{h} cn={cn} 像素{len(col)}B')
