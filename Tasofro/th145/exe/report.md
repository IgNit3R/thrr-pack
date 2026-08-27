# 東方深秘録 ~ Urban Legend in Limbo (TH14.5) — 主程序深度静态分析报告

- 目标文件: `E:/GitWorkspace/thworks/tf/th145/th145.exe`
- 分析方式: 纯静态 (pefile 结构解析 + capstone 反汇编 + 字符串提取),未执行目标程序

## 1. 文件概要

| 属性 | 值 |
|---|---|
| 大小 | 5983744 bytes (5.7 MiB) |
| MD5 | `f54bdd766533707cfbc82a1e9c86d24f` |
| SHA256 | `407a0475387ab07f40de3a33c9e50a027dcd7858be0782b347a694c6b858c2d9` |
| 文件修改时间 | 2015-04-22T22:29:12+00:00 |
| PE 时间戳 | 2015-04-22 21:29:12 UTC (raw 0x553812A8) |
| 架构/子系统 | i386 / PE32 / WINDOWS_GUI |
| 链接器版本 | 11.0 → VS2012 |
| 入口点 | RVA 0x38DBB3 (VA 0x0078DBB3) |
| ImageBase | 0x400000 |
| CheckSum 校验 | 不通过(存储 0,未生成) |

**编译指纹结论**: 链接器 11.0 → VS2012。**打包器**: no strong packer indicators。**图形/模块栈**: Direct3D9, D3DX, DirectInput8, DirectInput, DirectSound, winmm, winsock2, XInput。

## 2. 节区表

| 节 | VA | VSize | RawPtr | RawSize | 熵 | 属性 | V/R比 |
|---|---|---|---|---|---|---|---|
| .text | 0x1000 | 4294058 | 1024 | 4294144 | 6.4978 | EXEC|READ|CODE | 1.0 |
| .rdata | 0x41A000 | 798298 | 4295168 | 798720 | 5.3049 | READ|IDATA | 0.999 |
| .data | 0x4DD000 | 481948 | 5093888 | 412160 | 5.2562 | READ|WRITE|IDATA | 1.169 |
| .tls | 0x553000 | 2 | 5506048 | 512 | -0.0 | READ|WRITE|IDATA | 0.004 |
| _RDATA | 0x554000 | 2016 | 5506560 | 2048 | 4.8025 | READ|IDATA | 0.984 |
| .rsrc | 0x555000 | 3888 | 5508608 | 4096 | 6.3015 | READ|IDATA | 0.949 |
| .reloc | 0x556000 | 470706 | 5512704 | 471040 | 3.3443 | READ|IDATA | 0.999 |

## 3. 导入表 (16 DLL / 329 函数)

| DLL | 导入数 |
|---|---|
| WINMM.dll | 2 |
| d3dx9_43.dll | 13 |
| IMM32.dll | 6 |
| KERNEL32.dll | 181 |
| USER32.dll | 65 |
| GDI32.dll | 16 |
| ADVAPI32.dll | 12 |
| SHELL32.dll | 2 |
| ole32.dll | 4 |
| OLEAUT32.dll | 2 |
| WS2_32.dll | 20 |
| PSAPI.DLL | 1 |
| DINPUT8.dll | 1 |
| XINPUT9_1_0.dll | 2 |
| d3d9.dll | 1 |
| DSOUND.dll | 1 |

**关键 API 使用**(按功能分类,来自关键函数识别):见 §8。

## 4. 导出表

无导出(典型应用程序)。

## 5. 资源

| 类型 | 数量 | 总字节 |
|---|---|---|
| type#1041 | 2 | 3260 |
| type#1033 | 1 | 381 |

## 6. TLS / 签名 / Overlay

- TLS: 存在 (callbacks=['0x784880'])
- 数字签名: 无
- Overlay: offset 5983744, size 0 bytes (无 overlay)

Rich 头(工具链指纹):
- prod_id=13082782 build=1 ×1
- prod_id=13485809 build=79 ×1
- prod_id=13616881 build=143 ×1
- prod_id=13551345 build=266 ×1
- prod_id=13561446 build=8 ×1
- prod_id=13495910 build=2 ×1
- prod_id=13626982 build=174 ×1
- prod_id=10244818 build=2 ×1
- prod_id=8111655 build=2 ×1
- prod_id=11236975 build=2 ×1
- prod_id=9664521 build=4 ×1
- prod_id=8615945 build=3 ×1
- prod_id=13369309 build=25 ×1
- prod_id=65536 build=354 ×1
- prod_id=13889126 build=183 ×1
- prod_id=13233766 build=1 ×1
- prod_id=9895936 build=1 ×1
- prod_id=13430374 build=1 ×1

## 7. 入口点反汇编(前段)

```asm
0078DBB3  call     0x79eee4   ; -> sub_79EEE4 [func-start]
0078DBB8  jmp      0x78dbbd
0078DBBD  push     0x14
0078DBBF  push     0x8c2508
0078DBC4  call     0x799df0
0078DBC9  call     0x7972c5   ; -> sub_7972C5 [func-start]
0078DBCE  movzx    esi, ax
0078DBD1  push     2
0078DBD3  call     0x79a20b   ; -> sub_79A20B [func-start]
0078DBD8  pop      ecx
0078DBD9  mov      eax, 0x5a4d
0078DBDE  cmp      word ptr [0x400000], ax
0078DBE5  je       0x78dbeb
0078DBE7  xor      ebx, ebx
0078DBE9  jmp      0x78dc1e
0078DBEB  mov      eax, dword ptr [0x40003c]
0078DBF0  cmp      dword ptr [eax + 0x400000], 0x4550
0078DBFA  jne      0x78dbe7
0078DBFC  mov      ecx, 0x10b
0078DC01  cmp      word ptr [eax + 0x400018], cx
0078DC08  jne      0x78dbe7
0078DC0A  xor      ebx, ebx
0078DC0C  cmp      dword ptr [eax + 0x400074], 0xe
0078DC13  jbe      0x78dc1e
0078DC15  cmp      dword ptr [eax + 0x4000e8], ebx
0078DC1B  setne    bl
0078DC1E  mov      dword ptr [ebp - 0x1c], ebx
0078DC21  call     0x79981e
0078DC26  test     eax, eax
0078DC28  jne      0x78dc32
0078DC2A  push     0x1c
0078DC2C  call     0x78dd0d   ; -> sub_78DD0D [func-start]
0078DC31  pop      ecx
0078DC32  call     0x79e999
0078DC37  test     eax, eax
0078DC39  jne      0x78dc43
0078DC3B  push     0x10
0078DC3D  call     0x78dd0d   ; -> sub_78DD0D [func-start]
0078DC42  pop      ecx
0078DC43  call     0x79ef7e
```

## 8. 关键函数识别(capstone + IAT 引用分析)

估计函数总数(E8 call 目标统计): **10830**

### [message_pump] 0x004164B0 (RVA 0x164B0, ≈0x70 bytes, 入度 0)

引用 API: `USER32.dll!PeekMessageA`, `USER32.dll!PostMessageA`

```asm
004164B0  push     ebp
004164B1  mov      ebp, esp
004164B3  mov      ecx, dword ptr [ecx + 0x1c]
004164B6  sub      esp, 0x1c
004164B9  test     ecx, ecx
004164BB  jne      0x4164c8
004164BD  mov      eax, 0x80004005
004164C2  mov      esp, ebp
004164C4  pop      ebp
004164C5  ret      0x14
004164C8  mov      eax, dword ptr [ecx]
004164CA  push     esi
004164CB  mov      esi, dword ptr [ebp + 0x10]
004164CE  push     edi
004164CF  push     dword ptr [ebp + 0x18]
004164D2  push     dword ptr [ebp + 0x14]
004164D5  push     esi
004164D6  push     dword ptr [ebp + 0xc]
004164D9  push     dword ptr [ebp + 8]
004164DC  push     ecx
004164DD  call     dword ptr [eax + 0xc]
004164E0  mov      edi, eax
004164E2  cmp      edi, 0x88760868
004164E8  jne      0x416513
004164EA  push     0
004164EC  push     0x10017
```

### [winmain_candidate] 0x00423130 (RVA 0x23130, ≈0x1d0 bytes, 入度 1)

引用 API: `GDI32.dll!GetStockObject`, `IMM32.dll!ImmGetContext`, `IMM32.dll!ImmReleaseContext`, `IMM32.dll!ImmSetOpenStatus`, `USER32.dll!AdjustWindowRectEx`, `USER32.dll!CreateWindowExA`, `USER32.dll!LoadCursorA`, `USER32.dll!LoadIconA`, `USER32.dll!RegisterClassExA`, `USER32.dll!ShowWindow`, `USER32.dll!UpdateWindow`

```asm
00423130  push     ebp
00423131  mov      ebp, esp
00423133  and      esp, 0xfffffff8
00423136  sub      esp, 0x15c
0042313C  mov      eax, dword ptr [0x92a3e0]
00423141  xor      eax, esp
00423143  mov      dword ptr [esp + 0x158], eax
0042314A  mov      eax, dword ptr [ebp + 0x14]
0042314D  push     ebx
0042314E  push     esi
0042314F  mov      esi, dword ptr [ebp + 0x10]
00423152  push     edi
00423153  push     0
00423155  mov      dword ptr [esp + 0x14], eax
00423159  mov      eax, dword ptr [ebp + 0xc]
0042315C  push     0
0042315E  mov      dword ptr [0x92f090], eax
00423163  mov      dword ptr [esp + 0x5c], eax
00423167  mov      dword ptr [0x943fe8], ecx
0042316D  mov      ecx, dword ptr [ebp + 8]
00423170  push     0xca0000
00423175  lea      eax, [esp + 0x54]
00423179  push     eax
0042317A  mov      dword ptr [esp + 0x1c], edx
0042317E  mov      dword ptr [esp + 0x24], esi
00423182  mov      dword ptr [0x92f08c], ecx
```

### [message_pump] 0x004236B0 (RVA 0x236B0, ≈0x70 bytes, 入度 1)

引用 API: `USER32.dll!DispatchMessageA`, `USER32.dll!GetMessageA`, `USER32.dll!PeekMessageA`, `USER32.dll!TranslateMessage`, `USER32.dll!WaitMessage`

```asm
004236B0  push     ebp
004236B1  mov      ebp, esp
004236B3  sub      esp, 0x1c
004236B6  push     ebx
004236B7  mov      ebx, dword ptr [0x81a414]
004236BD  push     esi
004236BE  mov      esi, dword ptr [0x81a43c]
004236C4  push     edi
004236C5  mov      edi, dword ptr [0x81a48c]
004236CB  jmp      0x4236d0
004236CD  lea      ecx, [ecx]
004236D0  push     0
004236D2  push     0
004236D4  push     0
004236D6  push     0
004236D8  lea      eax, [ebp - 0x1c]
004236DB  push     eax
004236DC  call     edi
004236DE  test     eax, eax
004236E0  je       0x423708
004236E2  push     0
004236E4  push     0
004236E6  push     0
004236E8  lea      eax, [ebp - 0x1c]
004236EB  push     eax
004236EC  call     ebx
```

### [network_winsock] 0x00423A50 (RVA 0x23A50, ≈0xa0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00423A50  push     ebp
00423A51  mov      ebp, esp
00423A53  and      esp, 0xfffffff8
00423A56  sub      esp, 0x1a0
00423A5C  mov      eax, dword ptr [0x92a3e0]
00423A61  xor      eax, esp
00423A63  mov      dword ptr [esp + 0x19c], eax
00423A6A  push     esi
00423A6B  mov      esi, ecx
00423A6D  push     edi
00423A6E  mov      ecx, 0x9452a4
00423A73  mov      eax, 1
00423A78  lock xadd dword ptr [ecx], eax
00423A7C  inc      eax
00423A7D  mov      edi, 0x9452a8
00423A82  cmp      eax, 1
00423A85  jne      0x423a96
00423A87  lea      eax, [esp + 0x10]
00423A8B  push     eax
00423A8C  push     2
00423A8E  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00423A94  xchg     dword ptr [edi], eax
00423A96  cmp      byte ptr [ebp + 8], 0
00423A9A  je       0x423aa6
00423A9C  xor      eax, eax
00423A9E  lock xadd dword ptr [edi], eax
```

### [network_winsock] 0x00423AF0 (RVA 0x23AF0, ≈0x20 bytes, 入度 0)

引用 API: `KERNEL32.dll!LeaveCriticalSection`, `WS2_32.dll!WSACleanup`

```asm
00423AF0  mov      ah, 0xa4
00423AF2  add      dword ptr [eax], 0xccccccc3
00423AF8  int3     
00423AF9  int3     
00423AFA  int3     
00423AFB  int3     
00423AFC  int3     
00423AFD  int3     
00423AFE  int3     
00423AFF  int3     
00423B00  cmp      byte ptr [ecx + 4], 0
00423B04  je       0x423b0e
00423B06  push     dword ptr [ecx]
00423B08  call     dword ptr [0x81a288]   ; IAT:KERNEL32.dll!LeaveCriticalSection
00423B0E  ret      
00423B0F  int3     
00423B10  push     ebp
00423B11  mov      ebp, esp
00423B13  sub      esp, 8
00423B16  push     esi
00423B17  mov      esi, ecx
00423B19  push     edi
00423B1A  mov      edi, dword ptr [esi]
00423B1C  test     edi, edi
00423B1E  je       0x423b5f
00423B20  mov      ecx, dword ptr [esi]
```

### [network_winsock] 0x004264F0 (RVA 0x264F0, ≈0x70 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
004264F0  push     ebp
004264F1  mov      ebp, esp
004264F3  push     -1
004264F5  push     0x7fd485
004264FA  mov      eax, dword ptr fs:[0]
00426500  push     eax
00426501  push     esi
00426502  mov      eax, dword ptr [0x92a3e0]
00426507  xor      eax, ebp
00426509  push     eax
0042650A  lea      eax, [ebp - 0xc]
0042650D  mov      dword ptr fs:[0], eax
00426513  mov      dword ptr [ebp - 4], 0
0042651A  mov      esi, dword ptr [ecx + 4]
0042651D  test     esi, esi
0042651F  je       0x426531
00426521  mov      ecx, esi
00426523  call     0x425a90   ; -> sub_425A90 [func-start]
00426528  push     esi
00426529  call     0x78c6fc   ; -> sub_78C6FC [func-start]
0042652E  add      esp, 4
00426531  mov      ecx, 0x9452a4
00426536  or       eax, 0xffffffff
00426539  lock xadd dword ptr [ecx], eax
0042653D  jne      0x426545
0042653F  call     dword ptr [0x81a4b4]   ; IAT:WS2_32.dll!WSACleanup
```

