# 東方永夜抄 ~ Imperishable Night (TH08) — 主程序深度静态分析报告

- 目标文件: `@tsa/eiya/th08.exe`
- 分析方式: 纯静态 (pefile 结构解析 + capstone 反汇编 + 字符串提取),未执行目标程序
- 生成时间: 2026-08-24 18:46

## 1. 文件概要

| 属性 | 值 |
|---|---|
| 大小 | 840,704 bytes (821.0 KiB) |
| MD5 | `77b6785e04a3406e50be68714a193650` |
| SHA256 | `330fbdbf58a710829d65277b4f312cfb…` |
| 文件修改时间 | 2004-09-19T16:09:48.902592+00:00 |
| PE 时间戳 | 2004-09-19 16:09:48 UTC (raw 0x414DAF4C) |
| 架构/子系统 | i386 / PE32 / WINDOWS_GUI |
| 链接器版本 | 7.0 → VS2002 |
| 入口点 | RVA 0xA619E (VA 0x004A619E) |
| ImageBase | 0x00400000 |
| CheckSum 校验 | 不通过(典型于旧工具链) |

**编译指纹结论**: 链接器 7.0 → VS2002。**打包器**: no strong packer indicators。**图形栈**: Direct3D8, DirectInput。

## 2. 节区表

| 节 | VA | VSize | RawPtr | RawSize | 熵 | 属性 | V/R比 |
|---|---|---|---|---|---|---|---|
| `.text` | 0x00002000 | 727,928 | 7,680 | 728,064 | 6.5897 | EXEC|READ|CODE | 1.0 |
| `.rdata` | 0x000B4000 | 70,276 | 735,744 | 70,656 | 6.2246 | READ|IDATA | 0.995 |
| `.data` | 0x000C6000 | 21,051,456 | 806,400 | 28,160 | 4.4031 | READ|WRITE|IDATA | 747.566 |
| `.data1` | 0x014DA000 | 2,272 | 834,560 | 2,560 | 3.6195 | READ|WRITE|IDATA | 0.887 |
| `.rsrc` | 0x014DB000 | 3,424 | 837,120 | 3,584 | 5.5946 | READ|IDATA | 0.955 |

## 3. 导入表 (9 DLL / 155 函数)

| DLL | 导入数 |
|---|---|
| DINPUT8.dll | 1 |
| DSOUND.dll | 1 |
| d3d8.dll | 1 |
| WINMM.dll | 15 |
| KERNEL32.dll | 94 |
| USER32.dll | 27 |
| GDI32.dll | 10 |
| ADVAPI32.dll | 3 |
| ole32.dll | 3 |

**关键 API 使用**(按功能分类,来自关键函数识别):见 §7。

## 4. 导出表

无导出(典型应用程序)。

## 5. 资源

| 类型 | 数量 | 总字节 |
|---|---|---|
| ICON | 1 | 3,240 |
| GROUP_ICON | 1 | 20 |

## 6. TLS / 签名 / Overlay

- TLS: 无 TLS 目录
- 数字签名: 无
- Overlay: offset 840,704, size 0 bytes (无 overlay)

## 7. 入口点反汇编(前段)

