# 東方憑依華 ~ Antinomy of Common Flowers (TH15.5) — 主程序深度静态分析报告

- 目标文件: `E:/GitWorkspace/thworks/tf/th155/th155.exe`
- 分析方式: 纯静态 (pefile 结构解析 + capstone 反汇编 + 字符串提取),未执行目标程序

## 1. 文件概要

| 属性 | 值 |
|---|---|
| 大小 | 5287640 bytes (5.0 MiB) |
| MD5 | `4418d8721d4f6fde36eefd8ab30889ac` |
| SHA256 | `fc6708094b53afa3c00584ecb6e9be14bbf57c2fcd568ef8017af27f8b8ee1f8` |
| 文件修改时间 | 2020-01-26T11:44:25.501502+00:00 |
| PE 时间戳 | 2018-04-23 09:56:22 UTC (raw 0x5ADDADC6) |
| 架构/子系统 | i386 / PE32 / WINDOWS_GUI |
| 链接器版本 | 14.0 → VS2015 |
| 入口点 | RVA 0x2E1B8C (VA 0x006E1B8C) |
| ImageBase | 0x400000 |
| CheckSum 校验 | 通过 |

**编译指纹结论**: 链接器 14.0 → VS2015。**打包器**: no strong packer indicators。**图形/模块栈**: D3DX, DirectInput8, DirectInput, DirectSound, winmm, winsock2, XInput。

## 2. 节区表

| 节 | VA | VSize | RawPtr | RawSize | 熵 | 属性 | V/R比 |
|---|---|---|---|---|---|---|---|
| .text | 0x1000 | 3695162 | 1024 | 3695616 | 6.5627 | EXEC|READ|CODE | 1.0 |
| .rdata | 0x388000 | 1113334 | 3696640 | 1113600 | 5.1738 | READ|IDATA | 1.0 |
| .data | 0x498000 | 293540 | 4810240 | 265216 | 5.2592 | READ|WRITE|IDATA | 1.107 |
| .gfids | 0x4E0000 | 4580 | 5075456 | 4608 | 4.1295 | READ|IDATA | 0.994 |
| .tls | 0x4E2000 | 9 | 5080064 | 512 | 0.0204 | READ|WRITE|IDATA | 0.018 |
| _RDATA | 0x4E3000 | 1504 | 5080576 | 1536 | 4.6805 | READ|IDATA | 0.979 |
| .rsrc | 0x4E4000 | 8808 | 5082112 | 9216 | 2.6048 | READ|IDATA | 0.956 |
| .reloc | 0x4E7000 | 190728 | 5091328 | 190976 | 6.6443 | READ|IDATA | 0.999 |

## 3. 导入表 (19 DLL / 333 函数)

| DLL | 导入数 |
|---|---|
| WINMM.dll | 2 |
| IMM32.dll | 5 |
| d3dx11_43.dll | 1 |
| d3dx9_43.dll | 4 |
| KERNEL32.dll | 198 |
| USER32.dll | 57 |
| GDI32.dll | 7 |
| ADVAPI32.dll | 16 |
| SHELL32.dll | 2 |
| ole32.dll | 4 |
| OLEAUT32.dll | 2 |
| WINTRUST.dll | 1 |
| VERSION.dll | 3 |
| dbghelp.dll | 6 |
| DINPUT8.dll | 1 |
| XINPUT9_1_0.dll | 2 |
| d3d11.dll | 1 |
| DSOUND.dll | 1 |
| WS2_32.dll | 20 |

**关键 API 使用**(按功能分类,来自关键函数识别):见 §8。

## 4. 导出表

无导出(典型应用程序)。

## 5. 资源

| 类型 | 数量 | 总字节 |
|---|---|---|
| type#1041 | 3 | 8586 |

## 6. TLS / 签名 / Overlay

- TLS: 存在 (callbacks=['0x74DE30'])
- 数字签名: 有 (offset 5282304, size 5336)
- Overlay: offset 5282304, size 5336 bytes (存在! 文件尾部附加数据)

Rich 头(工具链指纹):
- prod_id=15834292 build=48 ×1
- prod_id=15965364 build=185 ×1
- prod_id=15899828 build=46 ×1
- prod_id=17127909 build=2 ×1
- prod_id=13082782 build=1 ×1
- prod_id=16997947 build=32 ×1
- prod_id=17129019 build=120 ×1
- prod_id=17063483 build=41 ×1
- prod_id=10244818 build=4 ×1
- prod_id=17062866 build=22 ×1
- prod_id=17128814 build=63 ×1
- prod_id=17128402 build=51 ×1
- prod_id=13561446 build=1 ×1
- prod_id=17063570 build=7 ×1
- prod_id=13495910 build=2 ×1
- prod_id=17129106 build=65 ×1
- prod_id=13631453 build=2 ×1
- prod_id=13696989 build=3 ×1
- prod_id=13369309 build=37 ×1
- prod_id=65536 build=364 ×1
- prod_id=17391250 build=335 ×1
- prod_id=16735890 build=1 ×1
- prod_id=16932498 build=1 ×1

## 7. 入口点反汇编(前段)

```asm
006E1B8C  call     0x6e2a07   ; -> sub_6E2A07 [func-start]
006E1B91  jmp      0x6e1a24
006E1B96  push     0x10
006E1B98  push     0x892bf0
006E1B9D  call     0x6e29a0
006E1BA2  xor      ebx, ebx
006E1BA4  mov      dword ptr [ebp - 0x20], ebx
006E1BA7  mov      byte ptr [ebp - 0x19], bl
006E1BAA  mov      dword ptr [ebp - 4], ebx
006E1BAD  cmp      ebx, dword ptr [ebp + 0x10]
006E1BB0  je       0x6e1bcc
006E1BB2  mov      ecx, dword ptr [ebp + 0x14]
006E1BB5  call     0x6e2531
006E1BBA  mov      ecx, dword ptr [ebp + 8]
006E1BBD  call     dword ptr [ebp + 0x14]
006E1BC0  mov      eax, dword ptr [ebp + 0xc]
006E1BC3  add      dword ptr [ebp + 8], eax
006E1BC6  inc      ebx
006E1BC7  mov      dword ptr [ebp - 0x20], ebx
006E1BCA  jmp      0x6e1bad
006E1BCC  mov      al, 1
006E1BCE  mov      byte ptr [ebp - 0x19], al
006E1BD1  mov      dword ptr [ebp - 4], 0xfffffffe
006E1BD8  call     0x6e1beb
006E1BDD  call     0x6e29e6
006E1BE2  ret      0x14
006E1BE5  mov      ebx, dword ptr [ebp - 0x20]
006E1BE8  mov      al, byte ptr [ebp - 0x19]
006E1BEB  test     al, al
006E1BED  jne      0x6e1bfe
006E1BEF  push     dword ptr [ebp + 0x18]
006E1BF2  push     ebx
006E1BF3  push     dword ptr [ebp + 0xc]
006E1BF6  push     dword ptr [ebp + 8]
006E1BF9  call     0x6e1658
006E1BFE  ret      
006E1BFF  push     ebp
006E1C00  mov      ebp, esp
006E1C02  push     0
006E1C04  call     dword ptr [0x788300]   ; IAT:KERNEL32.dll!SetUnhandledExceptionFilter
```

## 8. 关键函数识别(capstone + IAT 引用分析)

估计函数总数(E8 call 目标统计): **11783**

### [network_winsock] 0x00406FE0 (RVA 0x6FE0, ≈0x1d0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00406FE0  push     ebp
00406FE1  mov      ebp, esp
00406FE3  and      esp, 0xfffffff8
00406FE6  sub      esp, 0x198
00406FEC  mov      eax, dword ptr [0x898e24]
00406FF1  xor      eax, esp
00406FF3  mov      dword ptr [esp + 0x194], eax
00406FFA  push     0x784d80
00406FFF  call     0x6e1918   ; -> sub_6E1918 [func-start]
00407004  add      esp, 4
00407007  mov      eax, 1
0040700C  lock xadd dword ptr [0x8dc81c], eax
00407014  inc      eax
00407015  cmp      eax, 1
00407018  jne      0x40702d
0040701A  lea      eax, [esp]
0040701D  push     eax
0040701E  push     2
00407020  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
00407026  mov      ecx, 0x8dc820
0040702B  xchg     dword ptr [ecx], eax
0040702D  mov      ecx, dword ptr [esp + 0x194]
00407034  xor      ecx, esp
00407036  call     0x6e134f
0040703B  mov      esp, ebp
0040703D  pop      ebp
```

### [network_winsock] 0x004071B0 (RVA 0x71B0, ≈0xe0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
004071B0  push     ebp
004071B1  mov      ebp, esp
004071B3  and      esp, 0xfffffff8
004071B6  sub      esp, 0x198
004071BC  mov      eax, dword ptr [0x898e24]
004071C1  xor      eax, esp
004071C3  mov      dword ptr [esp + 0x194], eax
004071CA  push     0x784e00
004071CF  call     0x6e1918   ; -> sub_6E1918 [func-start]
004071D4  add      esp, 4
004071D7  mov      eax, 1
004071DC  lock xadd dword ptr [0x8dc81c], eax
004071E4  inc      eax
004071E5  cmp      eax, 1
004071E8  jne      0x4071fd
004071EA  lea      eax, [esp]
004071ED  push     eax
004071EE  push     2
004071F0  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
004071F6  mov      ecx, 0x8dc820
004071FB  xchg     dword ptr [ecx], eax
004071FD  mov      ecx, dword ptr [esp + 0x194]
00407204  xor      ecx, esp
00407206  call     0x6e134f
0040720B  mov      esp, ebp
0040720D  pop      ebp
```

### [network_winsock] 0x00407290 (RVA 0x7290, ≈0x100 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00407290  push     ebp
00407291  mov      ebp, esp
00407293  and      esp, 0xfffffff8
00407296  sub      esp, 0x198
0040729C  mov      eax, dword ptr [0x898e24]
004072A1  xor      eax, esp
004072A3  mov      dword ptr [esp + 0x194], eax
004072AA  push     0x784e20
004072AF  call     0x6e1918   ; -> sub_6E1918 [func-start]
004072B4  add      esp, 4
004072B7  mov      eax, 1
004072BC  lock xadd dword ptr [0x8dc81c], eax
004072C4  inc      eax
004072C5  cmp      eax, 1
004072C8  jne      0x4072dd
004072CA  lea      eax, [esp]
004072CD  push     eax
004072CE  push     2
004072D0  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
004072D6  mov      ecx, 0x8dc820
004072DB  xchg     dword ptr [ecx], eax
004072DD  mov      ecx, dword ptr [esp + 0x194]
004072E4  xor      ecx, esp
004072E6  call     0x6e134f
004072EB  mov      esp, ebp
004072ED  pop      ebp
```

### [network_winsock] 0x00407390 (RVA 0x7390, ≈0xe0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAStartup`

```asm
00407390  push     ebp
00407391  mov      ebp, esp
00407393  and      esp, 0xfffffff8
00407396  sub      esp, 0x198
0040739C  mov      eax, dword ptr [0x898e24]
004073A1  xor      eax, esp
004073A3  mov      dword ptr [esp + 0x194], eax
004073AA  push     0x784e50
004073AF  call     0x6e1918   ; -> sub_6E1918 [func-start]
004073B4  add      esp, 4
004073B7  mov      eax, 1
004073BC  lock xadd dword ptr [0x8dc81c], eax
004073C4  inc      eax
004073C5  cmp      eax, 1
004073C8  jne      0x4073dd
004073CA  lea      eax, [esp]
004073CD  push     eax
004073CE  push     2
004073D0  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
004073D6  mov      ecx, 0x8dc820
004073DB  xchg     dword ptr [ecx], eax
004073DD  mov      ecx, dword ptr [esp + 0x194]
004073E4  xor      ecx, esp
004073E6  call     0x6e134f
004073EB  mov      esp, ebp
004073ED  pop      ebp
```