### [network_winsock] 0x004271C0 (RVA 0x271C0, ≈0x3c0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
004271C0  push     ebp
004271C1  mov      ebp, esp
004271C3  push     -1
004271C5  push     0x7fd428
004271CA  mov      eax, dword ptr fs:[0]
004271D0  push     eax
004271D1  sub      esp, 8
004271D4  push     ebx
004271D5  push     esi
004271D6  push     edi
004271D7  mov      eax, dword ptr [0x92a3e0]
004271DC  xor      eax, ebp
004271DE  push     eax
004271DF  lea      eax, [ebp - 0xc]
004271E2  mov      dword ptr fs:[0], eax
004271E8  mov      esi, ecx
004271EA  mov      dword ptr [ebp - 0x10], esi
004271ED  mov      dword ptr [esi], 0x85e8e4
004271F3  mov      dword ptr [ebp - 4], 0x12
004271FA  mov      ebx, dword ptr [esi + 0xe8]
00427200  or       edi, 0xffffffff
00427203  mov      dword ptr [esi + 0xe8], 0
0042720D  mov      dword ptr [esi + 0xe4], 0
00427217  test     ebx, ebx
00427219  je       0x42723e
0042721B  lea      eax, [ebx + 4]
```

### [graphics_init_d3d9] 0x005EAD20 (RVA 0x1EAD20, ≈0x280 bytes, 入度 0)

引用 API: `KERNEL32.dll!GetProcAddress`, `KERNEL32.dll!GetVersionExA`, `USER32.dll!GetWindowInfo`, `USER32.dll!GetWindowLongA`, `USER32.dll!SetWindowLongA`, `d3d9.dll!Direct3DCreate9`, `d3dx9_43.dll!D3DXCreateEffectPool`

```asm
005EAD20  push     ebp
005EAD21  mov      ebp, esp
005EAD23  sub      esp, 0xd8
005EAD29  mov      eax, dword ptr [0x92a3e0]
005EAD2E  xor      eax, ebp
005EAD30  mov      dword ptr [ebp - 4], eax
005EAD33  push     ebx
005EAD34  push     edi
005EAD35  mov      edi, dword ptr [ebp + 8]
005EAD38  push     0x20
005EAD3A  mov      ebx, ecx
005EAD3C  call     dword ptr [0x81a510]   ; IAT:d3d9.dll!Direct3DCreate9
005EAD42  mov      edx, eax
005EAD44  mov      dword ptr [ebx + 0xc], edx
005EAD47  test     edx, edx
005EAD49  je       0x5eaeee
005EAD4F  mov      ecx, dword ptr [edx]
005EAD51  lea      eax, [ebx + 0x14]
005EAD54  push     eax
005EAD55  push     0
005EAD57  push     edx
005EAD58  call     dword ptr [ecx + 0x20]
005EAD5B  test     eax, eax
005EAD5D  js       0x5eaeee
005EAD63  push     esi
005EAD64  test     edi, edi
```

### [network_winsock] 0x00614CF0 (RVA 0x214CF0, ≈0x70 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!bind`

```asm
00614CF0  push     ebp
00614CF1  mov      ebp, esp
00614CF3  push     ecx
00614CF4  push     ebx
00614CF5  push     esi
00614CF6  mov      esi, ecx
00614CF8  push     edi
00614CF9  mov      edi, edx
00614CFB  cmp      esi, -1
00614CFE  jne      0x614d19
00614D00  call     0x785790   ; -> sub_785790 [func-start]
00614D05  mov      ecx, dword ptr [ebp + 0xc]
00614D08  mov      dword ptr [ecx + 4], eax
00614D0B  mov      dword ptr [ecx], 0x2719
00614D11  or       eax, esi
00614D13  pop      edi
00614D14  pop      esi
00614D15  pop      ebx
00614D16  pop      ecx
00614D17  pop      ebp
00614D18  ret      
00614D19  push     0
00614D1B  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00614D21  push     dword ptr [ebp + 8]
00614D24  push     edi
00614D25  push     esi
```

### [network_winsock] 0x00614D60 (RVA 0x214D60, ≈0x100 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!closesocket`, `WS2_32.dll!ioctlsocket`

```asm
00614D60  push     ebp
00614D61  mov      ebp, esp
00614D63  sub      esp, 0x14
00614D66  push     ebx
00614D67  push     esi
00614D68  mov      esi, ecx
00614D6A  mov      eax, edx
00614D6C  xor      ebx, ebx
00614D6E  push     edi
00614D6F  mov      edi, dword ptr [ebp + 0xc]
00614D72  mov      dword ptr [ebp - 8], eax
00614D75  mov      dword ptr [ebp - 0xc], esi
00614D78  cmp      esi, -1
00614D7B  je       0x614e3b
00614D81  test     byte ptr [eax], 8
00614D84  je       0x614da9
00614D86  xor      eax, eax
00614D88  mov      dword ptr [ebp - 4], eax
00614D8B  call     0x785790   ; -> sub_785790 [func-start]
00614D90  mov      edx, dword ptr [ebp - 8]
00614D93  lea      eax, [ebp - 0x14]
00614D96  push     eax
00614D97  push     ecx
00614D98  lea      eax, [ebp - 4]
00614D9B  push     eax
00614D9C  sub      esp, 8
```

### [network_winsock] 0x00614E60 (RVA 0x214E60, ≈0xa0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASend`, `WS2_32.dll!WSASetLastError`

```asm
00614E60  push     ebp
00614E61  mov      ebp, esp
00614E63  sub      esp, 8
00614E66  push     ebx
00614E67  push     esi
00614E68  push     edi
00614E69  push     0
00614E6B  mov      esi, edx
00614E6D  mov      edi, ecx
00614E6F  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00614E75  push     0
00614E77  push     0
00614E79  push     0
00614E7B  lea      eax, [ebp - 4]
00614E7E  push     eax
00614E7F  push     1
00614E81  push     esi
00614E82  push     edi
00614E83  mov      dword ptr [ebp - 4], 0
00614E8A  call     dword ptr [0x81a4e0]   ; IAT:WS2_32.dll!WSASend
00614E90  mov      ebx, eax
00614E92  call     0x785790   ; -> sub_785790 [func-start]
00614E97  mov      esi, eax
00614E99  call     dword ptr [0x81a4d8]   ; IAT:WS2_32.dll!WSAGetLastError
00614E9F  mov      edi, dword ptr [ebp + 0x10]
00614EA2  mov      dword ptr [edi], eax
```

### [network_winsock] 0x00614F00 (RVA 0x214F00, ≈0xa0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASendTo`, `WS2_32.dll!WSASetLastError`

```asm
00614F00  push     ebp
00614F01  mov      ebp, esp
00614F03  sub      esp, 8
00614F06  push     ebx
00614F07  push     esi
00614F08  push     edi
00614F09  push     0
00614F0B  mov      esi, edx
00614F0D  mov      edi, ecx
00614F0F  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00614F15  push     0
00614F17  push     0
00614F19  push     dword ptr [ebp + 0x14]
00614F1C  lea      eax, [ebp - 4]
00614F1F  push     dword ptr [ebp + 0x10]
00614F22  mov      dword ptr [ebp - 4], 0
00614F29  push     0
00614F2B  push     eax
00614F2C  push     dword ptr [ebp + 8]
00614F2F  push     esi
00614F30  push     edi
00614F31  call     dword ptr [0x81a4e8]   ; IAT:WS2_32.dll!WSASendTo
00614F37  mov      ebx, eax
00614F39  call     0x785790   ; -> sub_785790 [func-start]
00614F3E  mov      esi, eax
00614F40  call     dword ptr [0x81a4d8]   ; IAT:WS2_32.dll!WSAGetLastError
```

### [network_winsock] 0x00615050 (RVA 0x215050, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!WSASocketW`, `WS2_32.dll!setsockopt`

```asm
00615050  push     ebp
00615051  mov      ebp, esp
00615053  push     ecx
00615054  push     ebx
00615055  push     esi
00615056  push     edi
00615057  mov      ebx, ecx
00615059  push     0
0061505B  mov      esi, edx
0061505D  mov      dword ptr [ebp - 4], ebx
00615060  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00615066  push     1
00615068  push     0
0061506A  push     0
0061506C  push     dword ptr [ebp + 8]
0061506F  push     esi
00615070  push     ebx
00615071  call     dword ptr [0x81a4e4]   ; IAT:WS2_32.dll!WSASocketW
00615077  mov      edi, eax
00615079  call     0x785790   ; -> sub_785790 [func-start]
0061507E  mov      esi, eax
00615080  call     dword ptr [0x81a4d8]   ; IAT:WS2_32.dll!WSAGetLastError
00615086  mov      ebx, dword ptr [ebp + 0xc]
00615089  mov      dword ptr [ebx], eax
0061508B  mov      dword ptr [ebx + 4], esi
0061508E  cmp      edi, -1
```

### [network_winsock] 0x006150E0 (RVA 0x2150E0, ≈0x80 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!setsockopt`

```asm
006150E0  push     ebp
006150E1  mov      ebp, esp
006150E3  push     ebx
006150E4  push     esi
006150E5  mov      esi, ecx
006150E7  push     edi
006150E8  cmp      esi, -1
006150EB  jne      0x615105
006150ED  call     0x785790   ; -> sub_785790 [func-start]
006150F2  mov      ecx, dword ptr [ebp + 0x18]
006150F5  mov      dword ptr [ecx + 4], eax
006150F8  mov      dword ptr [ecx], 0x2719
006150FE  or       eax, esi
00615100  pop      edi
00615101  pop      esi
00615102  pop      ebx
00615103  pop      ebp
00615104  ret      
00615105  or       byte ptr [edx], 8
00615108  push     0
0061510A  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00615110  push     4
00615112  push     dword ptr [ebp + 0x10]
00615115  push     0x80
0061511A  push     0xffff
0061511F  push     esi
```

### [network_winsock] 0x00615160 (RVA 0x215160, ≈0xc0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!select`

```asm
00615160  push     ebp
00615161  mov      ebp, esp
00615163  sub      esp, 0x118
00615169  mov      eax, dword ptr [0x92a3e0]
0061516E  xor      eax, ebp
00615170  mov      dword ptr [ebp - 4], eax
00615173  push     ebx
00615174  push     esi
00615175  mov      esi, ecx
00615177  push     edi
00615178  mov      edi, dword ptr [ebp + 8]
0061517B  cmp      esi, -1
0061517E  jne      0x6151a1
00615180  call     0x785790   ; -> sub_785790 [func-start]
00615185  mov      dword ptr [edi + 4], eax
00615188  mov      dword ptr [edi], 0x2719
0061518E  or       eax, esi
00615190  pop      edi
00615191  pop      esi
00615192  pop      ebx
00615193  mov      ecx, dword ptr [ebp - 4]
00615196  xor      ecx, ebp
00615198  call     0x78ab66   ; -> sub_78AB66 [func-start]
0061519D  mov      esp, ebp
0061519F  pop      ebp
006151A0  ret      
```

### [network_winsock] 0x00615220 (RVA 0x215220, ≈0x1a0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!WSAStringToAddressA`

```asm
00615220  push     ebp
00615221  mov      ebp, esp
00615223  sub      esp, 0xa0
00615229  mov      eax, dword ptr [0x92a3e0]
0061522E  xor      eax, ebp
00615230  mov      dword ptr [ebp - 8], eax
00615233  mov      eax, dword ptr [ebp + 8]
00615236  push     ebx
00615237  push     esi
00615238  push     edi
00615239  mov      edi, dword ptr [ebp + 0x10]
0061523C  mov      dword ptr [ebp - 0x90], eax
00615242  mov      eax, dword ptr [ebp + 0xc]
00615245  push     0
00615247  mov      ebx, ecx
00615249  mov      dword ptr [ebp - 0x9c], eax
0061524F  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00615255  cmp      ebx, 2
00615258  je       0x615281
0061525A  cmp      ebx, 0x17
0061525D  je       0x615281
0061525F  call     0x785790   ; -> sub_785790 [func-start]
00615264  mov      dword ptr [edi + 4], eax
00615267  mov      dword ptr [edi], 0x273f
0061526D  or       eax, 0xffffffff
00615270  pop      edi
```

### [network_winsock] 0x006159B0 (RVA 0x2159B0, ≈0xb0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSARecvFrom`

```asm
006159B0  push     ebp
006159B1  mov      ebp, esp
006159B3  push     ebx
006159B4  push     esi
006159B5  push     edi
006159B6  mov      edi, ecx
006159B8  mov      eax, 1
006159BD  mov      edx, dword ptr [edi + 4]
006159C0  add      edx, 0x18
006159C3  lock xadd dword ptr [edx], eax
006159C7  mov      eax, dword ptr [ebp + 8]
006159CA  push     0
006159CC  mov      ecx, dword ptr [eax]
006159CE  cmp      ecx, -1
006159D1  jne      0x6159ea
006159D3  mov      ecx, dword ptr [edi + 4]
006159D6  push     0x2719
006159DB  push     dword ptr [ebp + 0x20]
006159DE  call     0x614c70   ; -> sub_614C70 [func-start]
006159E3  pop      edi
006159E4  pop      esi
006159E5  pop      ebx
006159E6  pop      ebp
006159E7  ret      0x1c
006159EA  mov      ebx, dword ptr [ebp + 0x20]
006159ED  mov      eax, dword ptr [ebp + 0x18]
```