```asm
004A619E  push     0x60
004A61A0  push     0x4bd8b0
004A61A5  call     0x4a6e78   ; -> sub_0A6E78 [func-start]
004A61AA  mov      edi, 0x94
004A61AF  mov      eax, edi
004A61B1  call     0x4a48e0   ; -> sub_0A48E0 [func-start]
004A61B6  mov      dword ptr [ebp - 0x18], esp
004A61B9  mov      esi, esp
004A61BB  mov      dword ptr [esi], edi
004A61BD  push     esi
004A61BE  call     dword ptr [0x4b4078]   ; IAT:KERNEL32.dll!GetVersionExA
004A61C4  mov      ecx, dword ptr [esi + 0x10]
004A61C7  mov      dword ptr [0x18d8000], ecx
004A61CD  mov      eax, dword ptr [esi + 4]
004A61D0  mov      dword ptr [0x18d800c], eax
004A61D5  mov      edx, dword ptr [esi + 8]
004A61D8  mov      dword ptr [0x18d8010], edx
004A61DE  mov      esi, dword ptr [esi + 0xc]
004A61E1  and      esi, 0x7fff
004A61E7  mov      dword ptr [0x18d8004], esi
004A61ED  cmp      ecx, 2
004A61F0  je       0x4a61fe
004A61F2  or       esi, 0x8000
004A61F8  mov      dword ptr [0x18d8004], esi
004A61FE  shl      eax, 8
004A6201  add      eax, edx
004A6203  mov      dword ptr [0x18d8008], eax
004A6208  xor      esi, esi
004A620A  push     esi
004A620B  mov      edi, dword ptr [0x4b40e0]   ; IAT:KERNEL32.dll!GetModuleHandleA
004A6211  call     edi
004A6213  cmp      word ptr [eax], 0x5a4d
004A6218  jne      0x4a6239
004A621A  mov      ecx, dword ptr [eax + 0x3c]
004A621D  add      ecx, eax
004A621F  cmp      dword ptr [ecx], 0x4550
004A6225  jne      0x4a6239
004A6227  movzx    eax, word ptr [ecx + 0x18]
004A622B  cmp      eax, 0x10b
004A6230  je       0x4a6251
004A6232  cmp      eax, 0x20b
004A6237  je       0x4a623e
004A6239  mov      dword ptr [ebp - 0x1c], esi
004A623C  jmp      0x4a6265   ; -> sub_0A6265 [func-start]
004A623E  cmp      dword ptr [ecx + 0x84], 0xe
004A6245  jbe      0x4a6239
004A6247  xor      eax, eax
004A6249  cmp      dword ptr [ecx + 0xf8], esi
004A624F  jmp      0x4a625f   ; -> sub_0A625F [func-start]
004A6251  cmp      dword ptr [ecx + 0x74], 0xe
004A6255  jbe      0x4a6239
004A6257  xor      eax, eax
004A6259  cmp      dword ptr [ecx + 0xe8], esi
004A625F  setne    al
004A6262  mov      dword ptr [ebp - 0x1c], eax
004A6265  push     1
004A6267  call     0x4a81c0   ; -> sub_0A81C0 [func-start]
004A626C  pop      ecx
004A626D  test     eax, eax
004A626F  jne      0x4a6279
004A6271  push     0x1c
004A6273  call     0x4a617a   ; -> sub_0A617A [func-start]
004A6278  pop      ecx
004A6279  call     0x4aa0d8   ; -> sub_0AA0D8 [func-start]
004A627E  test     eax, eax
004A6280  jne      0x4a628a
004A6282  push     0x10
004A6284  call     0x4a617a   ; -> sub_0A617A [func-start]
004A6289  pop      ecx
004A628A  call     0x4acbfe   ; -> sub_0ACBFE [func-start]
004A628F  mov      dword ptr [ebp - 4], esi
004A6292  call     0x4aca00   ; -> sub_0ACA00 [func-start]
004A6297  test     eax, eax
004A6299  jge      0x4a62a3
004A629B  push     0x1b
004A629D  call     0x4a6155   ; -> sub_0A6155 [func-start]
004A62A2  pop      ecx
004A62A3  call     dword ptr [0x4b4190]   ; IAT:KERNEL32.dll!GetCommandLineA
004A62A9  mov      dword ptr [0x18d983c], eax
004A62AE  call     0x4ac8de   ; -> sub_0AC8DE [func-start]
004A62B3  mov      dword ptr [0x18d7ff0], eax
004A62B8  call     0x4ac83c   ; -> sub_0AC83C [func-start]
004A62BD  test     eax, eax
004A62BF  jge      0x4a62c9
004A62C1  push     8
004A62C3  call     0x4a6155   ; -> sub_0A6155 [func-start]
004A62C8  pop      ecx
004A62C9  call     0x4ac609   ; -> sub_0AC609 [func-start]
004A62CE  test     eax, eax
004A62D0  jge      0x4a62da
```