### [network_winsock] 0x00407470 (RVA 0x7470, ≈0x1630 bytes, 入度 0)

引用 API: `KERNEL32.dll!GetTickCount`, `KERNEL32.dll!QueryPerformanceCounter`, `KERNEL32.dll!QueryPerformanceFrequency`, `WS2_32.dll!WSAStartup`

```asm
00407470  push     ebp
00407471  mov      ebp, esp
00407473  and      esp, 0xfffffff8
00407476  sub      esp, 0x198
0040747C  mov      eax, dword ptr [0x898e24]
00407481  xor      eax, esp
00407483  mov      dword ptr [esp + 0x194], eax
0040748A  push     0x784e70
0040748F  call     0x6e1918   ; -> sub_6E1918 [func-start]
00407494  add      esp, 4
00407497  mov      eax, 1
0040749C  lock xadd dword ptr [0x8dc81c], eax
004074A4  inc      eax
004074A5  cmp      eax, 1
004074A8  jne      0x4074bd
004074AA  lea      eax, [esp]
004074AD  push     eax
004074AE  push     2
004074B0  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
004074B6  mov      ecx, 0x8dc820
004074BB  xchg     dword ptr [ecx], eax
004074BD  mov      ecx, dword ptr [esp + 0x194]
004074C4  xor      ecx, esp
004074C6  call     0x6e134f
004074CB  mov      esp, ebp
004074CD  pop      ebp
```

### [winmain_candidate] 0x004238A0 (RVA 0x238A0, ≈0x1d0 bytes, 入度 0)

引用 API: `GDI32.dll!GetStockObject`, `IMM32.dll!ImmGetContext`, `IMM32.dll!ImmReleaseContext`, `IMM32.dll!ImmSetOpenStatus`, `USER32.dll!AdjustWindowRectEx`, `USER32.dll!CreateWindowExA`, `USER32.dll!LoadCursorA`, `USER32.dll!LoadIconA`, `USER32.dll!RegisterClassExA`, `USER32.dll!ShowWindow`, `USER32.dll!UpdateWindow`

```asm
004238A0  push     ebp
004238A1  mov      ebp, esp
004238A3  and      esp, 0xfffffff8
004238A6  sub      esp, 0x15c
004238AC  mov      eax, dword ptr [0x898e24]
004238B1  xor      eax, esp
004238B3  mov      dword ptr [esp + 0x158], eax
004238BA  mov      eax, dword ptr [ebp + 0x14]
004238BD  push     ebx
004238BE  push     esi
004238BF  mov      esi, dword ptr [ebp + 0x10]
004238C2  push     edi
004238C3  push     0
004238C5  mov      dword ptr [esp + 0x10], eax
004238C9  mov      eax, dword ptr [ebp + 0xc]
004238CC  push     0
004238CE  mov      dword ptr [0x89af0c], eax
004238D3  mov      dword ptr [esp + 0x5c], eax
004238D7  lea      eax, [esp + 0x50]
004238DB  push     0xca0000
004238E0  mov      dword ptr [0x8dad14], ecx
004238E6  mov      ecx, dword ptr [ebp + 8]
004238E9  push     eax
004238EA  mov      dword ptr [esp + 0x24], edx
004238EE  mov      dword ptr [esp + 0x20], esi
004238F2  mov      dword ptr [0x89af10], ecx
```

### [input_init] 0x0043B680 (RVA 0x3B680, ≈0x230 bytes, 入度 0)

引用 API: `DINPUT8.dll!DirectInput8Create`

```asm
0043B680  push     ebp
0043B681  mov      ebp, esp
0043B683  and      esp, 0xfffffff8
0043B686  sub      esp, 8
0043B689  cmp      dword ptr [0x8daeec], 0
0043B690  jne      0x43b71a
0043B696  push     0
0043B698  push     0x8daeec
0043B69D  push     0x7da7f8
0043B6A2  push     0x800
0043B6A7  push     dword ptr [0x8dad34]
0043B6AD  call     dword ptr [0x788044]   ; IAT:DINPUT8.dll!DirectInput8Create
0043B6B3  test     eax, eax
0043B6B5  jns      0x43b6bd
0043B6B7  xor      al, al
0043B6B9  mov      esp, ebp
0043B6BB  pop      ebp
0043B6BC  ret      
0043B6BD  push     0x100
0043B6C2  push     0
0043B6C4  push     0x8daf00
0043B6C9  call     0x6fad20
0043B6CE  xorps    xmm0, xmm0
0043B6D1  mov      dword ptr [0x8daec8], 0
0043B6DB  add      esp, 0xc
0043B6DE  movups   xmmword ptr [0x8daeb8], xmm0
```

### [sound_init_dsound] 0x0043D820 (RVA 0x3D820, ≈0x150 bytes, 入度 0)

引用 API: `DSOUND.dll!ord#11`

```asm
0043D820  push     ebp
0043D821  mov      ebp, esp
0043D823  sub      esp, 0x8c
0043D829  mov      eax, dword ptr [0x898e24]
0043D82E  xor      eax, ebp
0043D830  mov      dword ptr [ebp - 4], eax
0043D833  push     esi
0043D834  push     0
0043D836  push     0x8db00c
0043D83B  push     0
0043D83D  mov      esi, ecx
0043D83F  call     dword ptr [0x78804c]   ; IAT:DSOUND.dll!ord#11
0043D845  test     eax, eax
0043D847  jns      0x43d85a
0043D849  xor      al, al
0043D84B  pop      esi
0043D84C  mov      ecx, dword ptr [ebp - 4]
0043D84F  xor      ecx, ebp
0043D851  call     0x6e134f
0043D856  mov      esp, ebp
0043D858  pop      ebp
0043D859  ret      
0043D85A  mov      eax, dword ptr [0x8db00c]
0043D85F  push     2
0043D861  push     dword ptr [0x8dad30]
0043D867  mov      ecx, dword ptr [eax]
```

### [message_pump] 0x00530630 (RVA 0x130630, ≈0x1b10 bytes, 入度 0)

引用 API: `ADVAPI32.dll!ImpersonateSelf`, `ADVAPI32.dll!OpenThreadToken`, `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!ContinueDebugEvent`, `KERNEL32.dll!CreateFileMappingA`, `KERNEL32.dll!CreateProcessA`, `KERNEL32.dll!DebugActiveProcess`, `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!GetCurrentProcessId`, `KERNEL32.dll!GetCurrentThread`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!GetThreadContext`, `KERNEL32.dll!IsDebuggerPresent`, `KERNEL32.dll!K32EnumProcessModules`, `KERNEL32.dll!K32GetModuleBaseNameA`, `KERNEL32.dll!K32GetModuleInformation`, `KERNEL32.dll!MapViewOfFile`, `KERNEL32.dll!OpenFileMappingA`, `KERNEL32.dll!OpenProcess`, `KERNEL32.dll!OpenThread`, `KERNEL32.dll!ReadProcessMemory`, `KERNEL32.dll!RtlCaptureStackBackTrace`, `KERNEL32.dll!SetCurrentDirectoryA`, `KERNEL32.dll!Sleep`, `KERNEL32.dll!TerminateProcess`, `KERNEL32.dll!WaitForDebugEvent`, `USER32.dll!CreateWindowExA`, `USER32.dll!DispatchMessageA`, `USER32.dll!GetWindowTextA`, `USER32.dll!IsWindow`, `USER32.dll!PeekMessageA`, `USER32.dll!TranslateMessage`, `USER32.dll!wsprintfA`, `WINMM.dll!timeGetTime`, `dbghelp.dll!StackWalk`, `dbghelp.dll!SymFromAddr`, `dbghelp.dll!SymFunctionTableAccess`, `dbghelp.dll!SymGetModuleBase`, `dbghelp.dll!SymGetSymFromAddr`, `dbghelp.dll!SymInitialize`

```asm
00530630  push     ebp
00530631  mov      ebp, esp
00530633  push     -1
00530635  push     0x771c6a
0053063A  mov      eax, dword ptr fs:[0]
00530640  push     eax
00530641  mov      eax, 0x1db8
00530646  call     0x6e1e10
0053064B  mov      eax, dword ptr [0x898e24]
00530650  xor      eax, ebp
00530652  mov      dword ptr [ebp - 0x10], eax
00530655  push     eax
00530656  lea      eax, [ebp - 0xc]
00530659  mov      dword ptr fs:[0], eax
0053065F  push     0xffff
00530664  call     0x6e1dfe   ; -> sub_6E1DFE [func-start]
00530669  add      esp, 4
0053066C  mov      dword ptr [ebp - 0x1d10], eax
00530672  mov      eax, dword ptr [ebp - 0x1d10]
00530678  push     eax
00530679  lea      ecx, [ebp - 0x1b64]
0053067F  call     0x409080   ; -> sub_409080 [func-start]
00530684  mov      dword ptr [ebp - 4], 0
0053068B  push     0xffff
00530690  lea      ecx, [ebp - 0x1b64]
00530696  call     0x40f6e0
```

### [network_winsock] 0x0057024A (RVA 0x17024A, ≈0x6 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
0057024A  adc      byte ptr [ebp - 0x333cff88], al
00570250  push     ebp
00570251  mov      ebp, esp
00570253  and      esp, 0xfffffff8
00570256  sub      esp, 0xc
00570259  push     esi
0057025A  mov      esi, ecx
0057025C  mov      dword ptr [esp + 8], 0
00570264  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00570269  mov      ecx, dword ptr [esi + 8]
0057026C  mov      dword ptr [esp + 0xc], eax
00570270  lea      eax, [esp + 8]
00570274  push     eax
00570275  call     0x56fbb0   ; -> sub_56FBB0 [func-start]
0057027A  cmp      dword ptr [esp + 8], 0
0057027F  jne      0x570286
00570281  pop      esi
00570282  mov      esp, ebp
00570284  pop      ebp
00570285  ret      
00570286  lea      ecx, [esp + 8]
0057028A  call     0x56f150   ; -> sub_56F150 [func-start]
0057028F  int3     
00570290  push     ebp
00570291  mov      ebp, esp
00570293  test     byte ptr [ebp + 8], 1
```

### [network_winsock] 0x005702C0 (RVA 0x1702C0, ≈0x70 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!bind`

```asm
005702C0  push     ebp
005702C1  mov      ebp, esp
005702C3  push     esi
005702C4  mov      esi, ecx
005702C6  push     edi
005702C7  mov      edi, edx
005702C9  cmp      esi, -1
005702CC  jne      0x5702e5
005702CE  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
005702D3  mov      ecx, dword ptr [ebp + 0xc]
005702D6  pop      edi
005702D7  mov      dword ptr [ecx + 4], eax
005702DA  or       eax, esi
005702DC  mov      dword ptr [ecx], 0x2719
005702E2  pop      esi
005702E3  pop      ebp
005702E4  ret      
005702E5  push     ebx
005702E6  push     0
005702E8  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
005702EE  push     dword ptr [ebp + 8]
005702F1  push     edi
005702F2  push     esi
005702F3  call     dword ptr [0x7884e0]   ; IAT:WS2_32.dll!bind
005702F9  mov      ebx, eax
005702FB  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
```

### [network_winsock] 0x00570330 (RVA 0x170330, ≈0x100 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!closesocket`, `WS2_32.dll!ioctlsocket`