### [network_winsock] 0x00615B00 (RVA 0x215B00, ≈0x130 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!WSAStringToAddressA`

```asm
00615B00  push     ebp
00615B01  mov      ebp, esp
00615B03  sub      esp, 0x98
00615B09  mov      eax, dword ptr [0x92a3e0]
00615B0E  xor      eax, ebp
00615B10  mov      dword ptr [ebp - 8], eax
00615B13  push     ebx
00615B14  mov      ebx, dword ptr [ebp + 8]
00615B17  push     esi
00615B18  push     edi
00615B19  xor      esi, esi
00615B1B  push     esi
00615B1C  mov      dword ptr [ebp - 0x90], ecx
00615B22  call     dword ptr [0x81a4c0]   ; IAT:WS2_32.dll!WSASetLastError
00615B28  lea      eax, [ebp - 0x94]
00615B2E  push     eax
00615B2F  lea      eax, [ebp - 0x8c]
00615B35  push     eax
00615B36  push     esi
00615B37  push     2
00615B39  push     0x8640c4
00615B3E  mov      dword ptr [ebp - 0x94], 0x80
00615B48  call     dword ptr [0x81a4f0]   ; IAT:WS2_32.dll!WSAStringToAddressA
00615B4E  mov      dword ptr [ebp - 0x98], eax
00615B54  call     0x785790   ; -> sub_785790 [func-start]
00615B59  mov      edi, eax
```

### [network_winsock] 0x00615E90 (RVA 0x215E90, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!htons`

```asm
00615E90  push     ebp
00615E91  mov      ebp, esp
00615E93  cmp      dword ptr [ebp + 8], 2
00615E97  push     esi
00615E98  push     dword ptr [ebp + 0xc]
00615E9B  mov      esi, ecx
00615E9D  xorps    xmm0, xmm0
00615EA0  movq     qword ptr [esi], xmm0
00615EA4  movq     qword ptr [esi + 8], xmm0
00615EA9  movq     qword ptr [esi + 0x10], xmm0
00615EAE  mov      dword ptr [esi + 0x18], 0
00615EB5  jne      0x615ed7
00615EB7  mov      eax, 2
00615EBC  mov      word ptr [esi], ax
00615EBF  call     dword ptr [0x81a4d4]   ; IAT:WS2_32.dll!htons
00615EC5  mov      word ptr [esi + 2], ax
00615EC9  mov      dword ptr [esi + 4], 0
00615ED0  mov      eax, esi
00615ED2  pop      esi
00615ED3  pop      ebp
00615ED4  ret      8
00615ED7  mov      eax, 0x17
00615EDC  mov      word ptr [esi], ax
00615EDF  call     dword ptr [0x81a4d4]   ; IAT:WS2_32.dll!htons
00615EE5  mov      word ptr [esi + 2], ax
00615EE9  mov      dword ptr [esi + 4], 0
```

### [network_winsock] 0x00615F20 (RVA 0x215F20, ≈0xb0 bytes, 入度 0)

引用 API: `WS2_32.dll!htonl`, `WS2_32.dll!htons`, `WS2_32.dll!ntohl`

```asm
00615F20  push     ebp
00615F21  mov      ebp, esp
00615F23  sub      esp, 0x18
00615F26  xorps    xmm0, xmm0
00615F29  push     esi
00615F2A  mov      esi, ecx
00615F2C  push     edi
00615F2D  mov      edi, dword ptr [ebp + 8]
00615F30  push     dword ptr [ebp + 0xc]
00615F33  movq     qword ptr [esi], xmm0
00615F37  movq     qword ptr [esi + 8], xmm0
00615F3C  movq     qword ptr [esi + 0x10], xmm0
00615F41  mov      dword ptr [esi + 0x18], 0
00615F48  cmp      dword ptr [edi], 0
00615F4B  jne      0x615f86
00615F4D  mov      eax, 2
00615F52  mov      word ptr [esi], ax
00615F55  call     dword ptr [0x81a4d4]   ; IAT:WS2_32.dll!htons
00615F5B  mov      word ptr [esi + 2], ax
00615F5F  lea      eax, [ebp + 0xc]
00615F62  push     eax
00615F63  mov      ecx, edi
00615F65  call     0x615cb0   ; -> sub_615CB0 [func-start]
00615F6A  push     dword ptr [eax]
00615F6C  call     dword ptr [0x81a4ec]   ; IAT:WS2_32.dll!ntohl
00615F72  push     eax
```

### [network_winsock] 0x00615FD0 (RVA 0x215FD0, ≈0x70 bytes, 入度 0)

引用 API: `WS2_32.dll!htonl`, `WS2_32.dll!ntohl`

```asm
00615FD0  push     ebp
00615FD1  mov      ebp, esp
00615FD3  mov      eax, ecx
00615FD5  cmp      word ptr [eax], 2
00615FD9  jne      0x616011
00615FDB  push     dword ptr [eax + 4]
00615FDE  call     dword ptr [0x81a4ec]   ; IAT:WS2_32.dll!ntohl
00615FE4  push     eax
00615FE5  call     dword ptr [0x81a4b0]   ; IAT:WS2_32.dll!htonl
00615FEB  mov      ecx, dword ptr [ebp + 8]
00615FEE  xorps    xmm0, xmm0
00615FF1  mov      dword ptr [ecx], 0
00615FF7  mov      dword ptr [ecx + 4], eax
00615FFA  movq     qword ptr [ecx + 8], xmm0
00615FFF  movq     qword ptr [ecx + 0x10], xmm0
00616004  mov      dword ptr [ecx + 0x18], 0
0061600B  mov      eax, ecx
0061600D  pop      ebp
0061600E  ret      4
00616011  mov      ecx, dword ptr [eax + 0x18]
00616014  movq     xmm0, qword ptr [eax + 8]
00616019  movq     xmm1, qword ptr [eax + 0x10]
0061601E  mov      eax, dword ptr [ebp + 8]
00616021  mov      dword ptr [eax], 1
00616027  mov      dword ptr [eax + 4], 0
0061602E  movq     qword ptr [eax + 8], xmm0
```

### [network_winsock] 0x00616040 (RVA 0x216040, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!ntohs`

```asm
00616040  push     ebp
00616041  mov      ebp, esp
00616043  and      esp, 0xfffffff8
00616046  sub      esp, 0x3c
00616049  mov      eax, dword ptr [0x92a3e0]
0061604E  xor      eax, esp
00616050  mov      dword ptr [esp + 0x38], eax
00616054  push     ebx
00616055  push     esi
00616056  push     edi
00616057  mov      ebx, edx
00616059  lea      eax, [esp + 0xc]
0061605D  mov      edi, ecx
0061605F  push     eax
00616060  mov      ecx, ebx
00616062  call     0x615fd0   ; -> sub_615FD0 [func-start]
00616067  mov      esi, eax
00616069  lea      eax, [esp + 0x28]
0061606D  push     eax
0061606E  mov      ecx, edi
00616070  call     0x615fd0   ; -> sub_615FD0 [func-start]
00616075  mov      edx, esi
00616077  mov      ecx, eax
00616079  call     0x615e30
0061607E  test     al, al
00616080  je       0x6160b5
```

### [network_winsock] 0x00616C70 (RVA 0x216C70, ≈0x1e0 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `WS2_32.dll!WSACleanup`

```asm
00616C70  push     ebp
00616C71  mov      ebp, esp
00616C73  push     -1
00616C75  push     0x80a5a5
00616C7A  mov      eax, dword ptr fs:[0]
00616C80  push     eax
00616C81  sub      esp, 8
00616C84  push     ebx
00616C85  push     esi
00616C86  push     edi
00616C87  mov      eax, dword ptr [0x92a3e0]
00616C8C  xor      eax, ebp
00616C8E  push     eax
00616C8F  lea      eax, [ebp - 0xc]
00616C92  mov      dword ptr fs:[0], eax
00616C98  mov      edi, ecx
00616C9A  mov      dword ptr [ebp - 0x10], edi
00616C9D  mov      dword ptr [edi], 0x864164
00616CA3  mov      dword ptr [ebp - 4], 0xc
00616CAA  call     0x6170f0
00616CAF  mov      byte ptr [ebp - 4], 0xb
00616CB3  mov      eax, dword ptr [edi + 0x238]
00616CB9  push     eax
00616CBA  push     dword ptr [eax]
00616CBC  lea      eax, [ebp - 0x14]
00616CBF  push     eax
```

### [network_winsock] 0x006173B0 (RVA 0x2173B0, ≈0x310 bytes, 入度 0)

引用 API: `KERNEL32.dll!Sleep`, `WS2_32.dll!WSACleanup`

```asm
006173B0  push     ebp
006173B1  mov      ebp, esp
006173B3  push     -1
006173B5  push     0x80a6cb
006173BA  mov      eax, dword ptr fs:[0]
006173C0  push     eax
006173C1  sub      esp, 0xb4
006173C7  mov      eax, dword ptr [0x92a3e0]
006173CC  xor      eax, ebp
006173CE  mov      dword ptr [ebp - 0x14], eax
006173D1  push     ebx
006173D2  push     esi
006173D3  push     edi
006173D4  push     eax
006173D5  lea      eax, [ebp - 0xc]
006173D8  mov      dword ptr fs:[0], eax
006173DE  mov      dword ptr [ebp - 0x10], esp
006173E1  mov      ebx, ecx
006173E3  mov      dword ptr [ebp - 4], 0
006173EA  mov      dword ptr [ebp - 0x88], 0
006173F4  mov      dword ptr [ebp - 0x80], 0
006173FB  call     0x785790   ; -> sub_785790 [func-start]
00617400  mov      dword ptr [ebp - 0x7c], eax
00617403  lea      eax, [ebp - 0x80]
00617406  push     eax
00617407  lea      ecx, [ebp - 0xc0]
```

### [network_winsock] 0x006198B0 (RVA 0x2198B0, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!ntohs`

```asm
006198B0  push     ebp
006198B1  mov      ebp, esp
006198B3  push     esi
006198B4  mov      esi, dword ptr [ebp + 8]
006198B7  cmp      dword ptr [esi + 8], 0
006198BB  je       0x6198dd
006198BD  call     0x785790   ; -> sub_785790 [func-start]
006198C2  cmp      dword ptr [esi + 0xc], eax
006198C5  jne      0x6198d0
006198C7  cmp      dword ptr [esi + 8], 0x2738
006198CE  je       0x6198dd
006198D0  mov      eax, dword ptr [esi]
006198D2  mov      ecx, 0xffff
006198D7  mov      word ptr [eax], cx
006198DA  pop      esi
006198DB  pop      ebp
006198DC  ret      
006198DD  mov      eax, dword ptr [esi + 4]
006198E0  cmp      word ptr [eax], 2
006198E4  movzx    eax, word ptr [eax + 2]
006198E8  push     eax
006198E9  call     dword ptr [0x81a4cc]   ; IAT:WS2_32.dll!ntohs
006198EF  movzx    ecx, ax
006198F2  mov      eax, dword ptr [esi]
006198F4  pop      esi
006198F5  mov      word ptr [eax], cx
```

### [input_init] 0x00619B90 (RVA 0x219B90, ≈0x1a0 bytes, 入度 0)

引用 API: `DINPUT8.dll!DirectInput8Create`

```asm
00619B90  push     ebp
00619B91  mov      ebp, esp
00619B93  cmp      dword ptr [ecx + 8], 0
00619B97  lea      edx, [ecx + 8]
00619B9A  je       0x619ba2
00619B9C  mov      al, 1
00619B9E  pop      ebp
00619B9F  ret      8
00619BA2  mov      eax, dword ptr [ebp + 8]
00619BA5  push     0
00619BA7  push     edx
00619BA8  push     0x836d24
00619BAD  push     0x800
00619BB2  push     dword ptr [ebp + 0xc]
00619BB5  mov      dword ptr [ecx + 4], eax
00619BB8  call     dword ptr [0x81a034]   ; IAT:DINPUT8.dll!DirectInput8Create
00619BBE  test     eax, eax
00619BC0  setns    al
00619BC3  pop      ebp
00619BC4  ret      8
00619BC7  int3     
00619BC8  int3     
00619BC9  int3     
00619BCA  int3     
00619BCB  int3     
00619BCC  int3     
```

### [sound_init_dsound] 0x0061AF40 (RVA 0x21AF40, ≈0x110 bytes, 入度 0)

引用 API: `DSOUND.dll!ord#11`

```asm
0061AF40  push     ebp
0061AF41  mov      ebp, esp
0061AF43  and      esp, 0xfffffff0
0061AF46  sub      esp, 0xa8
0061AF4C  mov      eax, dword ptr [0x92a3e0]
0061AF51  xor      eax, esp
0061AF53  mov      dword ptr [esp + 0xa4], eax
0061AF5A  push     esi
0061AF5B  push     edi
0061AF5C  mov      edi, dword ptr [ebp + 8]
0061AF5F  mov      eax, ecx
0061AF61  push     0
0061AF63  lea      esi, [eax + 4]
0061AF66  push     esi
0061AF67  push     0
0061AF69  mov      dword ptr [esp + 0x18], eax
0061AF6D  call     dword ptr [0x81a03c]   ; IAT:DSOUND.dll!ord#11
0061AF73  test     eax, eax
0061AF75  jns      0x61af8f
0061AF77  xor      al, al
0061AF79  pop      edi
0061AF7A  pop      esi
0061AF7B  mov      ecx, dword ptr [esp + 0xa4]
0061AF82  xor      ecx, esp
0061AF84  call     0x78ab66   ; -> sub_78AB66 [func-start]
0061AF89  mov      esp, ebp
```

### [network_winsock] 0x00623790 (RVA 0x223790, ≈0x130 bytes, 入度 0)

引用 API: `WS2_32.dll!ntohl`, `WS2_32.dll!ntohs`