## 8. 关键函数识别(capstone + IAT 引用分析)

估计函数总数(E8 call 目标统计): **1832**

### [graphics_init] 0x00442200 (RVA 0x42200, ≈0x40 bytes, 入度 1)

引用 API: `d3d8.dll!Direct3DCreate8`

```asm
00442200  push     ebp
00442201  mov      ebp, esp
00442203  push     0xdc
00442208  call     0x476cec   ; -> thunk:d3d8.dll!Direct3DCreate8
0044220D  mov      dword ptr [0x17ce75c], eax
00442212  cmp      dword ptr [0x17ce75c], 0
00442219  jne      0x442234
0044221B  push     0x4b5c00
00442220  push     0x164d540
00442225  call     0x43eb60   ; -> sub_03EB60 [func-start]
0044222A  add      esp, 8
0044222D  mov      eax, 1
00442232  jmp      0x442236   ; -> sub_042236 [func-start]
00442234  xor      eax, eax
00442236  pop      ebp
00442237  ret      
```

### [input_init] 0x00446A37 (RVA 0x46A37, ≈0x4d4 bytes, 入度 1)

引用 API: `DINPUT8.dll!DirectInput8Create`, `USER32.dll!GetWindowLongA`

```asm
00446A37  push     ebp
00446A38  mov      ebp, esp
00446A3A  push     ecx
00446A3B  push     ecx
00446A3C  mov      dword ptr [ebp - 8], ecx
00446A3F  push     -6
00446A41  mov      eax, dword ptr [ebp - 8]
00446A44  push     dword ptr [eax + 0x44]
00446A47  call     dword ptr [0x4b41e4]   ; IAT:USER32.dll!GetWindowLongA
00446A4D  mov      dword ptr [ebp - 4], eax
00446A50  mov      eax, dword ptr [ebp - 8]
00446A53  mov      eax, dword ptr [eax + 0x150]
00446A59  shr      eax, 0xb
00446A5C  and      eax, 1
00446A5F  test     eax, eax
00446A61  je       0x446a6b
00446A63  or       eax, 0xffffffff
00446A66  jmp      0x446cc5   ; -> sub_046CC5 [func-start]
00446A6B  push     0
00446A6D  mov      eax, dword ptr [ebp - 8]
00446A70  add      eax, 0xc
00446A73  push     eax
00446A74  push     0x4bd6c0
00446A79  push     0x800
00446A7E  push     dword ptr [ebp - 4]
00446A81  call     0x476ce0   ; -> thunk:DINPUT8.dll!DirectInput8Create
00446A86  test     eax, eax
00446A88  jge      0x446aaa
00446A8A  mov      eax, dword ptr [ebp - 8]
00446A8D  and      dword ptr [eax + 0xc], 0
00446A91  push     0x4b6904
00446A96  push     0x164d540
00446A9B  call     0x43ea00   ; -> sub_03EA00 [func-start]
00446AA0  pop      ecx
```

### [message_pump] 0x004418C0 (RVA 0x418C0, ≈0x550 bytes, 入度 1)

引用 API: `KERNEL32.dll!QueryPerformanceFrequency`, `KERNEL32.dll!Sleep`, `USER32.dll!DestroyWindow`, `USER32.dll!DispatchMessageA`, `USER32.dll!MoveWindow`, `USER32.dll!PeekMessageA`, `USER32.dll!SetCursor`, `USER32.dll!ShowCursor`, `USER32.dll!ShowWindow`, `USER32.dll!SystemParametersInfoA`, `USER32.dll!TranslateMessage`, `USER32.dll!WINNLSEnableIME`