```asm
00570330  push     ebp
00570331  mov      ebp, esp
00570333  sub      esp, 0x14
00570336  push     ebx
00570337  push     esi
00570338  mov      esi, ecx
0057033A  mov      eax, edx
0057033C  xor      ebx, ebx
0057033E  mov      dword ptr [ebp - 8], eax
00570341  mov      dword ptr [ebp - 0xc], esi
00570344  push     edi
00570345  mov      edi, dword ptr [ebp + 0xc]
00570348  cmp      esi, -1
0057034B  je       0x57040b
00570351  test     byte ptr [eax], 8
00570354  je       0x570379
00570356  xor      eax, eax
00570358  mov      dword ptr [ebp - 4], eax
0057035B  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00570360  mov      edx, dword ptr [ebp - 8]
00570363  lea      eax, [ebp - 0x14]
00570366  push     eax
00570367  push     ecx
00570368  lea      eax, [ebp - 4]
0057036B  mov      ecx, esi
0057036D  push     eax
```

### [network_winsock] 0x00570430 (RVA 0x170430, ≈0xa0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASend`, `WS2_32.dll!WSASetLastError`

```asm
00570430  push     ebp
00570431  mov      ebp, esp
00570433  sub      esp, 8
00570436  push     ebx
00570437  push     esi
00570438  push     edi
00570439  push     0
0057043B  mov      esi, edx
0057043D  mov      edi, ecx
0057043F  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
00570445  push     0
00570447  push     0
00570449  push     0
0057044B  lea      eax, [ebp - 4]
0057044E  mov      dword ptr [ebp - 4], 0
00570455  push     eax
00570456  push     1
00570458  push     esi
00570459  push     edi
0057045A  call     dword ptr [0x7884d0]   ; IAT:WS2_32.dll!WSASend
00570460  mov      ebx, eax
00570462  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00570467  mov      esi, eax
00570469  call     dword ptr [0x7884f4]   ; IAT:WS2_32.dll!WSAGetLastError
0057046F  mov      edi, dword ptr [ebp + 0x10]
00570472  mov      dword ptr [edi], eax
```

### [network_winsock] 0x005704D0 (RVA 0x1704D0, ≈0xa0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASendTo`, `WS2_32.dll!WSASetLastError`

```asm
005704D0  push     ebp
005704D1  mov      ebp, esp
005704D3  sub      esp, 8
005704D6  push     ebx
005704D7  push     esi
005704D8  push     edi
005704D9  push     0
005704DB  mov      esi, edx
005704DD  mov      edi, ecx
005704DF  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
005704E5  push     0
005704E7  push     0
005704E9  push     dword ptr [ebp + 0x14]
005704EC  lea      eax, [ebp - 4]
005704EF  mov      dword ptr [ebp - 4], 0
005704F6  push     dword ptr [ebp + 0x10]
005704F9  push     0
005704FB  push     eax
005704FC  push     dword ptr [ebp + 8]
005704FF  push     esi
00570500  push     edi
00570501  call     dword ptr [0x7884d4]   ; IAT:WS2_32.dll!WSASendTo
00570507  mov      ebx, eax
00570509  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
0057050E  mov      esi, eax
00570510  call     dword ptr [0x7884f4]   ; IAT:WS2_32.dll!WSAGetLastError
```

### [network_winsock] 0x00570620 (RVA 0x170620, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!WSASocketW`, `WS2_32.dll!setsockopt`

```asm
00570620  push     ebp
00570621  mov      ebp, esp
00570623  push     ecx
00570624  push     ebx
00570625  push     esi
00570626  push     edi
00570627  mov      ebx, ecx
00570629  mov      esi, edx
0057062B  push     0
0057062D  mov      dword ptr [ebp - 4], ebx
00570630  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
00570636  push     1
00570638  push     0
0057063A  push     0
0057063C  push     dword ptr [ebp + 8]
0057063F  push     esi
00570640  push     ebx
00570641  call     dword ptr [0x788518]   ; IAT:WS2_32.dll!WSASocketW
00570647  mov      edi, eax
00570649  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
0057064E  mov      esi, eax
00570650  call     dword ptr [0x7884f4]   ; IAT:WS2_32.dll!WSAGetLastError
00570656  mov      ebx, dword ptr [ebp + 0xc]
00570659  mov      dword ptr [ebx], eax
0057065B  mov      dword ptr [ebx + 4], esi
0057065E  cmp      edi, -1
```

### [network_winsock] 0x005706B0 (RVA 0x1706B0, ≈0x80 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!setsockopt`

```asm
005706B0  push     ebp
005706B1  mov      ebp, esp
005706B3  push     ebx
005706B4  push     esi
005706B5  mov      esi, ecx
005706B7  push     edi
005706B8  cmp      esi, -1
005706BB  jne      0x5706d5
005706BD  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
005706C2  mov      ecx, dword ptr [ebp + 0x18]
005706C5  mov      dword ptr [ecx + 4], eax
005706C8  or       eax, esi
005706CA  mov      dword ptr [ecx], 0x2719
005706D0  pop      edi
005706D1  pop      esi
005706D2  pop      ebx
005706D3  pop      ebp
005706D4  ret      
005706D5  or       byte ptr [edx], 8
005706D8  push     0
005706DA  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
005706E0  push     4
005706E2  push     dword ptr [ebp + 0x10]
005706E5  push     0x80
005706EA  push     0xffff
005706EF  push     esi
```

### [network_winsock] 0x00570730 (RVA 0x170730, ≈0xc0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!select`

```asm
00570730  push     ebp
00570731  mov      ebp, esp
00570733  sub      esp, 0x118
00570739  mov      eax, dword ptr [0x898e24]
0057073E  xor      eax, ebp
00570740  mov      dword ptr [ebp - 4], eax
00570743  push     ebx
00570744  push     esi
00570745  mov      esi, ecx
00570747  push     edi
00570748  mov      edi, dword ptr [ebp + 8]
0057074B  cmp      esi, -1
0057074E  jne      0x570771
00570750  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00570755  mov      dword ptr [edi + 4], eax
00570758  or       eax, esi
0057075A  mov      dword ptr [edi], 0x2719
00570760  pop      edi
00570761  pop      esi
00570762  pop      ebx
00570763  mov      ecx, dword ptr [ebp - 4]
00570766  xor      ecx, ebp
00570768  call     0x6e134f
0057076D  mov      esp, ebp
0057076F  pop      ebp
00570770  ret      
```

### [network_winsock] 0x005707F0 (RVA 0x1707F0, ≈0x1b0 bytes, 入度 0)

引用 API: `KERNEL32.dll!MultiByteToWideChar`, `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSASetLastError`, `WS2_32.dll!WSAStringToAddressW`

```asm
005707F0  push     ebp
005707F1  mov      ebp, esp
005707F3  sub      esp, 0xa0
005707F9  mov      eax, dword ptr [0x898e24]
005707FE  xor      eax, ebp
00570800  mov      dword ptr [ebp - 8], eax
00570803  mov      eax, dword ptr [ebp + 8]
00570806  push     ebx
00570807  push     esi
00570808  push     edi
00570809  mov      edi, dword ptr [ebp + 0x10]
0057080C  mov      ebx, ecx
0057080E  mov      dword ptr [ebp - 0x90], eax
00570814  mov      eax, dword ptr [ebp + 0xc]
00570817  push     0
00570819  mov      dword ptr [ebp - 0x9c], eax
0057081F  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
00570825  cmp      ebx, 2
00570828  je       0x570845
0057082A  cmp      ebx, 0x17
0057082D  je       0x570845
0057082F  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00570834  mov      dword ptr [edi + 4], eax
00570837  or       eax, 0xffffffff
0057083A  mov      dword ptr [edi], 0x273f
00570840  jmp      0x570948
```

### [network_winsock] 0x00570E00 (RVA 0x170E00, ≈0xb0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSAGetLastError`, `WS2_32.dll!WSARecvFrom`

```asm
00570E00  push     ebp
00570E01  mov      ebp, esp
00570E03  push     ebx
00570E04  push     esi
00570E05  push     edi
00570E06  mov      edi, ecx
00570E08  mov      eax, dword ptr [edi + 4]
00570E0B  add      eax, 0x18
00570E0E  lock inc dword ptr [eax]
00570E11  mov      eax, dword ptr [ebp + 8]
00570E14  push     0
00570E16  mov      ecx, dword ptr [eax]
00570E18  cmp      ecx, -1
00570E1B  jne      0x570e34
00570E1D  mov      ecx, dword ptr [edi + 4]
00570E20  push     0x2719
00570E25  push     dword ptr [ebp + 0x20]
00570E28  call     0x56fe50   ; -> sub_56FE50 [func-start]
00570E2D  pop      edi
00570E2E  pop      esi
00570E2F  pop      ebx
00570E30  pop      ebp
00570E31  ret      0x1c
00570E34  mov      ebx, dword ptr [ebp + 0x20]
00570E37  mov      eax, dword ptr [ebp + 0x18]
00570E3A  push     ebx
```

### [network_winsock] 0x005711A0 (RVA 0x1711A0, ≈0x90 bytes, 入度 0)

引用 API: `WS2_32.dll!htons`

```asm
005711A0  push     ebp
005711A1  mov      ebp, esp
005711A3  cmp      dword ptr [ebp + 8], 2
005711A7  xorps    xmm0, xmm0
005711AA  push     esi
005711AB  push     dword ptr [ebp + 0xc]
005711AE  mov      esi, ecx
005711B0  movups   xmmword ptr [esi], xmm0
005711B3  movq     qword ptr [esi + 0x10], xmm0
005711B8  mov      dword ptr [esi + 0x18], 0
005711BF  jne      0x5711e1
005711C1  mov      eax, 2
005711C6  mov      word ptr [esi], ax
005711C9  call     dword ptr [0x7884e4]   ; IAT:WS2_32.dll!htons
005711CF  mov      word ptr [esi + 2], ax
005711D3  mov      eax, esi
005711D5  mov      dword ptr [esi + 4], 0
005711DC  pop      esi
005711DD  pop      ebp
005711DE  ret      8
005711E1  mov      eax, 0x17
005711E6  mov      word ptr [esi], ax
005711E9  call     dword ptr [0x7884e4]   ; IAT:WS2_32.dll!htons
005711EF  mov      word ptr [esi + 2], ax
005711F3  mov      eax, esi
005711F5  mov      dword ptr [esi + 4], 0
```

### [network_winsock] 0x00571230 (RVA 0x171230, ≈0xb0 bytes, 入度 0)

引用 API: `WS2_32.dll!htonl`, `WS2_32.dll!htons`, `WS2_32.dll!ntohl`

```asm
00571230  push     ebp
00571231  mov      ebp, esp
00571233  and      esp, 0xfffffff8
00571236  sub      esp, 0x18
00571239  xorps    xmm0, xmm0
0057123C  push     esi
0057123D  mov      esi, ecx
0057123F  push     edi
00571240  mov      edi, dword ptr [ebp + 8]
00571243  push     dword ptr [ebp + 0xc]
00571246  movups   xmmword ptr [esi], xmm0
00571249  movq     qword ptr [esi + 0x10], xmm0
0057124E  mov      dword ptr [esi + 0x18], 0
00571255  cmp      dword ptr [edi], 0
00571258  jne      0x571294
0057125A  mov      eax, 2
0057125F  mov      word ptr [esi], ax
00571262  call     dword ptr [0x7884e4]   ; IAT:WS2_32.dll!htons
00571268  mov      word ptr [esi + 2], ax
0057126C  mov      ecx, edi
0057126E  lea      eax, [esp + 8]
00571272  push     eax
00571273  call     0x570fb0   ; -> sub_570FB0 [func-start]
00571278  push     dword ptr [eax]
0057127A  call     dword ptr [0x7884f0]   ; IAT:WS2_32.dll!ntohl
00571280  push     eax
```