```asm
00623790  push     ebp
00623791  mov      ebp, esp
00623793  sub      esp, 0x44
00623796  mov      eax, dword ptr [0x92a3e0]
0062379B  xor      eax, ebp
0062379D  mov      dword ptr [ebp - 4], eax
006237A0  push     ebx
006237A1  push     esi
006237A2  push     edi
006237A3  mov      edi, edx
006237A5  lea      eax, [ebp - 0x3c]
006237A8  mov      ebx, ecx
006237AA  push     eax
006237AB  mov      ecx, edi
006237AD  mov      dword ptr [ebp - 0x40], edi
006237B0  call     0x615fd0   ; -> sub_615FD0 [func-start]
006237B5  mov      esi, eax
006237B7  lea      eax, [ebp - 0x20]
006237BA  push     eax
006237BB  mov      ecx, ebx
006237BD  mov      dword ptr [ebp - 0x44], esi
006237C0  call     0x615fd0   ; -> sub_615FD0 [func-start]
006237C5  mov      ecx, dword ptr [eax]
006237C7  mov      edx, dword ptr [esi]
006237C9  cmp      ecx, edx
006237CB  jl       0x62386e
```

### [network_winsock] 0x00625200 (RVA 0x225200, ≈0x1b0 bytes, 入度 0)

引用 API: `KERNEL32.dll!SetEvent`, `KERNEL32.dll!SleepEx`, `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!freeaddrinfo`

```asm
00625200  push     ebp
00625201  mov      ebp, esp
00625203  push     -1
00625205  push     0x80bf18
0062520A  mov      eax, dword ptr fs:[0]
00625210  push     eax
00625211  push     ebx
00625212  push     esi
00625213  mov      eax, dword ptr [0x92a3e0]
00625218  xor      eax, ebp
0062521A  push     eax
0062521B  lea      eax, [ebp - 0xc]
0062521E  mov      dword ptr fs:[0], eax
00625224  mov      ebx, dword ptr [ebp + 8]
00625227  mov      dword ptr [ebp + 8], ebx
0062522A  mov      dword ptr [ebp - 4], 0
00625231  push     dword ptr [ebx + 4]
00625234  call     dword ptr [0x81a278]   ; IAT:KERNEL32.dll!SetEvent
0062523A  mov      eax, dword ptr [ebx]
0062523C  mov      ecx, ebx
0062523E  call     dword ptr [eax + 4]
00625241  mov      eax, dword ptr [ebx]
00625243  mov      esi, dword ptr [ebx + 8]
00625246  push     1
00625248  mov      ecx, ebx
0062524A  call     dword ptr [eax]
```

### [network_winsock] 0x006254D0 (RVA 0x2254D0, ≈0x160 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!DeleteCriticalSection`, `WS2_32.dll!WSACleanup`

```asm
006254D0  push     ebp
006254D1  mov      ebp, esp
006254D3  push     -1
006254D5  push     0x80bb31
006254DA  mov      eax, dword ptr fs:[0]
006254E0  push     eax
006254E1  sub      esp, 0xc
006254E4  push     ebx
006254E5  push     esi
006254E6  push     edi
006254E7  mov      eax, dword ptr [0x92a3e0]
006254EC  xor      eax, ebp
006254EE  push     eax
006254EF  lea      eax, [ebp - 0xc]
006254F2  mov      dword ptr fs:[0], eax
006254F8  mov      esi, ecx
006254FA  mov      dword ptr [ebp - 0x14], esi
006254FD  mov      dword ptr [ebp - 4], 3
00625504  call     0x6255b0
00625509  mov      edi, dword ptr [esi + 0x28]
0062550C  test     edi, edi
0062550E  je       0x625522
00625510  push     dword ptr [edi + 4]
00625513  call     dword ptr [0x81a274]   ; IAT:KERNEL32.dll!CloseHandle
00625519  push     edi
0062551A  call     0x78c6fc   ; -> sub_78C6FC [func-start]
```

### [network_winsock] 0x00626BB0 (RVA 0x226BB0, ≈0x80 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00626BB0  push     ebp
00626BB1  mov      ebp, esp
00626BB3  push     -1
00626BB5  push     0x80bae5
00626BBA  mov      eax, dword ptr fs:[0]
00626BC0  push     eax
00626BC1  push     esi
00626BC2  push     edi
00626BC3  mov      eax, dword ptr [0x92a3e0]
00626BC8  xor      eax, ebp
00626BCA  push     eax
00626BCB  lea      eax, [ebp - 0xc]
00626BCE  mov      dword ptr fs:[0], eax
00626BD4  mov      esi, dword ptr [ecx]
00626BD6  test     esi, esi
00626BD8  je       0x626c15
00626BDA  mov      dword ptr [ebp - 4], 0
00626BE1  mov      edi, dword ptr [esi + 4]
00626BE4  test     edi, edi
00626BE6  je       0x626bf8
00626BE8  mov      ecx, edi
00626BEA  call     0x425a90   ; -> sub_425A90 [func-start]
00626BEF  push     edi
00626BF0  call     0x78c6fc   ; -> sub_78C6FC [func-start]
00626BF5  add      esp, 4
00626BF8  mov      ecx, 0x9452a4
```

### [network_winsock] 0x00626C30 (RVA 0x226C30, ≈0xc0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00626C30  push     ebp
00626C31  mov      ebp, esp
00626C33  push     -1
00626C35  push     0x80be05
00626C3A  mov      eax, dword ptr fs:[0]
00626C40  push     eax
00626C41  push     ebx
00626C42  push     esi
00626C43  push     edi
00626C44  mov      eax, dword ptr [0x92a3e0]
00626C49  xor      eax, ebp
00626C4B  push     eax
00626C4C  lea      eax, [ebp - 0xc]
00626C4F  mov      dword ptr fs:[0], eax
00626C55  mov      esi, ecx
00626C57  mov      edi, dword ptr [esi]
00626C59  test     edi, edi
00626C5B  je       0x626c98
00626C5D  mov      dword ptr [ebp - 4], 0
00626C64  mov      ebx, dword ptr [edi + 4]
00626C67  test     ebx, ebx
00626C69  je       0x626c7b
00626C6B  mov      ecx, ebx
00626C6D  call     0x425a90   ; -> sub_425A90 [func-start]
00626C72  push     ebx
00626C73  call     0x78c6fc   ; -> sub_78C6FC [func-start]
```

### [network_winsock] 0x00626F20 (RVA 0x226F20, ≈0x310 bytes, 入度 0)

引用 API: `WS2_32.dll!WSASetLastError`, `WS2_32.dll!freeaddrinfo`, `WS2_32.dll!getaddrinfo`

```asm
00626F20  push     ebp
00626F21  mov      ebp, esp
00626F23  and      esp, 0xfffffff8
00626F26  push     -1
00626F28  push     0x80be98
00626F2D  mov      eax, dword ptr fs:[0]
00626F33  push     eax
00626F34  sub      esp, 0x90
00626F3A  mov      eax, dword ptr [0x92a3e0]
00626F3F  xor      eax, esp
00626F41  mov      dword ptr [esp + 0x88], eax
00626F48  push     ebx
00626F49  push     esi
00626F4A  push     edi
00626F4B  mov      eax, dword ptr [0x92a3e0]
00626F50  xor      eax, esp
00626F52  push     eax
00626F53  lea      eax, [esp + 0xa0]
00626F5A  mov      dword ptr fs:[0], eax
00626F60  mov      eax, dword ptr [ebp + 8]
00626F63  mov      ebx, dword ptr [ebp + 0x10]
00626F66  mov      dword ptr [esp + 0x1c], eax
00626F6A  mov      eax, dword ptr [ebp + 0x14]
00626F6D  mov      dword ptr [esp + 0x14], eax
00626F71  lea      eax, [esp + 0x80]
00626F78  mov      dword ptr [esp + 0x18], 0
```

### [message_pump] 0x006585A0 (RVA 0x2585A0, ≈0x9e0 bytes, 入度 1)