```asm
004418C0  push     ebp
004418C1  mov      ebp, esp
004418C3  sub      esp, 0x4c
004418C6  mov      dword ptr [ebp - 0x24], 0
004418CD  mov      eax, dword ptr [ebp + 8]
004418D0  mov      dword ptr [0x17ce758], eax
004418D5  push     0
004418D7  push     0x17ce720
004418DC  push     0
004418DE  push     0x10
004418E0  call     dword ptr [0x4b420c]   ; IAT:USER32.dll!SystemParametersInfoA
004418E6  push     0
004418E8  push     0x17ce724
004418ED  push     0
004418EF  push     0x53
004418F1  call     dword ptr [0x4b420c]   ; IAT:USER32.dll!SystemParametersInfoA
004418F7  push     0
004418F9  push     0x17ce728
004418FE  push     0
00441900  push     0x54
00441902  call     dword ptr [0x4b420c]   ; IAT:USER32.dll!SystemParametersInfoA
00441908  push     2
0044190A  push     0
0044190C  push     0
0044190E  push     0x11
00441910  call     dword ptr [0x4b420c]   ; IAT:USER32.dll!SystemParametersInfoA
00441916  push     2
00441918  push     0
0044191A  push     0
0044191C  push     0x55
0044191E  call     dword ptr [0x4b420c]   ; IAT:USER32.dll!SystemParametersInfoA
00441924  push     2
00441926  push     0
00441928  push     0
```

### [sound_init_dsound] 0x00471730 (RVA 0x71730, ≈0x90 bytes, 入度 1)

引用 API: `DSOUND.dll!ord#11`

```asm
00471730  push     ebp
00471731  mov      ebp, esp
00471733  sub      esp, 0xc
00471736  mov      dword ptr [ebp - 0xc], ecx
00471739  mov      dword ptr [ebp - 4], 0
00471740  mov      eax, dword ptr [ebp - 0xc]
00471743  cmp      dword ptr [eax], 0
00471746  je       0x471761
00471748  mov      ecx, dword ptr [ebp - 0xc]
0047174B  mov      edx, dword ptr [ecx]
0047174D  mov      eax, dword ptr [ebp - 0xc]
00471750  mov      ecx, dword ptr [eax]
00471752  mov      edx, dword ptr [edx]
00471754  push     ecx
00471755  call     dword ptr [edx + 8]
00471758  mov      eax, dword ptr [ebp - 0xc]
0047175B  mov      dword ptr [eax], 0
00471761  push     0
00471763  mov      ecx, dword ptr [ebp - 0xc]
00471766  push     ecx
00471767  push     0
00471769  call     0x476ce6   ; -> thunk:DSOUND.dll!ord#11
0047176E  mov      dword ptr [ebp - 8], eax
00471771  cmp      dword ptr [ebp - 8], 0
00471775  jge      0x47177c
00471777  mov      eax, dword ptr [ebp - 8]
0047177A  jmp      0x4717b8   ; -> sub_0717B8 [func-start]
0047177C  mov      edx, dword ptr [ebp + 0xc]
0047177F  push     edx
00471780  mov      eax, dword ptr [ebp + 8]
00471783  push     eax
00471784  mov      ecx, dword ptr [ebp - 0xc]
00471787  mov      edx, dword ptr [ecx]
00471789  mov      eax, dword ptr [ebp - 0xc]
```

### [text_render] 0x0043F9C8 (RVA 0x3F9C8, ≈0x321 bytes, 入度 1)

引用 API: `GDI32.dll!CreateFontA`, `GDI32.dll!DeleteObject`, `GDI32.dll!SelectObject`, `GDI32.dll!SetBkMode`, `GDI32.dll!SetTextColor`, `GDI32.dll!TextOutA`