### [network_winsock] 0x00571320 (RVA 0x171320, ≈0x60 bytes, 入度 0)

引用 API: `WS2_32.dll!htonl`, `WS2_32.dll!ntohl`

```asm
00571320  push     ebp
00571321  mov      ebp, esp
00571323  mov      eax, ecx
00571325  cmp      word ptr [eax], 2
00571329  jne      0x57135b
0057132B  push     dword ptr [eax + 4]
0057132E  call     dword ptr [0x7884f0]   ; IAT:WS2_32.dll!ntohl
00571334  push     eax
00571335  call     dword ptr [0x7884ec]   ; IAT:WS2_32.dll!htonl
0057133B  mov      ecx, dword ptr [ebp + 8]
0057133E  xorps    xmm0, xmm0
00571341  mov      dword ptr [ecx], 0
00571347  mov      dword ptr [ecx + 4], eax
0057134A  mov      eax, ecx
0057134C  movups   xmmword ptr [ecx + 8], xmm0
00571350  mov      dword ptr [ecx + 0x18], 0
00571357  pop      ebp
00571358  ret      4
0057135B  mov      ecx, dword ptr [eax + 0x18]
0057135E  movups   xmm0, xmmword ptr [eax + 8]
00571362  mov      eax, dword ptr [ebp + 8]
00571365  mov      dword ptr [eax], 1
0057136B  mov      dword ptr [eax + 4], 0
00571372  movups   xmmword ptr [eax + 8], xmm0
00571376  mov      dword ptr [eax + 0x18], ecx
00571379  pop      ebp
```

### [network_winsock] 0x00571380 (RVA 0x171380, ≈0x150 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `WS2_32.dll!htonl`, `WS2_32.dll!ntohl`, `WS2_32.dll!ntohs`

```asm
00571380  push     ebp
00571381  mov      ebp, esp
00571383  and      esp, 0xfffffff8
00571386  sub      esp, 0x44
00571389  mov      eax, dword ptr [0x898e24]
0057138E  xor      eax, esp
00571390  mov      dword ptr [esp + 0x40], eax
00571394  push     ebx
00571395  mov      ebx, edx
00571397  push     esi
00571398  push     edi
00571399  mov      edi, ecx
0057139B  mov      ecx, dword ptr [0x7884f0]
005713A1  cmp      word ptr [ebx], 2
005713A5  jne      0x5713ca
005713A7  push     dword ptr [ebx + 4]
005713AA  call     ecx
005713AC  push     eax
005713AD  call     dword ptr [0x7884ec]   ; IAT:WS2_32.dll!htonl
005713B3  mov      ecx, dword ptr [0x7884f0]
005713B9  mov      esi, eax
005713BB  mov      dword ptr [esp + 0x14], 0
005713C3  xorps    xmm0, xmm0
005713C6  xor      eax, eax
005713C8  jmp      0x5713db
005713CA  mov      eax, dword ptr [ebx + 0x18]
```

### [network_winsock] 0x005723B0 (RVA 0x1723B0, ≈0x220 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!GetProcessHeap`, `KERNEL32.dll!HeapFree`, `WS2_32.dll!WSACleanup`

```asm
005723B0  push     ebp
005723B1  mov      ebp, esp
005723B3  push     -1
005723B5  push     0x76f032
005723BA  mov      eax, dword ptr fs:[0]
005723C0  push     eax
005723C1  push     ecx
005723C2  push     ebx
005723C3  push     esi
005723C4  push     edi
005723C5  mov      eax, dword ptr [0x898e24]
005723CA  xor      eax, ebp
005723CC  push     eax
005723CD  lea      eax, [ebp - 0xc]
005723D0  mov      dword ptr fs:[0], eax
005723D6  mov      edi, ecx
005723D8  mov      dword ptr [edi], 0x84c944
005723DE  call     0x572920   ; -> sub_572920 [func-start]
005723E3  mov      eax, dword ptr [edi + 0x240]
005723E9  lea      ecx, [edi + 0x240]
005723EF  push     eax
005723F0  push     dword ptr [eax]
005723F2  lea      eax, [ebp - 0x10]
005723F5  push     eax
005723F6  call     0x446860   ; -> sub_446860 [func-start]
005723FB  push     dword ptr [edi + 0x240]
```

### [network_winsock] 0x00572BC0 (RVA 0x172BC0, ≈0x250 bytes, 入度 0)

引用 API: `KERNEL32.dll!GetProcessHeap`, `KERNEL32.dll!HeapFree`, `KERNEL32.dll!Sleep`, `WS2_32.dll!WSACleanup`

```asm
00572BC0  push     ebp
00572BC1  mov      ebp, esp
00572BC3  push     -1
00572BC5  push     0x773f0b
00572BCA  mov      eax, dword ptr fs:[0]
00572BD0  push     eax
00572BD1  sub      esp, 0xc0
00572BD7  mov      eax, dword ptr [0x898e24]
00572BDC  xor      eax, ebp
00572BDE  mov      dword ptr [ebp - 0x14], eax
00572BE1  push     ebx
00572BE2  push     esi
00572BE3  push     edi
00572BE4  push     eax
00572BE5  lea      eax, [ebp - 0xc]
00572BE8  mov      dword ptr fs:[0], eax
00572BEE  mov      dword ptr [ebp - 0x10], esp
00572BF1  mov      ebx, ecx
00572BF3  lea      ecx, [ebp - 0xb0]
00572BF9  mov      dword ptr [ebp - 0x7c], 0
00572C00  mov      dword ptr [ebp - 4], 0
00572C07  call     0x571090   ; -> sub_571090 [func-start]
00572C0C  push     0x2a30
00572C11  push     eax
00572C12  lea      ecx, [ebp - 0x30]
00572C15  call     0x571230   ; -> sub_571230 [func-start]
```

### [network_winsock] 0x005734DF (RVA 0x1734DF, ≈0x11 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
005734DF  adc      byte ptr [ebp - 0x333cff88], al
005734E5  int3     
005734E6  int3     
005734E7  int3     
005734E8  int3     
005734E9  int3     
005734EA  int3     
005734EB  int3     
005734EC  int3     
005734ED  int3     
005734EE  int3     
005734EF  int3     
005734F0  push     ebp
005734F1  mov      ebp, esp
005734F3  and      esp, 0xfffffff8
005734F6  sub      esp, 0x1a0
005734FC  mov      eax, dword ptr [0x898e24]
00573501  xor      eax, esp
00573503  mov      dword ptr [esp + 0x19c], eax
0057350A  push     esi
0057350B  push     edi
0057350C  mov      esi, ecx
0057350E  mov      eax, 1
00573513  lock xadd dword ptr [0x8dc81c], eax
0057351B  inc      eax
0057351C  mov      edi, 0x8dc820
```

### [network_winsock] 0x005734F0 (RVA 0x1734F0, ≈0xa0 bytes, 入度 0)

引用 API: `KERNEL32.dll!TlsSetValue`, `WS2_32.dll!WSAStartup`

```asm
005734F0  push     ebp
005734F1  mov      ebp, esp
005734F3  and      esp, 0xfffffff8
005734F6  sub      esp, 0x1a0
005734FC  mov      eax, dword ptr [0x898e24]
00573501  xor      eax, esp
00573503  mov      dword ptr [esp + 0x19c], eax
0057350A  push     esi
0057350B  push     edi
0057350C  mov      esi, ecx
0057350E  mov      eax, 1
00573513  lock xadd dword ptr [0x8dc81c], eax
0057351B  inc      eax
0057351C  mov      edi, 0x8dc820
00573521  cmp      eax, 1
00573524  jne      0x573535
00573526  lea      eax, [esp + 0x10]
0057352A  push     eax
0057352B  push     2
0057352D  call     dword ptr [0x78850c]   ; IAT:WS2_32.dll!WSAStartup
00573533  xchg     dword ptr [edi], eax
00573535  cmp      byte ptr [ebp + 8], 0
00573539  je       0x573545
0057353B  xor      eax, eax
0057353D  lock xadd dword ptr [edi], eax
00573541  test     eax, eax
```

### [network_winsock] 0x00576750 (RVA 0x176750, ≈0xf0 bytes, 入度 0)

引用 API: `WS2_32.dll!ntohs`

```asm
00576750  push     ebp
00576751  mov      ebp, esp
00576753  push     esi
00576754  mov      esi, dword ptr [ebp + 8]
00576757  cmp      dword ptr [esi + 8], 0
0057675B  je       0x57677d
0057675D  call     0x6dbee0   ; -> sub_6DBEE0 [func-start]
00576762  cmp      dword ptr [esi + 0xc], eax
00576765  jne      0x576770
00576767  cmp      dword ptr [esi + 8], 0x2738
0057676E  je       0x57677d
00576770  mov      eax, dword ptr [esi]
00576772  mov      ecx, 0xffff
00576777  pop      esi
00576778  mov      word ptr [eax], cx
0057677B  pop      ebp
0057677C  ret      
0057677D  mov      eax, dword ptr [esi + 4]
00576780  cmp      word ptr [eax], 2
00576784  movzx    eax, word ptr [eax + 2]
00576788  push     eax
00576789  call     dword ptr [0x7884e8]   ; IAT:WS2_32.dll!ntohs
0057678F  movzx    ecx, ax
00576792  mov      eax, dword ptr [esi]
00576794  pop      esi
00576795  mov      word ptr [eax], cx
```

### [network_winsock] 0x00576980 (RVA 0x176980, ≈0x180 bytes, 入度 0)

引用 API: `WS2_32.dll!htonl`, `WS2_32.dll!ntohl`, `WS2_32.dll!ntohs`

```asm
00576980  push     ebp
00576981  mov      ebp, esp
00576983  sub      esp, 0x44
00576986  mov      eax, dword ptr [0x898e24]
0057698B  xor      eax, ebp
0057698D  mov      dword ptr [ebp - 4], eax
00576990  push     ebx
00576991  mov      ebx, edx
00576993  mov      edx, dword ptr [0x7884f0]
00576999  push     esi
0057699A  push     edi
0057699B  mov      edi, ecx
0057699D  cmp      word ptr [ebx], 2
005769A1  jne      0x5769c1
005769A3  push     dword ptr [ebx + 4]
005769A6  call     edx
005769A8  push     eax
005769A9  call     dword ptr [0x7884ec]   ; IAT:WS2_32.dll!htonl
005769AF  mov      edx, dword ptr [0x7884f0]
005769B5  xor      esi, esi
005769B7  mov      ecx, eax
005769B9  mov      dword ptr [ebp - 8], esi
005769BC  xorps    xmm0, xmm0
005769BF  jmp      0x5769d2
005769C1  mov      eax, dword ptr [ebx + 0x18]
005769C4  mov      esi, 1
```

### [network_winsock] 0x00577E40 (RVA 0x177E40, ≈0x1b0 bytes, 入度 0)

引用 API: `KERNEL32.dll!SetEvent`, `KERNEL32.dll!SleepEx`, `WS2_32.dll!WSAGetLastError`

```asm
00577E40  push     ebp
00577E41  mov      ebp, esp
00577E43  push     -1
00577E45  push     0x7745b8
00577E4A  mov      eax, dword ptr fs:[0]
00577E50  push     eax
00577E51  push     ebx
00577E52  push     esi
00577E53  mov      eax, dword ptr [0x898e24]
00577E58  xor      eax, ebp
00577E5A  push     eax
00577E5B  lea      eax, [ebp - 0xc]
00577E5E  mov      dword ptr fs:[0], eax
00577E64  mov      ebx, dword ptr [ebp + 8]
00577E67  mov      dword ptr [ebp + 8], ebx
00577E6A  mov      dword ptr [ebp - 4], 0
00577E71  push     dword ptr [ebx + 4]
00577E74  call     dword ptr [0x788138]   ; IAT:KERNEL32.dll!SetEvent
00577E7A  mov      eax, dword ptr [ebx]
00577E7C  mov      ecx, ebx
00577E7E  call     dword ptr [eax + 4]
00577E81  mov      eax, dword ptr [ebx]
00577E83  mov      ecx, ebx
00577E85  mov      esi, dword ptr [ebx + 8]
00577E88  push     1
00577E8A  call     dword ptr [eax]
```

### [network_winsock] 0x00577FF0 (RVA 0x177FF0, ≈0x80 bytes, 入度 0)

引用 API: `WS2_32.dll!WSASetLastError`, `WS2_32.dll!freeaddrinfo`, `WS2_32.dll!getaddrinfo`

```asm
00577FF0  push     ebp
00577FF1  mov      ebp, esp
00577FF3  and      esp, 0xfffffff8
00577FF6  sub      esp, 0xc
00577FF9  push     ebx
00577FFA  push     esi
00577FFB  push     edi
00577FFC  mov      edi, edx
00577FFE  mov      ebx, ecx
00578000  test     edi, edi
00578002  je       0x578009
00578004  cmp      byte ptr [edi], 0
00578007  jne      0x57800b
00578009  xor      edi, edi
0057800B  mov      esi, dword ptr [ebp + 8]
0057800E  test     esi, esi
00578010  je       0x578017
00578012  cmp      byte ptr [esi], 0
00578015  jne      0x578019
00578017  xor      esi, esi
00578019  push     0
0057801B  call     dword ptr [0x788508]   ; IAT:WS2_32.dll!WSASetLastError
00578021  push     dword ptr [ebp + 0x10]
00578024  push     dword ptr [ebp + 0xc]
00578027  push     esi
00578028  push     edi
```

### [network_winsock] 0x00578170 (RVA 0x178170, ≈0xe0 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!DeleteCriticalSection`, `WS2_32.dll!WSACleanup`