引用 API: `KERNEL32.dll!ContinueDebugEvent`, `KERNEL32.dll!CreateFileMappingA`, `KERNEL32.dll!CreateProcessA`, `KERNEL32.dll!DebugActiveProcess`, `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!GetCurrentProcessId`, `KERNEL32.dll!GetCurrentThread`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!GetSystemDirectoryA`, `KERNEL32.dll!IsDebuggerPresent`, `KERNEL32.dll!MapViewOfFile`, `KERNEL32.dll!OpenFileMappingA`, `KERNEL32.dll!OpenProcess`, `KERNEL32.dll!SetCurrentDirectoryA`, `KERNEL32.dll!Sleep`, `KERNEL32.dll!TerminateProcess`, `KERNEL32.dll!WaitForDebugEvent`, `PSAPI.DLL!EnumProcessModules`, `USER32.dll!CreateWindowExA`, `USER32.dll!DispatchMessageA`, `USER32.dll!PeekMessageA`, `USER32.dll!TranslateMessage`, `USER32.dll!wsprintfA`, `WINMM.dll!timeGetTime`

```asm
006585A0  push     ebp
006585A1  mov      ebp, esp
006585A3  push     -1
006585A5  push     0x80dfe8
006585AA  mov      eax, dword ptr fs:[0]
006585B0  push     eax
006585B1  sub      esp, 0xe84
006585B7  mov      eax, dword ptr [0x92a3e0]
006585BC  xor      eax, ebp
006585BE  mov      dword ptr [ebp - 0x10], eax
006585C1  push     eax
006585C2  lea      eax, [ebp - 0xc]
006585C5  mov      dword ptr fs:[0], eax
006585CB  push     0xffff
006585D0  call     0x76b886   ; -> sub_76B886 [func-start]
006585D5  add      esp, 4
006585D8  mov      dword ptr [ebp - 0xe08], eax
006585DE  mov      eax, dword ptr [ebp - 0xe08]
006585E4  push     eax
006585E5  lea      ecx, [ebp - 0xda4]
006585EB  call     0x4021f0   ; -> sub_4021F0 [func-start]
006585F0  mov      dword ptr [ebp - 4], 0
006585F7  push     0xffff
006585FC  lea      ecx, [ebp - 0xda4]
00658602  call     0x4032b0   ; -> sub_4032B0 [func-start]
00658607  push     eax
```

### [text_render] 0x00749270 (RVA 0x349270, ≈0x290 bytes, 入度 0)

引用 API: `GDI32.dll!CreateCompatibleDC`, `GDI32.dll!CreateDIBSection`, `GDI32.dll!CreateFontA`, `GDI32.dll!CreatePen`, `GDI32.dll!DeleteObject`, `GDI32.dll!GetTextMetricsA`, `GDI32.dll!SelectObject`, `GDI32.dll!SetBkColor`, `GDI32.dll!SetBkMode`

```asm
00749270  push     ebp
00749271  mov      ebp, esp
00749273  sub      esp, 0x7c
00749276  mov      eax, dword ptr [0x92a3e0]
0074927B  xor      eax, ebp
0074927D  mov      dword ptr [ebp - 4], eax
00749280  push     ebx
00749281  mov      ebx, ecx
00749283  push     esi
00749284  push     edi
00749285  lea      edi, [ebx + 0x3c]
00749288  mov      dword ptr [ebp - 0x7c], ebx
0074928B  lea      edx, [ebx + 0x150]
00749291  mov      ecx, edi
00749293  mov      esi, 0x110
00749298  mov      eax, dword ptr [ecx]
0074929A  cmp      eax, dword ptr [edx]
0074929C  jne      0x7492ab
0074929E  add      ecx, 4
007492A1  add      edx, 4
007492A4  sub      esi, 4
007492A7  jae      0x749298
007492A9  jmp      0x7492e4
007492AB  mov      eax, dword ptr [ebx + 8]
007492AE  mov      esi, dword ptr [0x81a064]
007492B4  test     eax, eax
```

### [text_render] 0x007496E0 (RVA 0x3496E0, ≈0x6c0 bytes, 入度 0)

引用 API: `GDI32.dll!DeleteDC`, `GDI32.dll!DeleteObject`, `GDI32.dll!GetTextExtentPoint32A`, `GDI32.dll!SelectObject`, `GDI32.dll!SetBkColor`, `GDI32.dll!SetTextColor`, `GDI32.dll!TextOutA`, `USER32.dll!CharNextA`

```asm
007496E0  push     ebp
007496E1  mov      ebp, esp
007496E3  and      esp, 0xfffffff8
007496E6  sub      esp, 0x34
007496E9  push     ebx
007496EA  push     esi
007496EB  push     edi
007496EC  mov      edi, ecx
007496EE  mov      dword ptr [esp + 0x1c], edi
007496F2  cmp      dword ptr [edi + 0x20], 0
007496F6  je       0x749d05
007496FC  cmp      dword ptr [edi + 0x1c], 0
00749700  je       0x749d05
00749706  cmp      dword ptr [edi + 0x10], 0
0074970A  je       0x749d05
00749710  mov      esi, dword ptr [ebp + 0x14]
00749713  push     esi
00749714  call     dword ptr [0x81a3cc]   ; IAT:USER32.dll!CharNextA
0074971A  lea      ecx, [esp + 0x38]
0074971E  push     ecx
0074971F  sub      eax, esi
00749721  push     eax
00749722  push     esi
00749723  push     dword ptr [edi + 0x1c]
00749726  mov      dword ptr [esp + 0x24], eax
0074972A  call     dword ptr [0x81a060]   ; IAT:GDI32.dll!GetTextExtentPoint32A
```

### [network_winsock] 0x0080E2D0 (RVA 0x40E2D0, ≈0x270 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080E2D0  push     ebp
0080E2D1  mov      ebp, esp
0080E2D3  and      esp, 0xfffffff8
0080E2D6  sub      esp, 0x198
0080E2DC  mov      eax, dword ptr [0x92a3e0]
0080E2E1  xor      eax, esp
0080E2E3  mov      dword ptr [esp + 0x194], eax
0080E2EA  push     0x814810
0080E2EF  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080E2F4  add      esp, 4
0080E2F7  mov      ecx, 0x9452a4
0080E2FC  mov      eax, 1
0080E301  lock xadd dword ptr [ecx], eax
0080E305  inc      eax
0080E306  cmp      eax, 1
0080E309  jne      0x80e31e
0080E30B  lea      eax, [esp]
0080E30E  push     eax
0080E30F  push     2
0080E311  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080E317  mov      ecx, 0x9452a8
0080E31C  xchg     dword ptr [ecx], eax
0080E31E  mov      ecx, dword ptr [esp + 0x194]
0080E325  xor      ecx, esp
0080E327  mov      dword ptr [0x94419c], 0x94525c
0080E331  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x0080E540 (RVA 0x40E540, ≈0x2c0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080E540  push     ebp
0080E541  mov      ebp, esp
0080E543  and      esp, 0xfffffff8
0080E546  sub      esp, 0x198
0080E54C  mov      eax, dword ptr [0x92a3e0]
0080E551  xor      eax, esp
0080E553  mov      dword ptr [esp + 0x194], eax
0080E55A  push     0x8148c0
0080E55F  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080E564  add      esp, 4
0080E567  mov      ecx, 0x9452a4
0080E56C  mov      eax, 1
0080E571  lock xadd dword ptr [ecx], eax
0080E575  inc      eax
0080E576  cmp      eax, 1
0080E579  jne      0x80e58e
0080E57B  lea      eax, [esp]
0080E57E  push     eax
0080E57F  push     2
0080E581  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080E587  mov      ecx, 0x9452a8
0080E58C  xchg     dword ptr [ecx], eax
0080E58E  mov      ecx, dword ptr [esp + 0x194]
0080E595  xor      ecx, esp
0080E597  mov      dword ptr [0x9441fc], 0x94525e
0080E5A1  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x0080E800 (RVA 0x40E800, ≈0x250 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080E800  push     ebp
0080E801  mov      ebp, esp
0080E803  and      esp, 0xfffffff8
0080E806  sub      esp, 0x198
0080E80C  mov      eax, dword ptr [0x92a3e0]
0080E811  xor      eax, esp
0080E813  mov      dword ptr [esp + 0x194], eax
0080E81A  push     0x814910
0080E81F  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080E824  add      esp, 4
0080E827  mov      ecx, 0x9452a4
0080E82C  mov      eax, 1
0080E831  lock xadd dword ptr [ecx], eax
0080E835  inc      eax
0080E836  cmp      eax, 1
0080E839  jne      0x80e84e
0080E83B  lea      eax, [esp]
0080E83E  push     eax
0080E83F  push     2
0080E841  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080E847  mov      ecx, 0x9452a8
0080E84C  xchg     dword ptr [ecx], eax
0080E84E  mov      ecx, dword ptr [esp + 0x194]
0080E855  xor      ecx, esp
0080E857  mov      dword ptr [0x944250], 0x94525f
0080E861  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x0080EA50 (RVA 0x40EA50, ≈0x190 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080EA50  push     ebp
0080EA51  mov      ebp, esp
0080EA53  and      esp, 0xfffffff8
0080EA56  sub      esp, 0x198
0080EA5C  mov      eax, dword ptr [0x92a3e0]
0080EA61  xor      eax, esp
0080EA63  mov      dword ptr [esp + 0x194], eax
0080EA6A  push     0x814c80
0080EA6F  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080EA74  add      esp, 4
0080EA77  mov      ecx, 0x9452a4
0080EA7C  mov      eax, 1
0080EA81  lock xadd dword ptr [ecx], eax
0080EA85  inc      eax
0080EA86  cmp      eax, 1
0080EA89  jne      0x80ea9e
0080EA8B  lea      eax, [esp]
0080EA8E  push     eax
0080EA8F  push     2
0080EA91  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080EA97  mov      ecx, 0x9452a8
0080EA9C  xchg     dword ptr [ecx], eax
0080EA9E  mov      ecx, dword ptr [esp + 0x194]
0080EAA5  xor      ecx, esp
0080EAA7  mov      dword ptr [0x944288], 0x945260
0080EAB1  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x0080EBE0 (RVA 0x40EBE0, ≈0x190 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080EBE0  push     ebp
0080EBE1  mov      ebp, esp
0080EBE3  and      esp, 0xfffffff8
0080EBE6  sub      esp, 0x198
0080EBEC  mov      eax, dword ptr [0x92a3e0]
0080EBF1  xor      eax, esp
0080EBF3  mov      dword ptr [esp + 0x194], eax
0080EBFA  push     0x814ca0
0080EBFF  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080EC04  add      esp, 4
0080EC07  mov      ecx, 0x9452a4
0080EC0C  mov      eax, 1
0080EC11  lock xadd dword ptr [ecx], eax
0080EC15  inc      eax
0080EC16  cmp      eax, 1
0080EC19  jne      0x80ec2e
0080EC1B  lea      eax, [esp]
0080EC1E  push     eax
0080EC1F  push     2
0080EC21  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080EC27  mov      ecx, 0x9452a8
0080EC2C  xchg     dword ptr [ecx], eax
0080EC2E  mov      ecx, dword ptr [esp + 0x194]
0080EC35  xor      ecx, esp
0080EC37  mov      dword ptr [0x9442b4], 0x945261
0080EC41  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x0080ED70 (RVA 0x40ED70, ≈0x33d0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
0080ED70  push     ebp
0080ED71  mov      ebp, esp
0080ED73  and      esp, 0xfffffff8
0080ED76  sub      esp, 0x198
0080ED7C  mov      eax, dword ptr [0x92a3e0]
0080ED81  xor      eax, esp
0080ED83  mov      dword ptr [esp + 0x194], eax
0080ED8A  push     0x814cc0
0080ED8F  call     0x78bf32   ; -> sub_78BF32 [func-start]
0080ED94  add      esp, 4
0080ED97  mov      ecx, 0x9452a4
0080ED9C  mov      eax, 1
0080EDA1  lock xadd dword ptr [ecx], eax
0080EDA5  inc      eax
0080EDA6  cmp      eax, 1
0080EDA9  jne      0x80edbe
0080EDAB  lea      eax, [esp]
0080EDAE  push     eax
0080EDAF  push     2
0080EDB1  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
0080EDB7  mov      ecx, 0x9452a8
0080EDBC  xchg     dword ptr [ecx], eax
0080EDBE  mov      ecx, dword ptr [esp + 0x194]
0080EDC5  xor      ecx, esp
0080EDC7  mov      dword ptr [0x9442f0], 0x945262
0080EDD1  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x00812140 (RVA 0x412140, ≈0x280 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00812140  push     ebp
00812141  mov      ebp, esp
00812143  and      esp, 0xfffffff8
00812146  sub      esp, 0x198
0081214C  mov      eax, dword ptr [0x92a3e0]
00812151  xor      eax, esp
00812153  mov      dword ptr [esp + 0x194], eax
0081215A  push     0x816b10
0081215F  call     0x78bf32   ; -> sub_78BF32 [func-start]
00812164  add      esp, 4
00812167  mov      ecx, 0x9452a4
0081216C  mov      eax, 1
00812171  lock xadd dword ptr [ecx], eax
00812175  inc      eax
00812176  cmp      eax, 1
00812179  jne      0x81218e
0081217B  lea      eax, [esp]
0081217E  push     eax
0081217F  push     2
00812181  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812187  mov      ecx, 0x9452a8
0081218C  xchg     dword ptr [ecx], eax
0081218E  mov      ecx, dword ptr [esp + 0x194]
00812195  xor      ecx, esp
00812197  mov      dword ptr [0x944e04], 0x945264
008121A1  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x008123C0 (RVA 0x4123C0, ≈0x470 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
008123C0  push     ebp
008123C1  mov      ebp, esp
008123C3  and      esp, 0xfffffff8
008123C6  sub      esp, 0x198
008123CC  mov      eax, dword ptr [0x92a3e0]
008123D1  xor      eax, esp
008123D3  mov      dword ptr [esp + 0x194], eax
008123DA  push     0x816b50
008123DF  call     0x78bf32   ; -> sub_78BF32 [func-start]
008123E4  add      esp, 4
008123E7  mov      ecx, 0x9452a4
008123EC  mov      eax, 1
008123F1  lock xadd dword ptr [ecx], eax
008123F5  inc      eax
008123F6  cmp      eax, 1
008123F9  jne      0x81240e
008123FB  lea      eax, [esp]
008123FE  push     eax
008123FF  push     2
00812401  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812407  mov      ecx, 0x9452a8
0081240C  xchg     dword ptr [ecx], eax
0081240E  mov      ecx, dword ptr [esp + 0x194]
00812415  xor      ecx, esp
00812417  mov      dword ptr [0x944ecc], 0x945265
00812421  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x00812830 (RVA 0x412830, ≈0x190 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00812830  push     ebp
00812831  mov      ebp, esp
00812833  and      esp, 0xfffffff8
00812836  sub      esp, 0x198
0081283C  mov      eax, dword ptr [0x92a3e0]
00812841  xor      eax, esp
00812843  mov      dword ptr [esp + 0x194], eax
0081284A  push     0x816c50
0081284F  call     0x78bf32   ; -> sub_78BF32 [func-start]
00812854  add      esp, 4
00812857  mov      ecx, 0x9452a4
0081285C  mov      eax, 1
00812861  lock xadd dword ptr [ecx], eax
00812865  inc      eax
00812866  cmp      eax, 1
00812869  jne      0x81287e
0081286B  lea      eax, [esp]
0081286E  push     eax
0081286F  push     2
00812871  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812877  mov      ecx, 0x9452a8
0081287C  xchg     dword ptr [ecx], eax
0081287E  mov      ecx, dword ptr [esp + 0x194]
00812885  xor      ecx, esp
00812887  mov      dword ptr [0x944f80], 0x945266
00812891  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x008129C0 (RVA 0x4129C0, ≈0x1b0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
008129C0  push     ebp
008129C1  mov      ebp, esp
008129C3  and      esp, 0xfffffff8
008129C6  sub      esp, 0x198
008129CC  mov      eax, dword ptr [0x92a3e0]
008129D1  xor      eax, esp
008129D3  mov      dword ptr [esp + 0x194], eax
008129DA  push     0x816c70
008129DF  call     0x78bf32   ; -> sub_78BF32 [func-start]
008129E4  add      esp, 4
008129E7  mov      ecx, 0x9452a4
008129EC  mov      eax, 1
008129F1  lock xadd dword ptr [ecx], eax
008129F5  inc      eax
008129F6  cmp      eax, 1
008129F9  jne      0x812a0e
008129FB  lea      eax, [esp]
008129FE  push     eax
008129FF  push     2
00812A01  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812A07  mov      ecx, 0x9452a8
00812A0C  xchg     dword ptr [ecx], eax
00812A0E  mov      ecx, dword ptr [esp + 0x194]
00812A15  xor      ecx, esp
00812A17  mov      dword ptr [0x944fb4], 0x945267
00812A21  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x00812B70 (RVA 0x412B70, ≈0x250 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00812B70  push     ebp
00812B71  mov      ebp, esp
00812B73  and      esp, 0xfffffff8
00812B76  sub      esp, 0x198
00812B7C  mov      eax, dword ptr [0x92a3e0]
00812B81  xor      eax, esp
00812B83  mov      dword ptr [esp + 0x194], eax
00812B8A  push     0x816ca0
00812B8F  call     0x78bf32   ; -> sub_78BF32 [func-start]
00812B94  add      esp, 4
00812B97  mov      ecx, 0x9452a4
00812B9C  mov      eax, 1
00812BA1  lock xadd dword ptr [ecx], eax
00812BA5  inc      eax
00812BA6  cmp      eax, 1
00812BA9  jne      0x812bbe
00812BAB  lea      eax, [esp]
00812BAE  push     eax
00812BAF  push     2
00812BB1  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812BB7  mov      ecx, 0x9452a8
00812BBC  xchg     dword ptr [ecx], eax
00812BBE  mov      ecx, dword ptr [esp + 0x194]
00812BC5  xor      ecx, esp
00812BC7  mov      dword ptr [0x944fe8], 0x945268
00812BD1  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x00812DC0 (RVA 0x412DC0, ≈0x4b0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00812DC0  push     ebp
00812DC1  mov      ebp, esp
00812DC3  and      esp, 0xfffffff8
00812DC6  sub      esp, 0x198
00812DCC  mov      eax, dword ptr [0x92a3e0]
00812DD1  xor      eax, esp
00812DD3  mov      dword ptr [esp + 0x194], eax
00812DDA  push     0x816cc0
00812DDF  call     0x78bf32   ; -> sub_78BF32 [func-start]
00812DE4  add      esp, 4
00812DE7  mov      ecx, 0x9452a4
00812DEC  mov      eax, 1
00812DF1  lock xadd dword ptr [ecx], eax
00812DF5  inc      eax
00812DF6  cmp      eax, 1
00812DF9  jne      0x812e0e
00812DFB  lea      eax, [esp]
00812DFE  push     eax
00812DFF  push     2
00812E01  call     dword ptr [0x81a4b8]   ; IAT:WS2_32.dll!WSAStartup
00812E07  mov      ecx, 0x9452a8
00812E0C  xchg     dword ptr [ecx], eax
00812E0E  mov      ecx, dword ptr [esp + 0x194]
00812E15  xor      ecx, esp
00812E17  mov      dword ptr [0x945094], 0x945269
00812E21  call     0x78ab66   ; -> sub_78AB66 [func-start]
```

### [network_winsock] 0x00814820 (RVA 0x414820, ≈0xb0 bytes, 入度 0)

引用 API: `KERNEL32.dll!TlsFree`, `WS2_32.dll!WSACleanup`