```asm
0043F9C8  mov      eax, 0x4b302d
0043F9CD  call     0x4a4838   ; -> sub_0A4838 [func-start]
0043F9D2  sub      esp, 0x7c
0043F9D5  mov      dword ptr [ebp - 0x88], edx
0043F9DB  mov      dword ptr [ebp - 0x84], ecx
0043F9E1  push     0x4b5b18
0043F9E6  push     0x11
0043F9E8  push     4
0043F9EA  push     0
0043F9EC  push     0
0043F9EE  push     0x80
0043F9F3  push     0
0043F9F5  push     0
0043F9F7  push     0
0043F9F9  push     0x258
0043F9FE  push     0
0043FA00  push     0
0043FA02  push     0
0043FA04  mov      eax, dword ptr [ebp + 0x10]
0043FA07  lea      eax, [eax + eax - 2]
0043FA0B  push     eax
0043FA0C  call     dword ptr [0x4b4040]   ; IAT:GDI32.dll!CreateFontA
0043FA12  mov      dword ptr [ebp - 0x14], eax
0043FA15  lea      ecx, [ebp - 0x5c]
0043FA18  call     0x43efef   ; -> sub_03EFEF [func-start]
0043FA1D  and      dword ptr [ebp - 4], 0
0043FA21  lea      eax, [ebp - 0x34]
0043FA24  push     eax
0043FA25  mov      eax, dword ptr [0x1653620]
0043FA2A  mov      eax, dword ptr [eax]
0043FA2C  push     dword ptr [0x1653620]
0043FA32  call     dword ptr [eax + 0x20]
0043FA35  push     dword ptr [ebp - 0x34]
0043FA38  push     dword ptr [ebp - 0x18]
```

### [winmain_candidate] 0x00442240 (RVA 0x42240, ≈0x280 bytes, 入度 1)

引用 API: `GDI32.dll!GetStockObject`, `USER32.dll!CreateWindowExA`, `USER32.dll!DefWindowProcA`, `USER32.dll!GetSystemMetrics`, `USER32.dll!LoadCursorA`, `USER32.dll!RegisterClassA`, `USER32.dll!SetCursor`, `USER32.dll!ShowCursor`

```asm
00442240  push     ebp
00442241  mov      ebp, esp
00442243  sub      esp, 0x34
00442246  push     esi
00442247  push     edi
00442248  mov      dword ptr [ebp - 0x34], ecx
0044224B  mov      ecx, 0xa
00442250  xor      eax, eax
00442252  lea      edi, [ebp - 0x30]
00442255  rep stosd dword ptr es:[edi], eax
00442257  push     4
00442259  call     dword ptr [0x4b4044]   ; IAT:GDI32.dll!GetStockObject
0044225F  mov      dword ptr [ebp - 0x14], eax
00442262  push     0x7f00
00442267  push     0
00442269  call     dword ptr [0x4b41fc]   ; IAT:USER32.dll!LoadCursorA
0044226F  mov      dword ptr [ebp - 0x18], eax
00442272  mov      eax, dword ptr [ebp - 0x34]
00442275  mov      dword ptr [ebp - 0x20], eax
00442278  mov      dword ptr [ebp - 0x2c], 0x442390
0044227F  mov      dword ptr [0x17ce708], 1
00442289  mov      dword ptr [0x17ce70c], 0
00442293  mov      dword ptr [ebp - 0xc], 0x4b5c60
0044229A  lea      ecx, [ebp - 0x30]
0044229D  push     ecx
0044229E  call     dword ptr [0x4b4200]   ; IAT:USER32.dll!RegisterClassA
004422A4  mov      ecx, 0x17ce758
004422A9  call     0x443ad0   ; -> sub_043AD0 [func-start]
004422AE  test     eax, eax
004422B0  jne      0x4422f4
004422B2  mov      dword ptr [ebp - 8], 0x280
004422B9  mov      dword ptr [ebp - 4], 0x1e0
004422C0  push     0
004422C2  mov      edx, dword ptr [ebp - 0x34]
```

### [hub_function(top call-magnet)] 0x0040B460 (RVA 0xB460, ≈0x10 bytes, 入度 326)

```asm
0040B460  push     ebp
0040B461  mov      ebp, esp
0040B463  push     ecx
0040B464  mov      dword ptr [ebp - 4], ecx
0040B467  mov      eax, dword ptr [ebp - 4]
0040B46A  mov      esp, ebp
0040B46C  pop      ebp
0040B46D  ret      
```

### [hub_function(top call-magnet)] 0x004065F0 (RVA 0x65F0, ≈0x20 bytes, 入度 200)

