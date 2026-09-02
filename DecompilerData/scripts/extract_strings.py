import sys, json, os, re
from collections import OrderedDict
import pefile

def section_map(path):
    pe = pefile.PE(path, fast_load=True)
    secs = []
    for s in pe.sections:
        name = s.Name.decode(errors='replace').rstrip('\x00')
        secs.append((s.PointerToRawData, s.PointerToRawData + max(s.SizeOfRawData, 1), name))
    pe.close()
    return secs

def section_of(secs, off):
    for lo, hi, name in secs:
        if lo <= off < hi:
            return name
    return '?'


def extract_strings(data, min_len=4):
    results = []  # (offset, kind, text, raw)
    n = len(data)
    i = 0
    SJIS1 = set(range(0x81, 0xA0)) | set(range(0xE0, 0xF0))
    while i < n:
        b = data[i]
        # UTF-16LE: printable char followed by 0x00, require at least min_len chars
        if 0x20 <= b < 0x7F and i + 1 < n and data[i+1] == 0:
            j = i
            buf = []
            while j + 1 < n and data[j+1] == 0 and (0x20 <= data[j] < 0x7F or data[j] in (0x0A, 0x0D, 0x09)):
                buf.append(data[j]); j += 2
            if len(buf) >= min_len:
                sec = section_of(SECS, i)
                if sec not in ('.text', '?'):
                    results.append((i, 'utf16', ''.join(chr(c) for c in buf), sec))
                i = j
                continue
        # ASCII run
        if 0x20 <= b < 0x7F or b in (0x0A, 0x0D, 0x09):
            j = i
            while j < n and (0x20 <= data[j] < 0x7F or data[j] in (0x0A, 0x0D, 0x09)):
                j += 1
            if j - i >= min_len:
                sec = section_of(SECS, i)
                if sec not in ('.text', '?'):
                    results.append((i, 'ascii', data[i:j].decode('ascii', 'replace'), sec))
                i = j
                continue
        # SJIS run: mix of ascii + sjis double-byte (and halfwidth katakana)
        if 0x20 <= b < 0x7F or 0xA1 <= b <= 0xDF or b in SJIS1:
            j = i
            while j < n:
                c = data[j]
                if 0x20 <= c < 0x7F or 0xA1 <= c <= 0xDF:
                    j += 1
                elif c in SJIS1 and j + 1 < n and 0x40 <= data[j+1] <= 0xFC:
                    j += 2
                else:
                    break
            if j - i >= min_len:
                raw = data[i:j]
                ok = True
                try:
                    txt = raw.decode('cp932')
                except UnicodeDecodeError:
                    txt = None; ok = False
                if ok and sum(1 for ch in txt if ord(ch) > 0x7F) >= 1:
                    # heuristic: real SJIS text has a decent share of double-byte chars
                    dbc = sum(1 for ch in txt if ord(ch) > 0x7F)
                    if dbc / len(txt) >= 0.25:
                        sec = section_of(SECS, i)
                        if sec not in ('.text', '?'):
                            results.append((i, 'sjis', txt, sec))
                i = j
                continue
        i += 1
    return results

def main():
    src = sys.argv[1]
    out_dir = sys.argv[2]
    base = os.path.splitext(os.path.basename(src))[0]
    global SECS
    SECS = section_map(src)
    data = open(src, 'rb').read()
    strs = extract_strings(data)
    # write readable catalog
    out_txt = os.path.join(out_dir, f'{base}_strings.txt')
    with open(out_txt, 'w', encoding='utf-8') as f:
        for off, kind, txt, sec in strs:
            f.write(f'{off:08X} [{kind:5}] ({sec:6}) {txt}\n')
    # json
    out_json = os.path.join(out_dir, f'{base}_strings.json')
    with open(out_json, 'w', encoding='utf-8') as f:
        json.dump([{'off': o, 'kind': k, 'sec': s, 'text': t} for o, k, t, s in strs], f, ensure_ascii=False, indent=1)
    from collections import Counter
    cnt = Counter(k for _, k, _, _ in strs)
    print(f'{base}: {len(strs)} strings | ' + ', '.join(f'{k}={v}' for k, v in cnt.most_common()))

if __name__ == '__main__':
    main()