```asm
00814820  mov      ah, 0xa4
00814822  add      dword ptr [eax], 0xccccccc3
00814828  int3     
00814829  int3     
0081482A  int3     
0081482B  int3     
0081482C  int3     
0081482D  int3     
0081482E  int3     
0081482F  int3     
00814830  push     esi
00814831  mov      esi, dword ptr [0x9441a8]
00814837  test     esi, esi
00814839  je       0x814864
0081483B  push     edi
0081483C  or       edi, 0xffffffff
0081483F  lea      ecx, [esi + 4]
00814842  mov      eax, edi
00814844  lock xadd dword ptr [ecx], eax
00814848  jne      0x814863
0081484A  mov      eax, dword ptr [esi]
0081484C  mov      ecx, esi
0081484E  call     dword ptr [eax]
00814850  lea      eax, [esi + 8]
00814853  lock xadd dword ptr [eax], edi
00814857  dec      edi
```

### [network_winsock] 0x008148D0 (RVA 0x4148D0, ≈0x50 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
008148D0  mov      ah, 0xa4
008148D2  add      dword ptr [eax], 0xccccccc3
008148D8  int3     
008148D9  int3     
008148DA  int3     
008148DB  int3     
008148DC  int3     
008148DD  int3     
008148DE  int3     
008148DF  int3     
008148E0  push     ecx
008148E1  call     0x433610   ; -> sub_433610 [func-start]
008148E6  pop      ecx
008148E7  ret      
008148E8  int3     
008148E9  int3     
008148EA  int3     
008148EB  int3     
008148EC  int3     
008148ED  int3     
008148EE  int3     
008148EF  int3     
008148F0  ret      
008148F1  int3     
008148F2  int3     
008148F3  int3     
```

### [network_winsock] 0x00814920 (RVA 0x414920, ≈0x60 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00814920  mov      ah, 0xa4
00814922  add      dword ptr [eax], 0xccccccc3
00814928  int3     
00814929  int3     
0081492A  int3     
0081492B  int3     
0081492C  int3     
0081492D  int3     
0081492E  int3     
0081492F  int3     
00814930  jmp      0x43c990   ; -> sub_43C990 [func-start]
00814935  int3     
00814936  int3     
00814937  int3     
00814938  int3     
00814939  int3     
0081493A  int3     
0081493B  int3     
0081493C  int3     
0081493D  int3     
0081493E  int3     
0081493F  int3     
00814940  jmp      0x43ce10   ; -> sub_43CE10 [func-start]
00814945  int3     
00814946  int3     
00814947  int3     
```

### [network_winsock] 0x00814C90 (RVA 0x414C90, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00814C90  mov      ah, 0xa4
00814C92  add      dword ptr [eax], 0xccccccc3
00814C98  int3     
00814C99  int3     
00814C9A  int3     
00814C9B  int3     
00814C9C  int3     
00814C9D  int3     
00814C9E  int3     
00814C9F  int3     
00814CA0  mov      ecx, 0x9452a4
00814CA5  or       eax, 0xffffffff
00814CA8  lock xadd dword ptr [ecx], eax
00814CAC  jne      0x814cb4
00814CAE  jmp      dword ptr [0x81a4b4]   ; IAT:WS2_32.dll!WSACleanup
00814CB4  ret      
00814CB5  int3     
00814CB6  int3     
00814CB7  int3     
00814CB8  int3     
00814CB9  int3     
00814CBA  int3     
00814CBB  int3     
00814CBC  int3     
00814CBD  int3     
00814CBE  int3     
```

### [network_winsock] 0x00814CB0 (RVA 0x414CB0, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00814CB0  mov      ah, 0xa4
00814CB2  add      dword ptr [eax], 0xccccccc3
00814CB8  int3     
00814CB9  int3     
00814CBA  int3     
00814CBB  int3     
00814CBC  int3     
00814CBD  int3     
00814CBE  int3     
00814CBF  int3     
00814CC0  mov      ecx, 0x9452a4
00814CC5  or       eax, 0xffffffff
00814CC8  lock xadd dword ptr [ecx], eax
00814CCC  jne      0x814cd4
00814CCE  jmp      dword ptr [0x81a4b4]   ; IAT:WS2_32.dll!WSACleanup
00814CD4  ret      
00814CD5  int3     
00814CD6  int3     
00814CD7  int3     
00814CD8  int3     
00814CD9  int3     
00814CDA  int3     
00814CDB  int3     
00814CDC  int3     
00814CDD  int3     
00814CDE  int3     
```

### [network_winsock] 0x00814CD0 (RVA 0x414CD0, ≈0x70 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00814CD0  mov      ah, 0xa4
00814CD2  add      dword ptr [eax], 0xccccccc3
00814CD8  int3     
00814CD9  int3     
00814CDA  int3     
00814CDB  int3     
00814CDC  int3     
00814CDD  int3     
00814CDE  int3     
00814CDF  int3     
00814CE0  push     ecx
00814CE1  call     0x441fc0   ; -> sub_441FC0 [func-start]
00814CE6  pop      ecx
00814CE7  ret      
00814CE8  int3     
00814CE9  int3     
00814CEA  int3     
00814CEB  int3     
00814CEC  int3     
00814CED  int3     
00814CEE  int3     
00814CEF  int3     
00814CF0  ret      
00814CF1  int3     
00814CF2  int3     
00814CF3  int3     
```

### [network_winsock] 0x00816B20 (RVA 0x416B20, ≈0x40 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816B20  mov      ah, 0xa4
00816B22  add      dword ptr [eax], 0xccccccc3
00816B28  int3     
00816B29  int3     
00816B2A  int3     
00816B2B  int3     
00816B2C  int3     
00816B2D  int3     
00816B2E  int3     
00816B2F  int3     
00816B30  push     ecx
00816B31  call     0x57a840   ; -> sub_57A840 [func-start]
00816B36  pop      ecx
00816B37  ret      
00816B38  int3     
00816B39  int3     
00816B3A  int3     
00816B3B  int3     
00816B3C  int3     
00816B3D  int3     
00816B3E  int3     
00816B3F  int3     
00816B40  push     ecx
00816B41  call     0x57a790   ; -> sub_57A790 [func-start]
00816B46  pop      ecx
00816B47  ret      
```

### [network_winsock] 0x00816B60 (RVA 0x416B60, ≈0x100 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816B60  mov      ah, 0xa4
00816B62  add      dword ptr [eax], 0xccccccc3
00816B68  int3     
00816B69  int3     
00816B6A  int3     
00816B6B  int3     
00816B6C  int3     
00816B6D  int3     
00816B6E  int3     
00816B6F  int3     
00816B70  jmp      0x4010b0   ; -> sub_4010B0 [func-start]
00816B75  int3     
00816B76  int3     
00816B77  int3     
00816B78  int3     
00816B79  int3     
00816B7A  int3     
00816B7B  int3     
00816B7C  int3     
00816B7D  int3     
00816B7E  int3     
00816B7F  int3     
00816B80  push     ecx
00816B81  call     0x61dac0   ; -> sub_61DAC0 [func-start]
00816B86  pop      ecx
00816B87  ret      
```

### [network_winsock] 0x00816C60 (RVA 0x416C60, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816C60  mov      ah, 0xa4
00816C62  add      dword ptr [eax], 0xccccccc3
00816C68  int3     
00816C69  int3     
00816C6A  int3     
00816C6B  int3     
00816C6C  int3     
00816C6D  int3     
00816C6E  int3     
00816C6F  int3     
00816C70  mov      ecx, 0x9452a4
00816C75  or       eax, 0xffffffff
00816C78  lock xadd dword ptr [ecx], eax
00816C7C  jne      0x816c84
00816C7E  jmp      dword ptr [0x81a4b4]   ; IAT:WS2_32.dll!WSACleanup
00816C84  ret      
00816C85  int3     
00816C86  int3     
00816C87  int3     
00816C88  int3     
00816C89  int3     
00816C8A  int3     
00816C8B  int3     
00816C8C  int3     
00816C8D  int3     
00816C8E  int3     
```

### [network_winsock] 0x00816C80 (RVA 0x416C80, ≈0x30 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816C80  mov      ah, 0xa4
00816C82  add      dword ptr [eax], 0xccccccc3
00816C88  int3     
00816C89  int3     
00816C8A  int3     
00816C8B  int3     
00816C8C  int3     
00816C8D  int3     
00816C8E  int3     
00816C8F  int3     
00816C90  jmp      0x4010b0   ; -> sub_4010B0 [func-start]
00816C95  int3     
00816C96  int3     
00816C97  int3     
00816C98  int3     
00816C99  int3     
00816C9A  int3     
00816C9B  int3     
00816C9C  int3     
00816C9D  int3     
00816C9E  int3     
00816C9F  int3     
00816CA0  mov      ecx, 0x9452a4
00816CA5  or       eax, 0xffffffff
00816CA8  lock xadd dword ptr [ecx], eax
00816CAC  jne      0x816cb4
```

### [network_winsock] 0x00816CB0 (RVA 0x416CB0, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816CB0  mov      ah, 0xa4
00816CB2  add      dword ptr [eax], 0xccccccc3
00816CB8  int3     
00816CB9  int3     
00816CBA  int3     
00816CBB  int3     
00816CBC  int3     
00816CBD  int3     
00816CBE  int3     
00816CBF  int3     
00816CC0  mov      ecx, 0x9452a4
00816CC5  or       eax, 0xffffffff
00816CC8  lock xadd dword ptr [ecx], eax
00816CCC  jne      0x816cd4
00816CCE  jmp      dword ptr [0x81a4b4]   ; IAT:WS2_32.dll!WSACleanup
00816CD4  ret      
00816CD5  int3     
00816CD6  int3     
00816CD7  int3     
00816CD8  int3     
00816CD9  int3     
00816CDA  int3     
00816CDB  int3     
00816CDC  int3     
00816CDD  int3     
00816CDE  int3     
```

### [network_winsock] 0x00816CD0 (RVA 0x416CD0, ≈0x10 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00816CD0  mov      ah, 0xa4
00816CD2  add      dword ptr [eax], 0xccccccc3
00816CD8  int3     
00816CD9  int3     
00816CDA  int3     
00816CDB  int3     
00816CDC  int3     
00816CDD  int3     
00816CDE  int3     
00816CDF  int3     
00816CE0  push     ebp
00816CE1  mov      ebp, esp
00816CE3  push     ecx
00816CE4  cmp      dword ptr [0x92fff8], 0x10
00816CEB  jb       0x816d1b
00816CED  push     esi
00816CEE  mov      esi, dword ptr [0x92ffe4]
00816CF4  lea      ecx, [ebp - 1]
00816CF7  call     0x4060f0   ; -> sub_4060F0 [func-start]
00816CFC  push     0x92ffe4
00816D01  lea      ecx, [ebp - 1]
00816D04  call     0x401130   ; -> sub_401130 [func-start]
00816D09  lea      ecx, [ebp - 1]
00816D0C  call     0x4060f0   ; -> sub_4060F0 [func-start]
00816D11  push     esi
00816D12  call     0x78c6fc   ; -> sub_78C6FC [func-start]
```

### [api_ref_function] 0x007918DB (RVA 0x3918DB, ≈0x3f5 bytes, 入度 69)

引用 API: `KERNEL32.dll!RaiseException`

```asm
007918DB  push     ebp
007918DC  mov      ebp, esp
007918DE  mov      eax, dword ptr [ebp + 0xc]
007918E1  sub      esp, 0x20
007918E4  push     esi
007918E5  push     edi
007918E6  push     8
007918E8  pop      ecx
007918E9  mov      esi, 0x826e80
007918EE  lea      edi, [ebp - 0x20]
007918F1  rep movsd dword ptr es:[edi], dword ptr [esi]
007918F3  mov      ecx, dword ptr [ebp + 8]
007918F6  pop      edi
007918F7  pop      esi
007918F8  test     eax, eax
007918FA  je       0x791909
007918FC  test     byte ptr [eax], 0x10
007918FF  je       0x791909
00791901  mov      eax, dword ptr [ecx]
00791903  mov      eax, dword ptr [eax - 4]
00791906  mov      eax, dword ptr [eax + 0x18]
00791909  mov      dword ptr [ebp - 8], ecx
0079190C  mov      dword ptr [ebp - 4], eax
0079190F  test     eax, eax
00791911  je       0x79191f
00791913  test     byte ptr [eax], 8
```

### [api_ref_function] 0x0078B76B (RVA 0x38B76B, ≈0x686 bytes, 入度 29)

引用 API: `KERNEL32.dll!GetFileType`, `KERNEL32.dll!GetModuleFileNameW`, `KERNEL32.dll!GetModuleHandleExW`, `KERNEL32.dll!GetStdHandle`, `KERNEL32.dll!WriteConsoleW`

```asm
0078B76B  push     ebp
0078B76C  mov      ebp, esp
0078B76E  sub      esp, 0xb20
0078B774  mov      eax, dword ptr [0x92a3e0]
0078B779  xor      eax, ebp
0078B77B  mov      dword ptr [ebp - 4], eax
0078B77E  mov      eax, dword ptr [ebp + 8]
0078B781  push     ebx
0078B782  push     esi
0078B783  mov      esi, dword ptr [ebp + 0xc]
0078B786  push     edi
0078B787  push     3
0078B789  mov      dword ptr [ebp - 0xb20], eax
0078B78F  call     0x79a218   ; -> sub_79A218 [func-start]
0078B794  xor      ebx, ebx
0078B796  inc      ebx
0078B797  pop      ecx
0078B798  cmp      eax, ebx
0078B79A  je       0x78bd0f
0078B7A0  push     3
0078B7A2  call     0x79a218   ; -> sub_79A218 [func-start]
0078B7A7  pop      ecx
0078B7A8  test     eax, eax
0078B7AA  jne      0x78b7b8
0078B7AC  cmp      dword ptr [0x943418], ebx
0078B7B2  je       0x78bd0f
```

### [api_ref_function] 0x00785790 (RVA 0x385790, ≈0x720 bytes, 入度 20)

引用 API: `KERNEL32.dll!GetSystemTimeAsFileTime`

```asm
00785790  push     -1
00785792  push     0x7f83ce
00785797  mov      eax, dword ptr fs:[0]
0078579D  push     eax
0078579E  mov      eax, dword ptr [0x92a3e0]
007857A3  xor      eax, esp
007857A5  push     eax
007857A6  lea      eax, [esp + 4]
007857AA  mov      dword ptr fs:[0], eax
007857B0  mov      eax, dword ptr [0x942e28]
007857B5  test     al, 1
007857B7  jne      0x7857e0
007857B9  or       eax, 1
007857BC  mov      dword ptr [0x942e28], eax
007857C1  push     0x819400
007857C6  mov      dword ptr [esp + 0x10], 0
007857CE  mov      dword ptr [0x942e24], 0x826790
007857D8  call     0x78bf32   ; -> sub_78BF32 [func-start]
007857DD  add      esp, 4
007857E0  mov      eax, 0x942e24
007857E5  mov      ecx, dword ptr [esp + 4]
007857E9  mov      dword ptr fs:[0], ecx
007857F0  pop      ecx
007857F1  add      esp, 0xc
007857F4  ret      
007857F5  int3     
```

### [api_ref_function] 0x0078B404 (RVA 0x38B404, ≈0x3c bytes, 入度 16)

引用 API: `KERNEL32.dll!GetLastError`, `KERNEL32.dll!HeapFree`

```asm
0078B404  push     ebp
0078B405  mov      ebp, esp
0078B407  cmp      dword ptr [ebp + 8], 0
0078B40B  je       0x78b43a
0078B40D  push     dword ptr [ebp + 8]
0078B410  push     0
0078B412  push     dword ptr [0x9433f4]
0078B418  call     dword ptr [0x81a248]   ; IAT:KERNEL32.dll!HeapFree
0078B41E  test     eax, eax
0078B420  jne      0x78b43a
0078B422  push     esi
0078B423  call     0x79426d
0078B428  mov      esi, eax
0078B42A  call     dword ptr [0x81a2ec]   ; IAT:KERNEL32.dll!GetLastError
0078B430  push     eax
0078B431  call     0x794280   ; -> sub_794280 [func-start]
0078B436  pop      ecx
0078B437  mov      dword ptr [esi], eax
0078B439  pop      esi
0078B43A  pop      ebp
0078B43B  ret      
0078B43C  int3     
0078B43D  int3     
0078B43E  int3     
0078B43F  int3     
0078B440  cmp      dword ptr [0x9433ec], 1
```

### [api_ref_function] 0x004027B0 (RVA 0x27B0, ≈0x40 bytes, 入度 11)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
004027B0  mov      eax, dword ptr [ecx + 4]
004027B3  push     esi
004027B4  lea      esi, [ecx + 4]
004027B7  test     eax, eax
004027B9  jne      0x4027e2
004027BB  push     eax
004027BC  push     eax
004027BD  call     0x402730   ; -> sub_402730 [func-start]
004027C2  mov      edx, eax
004027C4  add      esp, 8
004027C7  mov      ecx, edx
004027C9  xor      eax, eax
004027CB  lock cmpxchg dword ptr [esi], ecx
004027CF  mov      esi, eax
004027D1  test     esi, esi
004027D3  je       0x4027e0
004027D5  push     edx
004027D6  call     dword ptr [0x81a274]   ; IAT:KERNEL32.dll!CloseHandle
004027DC  mov      eax, esi
004027DE  pop      esi
004027DF  ret      
004027E0  mov      eax, edx
004027E2  pop      esi
004027E3  ret      
004027E4  int3     
004027E5  int3     
```