```asm
004065F0  push     ebp
004065F1  mov      ebp, esp
004065F3  push     ecx
004065F4  mov      dword ptr [ebp - 4], ecx
004065F7  mov      eax, dword ptr [ebp + 8]
004065FA  push     eax
004065FB  mov      ecx, dword ptr [ebp - 4]
004065FE  call     0x406610   ; -> sub_006610 [func-start]
00406603  mov      esp, ebp
00406605  pop      ebp
00406606  ret      4
```

### [hub_function(top call-magnet)] 0x004A3E70 (RVA 0xA3E70, ≈0x80 bytes, 入度 189)

```asm
004A3E70  push     ebp
004A3E71  mov      ebp, esp
004A3E73  sub      esp, 0x20
004A3E76  and      esp, 0xfffffff0
004A3E79  fld      st(0)
004A3E7B  fst      dword ptr [esp + 0x18]
004A3E7F  fistp    qword ptr [esp + 0x10]
004A3E83  fild     qword ptr [esp + 0x10]
004A3E87  mov      edx, dword ptr [esp + 0x18]
004A3E8B  mov      eax, dword ptr [esp + 0x10]
004A3E8F  test     eax, eax
004A3E91  je       0x4a3ecf
004A3E93  fsubp    st(1)
004A3E95  test     edx, edx
004A3E97  jns      0x4a3eb7
004A3E99  fstp     dword ptr [esp]
004A3E9C  mov      ecx, dword ptr [esp]
004A3E9F  xor      ecx, 0x80000000
004A3EA5  add      ecx, 0x7fffffff
004A3EAB  adc      eax, 0
004A3EAE  mov      edx, dword ptr [esp + 0x14]
004A3EB2  adc      edx, 0
```

### [hub_function(top call-magnet)] 0x0041F420 (RVA 0x1F420, ≈0x900 bytes, 入度 189)

```asm
0041F420  push     ebp
0041F421  mov      ebp, esp
0041F423  sub      esp, 0x24
0041F426  push     esi
0041F427  mov      dword ptr [ebp - 0x14], edx
0041F42A  mov      dword ptr [ebp - 0x10], ecx
0041F42D  mov      eax, dword ptr [ebp - 0x14]
0041F430  mov      dword ptr [ebp - 0x18], eax
0041F433  mov      ecx, dword ptr [ebp - 0x18]
0041F436  sub      ecx, 0x2710
0041F43C  mov      dword ptr [ebp - 0x18], ecx
0041F43F  cmp      dword ptr [ebp - 0x18], 0x64
0041F443  ja       0x41fb83
0041F449  mov      edx, dword ptr [ebp - 0x18]
0041F44C  jmp      dword ptr [edx*4 + 0x41fb8b]
0041F453  mov      eax, dword ptr [ebp - 0x10]
0041F456  mov      ecx, dword ptr [eax + 0x2ca0]
0041F45C  mov      eax, dword ptr [ecx + 0x18]
0041F45F  jmp      0x41fb86   ; -> sub_01FB86
0041F464  mov      edx, dword ptr [ebp - 0x10]
0041F467  mov      eax, dword ptr [edx + 0x2ca0]
0041F46D  mov      eax, dword ptr [eax + 0x1c]
```

## 9. Rich 编译器头

无 Rich 头(非 MSVC 链接或被抹除)。

## 10. 字符串分析

提取统计: {'ascii': 1288, 'sjis': 3026, 'utf16le': 3249} — 完整清单见同目录 `strings_all.txt`。

### 标题/项目相关

| 字符串 | 所在节 |
|---|---|
| `Touhou 08 App` | .rdata |
| `東方動作記録 --------------------------------------------- ` | .rdata |
| `東方永夜抄　～ Imperishable Night. ver 1.00d` | .rdata |
| `東方永夜抄　～ Imperishable Night. ver 1.00d 記録テキスト版` | .rdata |

### 制作署名相关

| 字符串 | 所在节 |
|---|---|
| `Please contact the application's support team for more information.` | .rdata |