```asm
00578170  push     ebp
00578171  mov      ebp, esp
00578173  push     -1
00578175  push     0x764036
0057817A  mov      eax, dword ptr fs:[0]
00578180  push     eax
00578181  push     ecx
00578182  push     ebx
00578183  push     esi
00578184  push     edi
00578185  mov      eax, dword ptr [0x898e24]
0057818A  xor      eax, ebp
0057818C  push     eax
0057818D  lea      eax, [ebp - 0xc]
00578190  mov      dword ptr fs:[0], eax
00578196  mov      esi, ecx
00578198  call     0x578250   ; -> sub_578250 [func-start]
0057819D  mov      edi, dword ptr [esi + 0x28]
005781A0  test     edi, edi
005781A2  je       0x5781b8
005781A4  push     dword ptr [edi + 4]
005781A7  call     dword ptr [0x7881dc]   ; IAT:KERNEL32.dll!CloseHandle
005781AD  push     0xc
005781AF  push     edi
005781B0  call     0x6e1935   ; -> sub_6E1935 [func-start]
005781B5  add      esp, 8
```

### [network_winsock] 0x00579CA0 (RVA 0x179CA0, ≈0xc0 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00579CA0  push     ebp
00579CA1  mov      ebp, esp
00579CA3  add      ecx, 0x14
00579CA6  pop      ebp
00579CA7  jmp      0x578310   ; -> sub_578310 [func-start]
00579CAC  int3     
00579CAD  int3     
00579CAE  int3     
00579CAF  int3     
00579CB0  add      ecx, 0x14
00579CB3  jmp      0x578250   ; -> sub_578250 [func-start]
00579CB8  int3     
00579CB9  int3     
00579CBA  int3     
00579CBB  int3     
00579CBC  int3     
00579CBD  int3     
00579CBE  int3     
00579CBF  int3     
00579CC0  push     esi
00579CC1  mov      esi, ecx
00579CC3  push     edi
00579CC4  mov      edi, dword ptr [esi]
00579CC6  test     edi, edi
00579CC8  je       0x579d03
00579CCA  push     ebx
```

### [network_winsock] 0x00579F00 (RVA 0x179F00, ≈0x270 bytes, 入度 0)

引用 API: `WS2_32.dll!freeaddrinfo`

```asm
00579F00  push     ebp
00579F01  mov      ebp, esp
00579F03  push     -1
00579F05  push     0x7748f1
00579F0A  mov      eax, dword ptr fs:[0]
00579F10  push     eax
00579F11  sub      esp, 0x8c
00579F17  mov      eax, dword ptr [0x898e24]
00579F1C  xor      eax, ebp
00579F1E  mov      dword ptr [ebp - 0x10], eax
00579F21  push     ebx
00579F22  push     esi
00579F23  push     edi
00579F24  push     eax
00579F25  lea      eax, [ebp - 0xc]
00579F28  mov      dword ptr fs:[0], eax
00579F2E  mov      eax, dword ptr [ebp + 0x14]
00579F31  mov      ebx, dword ptr [ebp + 0x10]
00579F34  mov      ecx, ebx
00579F36  mov      edi, dword ptr [ebp + 8]
00579F39  mov      dword ptr [ebp - 0x7c], eax
00579F3C  lea      eax, [ebp - 0x70]
00579F3F  mov      dword ptr [ebp - 0x80], 0
00579F46  push     eax
00579F47  mov      dword ptr [ebp - 0x78], edi
00579F4A  mov      dword ptr [ebp - 0x74], 0
```

### [network_winsock] 0x00784D8F (RVA 0x384D8F, ≈0x80 bytes, 入度 0)

引用 API: `KERNEL32.dll!TlsFree`, `WS2_32.dll!WSACleanup`

```asm
00784D8F  adc      byte ptr [ebp - 0x333cff88], al
00784D95  int3     
00784D96  int3     
00784D97  int3     
00784D98  int3     
00784D99  int3     
00784D9A  int3     
00784D9B  int3     
00784D9C  int3     
00784D9D  int3     
00784D9E  int3     
00784D9F  int3     
00784DA0  push     dword ptr [0x8dfa80]
00784DA6  call     dword ptr [0x7882a4]   ; IAT:KERNEL32.dll!TlsFree
00784DAC  ret      
00784DAD  int3     
00784DAE  int3     
00784DAF  int3     
00784DB0  push     dword ptr [0x8dfa7c]
00784DB6  call     dword ptr [0x7882a4]   ; IAT:KERNEL32.dll!TlsFree
00784DBC  ret      
00784DBD  int3     
00784DBE  int3     
00784DBF  int3     
00784DC0  jmp      0x408f50
00784DC5  int3     
```

### [network_winsock] 0x00784E0F (RVA 0x384E0F, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00784E0F  adc      byte ptr [ebp - 0x333cff88], al
00784E15  int3     
00784E16  int3     
00784E17  int3     
00784E18  int3     
00784E19  int3     
00784E1A  int3     
00784E1B  int3     
00784E1C  int3     
00784E1D  int3     
00784E1E  int3     
00784E1F  int3     
00784E20  or       eax, 0xffffffff
00784E23  lock xadd dword ptr [0x8dc81c], eax
00784E2B  jne      0x784e33
00784E2D  jmp      dword ptr [0x788510]   ; IAT:WS2_32.dll!WSACleanup
00784E33  ret      
00784E34  int3     
00784E35  int3     
00784E36  int3     
00784E37  int3     
00784E38  int3     
00784E39  int3     
00784E3A  int3     
00784E3B  int3     
00784E3C  int3     
```

### [network_winsock] 0x00784E2F (RVA 0x384E2F, ≈0x30 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00784E2F  adc      byte ptr [ebp - 0x333cff88], al
00784E35  int3     
00784E36  int3     
00784E37  int3     
00784E38  int3     
00784E39  int3     
00784E3A  int3     
00784E3B  int3     
00784E3C  int3     
00784E3D  int3     
00784E3E  int3     
00784E3F  int3     
00784E40  jmp      0x408f50
00784E45  int3     
00784E46  int3     
00784E47  int3     
00784E48  int3     
00784E49  int3     
00784E4A  int3     
00784E4B  int3     
00784E4C  int3     
00784E4D  int3     
00784E4E  int3     
00784E4F  int3     
00784E50  or       eax, 0xffffffff
00784E53  lock xadd dword ptr [0x8dc81c], eax
```

### [network_winsock] 0x00784E5F (RVA 0x384E5F, ≈0x20 bytes, 入度 0)

引用 API: `WS2_32.dll!WSACleanup`

```asm
00784E5F  adc      byte ptr [ebp - 0x333cff88], al
00784E65  int3     
00784E66  int3     
00784E67  int3     
00784E68  int3     
00784E69  int3     
00784E6A  int3     
00784E6B  int3     
00784E6C  int3     
00784E6D  int3     
00784E6E  int3     
00784E6F  int3     
00784E70  or       eax, 0xffffffff
00784E73  lock xadd dword ptr [0x8dc81c], eax
00784E7B  jne      0x784e83
00784E7D  jmp      dword ptr [0x788510]   ; IAT:WS2_32.dll!WSACleanup
00784E83  ret      
00784E84  int3     
00784E85  int3     
00784E86  int3     
00784E87  int3     
00784E88  int3     
00784E89  int3     
00784E8A  int3     
00784E8B  int3     
00784E8C  int3     
```

### [network_winsock] 0x00784E7F (RVA 0x384E7F, ≈0x211 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `WS2_32.dll!WSACleanup`

```asm
00784E7F  adc      byte ptr [ebp - 0x333cff88], al
00784E85  int3     
00784E86  int3     
00784E87  int3     
00784E88  int3     
00784E89  int3     
00784E8A  int3     
00784E8B  int3     
00784E8C  int3     
00784E8D  int3     
00784E8E  int3     
00784E8F  int3     
00784E90  cmp      dword ptr [0x8dc028], 0x10
00784E97  jb       0x784ec2
00784E99  push     esi
00784E9A  mov      esi, dword ptr [0x8dc014]
00784EA0  mov      ecx, 0x8dc014
00784EA5  push     0x8dc014
00784EAA  call     0x408f70
00784EAF  mov      eax, dword ptr [0x8dc028]
00784EB4  mov      ecx, 0x8dc014
00784EB9  inc      eax
00784EBA  push     eax
00784EBB  push     esi
00784EBC  call     0x412010   ; -> sub_412010 [func-start]
00784EC1  pop      esi
```

### [api_ref_function] 0x00408BE0 (RVA 0x8BE0, ≈0x1e0 bytes, 入度 0)

引用 API: `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!GetProcAddress`, `KERNEL32.dll!InitializeSListHead`, `KERNEL32.dll!QueryPerformanceCounter`, `KERNEL32.dll!QueryPerformanceFrequency`

```asm
00408BE0  push     ebp
00408BE1  mov      ebp, esp
00408BE3  push     -1
00408BE5  push     0x77edf6
00408BEA  mov      eax, dword ptr fs:[0]
00408BF0  push     eax
00408BF1  mov      eax, dword ptr [0x898e24]
00408BF6  xor      eax, ebp
00408BF8  push     eax
00408BF9  lea      eax, [ebp - 0xc]
00408BFC  mov      dword ptr fs:[0], eax
00408C02  mov      eax, dword ptr fs:[0x2c]
00408C08  mov      ecx, dword ptr [0x8d9efc]
00408C0E  mov      dword ptr [ebp - 4], 0
00408C15  mov      ecx, dword ptr [eax + ecx*4]
00408C18  mov      eax, dword ptr [0x8d9b24]
00408C1D  cmp      eax, dword ptr [ecx + 4]
00408C23  jle      0x408c5c
00408C25  push     0x8d9b24
00408C2A  call     0x6e14a7   ; -> sub_6E14A7 [func-start]
00408C2F  add      esp, 4
00408C32  cmp      dword ptr [0x8d9b24], -1
00408C39  jne      0x408c5c
00408C3B  push     0x786f50
00408C40  mov      dword ptr [0x898e08], 0x7cd440
00408C4A  call     0x6e1918   ; -> sub_6E1918 [func-start]
```

### [api_ref_function] 0x00409AA0 (RVA 0x9AA0, ≈0x80 bytes, 入度 0)

引用 API: `KERNEL32.dll!CreateEventA`

```asm
00409AA0  push     ebp
00409AA1  mov      ebp, esp
00409AA3  push     -1
00409AA5  push     0x763598
00409AAA  mov      eax, dword ptr fs:[0]
00409AB0  push     eax
00409AB1  sub      esp, 0x30
00409AB4  mov      eax, dword ptr [0x898e24]
00409AB9  xor      eax, ebp
00409ABB  mov      dword ptr [ebp - 0x10], eax
00409ABE  push     eax
00409ABF  lea      eax, [ebp - 0xc]
00409AC2  mov      dword ptr fs:[0], eax
00409AC8  mov      eax, dword ptr [ebp + 0xc]
00409ACB  mov      ecx, dword ptr [ebp + 8]
00409ACE  push     0
00409AD0  push     eax
00409AD1  push     ecx
00409AD2  push     0
00409AD4  call     dword ptr [0x7881f8]   ; IAT:KERNEL32.dll!CreateEventA
00409ADA  test     eax, eax
00409ADC  jne      0x409b04
00409ADE  push     0x7e29d4
00409AE3  push     0xb
00409AE5  lea      ecx, [ebp - 0x3c]
00409AE8  call     0x409a30   ; -> sub_409A30 [func-start]
```

### [api_ref_function] 0x00409B20 (RVA 0x9B20, ≈0x80 bytes, 入度 0)

引用 API: `KERNEL32.dll!CreateSemaphoreA`

```asm
00409B20  push     ebp
00409B21  mov      ebp, esp
00409B23  push     -1
00409B25  push     0x763598
00409B2A  mov      eax, dword ptr fs:[0]
00409B30  push     eax
00409B31  sub      esp, 0x30
00409B34  mov      eax, dword ptr [0x898e24]
00409B39  xor      eax, ebp
00409B3B  mov      dword ptr [ebp - 0x10], eax
00409B3E  push     eax
00409B3F  lea      eax, [ebp - 0xc]
00409B42  mov      dword ptr fs:[0], eax
00409B48  push     0
00409B4A  push     0x7fffffff
00409B4F  push     0
00409B51  push     0
00409B53  call     dword ptr [0x7881fc]   ; IAT:KERNEL32.dll!CreateSemaphoreA
00409B59  test     eax, eax
00409B5B  jne      0x409b83
00409B5D  push     0x7e29d4
00409B62  push     0xb
00409B64  lea      ecx, [ebp - 0x3c]
00409B67  call     0x409a30   ; -> sub_409A30 [func-start]
00409B6C  mov      dword ptr [ebp - 0x3c], 0x7de4fc
00409B73  lea      eax, [ebp - 0x3c]
```

### [api_ref_function] 0x00409BA0 (RVA 0x9BA0, ≈0xb0 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!WaitForSingleObjectEx`