### [api_ref_function] 0x00404060 (RVA 0x4060, ≈0xb0 bytes, 入度 7)

引用 API: `KERNEL32.dll!SetEvent`

```asm
00404060  push     esi
00404061  mov      esi, ecx
00404063  mov      eax, dword ptr [esi]
00404065  test     eax, eax
00404067  je       0x404086
00404069  push     eax
0040406A  call     0x78c6fc   ; -> sub_78C6FC [func-start]
0040406F  add      esp, 4
00404072  mov      dword ptr [esi], 0
00404078  mov      dword ptr [esi + 4], 0
0040407F  mov      dword ptr [esi + 8], 0
00404086  pop      esi
00404087  ret      
00404088  int3     
00404089  int3     
0040408A  int3     
0040408B  int3     
0040408C  int3     
0040408D  int3     
0040408E  int3     
0040408F  int3     
00404090  push     ecx
00404091  cmp      byte ptr [ecx + 4], 0
00404095  je       0x4040c3
00404097  mov      ecx, dword ptr [ecx]
00404099  mov      eax, 0x80000000
```

### [api_ref_function] 0x0076B750 (RVA 0x36B750, ≈0x5c bytes, 入度 6)

引用 API: `KERNEL32.dll!InterlockedDecrement`

```asm
0076B750  push     ebp
0076B751  mov      ebp, esp
0076B753  mov      eax, dword ptr [ebp + 8]
0076B756  push     esi
0076B757  mov      esi, ecx
0076B759  mov      dword ptr [esi], eax
0076B75B  test     eax, eax
0076B75D  jne      0x76b768
0076B75F  push     0xc
0076B761  call     0x7928f5   ; -> sub_7928F5 [func-start]
0076B766  jmp      0x76b77b
0076B768  cmp      eax, 4
0076B76B  jge      0x76b77c
0076B76D  imul     eax, eax, 0x18
0076B770  add      eax, 0x942a40
0076B775  push     eax
0076B776  call     0x76ef02   ; -> sub_76EF02 [func-start]
0076B77B  pop      ecx
0076B77C  mov      eax, esi
0076B77E  pop      esi
0076B77F  pop      ebp
0076B780  ret      4
0076B783  push     0x92956c
0076B788  call     dword ptr [0x81a344]   ; IAT:KERNEL32.dll!InterlockedDecrement
0076B78E  test     eax, eax
0076B790  jns      0x76b7ab
```

### [api_ref_function] 0x00402730 (RVA 0x2730, ≈0x80 bytes, 入度 5)

引用 API: `KERNEL32.dll!CreateEventA`

```asm
00402730  push     ebp
00402731  mov      ebp, esp
00402733  push     -1
00402735  push     0x7fbe38
0040273A  mov      eax, dword ptr fs:[0]
00402740  push     eax
00402741  sub      esp, 0x30
00402744  mov      eax, dword ptr [0x92a3e0]
00402749  xor      eax, ebp
0040274B  mov      dword ptr [ebp - 0x10], eax
0040274E  push     eax
0040274F  lea      eax, [ebp - 0xc]
00402752  mov      dword ptr fs:[0], eax
00402758  mov      eax, dword ptr [ebp + 0xc]
0040275B  mov      ecx, dword ptr [ebp + 8]
0040275E  push     0
00402760  push     eax
00402761  push     ecx
00402762  push     0
00402764  call     dword ptr [0x81a27c]   ; IAT:KERNEL32.dll!CreateEventA
0040276A  test     eax, eax
0040276C  jne      0x402794
0040276E  push     0x848900
00402773  push     0xb
00402775  lea      ecx, [ebp - 0x3c]
00402778  call     0x4026d0   ; -> sub_4026D0 [func-start]
```

### [api_ref_function] 0x00412F40 (RVA 0x12F40, ≈0xd0 bytes, 入度 5)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!WaitForSingleObjectEx`

```asm
00412F40  push     ebp
00412F41  mov      ebp, esp
00412F43  push     ecx
00412F44  push     ebx
00412F45  push     esi
00412F46  push     edi
00412F47  mov      edi, ecx
00412F49  lock bts dword ptr [edi], 0x1f
00412F4E  jae      0x413000
00412F54  mov      eax, dword ptr [edi]
00412F56  mov      dword ptr [ebp - 4], eax
00412F59  lea      eax, [ebp - 4]
00412F5C  push     eax
00412F5D  call     0x413010   ; -> sub_413010 [func-start]
00412F62  test     dword ptr [ebp - 4], 0x80000000
00412F69  je       0x413000
00412F6F  mov      ebx, dword ptr [edi + 4]
00412F72  lea      esi, [edi + 4]
00412F75  test     ebx, ebx
00412F77  jne      0x412f9e
00412F79  push     ebx
00412F7A  push     ebx
00412F7B  call     0x402730   ; -> sub_402730 [func-start]
00412F80  mov      edx, eax
00412F82  add      esp, 8
00412F85  mov      ecx, edx
```

### [api_ref_function] 0x0078CB41 (RVA 0x38CB41, ≈0xab bytes, 入度 5)

引用 API: `KERNEL32.dll!GetLastError`, `KERNEL32.dll!HeapReAlloc`

```asm
0078CB41  push     ebp
0078CB42  mov      ebp, esp
0078CB44  cmp      dword ptr [ebp + 8], 0
0078CB48  jne      0x78cb55
0078CB4A  push     dword ptr [ebp + 0xc]
0078CB4D  call     0x78df4e   ; -> sub_78DF4E [func-start]
0078CB52  pop      ecx
0078CB53  pop      ebp
0078CB54  ret      
0078CB55  push     esi
0078CB56  mov      esi, dword ptr [ebp + 0xc]
0078CB59  test     esi, esi
0078CB5B  jne      0x78cb6a
0078CB5D  push     dword ptr [ebp + 8]
0078CB60  call     0x78b404   ; -> sub_78B404 [func-start]
0078CB65  pop      ecx
0078CB66  xor      eax, eax
0078CB68  jmp      0x78cbb7
0078CB6A  push     ebx
0078CB6B  jmp      0x78cb9d
0078CB6D  test     esi, esi
0078CB6F  jne      0x78cb72
0078CB71  inc      esi
0078CB72  push     esi
0078CB73  push     dword ptr [ebp + 8]
0078CB76  push     0
```