### 窗口类/标题候选(SJIS, .data/.rdata)

| 字符串 | 所在节 |
|---|---|
| `ステージデータが見つかりません。データが壊れています` | .rdata |
| `霊符「夢想妙珠」` | .rdata |
| `劔?神霊「夢想封印　瞬」` | .rdata |
| `「ディゾルブスペル」` | .rdata |
| `魔符「アーティフルサクリファイス」` | .rdata |
| `魔操「リターンイナニメトネス」` | .rdata |
| `恋符「マスタースパーク」` | .rdata |
| `魔砲「ファイナルスパーク」` | .rdata |
| `紅符「不夜城レッド」` | .rdata |
| `紅魔「スカーレットデビル」` | .rdata |
| `幻符「殺人ドール」` | .rdata |
| `幻葬「夜霧の幻影殺人鬼」` | .rdata |
| `境符「四重結界」` | .rdata |
| `境界「永夜四重結界」` | .rdata |
| `人符「現世斬」` | .rdata |
| `人鬼「未来永劫斬」` | .rdata |
| `死符「ギャストリドリーム」` | .rdata |
| `死蝶「華胥の永眠」` | .rdata |
| `敵データのバージョンが違います` | .rdata |
| `燭ECLInt` | .rdata |
| `皚C遅殖` | .rdata |
| `ⅱ，I<` | .rdata |
| `「リザレクション」` | .rdata |
| `愿MAX` | .rdata |
| `鵤%.9d` | .rdata |
| `錢%.2d` | .rdata |
| `呂FRScreenImplInf` | .rdata |
| `漓+%d` | .rdata |
| `�ALast Spell Failed` | .rdata |
| `メッセージファイル %s が読み込めませんでした` | .rdata |

### 数据文件引用(.anm/.dat/.mid/.wav…)

扩展名分布: `.anm`×59, `.dat`×33, `.mid`×16, `.end`×12