```asm
00409BA0  push     ebp
00409BA1  mov      ebp, esp
00409BA3  push     ecx
00409BA4  push     ebx
00409BA5  push     esi
00409BA6  push     edi
00409BA7  mov      edi, ecx
00409BA9  lock bts dword ptr [edi], 0x1f
00409BAE  setae    al
00409BB1  test     al, al
00409BB3  jne      0x409c49
00409BB9  mov      eax, dword ptr [edi]
00409BBB  mov      dword ptr [ebp - 4], eax
00409BBE  lea      eax, [ebp - 4]
00409BC1  push     eax
00409BC2  call     0x409c50   ; -> sub_409C50 [func-start]
00409BC7  test     dword ptr [ebp - 4], 0x80000000
00409BCE  je       0x409c49
00409BD0  mov      ebx, dword ptr [edi + 4]
00409BD3  lea      esi, [edi + 4]
00409BD6  test     ebx, ebx
00409BD8  jne      0x409bff
00409BDA  push     ebx
00409BDB  push     ebx
00409BDC  call     0x409aa0   ; -> sub_409AA0 [func-start]
00409BE1  mov      edx, eax
```

### [api_ref_function] 0x00409C50 (RVA 0x9C50, ≈0xb0 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
00409C50  push     ebp
00409C51  mov      ebp, esp
00409C53  push     esi
00409C54  mov      esi, dword ptr [ebp + 8]
00409C57  push     edi
00409C58  mov      edi, ecx
00409C5A  push     ebx
00409C5B  nop      dword ptr [eax + eax]
00409C60  mov      eax, dword ptr [esi]
00409C62  mov      ebx, eax
00409C64  shr      ebx, 0x1f
00409C67  test     bl, bl
00409C69  je       0x409c70
00409C6B  lea      ecx, [eax + 1]
00409C6E  jmp      0x409c78
00409C70  mov      ecx, eax
00409C72  or       ecx, 0x80000000
00409C78  mov      edx, ecx
00409C7A  lock cmpxchg dword ptr [edi], edx
00409C7E  cmp      eax, dword ptr [esi]
00409C80  je       0x409c86
00409C82  mov      dword ptr [esi], eax
00409C84  jmp      0x409c60
00409C86  test     bl, bl
00409C88  pop      ebx
00409C89  je       0x409c8d
```

### [api_ref_function] 0x00409D00 (RVA 0x9D00, ≈0x110 bytes, 入度 0)

引用 API: `KERNEL32.dll!CreateSemaphoreA`, `KERNEL32.dll!ReleaseSemaphore`

```asm
00409D00  push     ebp
00409D01  mov      ebp, esp
00409D03  push     -1
00409D05  push     0x7635d0
00409D0A  mov      eax, dword ptr fs:[0]
00409D10  push     eax
00409D11  sub      esp, 0x30
00409D14  mov      eax, dword ptr [0x898e24]
00409D19  xor      eax, ebp
00409D1B  mov      dword ptr [ebp - 0x10], eax
00409D1E  push     esi
00409D1F  push     eax
00409D20  lea      eax, [ebp - 0xc]
00409D23  mov      dword ptr fs:[0], eax
00409D29  call     0x409b20   ; -> sub_409B20 [func-start]
00409D2E  mov      esi, dword ptr [0x7881fc]
00409D34  push     0
00409D36  push     0x7fffffff
00409D3B  push     0
00409D3D  push     0
00409D3F  mov      dword ptr [0x8db138], eax
00409D44  call     esi
00409D46  mov      dword ptr [0x8db13c], eax
00409D4B  push     0
00409D4D  push     0x7fffffff
00409D52  test     eax, eax
```

### [api_ref_function] 0x00409E10 (RVA 0x9E10, ≈0x260 bytes, 入度 0)

引用 API: `KERNEL32.dll!ReleaseSemaphore`, `KERNEL32.dll!WaitForSingleObjectEx`

```asm
00409E10  push     ebp
00409E11  mov      ebp, esp
00409E13  push     -1
00409E15  push     0x763610
00409E1A  mov      eax, dword ptr fs:[0]
00409E20  push     eax
00409E21  sub      esp, 0x60
00409E24  mov      eax, dword ptr [0x898e24]
00409E29  xor      eax, ebp
00409E2B  mov      dword ptr [ebp - 0x10], eax
00409E2E  push     ebx
00409E2F  push     esi
00409E30  push     edi
00409E31  push     eax
00409E32  lea      eax, [ebp - 0xc]
00409E35  mov      dword ptr fs:[0], eax
00409E3B  mov      edi, ecx
00409E3D  mov      ebx, dword ptr [ebp + 8]
00409E40  mov      esi, dword ptr [edi]
00409E42  test     esi, 0x400000
00409E48  jne      0x409e8d
00409E4A  cmp      esi, 0x80000000
00409E50  jae      0x409e8d
00409E52  lea      ecx, [esi + 1]
00409E55  xor      ecx, esi
00409E57  and      ecx, 0x7ff
```

### [api_ref_function] 0x0040A850 (RVA 0xA850, ≈0xf0 bytes, 入度 0)

引用 API: `KERNEL32.dll!EnterCriticalSection`, `KERNEL32.dll!LeaveCriticalSection`

```asm
0040A850  push     ebp
0040A851  mov      ebp, esp
0040A853  push     -1
0040A855  push     0x763746
0040A85A  mov      eax, dword ptr fs:[0]
0040A860  push     eax
0040A861  sub      esp, 0x64
0040A864  mov      eax, dword ptr [0x898e24]
0040A869  xor      eax, ebp
0040A86B  mov      dword ptr [ebp - 0x10], eax
0040A86E  push     esi
0040A86F  push     eax
0040A870  lea      eax, [ebp - 0xc]
0040A873  mov      dword ptr fs:[0], eax
0040A879  mov      esi, ecx
0040A87B  lea      eax, [ebp - 0x70]
0040A87E  mov      dword ptr [ebp - 0x20], 0xa
0040A885  mov      dword ptr [ebp - 0x1c], eax
0040A888  mov      dword ptr [ebp - 0x18], 0
0040A88F  mov      dword ptr [ebp - 4], 0
0040A896  mov      dword ptr [ebp - 0x14], esi
0040A899  mov      eax, dword ptr [esi]
0040A89B  mov      edx, dword ptr [eax + 8]
0040A89E  cmp      eax, 0x7e2f10
0040A8A3  jne      0x40a8b0
0040A8A5  push     dword ptr [esi + 0x1c]
```

### [api_ref_function] 0x0040A9C0 (RVA 0xA9C0, ≈0x80 bytes, 入度 0)

引用 API: `KERNEL32.dll!LeaveCriticalSection`

```asm
0040A9C0  push     ebp
0040A9C1  mov      ebp, esp
0040A9C3  push     -1
0040A9C5  push     0x763676
0040A9CA  mov      eax, dword ptr fs:[0]
0040A9D0  push     eax
0040A9D1  push     esi
0040A9D2  mov      eax, dword ptr [0x898e24]
0040A9D7  xor      eax, ebp
0040A9D9  push     eax
0040A9DA  lea      eax, [ebp - 0xc]
0040A9DD  mov      dword ptr fs:[0], eax
0040A9E3  mov      esi, ecx
0040A9E5  mov      dword ptr [ebp - 4], 0
0040A9EC  mov      ecx, dword ptr [esi + 0x5c]
0040A9EF  mov      eax, dword ptr [ecx]
0040A9F1  cmp      eax, 0x7e2f10
0040A9F6  jne      0x40aa03
0040A9F8  push     dword ptr [ecx + 0x1c]
0040A9FB  call     dword ptr [0x788140]   ; IAT:KERNEL32.dll!LeaveCriticalSection
0040AA01  jmp      0x40aa06
0040AA03  call     dword ptr [eax + 0xc]
0040AA06  cmp      dword ptr [esi + 0x54], 0
0040AA0A  je       0x40aa2d
0040AA0C  mov      eax, dword ptr [esi + 0x58]
0040AA0F  test     eax, eax
```

### [api_ref_function] 0x0040ACA0 (RVA 0xACA0, ≈0x70 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
0040ACA0  push     ebp
0040ACA1  mov      ebp, esp
0040ACA3  push     -1
0040ACA5  push     0x763706
0040ACAA  mov      eax, dword ptr fs:[0]
0040ACB0  push     eax
0040ACB1  mov      eax, dword ptr [0x898e24]
0040ACB6  xor      eax, ebp
0040ACB8  push     eax
0040ACB9  lea      eax, [ebp - 0xc]
0040ACBC  mov      dword ptr fs:[0], eax
0040ACC2  mov      dword ptr [ebp - 4], 0
0040ACC9  mov      eax, dword ptr [ecx + 4]
0040ACCC  mov      dword ptr [ecx], 0x842854
0040ACD2  cmp      dword ptr [0x8db1ec], 0
0040ACD9  jne      0x40ace0
0040ACDB  call     0x6c3a7e   ; -> sub_6C3A7E [func-start]
0040ACE0  cmp      eax, -1
0040ACE3  je       0x40acfa
0040ACE5  cmp      dword ptr [0x8db23c], 0
0040ACEC  jne      0x40acf3
0040ACEE  call     0x6c3a7e   ; -> sub_6C3A7E [func-start]
0040ACF3  push     eax
0040ACF4  call     dword ptr [0x7881dc]   ; IAT:KERNEL32.dll!CloseHandle
0040ACFA  mov      ecx, dword ptr [ebp - 0xc]
0040ACFD  mov      dword ptr fs:[0], ecx
```