### [api_ref_function] 0x00413220 (RVA 0x13220, ≈0x60 bytes, 入度 4)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
00413220  push     edi
00413221  mov      edi, ecx
00413223  mov      eax, dword ptr [edi + 4]
00413226  test     eax, eax
00413228  je       0x413251
0041322A  cmp      eax, -1
0041322D  je       0x413251
0041322F  push     eax
00413230  call     dword ptr [0x81a274]   ; IAT:KERNEL32.dll!CloseHandle
00413236  test     eax, eax
00413238  jne      0x413251
0041323A  push     0x1d7
0041323F  push     0x85d750
00413244  push     0x85d850
00413249  call     0x78b76b   ; -> sub_78B76B [func-start]
0041324E  add      esp, 0xc
00413251  mov      eax, dword ptr [edi]
00413253  pop      edi
00413254  test     eax, eax
00413256  je       0x41327f
00413258  cmp      eax, -1
0041325B  je       0x41327f
0041325D  push     eax
0041325E  call     dword ptr [0x81a274]   ; IAT:KERNEL32.dll!CloseHandle
00413264  test     eax, eax
00413266  jne      0x41327f
```

### [api_ref_function] 0x004139E0 (RVA 0x139E0, ≈0xb0 bytes, 入度 4)

引用 API: `KERNEL32.dll!ReleaseSemaphore`

```asm
004139E0  push     esi
004139E1  push     edi
004139E2  mov      edi, ecx
004139E4  mov      esi, dword ptr [edi]
004139E6  jmp      0x4139f0
004139E8  lea      esp, [esp]
004139EF  nop      
004139F0  lea      edx, [esi - 1]
004139F3  xor      edx, esi
004139F5  and      edx, 0x7ff
004139FB  xor      edx, esi
004139FD  test     edx, 0x7ff
00413A03  sete     cl
00413A06  test     cl, cl
00413A08  je       0x413a3e
00413A0A  test     edx, 0x800000
00413A10  je       0x413a20
00413A12  and      edx, 0xff7fffff
00413A18  or       edx, 0x400000
00413A1E  jmp      0x413a3e
00413A20  mov      eax, edx
00413A22  shr      eax, 0x18
00413A25  test     al, 0x7f
00413A27  je       0x413a38
00413A29  dec      eax
00413A2A  and      eax, 0x7f
```

### 高入度调用枢纽 (top call-magnet)

| RVA | VA | 入度 |
|---|---|---|
| 0x38C6FC | 0x0078C6FC | 289 |
| 0x38CCCF | 0x0078CCCF | 112 |
| 0x38AB66 | 0x0078AB66 | 75 |
| 0x3918DB | 0x007918DB | 69 |
| 0x26BFE0 | 0x0066BFE0 | 41 |
| 0x26C120 | 0x0066C120 | 34 |
| 0x38AC59 | 0x0078AC59 | 33 |
| 0x26C1B0 | 0x0066C1B0 | 32 |
| 0x36B242 | 0x0076B242 | 32 |
| 0x36B297 | 0x0076B297 | 31 |
| 0x38ADC0 | 0x0078ADC0 | 30 |
| 0x26A420 | 0x0066A420 | 30 |

## 9. Rich 编译器头

- prod_id=13082782 build=1 ×1
- prod_id=13485809 build=79 ×1
- prod_id=13616881 build=143 ×1
- prod_id=13551345 build=266 ×1
- prod_id=13561446 build=8 ×1
- prod_id=13495910 build=2 ×1
- prod_id=13626982 build=174 ×1
- prod_id=10244818 build=2 ×1
- prod_id=8111655 build=2 ×1
- prod_id=11236975 build=2 ×1
- prod_id=9664521 build=4 ×1
- prod_id=8615945 build=3 ×1
- prod_id=13369309 build=25 ×1
- prod_id=65536 build=354 ×1
- prod_id=13889126 build=183 ×1
- prod_id=13233766 build=1 ×1
- prod_id=9895936 build=1 ×1
- prod_id=13430374 build=1 ×1

## 10. 字符串分析

按编码计数(节内扫描): ASCII=11640, SJIS(CP932)=23240, UTF-16LE=565

### 文件引用(资源/存档/配置) (47 条)

- `If you can reproduce this, please email bugs@continuousphysics.com` [.rdata]
- `.global.nut` [.rdata]
- `kernel32.dll` [.rdata]
- `cmd.exe` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/exception/detail/exception_ptr.hpp` [.rdata]
- `Microsoft (R) HLSL Shader Compiler 9.29.952.3111` [.rdata]
- `Day of month value is out of range 1..31` [.rdata]
- `Month number is out of range 1..12` [.rdata]
- `KERNEL32.DLL` [.rdata]
- `data/script/boot.nut` [.rdata]
- `ss/%05d.jpg` [.rdata]
- `th145.pak` [.rdata]
- `th145b.pak` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/multiprecision/detail/number_base.hpp` [.rdata]
- `asio.misc` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/multiprecision/cpp_int/misc.hpp` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/multiprecision/cpp_int/divide.hpp` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/multiprecision/detail/integer_ops.hpp` [.rdata]
- `1.6.10` [.rdata]
- `255.255.255.255` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/uuid/string_generator.hpp` [.rdata]
- `C:\Users\nonotaro\Works\_lib_vc11\boost_1_57_0\boost/uuid/sha1.hpp` [.rdata]
- `Microsoft (R) HLSL Shader Compiler 9.22.949.2248` [.rdata]
- `Microsoft (R) HLSL Shader Compiler 9.19.949.1104` [.rdata]
- `ntdll.dll` [.rdata]
- `WINMM.dll` [.rdata]
- `d3dx9_43.dll` [.rdata]
- `IMM32.dll` [.rdata]
- `KERNEL32.dll` [.rdata]
- `USER32.dll` [.rdata]
- `GDI32.dll` [.rdata]
- `ADVAPI32.dll` [.rdata]
- `SHELL32.dll` [.rdata]
- `ole32.dll` [.rdata]
- `OLEAUT32.dll` [.rdata]
- `WS2_32.dll` [.rdata]
- `PSAPI.DLL` [.rdata]
- `DINPUT8.dll` [.rdata]
- `XINPUT9_1_0.dll` [.rdata]
- `d3d9.dll` [.rdata]
- `DSOUND.dll` [.rdata]
- `4$4.474` [.reloc]
- `3%6.7O7` [.reloc]
- `4_5.7U7` [.reloc]
- `7(7.7n7` [.reloc]
- `1(1.1n1` [.reloc]
- `8'8.8Q8` [.reloc]

### 网络对战模块 (80 条)

- `class instances do not support the new slot operator` [.rdata]
- `function not supported` [.rdata]
- `address_family_not_supported` [.rdata]
- `connection_already_in_progress` [.rdata]
- `connection_aborted` [.rdata]
- `connection_refused` [.rdata]
- `connection_reset` [.rdata]
- `host_unreachable` [.rdata]
- `already_connected` [.rdata]
- `network_down` [.rdata]
- `network_reset` [.rdata]
- `network_unreachable` [.rdata]
- `not_connected` [.rdata]
- `not_a_socket` [.rdata]
- `operation_not_supported` [.rdata]
- `protocol_not_supported` [.rdata]
- `address family not supported` [.rdata]
- `already connected` [.rdata]
- `connection aborted` [.rdata]
- `connection already in progress` [.rdata]
- `connection refused` [.rdata]
- `connection reset` [.rdata]
- `host unreachable` [.rdata]
- `network down` [.rdata]
- `network reset` [.rdata]
- `network unreachable` [.rdata]
- `not a socket` [.rdata]
- `not connected` [.rdata]
- `not supported` [.rdata]
- `operation not supported` [.rdata]
- `protocol not supported` [.rdata]
- `ConnectRenderSlot` [.rdata]
- `DisconnectRenderSlot` [.rdata]
- `Reconnect` [.rdata]
- `Connect` [.rdata]
- `GetConnectState` [.rdata]
- `ConnectReject` [.rdata]
- `ConnectComplete` [.rdata]
- `DisconnectParent` [.rdata]
- `DisconnectChild` [.rdata]
- `ConnectRequest` [.rdata]
- `NetworkClient` [.rdata]
- `NetworkServer` [.rdata]
- `unsupported zlib version` [.rdata]
- `libpng does not support gamma+background+rgb_to_gray` [.rdata]
- `CreateIoCompletionPort` [.rdata]
- `ScreenToClient` [.rdata]
- `GetClientRect` [.rdata]
- `ClientToScreen` [.rdata]
- `WSASocketW` [.rdata]
- `- floating point support not loaded` [.rdata]
- `portuguese-brazilian` [.rdata]
- `.?AVConnectionFilter@b2ParticleSystem@@` [.data]
- `.?AVUpdateTriadsCallback@?BE@??UpdatePairsAndTriads@b2ParticleSystem@@AAEXHHABVConnectionFilter@2@@Z@` [.data]
- `.?AVunsupported_os@Concurrency@@` [.data]
- `.?AV?$connection_body@U?$pair@W4slot_meta_group@detail@signals2@boost@@V?$optional@H@4@@std@@V?$slot0@XV?$function@$$A6AXXZ@boost@@@signals2@boost@@Vmutex@45@@detail@signals2@boost@@` [.data]
- `.?AV?$signal0@XV?$optional_last_value@X@signals2@boost@@HU?$less@H@std@@V?$function@$$A6AXXZ@3@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@3@Vmutex@23@@signals2@boost@@` [.data]
- `.?AV?$bound_extended_slot_function0@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@boost@@@detail@signals2@boost@@` [.data]
- `.?AVconnection_body_base@detail@signals2@boost@@` [.data]
- `.?AV?$sp_counted_impl_p@Vinvocation_state@?$signal0_impl@XV?$optional_last_value@X@signals2@boost@@HU?$less@H@std@@V?$function@$$A6AXXZ@3@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@3@Vmutex@23@@detail@signals2@boost@@@detail@boost@@` [.data]

### DirectX API 相关 (48 条)

- `D3DMatrix` [.rdata]
- `D3DXSaveTextureToFileA` [.rdata]
- `D3DXCreateTexture` [.rdata]
- `D3DXAssembleShader` [.rdata]
- `D3DXCreateEffectPool` [.rdata]
- `D3DXAssembleShaderFromFileA` [.rdata]
- `D3DXCreateTextureFromFileExA` [.rdata]
- `D3DXCreateTextureFromFileInMemoryEx` [.rdata]
- `D3DXGetImageInfoFromFileA` [.rdata]
- `D3DXVec3Transform` [.rdata]
- `D3DXMatrixScaling` [.rdata]
- `D3DXMatrixTranslation` [.rdata]
- `D3DXMatrixRotationYawPitchRoll` [.rdata]
- `D3DXGetShaderConstantTable` [.rdata]
- `.?AV<lambda_d3de95cef51eb27fa17bfea72d56c6c9>@@` [.data]
- `.?AV?$_Ref_count@VD3D9PixelShader@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9VertexShader@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@V?$TD3D9Texture@PAUIDirect3DTexture9@@@TF4@@@std@@` [.data]
- `.?AV<lambda_3c1aacf27a82adae1b98adab5d3d24d2>@@` [.data]
- `.?AV?$_Ref_count@VD3D9RenderTarget@TF4@@@std@@` [.data]
- `.?AV?$_Func_impl@U?$_Callable_obj@V<lambda_3e87b154fa0642e2b6869befcc19d3dc>@@$0A@@std@@V?$allocator@V?$_Func_class@_NU_Nil@std@@U12@U12@U12@U12@U12@U12@@std@@@2@_NU_Nil@2@U42@U42@U42@U42@U42@U42@@std@@` [.data]
- `.?AV<lambda_3e87b154fa0642e2b6869befcc19d3dc>@@` [.data]
- `.?AVD3D9Device@TF4@@` [.data]
- `.?AV?$enable_shared_from_this@VD3D9Device@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9VertexBuffer@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9Resource@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9Device@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj@VD3D9Resource@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj@VD3D9Device@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9RenderTarget@TF4@@V?$pool_allocator@VD3D9RenderTarget@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9IndexBuffer@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@V?$TD3D9Texture@PAUIDirect3DTexture9@@@TF4@@V?$pool_allocator@V?$TD3D9Texture@PAUIDirect3DTexture9@@@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9VertexBuffer@TF4@@V?$pool_allocator@VD3D9VertexBuffer@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9PixelShader@TF4@@V?$pool_allocator@VD3D9PixelShader@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9InputLayout@TF4@@V?$pool_allocator@VD3D9InputLayout@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9IndexBuffer@TF4@@V?$pool_allocator@VD3D9IndexBuffer@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9VertexShader@TF4@@V?$pool_allocator@VD3D9VertexShader@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9DepthStencil@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9InputLayout@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VD3D9DepthStencil@TF4@@V?$pool_allocator@VD3D9DepthStencil@TF4@@Udefault_user_allocator_new_delete@boost@@Vmutex@4@$0CA@$0A@@boost@@@std@@` [.data]
- `.?AV?$_Ref_count_del@VD3D9RenderTarget@TF4@@V<lambda_8461afa79ca5d6be26e5e85f1c660ab7>@@@std@@` [.data]
- `.?AV?$_Ref_count@VD3D9DeviceContext@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_del@VD3D9DepthStencil@TF4@@V<lambda_a099f3afc9f45d3423825b7289a7d203>@@@std@@` [.data]
- `.?AVID3D9InputAssemblerBuffer@TF4@@` [.data]
- `.?AVD3D9DeviceContext@TF4@@` [.data]
- `303<3D3d3` [.reloc]
- `3 3(30383D3d3l3t3|3` [.reloc]
- `383D3d3l3t3` [.reloc]

### 调试/错误消息 (17 条)

- `internal vm error bitwise op failed` [.rdata]
- `_nexti failed` [.rdata]
- `assert` [.rdata]
- `assertion failed` [.rdata]
- `compare func failed` [.rdata]
- `internal compiler error: too many literals` [.rdata]
- `internal compiler error: too many locals` [.rdata]
- `remove() failed` [.rdata]
- `rename() failed` [.rdata]
- `resize failed` [.rdata]
- `failed enable composition` [.rdata]
- `Failed GetUserName API.` [.rdata]
- `libpng error: %s` [.rdata]
- `internal error: array alloc` [.rdata]
- `internal error: array realloc` [.rdata]
- `Memory allocation failed while processing sCAL` [.rdata]
- `.?AV_Node_assert@std@@` [.data]

### 日文消息(游戏文案) (80 条)

- `U駆V丘` [.text]
- `U駆V虞` [.text]
- `U駆V虞錚` [.text]
- `虞疫` [.text]
- `P庚萇E` [.text]
- `業貴` [.text]
- `V虞V頏` [.text]
- `U駆QV虞` [.text]
- `業記$Hd` [.text]
- `業^句]` [.text]
- `U駆V虞祈` [.text]
- `QR勤鞆0` [.text]
- `_QR勤雹0` [.text]
- `U駆Q畿` [.text]
- `_QR勤韜/` [.text]
- `P孔霽E` [.text]
- `U駆QV孔` [.text]
- `右VWP孔` [.text]
- `;,ミ` [.text]
- `吋$$VW急` [.text]
- `業_^記$$3` [.text]
- `ζ 榎$` [.text]
- `VW虞ρ` [.text]
- `U駆QW櫛j` [.text]
- `畿髜VP鍮` [.text]
- `;蘋^]` [.text]
- `VW櫛仇` [.text]
- `U駆V虞襍` [.text]
- `U駆QW及` [.text]
- `U駆V虞阨` [.text]
- `0疫` [.text]
- `U駆Q帰` [.text]
- `影~$` [.text]
- `W緊隰08` [.text]
- `P桐欝$` [.text]
- `凝[句]` [.text]
- `右孔` [.text]
- `櫛厭u` [.text]
- `局貴` [.text]
- `U駆V虞康` [.text]
- `U駆V虞W急` [.text]
- `業_^[句]` [.text]
- `局_^[句]` [.text]
- `PQ庚猊E` [.text]
- `P勤鏃x-` [.text]
- `業記$(d` [.text]
- `W櫛右` [.text]
- `U駆V虞貴` [.text]
- `RQ勤錻` [.text]
- `U駆V虞;u` [.text]
- `好$0P広$` [.text]
- `愚;3t ミ$` [.text]
- `孝(貴` [.text]
- `右VP孔` [.text]
- `βⅦ孔` [.text]
- `筋降 W桐鏥` [.text]
- `愚;3t%ミ$` [.text]
- `右E` [.text]
- `P孔桐韵` [.text]
- `並貴` [.text]

## 11. 版本指纹综合结论

- 链接器: 11.0 → VS2012
- 打包器: no strong packer indicators
- 模块栈: Direct3D9, D3DX, DirectInput8, DirectInput, DirectSound, winmm, winsock2, XInput
- 入口: RVA 0x38DBB3 (VA 0x0078DBB3)
## 12. 补充发现(专项深挖)

- **引擎**: 延续 Manbow 引擎 + Act 框架 + Sqrat 绑定;脚本升级为 **Squirrel 3.0.6 stable**;RTTI 仍含 `ManbowRenderLayout@TH135`(引擎类名沿用 th135,未更名)。同目录含安装器残件 `updater.exe` / `unins000.exe`(Inno Setup,非游戏本体)。
- **网络对战**: WS2_32 20 函数,与 th135 同代方案 —— `WSASocketW / getaddrinfo / select / ioctlsocket / setsockopt / WSARecvFrom / WSASend / WSASendTo / WSAStringToAddressA / bind / htonl / htons / ntohl / ntohs / closesocket / freeaddrinfo / WSAStartup / WSACleanup / WSAGetLastError / WSASetLastError`;在线模式客户端-服务器(深秘录的「霊夢の玉」网络联动)。
- **输入/手柄**: DINPUT8 + **XINPUT9_1_0**(XInputGetState / XInputGetCapabilities)。
- **音频/图形**: DSOUND(ord#11)+ Direct3D9 + d3dx9_43(13 函数: D3DXCreateTexture / D3DXCreateEffectPool / D3DXAssembleShader / D3DXSaveTextureToFileA 等);新增 **PSAPI.dll**(进程内存统计)。
- **资源包**: `th145.pak` / `th145b.pak`(对应 W4 t30 拆包);配置 config.ini。
- **其他**: TLS 回调目录存在;VS2012 工具链;同目录 th145_update_141.exe(W7 范围)。