| 引用示例 | 扩展名 | 所在节 |
|---|---|---|
| ``Bcapture.anm` | .anm | .rdata |
| `ascii.anm` | .anm | .rdata |
| `face_st08sp.anm` | .anm | .rdata |
| `face_st08msp.anm` | .anm | .rdata |
| `face_st07sp.anm` | .anm | .rdata |
| `face_st06sp.anm` | .anm | .rdata |
| `face_st05sp.anm` | .anm | .rdata |
| `face_st05msp.anm` | .anm | .rdata |
| `face_st04bsp.anm` | .anm | .rdata |
| `face_yksp.anm` | .anm | .rdata |
| `face_yysp.anm` | .anm | .rdata |
| `face_rssp.anm` | .anm | .rdata |
| `face_alsp.anm` | .anm | .rdata |
| `face_ymsp.anm` | .anm | .rdata |
| `face_sksp.anm` | .anm | .rdata |
| `face_st04asp.anm` | .anm | .rdata |
| `face_st03sp.anm` | .anm | .rdata |
| `face_st02sp.anm` | .anm | .rdata |
| `face_st01sp.anm` | .anm | .rdata |
| `face_st08.anm` | .anm | .rdata |
| `face_st08m.anm` | .anm | .rdata |
| `face_st07.anm` | .anm | .rdata |
| `face_st06.anm` | .anm | .rdata |
| `face_st05b.anm` | .anm | .rdata |
| `face_st05.anm` | .anm | .rdata |
| `face_st04b.anm` | .anm | .rdata |
| `face_st04a.anm` | .anm | .rdata |
| `face_st03.anm` | .anm | .rdata |
| `face_st02.anm` | .anm | .rdata |
| `face_st01.anm` | .anm | .rdata |
| `face_yy00.anm` | .anm | .rdata |
| `face_ym00.anm` | .anm | .rdata |
| `face_rs00.anm` | .anm | .rdata |
| `face_sk00.anm` | .anm | .rdata |
| `face_al00.anm` | .anm | .rdata |
| `face_mr00.anm` | .anm | .rdata |
| `face_yk00.anm` | .anm | .rdata |
| `face_rm00.anm` | .anm | .rdata |
| `face_cdbg.anm` | .anm | .rdata |
| `end03c.end` | .end | .rdata |
| `end02c.end` | .end | .rdata |
| `end01c.end` | .end | .rdata |
| `end00c.end` | .end | .rdata |
| `end03b.end` | .end | .rdata |
| `end02b.end` | .end | .rdata |

### 路径类字符串(样例)

| 字符串 | 所在节 |
|---|---|
| `CCGG;\$$` | .text |
| `DXT2t\` | .text |
| `@9A\u39` | .text |
| `8^JtP8\$` | .text |
| `M\C;]`r` | .text |
| `d:\cygwin\home\zun\prog\th08\global.h` | .rdata |
| `ABCDEFGHIJKLMNOPQRSTUVWXYZ.,:;_@abcdefghijklmnopqrstuvwxyz+-/*=%0123456789#!?'"$(){}[]<>&\…` | .rdata |
| `>Software\Microsoft\Direct3D` | .rdata |
| `SOFTWARE\Microsoft\Direct3D` | .rdata |
| ` !"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxy…` | .rdata |
| `qqqUW\` | .rsrc |
| `毅\右��` | .text |
| `駆��\窺` | .text |
| `�ﾀt\j` | .text |
| `�ﾀt\畿` | .text |
| `偽�R劫\` | .text |
| `稀 燕\` | .text |
| `β\�q貴` | .text |
| `駆��\蔚` | .text |
| `偽�畿�笈\*` | .text |
| `駆��\VW窺` | .text |
| `毅\P貴` | .text |
| `汲\%*` | .text |
| `庚韋\鵆` | .text |
| `�h\yK` | .text |

### DirectX/API 相关字符串

| 字符串 | 所在节 |
|---|---|
| `@Intel(R) C/C++ Compiler Version 4.5 00015  : ..\ssefasttable.cpp : -Qvc6 -c -Ie:\ntsd\mul…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\ssefasttable2.cpp : -Qvc6 -c -Ie…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxmathsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxquatsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxquatsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxmathsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxtrigsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxtrigsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `Direct3D ` | .rdata |
| `DirectInput ` | .rdata |
| `DirectInput SetCooperativeLevel ` | .rdata |
| `DirectInput SetDataFormat ` | .rdata |
| ` DirectInput ` | .rdata |
| `DirectSound ` | .rdata |
| `>Software\Microsoft\Direct3D` | .rdata |
| `SOFTWARE\Microsoft\Direct3D` | .rdata |
| `DirectInput8Create` | .rdata |
| `DINPUT8.dll` | .rdata |
| `Direct3DCreate8` | .rdata |
| `AttachThreadInput` | .rdata |

### 开发/调试痕迹

| 字符串 | 所在节 |
|---|---|
| `@Intel(R) C/C++ Compiler Version 4.5 00015  : ..\ssefasttable.cpp : -Qvc6 -c -Ie:\ntsd\mul…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\ssefasttable2.cpp : -Qvc6 -c -Ie…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxmathsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxquatsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxquatsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxmathsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Version 4.5 00015  : ..\d3dxtrigsse.cpp : -Qvc6 -c -Ie:\ntsd\multi…` | (header/overlay) |
| `Intel(R) C/C++ Compiler Special Edition W2.0 000316  : ..\d3dxtrigsse2.cpp : -Qvc6 -c -Ie:…` | (header/overlay) |
| `d:\cygwin\home\zun\prog\th08\global.h` | .rdata |
| `p}?error ? mother.cpp` | .rdata |
| `>Software\Microsoft\Direct3D` | .rdata |
| `DebugSetMute` | .rdata |
| `LoadDebugRuntime` | .rdata |
| `SOFTWARE\Microsoft\Direct3D` | .rdata |
| `Microsoft Visual C++ Runtime Library` | .rdata |

## 11. 版本指纹综合结论

链接器 7.0(VS2002); PE 时间戳 2004-09-19 16:09:48 UTC; Direct3D8, DirectInput。