### [api_ref_function] 0x0040AD90 (RVA 0xAD90, ≈0x90 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
0040AD90  push     ebp
0040AD91  mov      ebp, esp
0040AD93  push     -1
0040AD95  push     0x763676
0040AD9A  mov      eax, dword ptr fs:[0]
0040ADA0  push     eax
0040ADA1  push     esi
0040ADA2  mov      eax, dword ptr [0x898e24]
0040ADA7  xor      eax, ebp
0040ADA9  push     eax
0040ADAA  lea      eax, [ebp - 0xc]
0040ADAD  mov      dword ptr fs:[0], eax
0040ADB3  mov      esi, ecx
0040ADB5  mov      dword ptr [ebp - 4], 0
0040ADBC  mov      eax, dword ptr [esi + 4]
0040ADBF  mov      dword ptr [esi], 0x842854
0040ADC5  cmp      dword ptr [0x8db1ec], 0
0040ADCC  jne      0x40add3
0040ADCE  call     0x6c3a7e   ; -> sub_6C3A7E [func-start]
0040ADD3  cmp      eax, -1
0040ADD6  je       0x40aded
0040ADD8  cmp      dword ptr [0x8db23c], 0
0040ADDF  jne      0x40ade6
0040ADE1  call     0x6c3a7e   ; -> sub_6C3A7E [func-start]
0040ADE6  push     eax
0040ADE7  call     dword ptr [0x7881dc]   ; IAT:KERNEL32.dll!CloseHandle
```

### [api_ref_function] 0x0040BC90 (RVA 0xBC90, ≈0x20 bytes, 入度 0)

引用 API: `KERNEL32.dll!CloseHandle`

```asm
0040BC90  push     ebp
0040BC91  mov      ebp, esp
0040BC93  mov      eax, dword ptr [ebp + 8]
0040BC96  cmp      eax, -1
0040BC99  je       0x40bca2
0040BC9B  push     eax
0040BC9C  call     dword ptr [0x7881dc]   ; IAT:KERNEL32.dll!CloseHandle
0040BCA2  pop      ebp
0040BCA3  ret      
0040BCA4  int3     
0040BCA5  int3     
0040BCA6  int3     
0040BCA7  int3     
0040BCA8  int3     
0040BCA9  int3     
0040BCAA  int3     
0040BCAB  int3     
0040BCAC  int3     
0040BCAD  int3     
0040BCAE  int3     
0040BCAF  int3     
0040BCB0  push     ebp
0040BCB1  mov      ebp, esp
0040BCB3  push     -1
0040BCB5  push     0x7638eb
0040BCBA  mov      eax, dword ptr fs:[0]
```

### 高入度调用枢纽 (top call-magnet)

| RVA | VA | 入度 |
|---|---|---|

## 9. Rich 编译器头

- prod_id=15834292 build=48 ×1
- prod_id=15965364 build=185 ×1
- prod_id=15899828 build=46 ×1
- prod_id=17127909 build=2 ×1
- prod_id=13082782 build=1 ×1
- prod_id=16997947 build=32 ×1
- prod_id=17129019 build=120 ×1
- prod_id=17063483 build=41 ×1
- prod_id=10244818 build=4 ×1
- prod_id=17062866 build=22 ×1
- prod_id=17128814 build=63 ×1
- prod_id=17128402 build=51 ×1
- prod_id=13561446 build=1 ×1
- prod_id=17063570 build=7 ×1
- prod_id=13495910 build=2 ×1
- prod_id=17129106 build=65 ×1
- prod_id=13631453 build=2 ×1
- prod_id=13696989 build=3 ×1
- prod_id=13369309 build=37 ×1
- prod_id=65536 build=364 ×1
- prod_id=17391250 build=335 ×1
- prod_id=16735890 build=1 ×1
- prod_id=16932498 build=1 ×1

## 10. 字符串分析

按编码计数(节内扫描): ASCII=14804, SJIS(CP932)=26850, UTF-16LE=866

### 文件引用(资源/存档/配置) (59 条)

- `If you can reproduce this, please email bugs@continuousphysics.com` [.rdata]
- `.global.nut` [.rdata]
- `/fonts/msgothic.ttc` [.rdata]
- `001.000` [.rdata]
- `001.001` [.rdata]
- `001.002` [.rdata]
- `001.003` [.rdata]
- `T#T.Tk` [.rdata]
- `kernel32.dll` [.rdata]
- `cmd.exe` [.rdata]
- `Day of month value is out of range 1..31` [.rdata]
- `Month number is out of range 1..12` [.rdata]
- `data/script/boot.nut` [.rdata]
- `ss/%05d.png` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/exception/detail/exception_ptr.hpp` [.rdata]
- `Microsoft (R) HLSL Shader Compiler 9.29.952.3111` [.rdata]
- `DXBC.SD` [.rdata]
- `.crash.bmp` [.rdata]
- `th155.pak` [.rdata]
- `th155b.pak` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/multiprecision/detail/number_base.hpp` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/multiprecision/detail/integer_ops.hpp` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/multiprecision/cpp_int/divide.hpp` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/multiprecision/cpp_int/misc.hpp` [.rdata]
- `1.6.10` [.rdata]
- `POS   :%7.1f,%7.1f,%7.1f` [.rdata]
- `NEAR  : %5.1f  FAR: %7.1f` [.rdata]
- `Eye   :%5.2f,%5.2f,%5.2f, Length:%0.0f` [.rdata]
- `TAR   :%7.1f,%7.1f,%7.1f` [.rdata]
- `Up    :%5.2f,%5.2f,%5.2f, Roll:%0.0f` [.rdata]
- `Right :%5.2f,%5.2f,%5.2f` [.rdata]
- `ntdll.dll` [.rdata]
- `1.6.12` [.rdata]
- `asio.misc` [.rdata]
- `255.255.255.255` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/uuid/string_generator.hpp` [.rdata]
- `D:\Works\libs_cpp\boost_1_61_0\boost/uuid/sha1.hpp` [.rdata]
- `KERNEL32.DLL` [.rdata]
- `D:\Works\th155\th155.pdb` [.rdata]
- `WINMM.dll` [.rdata]
- `IMM32.dll` [.rdata]
- `d3dx11_43.dll` [.rdata]
- `d3dx9_43.dll` [.rdata]
- `KERNEL32.dll` [.rdata]
- `USER32.dll` [.rdata]
- `GDI32.dll` [.rdata]
- `ADVAPI32.dll` [.rdata]
- `SHELL32.dll` [.rdata]
- `ole32.dll` [.rdata]
- `OLEAUT32.dll` [.rdata]
- `WINTRUST.dll` [.rdata]
- `VERSION.dll` [.rdata]
- `dbghelp.dll` [.rdata]
- `DINPUT8.dll` [.rdata]
- `XINPUT9_1_0.dll` [.rdata]
- `d3d11.dll` [.rdata]
- `DSOUND.dll` [.rdata]
- `WS2_32.dll` [.rdata]
- `1 1'1.142` [.reloc]

### 网络对战模块 (80 条)

- `class instances do not support the new slot operator` [.rdata]
- `network down` [.rdata]
- `network reset` [.rdata]
- `network unreachable` [.rdata]
- `not a socket` [.rdata]
- `not connected` [.rdata]
- `not supported` [.rdata]
- `operation not supported` [.rdata]
- `protocol not supported` [.rdata]
- `address family not supported` [.rdata]
- `already connected` [.rdata]
- `connection aborted` [.rdata]
- `connection already in progress` [.rdata]
- `connection refused` [.rdata]
- `connection reset` [.rdata]
- `function not supported` [.rdata]
- `host unreachable` [.rdata]
- `ConnectRenderSlot` [.rdata]
- `DisconnectRenderSlot` [.rdata]
- `ConnectCamera` [.rdata]
- `DisconnectChild` [.rdata]
- `ConnectRequest` [.rdata]
- `NetworkServer` [.rdata]
- `Connect` [.rdata]
- `GetConnectState` [.rdata]
- `Reconnect` [.rdata]
- `ConnectComplete` [.rdata]
- `DisconnectParent` [.rdata]
- `ConnectReject` [.rdata]
- `NetworkClient` [.rdata]
- `InterfaceObject_IHostEnvironment` [.rdata]
- `unsupported zlib version` [.rdata]
- `libpng does not support gamma+background+rgb_to_gray` [.rdata]
- `MeshVertex::ReadVertex error 32bit index no support` [.rdata]
- `ScreenToClient` [.rdata]
- `GetClientRect` [.rdata]
- `CreateIoCompletionPort` [.rdata]
- `WSASocketW` [.rdata]
- `portuguese-brazilian` [.rdata]
- `.?AVunsupported_os@Concurrency@@` [.data]
- `.?AVConnectionFilter@b2ParticleSystem@@` [.data]
- `.?AVUpdateTriadsCallback@?P@??UpdatePairsAndTriads@b2ParticleSystem@@AAEXHHABVConnectionFilter@2@@Z@` [.data]
- `.?AV?$sp_counted_impl_p@V?$grouped_list@HU?$less@H@std@@V?$shared_ptr@V?$connection_body@U?$pair@W4slot_meta_group@detail@signals2@boost@@V?$optional@H@4@@std@@V?$slot@$$A6AXXZV?$function@$$A6AXXZ@boost@@@signals2@boost@@Vmutex@45@@detail@signals2@boost@@@boost@@@detail@signals2@boost@@@detail@boost@@` [.data]
- `.?AV?$sp_counted_impl_p@V?$connection_body@U?$pair@W4slot_meta_group@detail@signals2@boost@@V?$optional@H@4@@std@@V?$slot@$$A6AXXZV?$function@$$A6AXXZ@boost@@@signals2@boost@@Vmutex@45@@detail@signals2@boost@@@detail@boost@@` [.data]
- `.?AVconnection_body_base@detail@signals2@boost@@` [.data]
- `.?AV?$sp_counted_impl_p@Vconnection@signals2@boost@@@detail@boost@@` [.data]
- `.?AV?$bound_extended_slot_function@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@boost@@@detail@signals2@boost@@` [.data]
- `.?AV?$connection_body@U?$pair@W4slot_meta_group@detail@signals2@boost@@V?$optional@H@4@@std@@V?$slot@$$A6AXXZV?$function@$$A6AXXZ@boost@@@signals2@boost@@Vmutex@45@@detail@signals2@boost@@` [.data]
- `.?AV?$sp_counted_impl_p@Vinvocation_state@?$signal_impl@$$A6AXXZV?$optional_last_value@X@signals2@boost@@HU?$less@H@std@@V?$function@$$A6AXXZ@3@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@3@Vmutex@23@@detail@signals2@boost@@@detail@boost@@` [.data]
- `.?AV?$sp_counted_impl_p@V?$signal_impl@$$A6AXXZV?$optional_last_value@X@signals2@boost@@HU?$less@H@std@@V?$function@$$A6AXXZ@3@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@3@Vmutex@23@@detail@signals2@boost@@@detail@boost@@` [.data]
- `.?AV?$signal@$$A6AXXZV?$optional_last_value@X@signals2@boost@@HU?$less@H@std@@V?$function@$$A6AXXZ@3@V?$function@$$A6AXABVconnection@signals2@boost@@@Z@3@Vmutex@23@@signals2@boost@@` [.data]
- `.?AVbtGhostPairCallback@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VNetworkServerImpl@Manbow@@V?$TPoolAllocator@VNetworkServerImpl@Manbow@@@TF4@@@std@@` [.data]
- `.?AU?$ClassTypeData@VNetworkServer@Manbow@@X@Sqrat@@` [.data]
- `.?AV?$Class@VNetworkServer@Manbow@@V?$DefaultAllocator@VNetworkServer@Manbow@@@Sqrat@@@Sqrat@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VNetworkClientImpl@Manbow@@V?$TPoolAllocator@VNetworkClientImpl@Manbow@@@TF4@@@std@@` [.data]
- `.?AU?$ClassTypeData@VNetworkClient@Manbow@@X@Sqrat@@` [.data]
- `.?AV?$Class@VNetworkClient@Manbow@@V?$DefaultAllocator@VNetworkClient@Manbow@@@Sqrat@@@Sqrat@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VNetworkTableSrc@Manbow@@V?$TPoolAllocator@VNetworkTableSrc@Manbow@@@TF4@@@std@@` [.data]
- `.?AV?$_Ref_count_obj_alloc@VNetworkTableDst@Manbow@@V?$TPoolAllocator@VNetworkTableDst@Manbow@@@TF4@@@std@@` [.data]

### DirectX API 相关 (80 条)

- `D3D11Graphics::GetSwapChain()->GetBuffer failed` [.rdata]
- `D3D11Graphics::GetDevice()->CreateRenderTargetView failed` [.rdata]
- `D3D11Graphics::GetDevice()->CreateTexture2D failed` [.rdata]
- `D3D11Graphics::GetDevice()->CreateDepthStencilView failed` [.rdata]
- `D3D11Texture::Create Error file not found %s` [.rdata]
- `D3DX11CreateShaderResourceViewFromMemory` [.rdata]
- `D3DXVec3Transform` [.rdata]
- `D3DXMatrixScaling` [.rdata]
- `D3DXMatrixTranslation` [.rdata]
- `D3DXMatrixRotationYawPitchRoll` [.rdata]
- `D3D11CreateDeviceAndSwapChain` [.rdata]
- `.P6AXPAPAUID3D11ShaderResourceView@@@Z` [.data]
- `.P6AXPAPAUID3D11Resource@@@Z` [.data]
- `.?AV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAUID3D11Buffer@@AAI@std@@` [.data]
- `.?AV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAUID3D11Texture2D@@AAI@std@@` [.data]
- `.?AV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAU4@AAI@std@@` [.data]
- `.?AV?$com_ptr@UID3D11ShaderResourceView@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11Resource@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$_Ref_count_del@DV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAU4@AAI@std@@@std@@` [.data]
- `.?AV?$_Ref_count_del@DV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAUID3D11Texture2D@@AAI@std@@@std@@` [.data]
- `.?AV?$_Ref_count_del@DV?$_Binder@U_Unforced@std@@A6AXPAXPAUID3D11DeviceContext@@PAUID3D11Resource@@I@ZABU?$_Ph@$00@2@AAV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@AAPAUID3D11Buffer@@AAI@std@@@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11Resource@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11ShaderResourceView@@P6AXPAPAU1@@Z@std@@` [.data]
- `.P6AXPAPAUID3D11RasterizerState@@@Z` [.data]
- `.?AV?$com_ptr@UID3D11DeviceContext@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11Buffer@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11RenderTargetView@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11DepthStencilView@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11RenderTargetView@@P6AXPAPAU1@@Z@std@@` [.data]
- `.P6AXPAPAUID3D11Buffer@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11VertexShader@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$com_ptr@UID3D11SamplerState@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11PixelShader@@@Z` [.data]
- `.P6AXPAPAUID3D11DeviceContext@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11PixelShader@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$com_ptr@UID3D11DepthStencilView@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11InputLayout@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11VertexShader@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11RenderTargetView@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11RasterizerState@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11SamplerState@@P6AXPAPAU1@@Z@std@@` [.data]
- `.P6AXPAPAUID3D11DepthStencilView@@@Z` [.data]
- `.?AV?$com_ptr@UID3D11RasterizerState@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11Texture2D@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11Device@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11Buffer@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11DepthStencilState@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$com_ptr@UID3D11Device@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11DepthStencilState@@@Z` [.data]
- `.?AV?$com_ptr@UID3D11PixelShader@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.?AV?$com_ptr@UID3D11BlendState@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11BlendState@@@Z` [.data]
- `.P6AXPAPAUID3D11Device@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11BlendState@@P6AXPAPAU1@@Z@std@@` [.data]
- `.?AV?$com_ptr@UID3D11DepthStencilState@@UNullParameterStruct@Act@@$00@Act@@` [.data]
- `.P6AXPAPAUID3D11VertexShader@@@Z` [.data]
- `.P6AXPAPAUID3D11SamplerState@@@Z` [.data]
- `.?AV?$_Ref_count_del@PAUID3D11InputLayout@@P6AXPAPAU1@@Z@std@@` [.data]
- `.P6AXPAPAUID3D11InputLayout@@@Z` [.data]
- `.?AV?$com_ptr@UID3D11Texture2D@@UNullParameterStruct@Act@@$00@Act@@` [.data]

### 调试/错误消息 (17 条)

- `internal vm error bitwise op failed` [.rdata]
- `_nexti failed` [.rdata]
- `assertion failed` [.rdata]
- `assert` [.rdata]
- `compare func failed` [.rdata]
- `internal compiler error: too many locals` [.rdata]
- `resize failed` [.rdata]
- `Failed to load script file.` [.rdata]
- `remove() failed` [.rdata]
- `rename() failed` [.rdata]
- `Failed GetUserName API.` [.rdata]
- `Memory allocation failed while processing sCAL` [.rdata]
- `libpng error: %s` [.rdata]
- `deflateEnd failed (ignored)` [.rdata]
- `internal error: array realloc` [.rdata]
- `internal error: array alloc` [.rdata]
- `.?AV_Node_assert@std@@` [.data]

### 日文消息(游戏文案) (80 条)

- `毅4技||` [.text]
- `脚8液$` [.text]
- `桔l鋼5` [.text]
- `3寀Bx吋$` [.text]
- `u鴉qδ` [.text]
- `}L亀$8欺$` [.text]
- `吸@欺$` [.text]
- `吸@噂$` [.text]
- `雨p亀$8欺$` [.text]
- `凝ζ$[^_]` [.text]
- `吋$,欝$` [.text]
- `詰$\起` [.text]
- `噂$<瑛$(鵜$` [.text]
- `季L軌P吋$` [.text]
- `季(軌0妓4吋$4鵜$0欝$8黍8祇<逆$,記$` [.text]
- `齏闍|$<` [.text]
- `液$,局+D$(;` [.text]
- `逆$,` [.text]
- `曲汽$4逆$8;` [.text]
- `隅+V;` [.text]
- `隅+H汽$0;` [.text]
- `逆$8記$0;` [.text]
- `隅+` [.text]
- `隅+` [.text]
- `玉隅+` [.text]
- `逆$,欺$` [.text]
- `隅+N;` [.text]
- `隅+@汽$0;` [.text]
- `隅+` [.text]
- `隅+` [.text]
- `襟汽$X桐輝` [.text]
- `瓜<桐構$` [.text]
- `ζ@拏]^_` [.text]
- `畿 偽4S犠0V丘` [.text]
- `丘,H91丘` [.text]
- `急闍EI` [.text]
- `9},t$孔$P孔,PRSV厭,鑾` [.text]
- `宇H祈4` [.text]
- `救4宇L` [.text]
- `W宇<霍T0` [.text]
- `偽(宇D祈8ζ 鵜` [.text]
- `串芹;~` [.text]
- `偽0貴4ζ` [.text]
- `孔膠孔澑孔` [.text]
- `P孔捻V` [.text]
- `犠8急熏K` [.text]
- `祈8貴L` [.text]
- `祈@貴4鵜` [.text]
- `祈<貴0鵜` [.text]
- `U駆V丘` [.text]
- `ENxWQ鎹` [.text]
- `P宇\孝xP丑`陏` [.text]
- `F`宇\孔` [.text]
- `P孝xP閹` [.text]
- `貴焜` [.text]
- `貴煖M` [.text]
- `|D祈D丘闍}艫` [.text]
- `顴窺` [.text]
- `窺M熏` [.text]
- `右FD丘` [.text]

## 11. 版本指纹综合结论

- 链接器: 14.0 → VS2015
- 打包器: no strong packer indicators
- 模块栈: D3DX, DirectInput8, DirectInput, DirectSound, winmm, winsock2, XInput
- 入口: RVA 0x2E1B8C (VA 0x006E1B8C)
## 12. 补充发现(专项深挖: Authenticode 签名 + D3D11 + 在线对战)

- **数字签名(本系列首次)**: th155.exe 尾部附加完整 **WIN_CERTIFICATE**(offset 5,282,304, size 5,336B, wRevision=0x200, wCertType=0x0002 PKCS_SIGNED_DATA),security 目录有效指向。签发者 **CN=Tomohiko Nakajima, O=Tomohiko Nakajima**(黄昏フロンティア核心开发者中嶋朋彦),COMODO RSA Code Signing CA 签发,有效期 2017-11-30 ~ 2022-12-01,附 COMODO SHA-1 时间戳。→ 从凭依华起 Tasofro 对主程序做代码签名。
- **图形栈升级 Direct3D 11**: 导入 `d3d11.dll!D3D11CreateDeviceAndSwapChain` + `d3dx11_43!D3DX11CreateShaderResourceViewFromMemory`(D3D11 渲染),同时保留 `d3dx9_43` 4 函数(D3DXMatrix* / D3DXVec3Transform,纯数学库)与 d3d9(1)。→ 凭依华起渲染管线切到 D3D11。
- **在线对战**: WS2_32 20 函数(WSASocketW / getaddrinfo / select / WSARecvFrom / WSASendTo 等,同 th145 方案);字符串 `NetworkClient` / `NetworkServer` 与连接状态机(ConnectRequest / DisconnectParent / DisconnectChild…)。
- **输入/音频**: DINPUT8 + XINPUT9_1_0(XInputGetState / XInputGetCapabilities)+ DSOUND(ord#11)。
- **引擎**: Squirrel 3.0.6 stable + **Bullet 物理**(btDynamicsWorldFloatData / btCollisionObjectFloatData RTTI)+ Manbow 系;新增 `.gfids` 节(自定义内部函数 ID 表)。
- **反篡改/自更新痕迹**: 0x00530630 函数带 `ImpersonateSelf / OpenThreadToken / CreateProcessA / ContinueDebugEvent / CreateFileMappingA`(令牌模拟+子进程调试=自保护/看门狗);另导入 WINTRUST(WinVerifyTrust,自身签名校验)、dbghelp(6,崩溃转储)、VERSION(3)。
- **资源包**: `th155.pak` / `th155b.pak`(对应 W4 t31 拆包);配置 config.ini / system.dat。
- **th155_log.exe**: 见 `report_log.md`(同源码双构建、要求管理员权限的辅助工具)。
