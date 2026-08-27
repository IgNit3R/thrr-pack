# 東方剛欲異聞 ~ 水没した沈愁地獄 (TH17.5) — game.exe — 主程序深度静态分析报告

- 目标文件: `E:/GitWorkspace/thworks/tf/th175/game.exe`
- 分析方式: 纯静态 (pefile 结构解析 + capstone 反汇编 + 字符串提取),未执行目标程序

## 1. 文件概要

| 属性 | 值 |
|---|---|
| 大小 | 5529321 bytes (5.3 MiB) |
| MD5 | `5cc5d0ca2407e57e8618db428de4105e` |
| SHA256 | `c779447ed3002dc108b63da2f45d2d1c6b51c5f62f32249a882791621600c0ec` |
| 文件修改时间 | 2022-10-31T10:22:50+00:00 |
| PE 时间戳 | 2022-10-31 02:31:12 UTC (raw 0x635F3370) |
| 架构/子系统 | i386 / PE32 / WINDOWS_GUI |
| 链接器版本 | 14.0 → VS2015 |
| 入口点 | RVA 0x2E47B (VA 0x0042E47B) |
| ImageBase | 0x400000 |
| CheckSum 校验 | 不通过(存储 0,未生成) |

**编译指纹结论**: 链接器 14.0 → VS2015。**打包器**: no strong packer indicators。**图形/模块栈**: winmm。

## 2. 节区表

| 节 | VA | VSize | RawPtr | RawSize | 熵 | 属性 | V/R比 |
|---|---|---|---|---|---|---|---|
| .text | 0x1000 | 413962 | 1024 | 414208 | 6.6062 | EXEC|READ|CODE | 0.999 |
| .rdata | 0x67000 | 102490 | 415232 | 102912 | 5.245 | READ|IDATA | 0.996 |
| .data | 0x81000 | 285256 | 518144 | 12288 | 4.4806 | READ|WRITE|IDATA | 23.214 |
| .tls | 0xC7000 | 9 | 530432 | 512 | 0.0204 | READ|WRITE|IDATA | 0.018 |
| .gfids | 0xC8000 | 2732 | 530944 | 3072 | 3.5584 | READ|IDATA | 0.889 |
| .rsrc | 0xC9000 | 5720 | 534016 | 6144 | 3.7203 | READ|IDATA | 0.931 |
| .reloc | 0xCB000 | 22484 | 540160 | 22528 | 6.5331 | READ|IDATA | 0.998 |

## 3. 导入表 (7 DLL / 185 函数)

| DLL | 导入数 |
|---|---|
| KERNEL32.dll | 139 |
| USER32.dll | 35 |
| GDI32.dll | 2 |
| ADVAPI32.dll | 4 |
| ole32.dll | 1 |
| WINMM.dll | 3 |
| WINTRUST.dll | 1 |

**关键 API 使用**(按功能分类,来自关键函数识别):见 §8。

## 4. 导出表

无导出(典型应用程序)。

## 5. 资源

| 类型 | 数量 | 总字节 |
|---|---|---|
| type#1041 | 3 | 4864 |
| type#1033 | 1 | 551 |

## 6. TLS / 签名 / Overlay

- TLS: 存在 (callbacks=无)
- 数字签名: 无
- Overlay: offset 562688, size 4966633 bytes (存在! 文件尾部附加数据)

Rich 头(工具链指纹):
- prod_id=15834292 build=20 ×1
- prod_id=15965364 build=154 ×1
- prod_id=15899828 build=30 ×1
- prod_id=17391255 build=2 ×1
- prod_id=16997947 build=24 ×1
- prod_id=17129019 build=110 ×1
- prod_id=17063483 build=37 ×1
- prod_id=13369309 build=17 ×1
- prod_id=65536 build=204 ×1
- prod_id=0 build=33 ×1
- prod_id=16735890 build=1 ×1
- prod_id=9895936 build=1 ×1
- prod_id=16932503 build=1 ×1

## 7. 入口点反汇编(前段)

```asm
0042E47B  call     0x42ea89   ; -> sub_42EA89 [func-start]
0042E480  jmp      0x42e313
0042E485  push     ebp
0042E486  mov      ebp, esp
0042E488  push     0
0042E48A  call     dword ptr [0x467060]   ; IAT:KERNEL32.dll!SetUnhandledExceptionFilter
0042E490  push     dword ptr [ebp + 8]
0042E493  call     dword ptr [0x467148]   ; IAT:KERNEL32.dll!UnhandledExceptionFilter
0042E499  push     0xc0000409
0042E49E  call     dword ptr [0x467038]   ; IAT:KERNEL32.dll!GetCurrentProcess
0042E4A4  push     eax
0042E4A5  call     dword ptr [0x46703c]   ; IAT:KERNEL32.dll!TerminateProcess
0042E4AB  pop      ebp
0042E4AC  ret      
0042E4AD  push     ebp
0042E4AE  mov      ebp, esp
0042E4B0  sub      esp, 0x324
0042E4B6  push     0x17
0042E4B8  call     0x462e5a
0042E4BD  test     eax, eax
0042E4BF  je       0x42e4c6
0042E4C1  push     2
0042E4C3  pop      ecx
0042E4C4  int      0x29
0042E4C6  mov      dword ptr [0x4c5668], eax
0042E4CB  mov      dword ptr [0x4c5664], ecx
0042E4D1  mov      dword ptr [0x4c5660], edx
0042E4D7  mov      dword ptr [0x4c565c], ebx
0042E4DD  mov      dword ptr [0x4c5658], esi
0042E4E3  mov      dword ptr [0x4c5654], edi
0042E4E9  mov      word ptr [0x4c5680], ss
0042E4F0  mov      word ptr [0x4c5674], cs
0042E4F7  mov      word ptr [0x4c5650], ds
0042E4FE  mov      word ptr [0x4c564c], es
0042E505  mov      word ptr [0x4c5648], fs
0042E50C  mov      word ptr [0x4c5644], gs
0042E513  pushfd   
0042E514  pop      dword ptr [0x4c5678]
0042E51A  mov      eax, dword ptr [ebp]
0042E51D  mov      dword ptr [0x4c566c], eax
```

## 8. 关键函数识别(capstone + IAT 引用分析)

估计函数总数(E8 call 目标统计): **1469**

### [message_pump] 0x00403C90 (RVA 0x3C90, ≈0xfb0 bytes, 入度 7)

引用 API: `GDI32.dll!CreateBrushIndirect`, `GDI32.dll!DeleteObject`, `KERNEL32.dll!Sleep`, `USER32.dll!AdjustWindowRect`, `USER32.dll!BeginPaint`, `USER32.dll!DestroyWindow`, `USER32.dll!EndPaint`, `USER32.dll!FillRect`, `USER32.dll!GetClientRect`, `USER32.dll!GetSystemMetrics`, `USER32.dll!GetWindowRect`, `USER32.dll!PeekMessageA`, `USER32.dll!PostMessageA`, `USER32.dll!PostQuitMessage`, `USER32.dll!SetWindowLongA`, `USER32.dll!SetWindowPos`, `USER32.dll!ShowCursor`, `USER32.dll!ShowWindow`, `WINMM.dll!timeEndPeriod`, `WINMM.dll!timeGetTime`

```asm
00403C90  push     ebp
00403C91  mov      ebp, esp
00403C93  push     ebx
00403C94  push     edi
00403C95  push     esi
00403C96  and      esp, 0xfffffff8
00403C99  sub      esp, 0x58
00403C9C  mov      esi, esp
00403C9E  mov      dword ptr [esi + 0x40], ebp
00403CA1  mov      dword ptr [esi + 0x44], esp
00403CA4  mov      dword ptr [esi + 0x50], 0xffffffff
00403CAB  mov      dword ptr [esi + 0x4c], 0x40d890
00403CB2  mov      edx, ecx
00403CB4  lea      eax, [esi + 0x48]
00403CB7  mov      ecx, dword ptr fs:[0]
00403CBE  mov      dword ptr [esi + 0x48], ecx
00403CC1  mov      dword ptr fs:[0], eax
00403CC7  mov      ecx, dword ptr [ebp + 0x30]
00403CCA  mov      eax, dword ptr [ebp + 8]
00403CCD  test     ecx, ecx
00403CCF  mov      dword ptr [esi + 8], eax
00403CD2  mov      dword ptr [esi + 0x34], 0
00403CD9  je       0x403cf5
00403CDB  mov      eax, dword ptr [ecx]
00403CDD  mov      dword ptr [esi + 4], edx
00403CE0  lea      edx, [esi + 0x10]
```

### [message_pump] 0x0040D9F0 (RVA 0xD9F0, ≈0x21c0 bytes, 入度 1)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!ContinueDebugEvent`, `KERNEL32.dll!CreateFileMappingA`, `KERNEL32.dll!CreateProcessA`, `KERNEL32.dll!DebugActiveProcess`, `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!GetCurrentProcessId`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!IsDebuggerPresent`, `KERNEL32.dll!MapViewOfFile`, `KERNEL32.dll!OpenFileMappingA`, `KERNEL32.dll!OpenProcess`, `KERNEL32.dll!ReadProcessMemory`, `KERNEL32.dll!SetCurrentDirectoryA`, `KERNEL32.dll!Sleep`, `KERNEL32.dll!TerminateProcess`, `KERNEL32.dll!WaitForDebugEvent`, `USER32.dll!CreateWindowExA`, `USER32.dll!DispatchMessageA`, `USER32.dll!IsHungAppWindow`, `USER32.dll!IsWindow`, `USER32.dll!MessageBoxA`, `USER32.dll!PeekMessageA`, `USER32.dll!PostMessageA`, `USER32.dll!TranslateMessage`, `USER32.dll!wsprintfA`, `WINMM.dll!timeGetTime`

```asm
0040D9F0  push     ebp
0040D9F1  mov      ebp, esp
0040D9F3  push     esi
0040D9F4  mov      esi, ecx
0040D9F6  mov      dword ptr [esi], 0x468544
0040D9FC  mov      dword ptr [esi + 4], 0
0040DA03  mov      dword ptr [esi + 0xc], 0
0040DA0A  mov      dword ptr [esi + 0x10], 0
0040DA11  push     0x2c
0040DA13  call     0x412e40   ; -> sub_412E40 [func-start]
0040DA18  add      esp, 4
0040DA1B  mov      dword ptr [eax], eax
0040DA1D  mov      dword ptr [eax + 4], eax
0040DA20  mov      dword ptr [eax + 8], eax
0040DA23  mov      word ptr [eax + 0xc], 0x101
0040DA29  mov      dword ptr [esi + 0xc], eax
0040DA2C  mov      dword ptr [esi + 8], 0
0040DA33  mov      eax, esi
0040DA35  pop      esi
0040DA36  pop      ebp
0040DA37  ret      
0040DA38  int3     
0040DA39  int3     
0040DA3A  int3     
0040DA3B  int3     
0040DA3C  int3     
```

### [winmain_candidate] 0x00410F00 (RVA 0x10F00, ≈0x2e0 bytes, 入度 1)

引用 API: `USER32.dll!CreateWindowExA`, `USER32.dll!GetClassInfoExA`, `USER32.dll!GetWindowLongA`, `USER32.dll!IsWindow`, `USER32.dll!LoadCursorA`, `USER32.dll!RegisterClassExA`, `USER32.dll!SetWindowLongA`

```asm
00410F00  push     ebp
00410F01  mov      ebp, esp
00410F03  push     ebx
00410F04  push     edi
00410F05  push     esi
00410F06  sub      esp, 0x38
00410F09  mov      esi, ecx
00410F0B  xor      eax, eax
00410F0D  cmp      dword ptr [esi + 4], 0
00410F11  jne      0x411061
00410F17  mov      ebx, dword ptr [ebp + 8]
00410F1A  lea      edi, [ebp - 0x3c]
00410F1D  mov      dword ptr [ebp - 0x34], 0
00410F24  mov      dword ptr [ebp - 0x38], 0
00410F2B  mov      dword ptr [ebp - 0x2c], 0
00410F32  mov      dword ptr [ebp - 0x30], 0
00410F39  mov      dword ptr [ebp - 0x24], 0
00410F40  mov      dword ptr [ebp - 0x28], 0
00410F47  mov      dword ptr [ebp - 0x1c], 0
00410F4E  mov      dword ptr [ebp - 0x20], 0
00410F55  mov      dword ptr [ebp - 0x14], 0
00410F5C  mov      dword ptr [ebp - 0x18], 0
00410F63  mov      dword ptr [ebp - 0x10], 0
00410F6A  mov      dword ptr [ebp - 0x3c], 0x30
00410F71  push     edi
00410F72  push     dword ptr [ebp + 0xc]
```

### [message_pump] 0x004111E0 (RVA 0x111E0, ≈0x1c60 bytes, 入度 1)

引用 API: `GDI32.dll!DeleteObject`, `KERNEL32.dll!GetCommandLineA`, `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!SetThreadExecutionState`, `KERNEL32.dll!SetUnhandledExceptionFilter`, `KERNEL32.dll!Sleep`, `KERNEL32.dll!TerminateProcess`, `USER32.dll!DestroyWindow`, `USER32.dll!DispatchMessageA`, `USER32.dll!GetMessageA`, `USER32.dll!IsWindow`, `USER32.dll!MessageBoxA`, `USER32.dll!PeekMessageA`, `USER32.dll!SetTimer`, `USER32.dll!TranslateMessage`, `USER32.dll!wsprintfA`, `WINMM.dll!timeGetTime`, `ole32.dll!CoInitializeEx`

```asm
004111E0  push     ebp
004111E1  mov      ebp, esp
004111E3  push     ebx
004111E4  push     edi
004111E5  push     esi
004111E6  sub      esp, 0x24
004111E9  mov      eax, dword ptr [0x4817ac]
004111EE  mov      edi, ecx
004111F0  xor      eax, ebp
004111F2  mov      dword ptr [ebp - 0x10], eax
004111F5  push     dword ptr [edi + 4]
004111F8  call     dword ptr [0x467298]   ; IAT:USER32.dll!IsWindow
004111FE  test     eax, eax
00411200  je       0x4112bb
00411206  mov      eax, dword ptr [ebp + 8]
00411209  test     eax, eax
0041120B  je       0x41125e
0041120D  test     al, 1
0041120F  jne      0x411287
00411211  test     al, 2
00411213  je       0x41129d
00411219  mov      dword ptr [ebp - 0x30], edi
0041121C  lea      edi, [ebp - 0x2c]
0041121F  push     1
00411221  push     0
00411223  push     0
```

### [api_ref_function] 0x004357F2 (RVA 0x357F2, ≈0x5e bytes, 入度 26)

引用 API: `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!TerminateProcess`

```asm
004357F2  mov      edi, edi
004357F4  push     esi
004357F5  xor      esi, esi
004357F7  push     esi
004357F8  push     esi
004357F9  push     esi
004357FA  push     esi
004357FB  push     esi
004357FC  call     0x435767
00435801  add      esp, 0x14
00435804  push     esi
00435805  push     esi
00435806  push     esi
00435807  push     esi
00435808  push     esi
00435809  call     0x43580f
0043580E  int3     
0043580F  push     0x17
00435811  call     0x462e5a
00435816  test     eax, eax
00435818  je       0x43581f
0043581A  push     5
0043581C  pop      ecx
0043581D  int      0x29
0043581F  push     esi
00435820  push     1
```

### [api_ref_function] 0x00402100 (RVA 0x2100, ≈0x2e0 bytes, 入度 21)

引用 API: `KERNEL32.dll!GetModuleHandleA`

```asm
00402100  push     ebp
00402101  mov      ebp, esp
00402103  push     ebx
00402104  push     edi
00402105  push     esi
00402106  sub      esp, 0x14
00402109  mov      dword ptr [ebp - 0x1c], esp
0040210C  mov      dword ptr [ebp - 0x10], 0xffffffff
00402113  mov      dword ptr [ebp - 0x14], 0x40d880
0040211A  mov      edx, dword ptr [ebp + 8]
0040211D  mov      edi, dword ptr [ebp + 0x10]
00402120  mov      ebx, dword ptr [ebp + 0xc]
00402123  lea      eax, [ebp - 0x18]
00402126  mov      ecx, dword ptr fs:[0]
0040212D  mov      dword ptr [ebp - 0x18], ecx
00402130  mov      dword ptr fs:[0], eax
00402136  mov      dword ptr [edx + 0x14], 0xf
0040213D  mov      dword ptr [edx + 0x10], 0
00402144  mov      byte ptr [edx], 0
00402147  mov      esi, dword ptr [ebx + 0x10]
0040214A  cmp      byte ptr [edi], 0
0040214D  je       0x40215a
0040214F  push     edi
00402150  call     0x435850   ; -> sub_435850 [func-start]
00402155  add      esp, 4
00402158  jmp      0x40215c
```

### [api_ref_function] 0x0043241E (RVA 0x3241E, ≈0x72 bytes, 入度 6)

引用 API: `KERNEL32.dll!RaiseException`

```asm
0043241E  push     ebp
0043241F  mov      ebp, esp
00432421  sub      esp, 0x20
00432424  push     ebx
00432425  mov      ebx, dword ptr [ebp + 8]
00432428  push     esi
00432429  push     edi
0043242A  push     8
0043242C  pop      ecx
0043242D  mov      esi, 0x46e4b4
00432432  lea      edi, [ebp - 0x20]
00432435  rep movsd dword ptr es:[edi], dword ptr [esi]
00432437  mov      edi, dword ptr [ebp + 0xc]
0043243A  test     edi, edi
0043243C  je       0x43245a
0043243E  test     byte ptr [edi], 0x10
00432441  je       0x43245a
00432443  mov      ecx, dword ptr [ebx]
00432445  sub      ecx, 4
00432448  push     ecx
00432449  mov      eax, dword ptr [ecx]
0043244B  mov      esi, dword ptr [eax + 0x20]
0043244E  mov      ecx, esi
00432450  mov      edi, dword ptr [eax + 0x18]
00432453  call     0x42e86b
00432458  call     esi
```

### [api_ref_function] 0x00412F80 (RVA 0x12F80, ≈0x410 bytes, 入度 4)

引用 API: `KERNEL32.dll!GetCurrentProcess`, `KERNEL32.dll!Sleep`, `KERNEL32.dll!TerminateProcess`

```asm
00412F80  add      dword ptr [0x4c5510], -1
00412F87  adc      dword ptr [0x4c5514], -1
00412F8E  jmp      0x439071   ; -> sub_439071 [func-start]
00412F93  int3     
00412F94  int3     
00412F95  int3     
00412F96  int3     
00412F97  int3     
00412F98  int3     
00412F99  int3     
00412F9A  int3     
00412F9B  int3     
00412F9C  int3     
00412F9D  int3     
00412F9E  int3     
00412F9F  int3     
00412FA0  push     ebp
00412FA1  mov      ebp, esp
00412FA3  push     esi
00412FA4  mov      esi, ecx
00412FA6  lea      eax, [esi + 4]
00412FA9  mov      dword ptr [esi], 0x467a38
00412FAF  push     eax
00412FB0  call     0x432fe7   ; -> sub_432FE7 [func-start]
00412FB5  add      esp, 4
00412FB8  cmp      dword ptr [ebp + 8], 0
```

### [api_ref_function] 0x0042DD64 (RVA 0x2DD64, ≈0xd1 bytes, 入度 4)

引用 API: `KERNEL32.dll!CreateEventW`, `KERNEL32.dll!GetModuleHandleW`, `KERNEL32.dll!GetProcAddress`

```asm
0042DD64  cmp      ecx, dword ptr [0x4817ac]
0042DD6A  bnd jne  0x42dd6f
0042DD6D  bnd ret  
0042DD6F  bnd jmp  0x42e4ad
0042DD75  push     ebx
0042DD76  push     esi
0042DD77  push     edi
0042DD78  push     0
0042DD7A  push     0xfa0
0042DD7F  push     0x4c551c
0042DD84  call     0x434e59   ; -> sub_434E59 [func-start]
0042DD89  add      esp, 0xc
0042DD8C  push     0x468e74
0042DD91  call     dword ptr [0x467140]   ; IAT:KERNEL32.dll!GetModuleHandleW
0042DD97  mov      esi, eax
0042DD99  test     esi, esi
0042DD9B  je       0x42de2d
0042DDA1  push     0x468e90
0042DDA6  push     esi
0042DDA7  call     dword ptr [0x467144]   ; IAT:KERNEL32.dll!GetProcAddress
0042DDAD  push     0x468eac
0042DDB2  push     esi
0042DDB3  mov      ebx, eax
0042DDB5  call     dword ptr [0x467144]   ; IAT:KERNEL32.dll!GetProcAddress
0042DDBB  push     0x468ec8
0042DDC0  push     esi
```

### [api_ref_function] 0x0040FC90 (RVA 0xFC90, ≈0x310 bytes, 入度 3)

引用 API: `USER32.dll!MessageBoxA`

```asm
0040FC90  mov      eax, dword ptr [0x481670]
0040FC95  test     eax, eax
0040FC97  je       0x40fca3
0040FC99  mov      cl, byte ptr [esp + 4]
0040FC9D  mov      byte ptr [eax + 0x41010], cl
0040FCA3  ret      
0040FCA4  int3     
0040FCA5  int3     
0040FCA6  int3     
0040FCA7  int3     
0040FCA8  int3     
0040FCA9  int3     
0040FCAA  int3     
0040FCAB  int3     
0040FCAC  int3     
0040FCAD  int3     
0040FCAE  int3     
0040FCAF  int3     
0040FCB0  mov      eax, dword ptr [0x481670]
0040FCB5  test     eax, eax
0040FCB7  je       0x40fcc3
0040FCB9  mov      cl, byte ptr [esp + 4]
0040FCBD  mov      byte ptr [eax + 0x41011], cl
0040FCC3  ret      
0040FCC4  int3     
0040FCC5  int3     
```

### [api_ref_function] 0x0041CBD0 (RVA 0x1CBD0, ≈0x4000 bytes, 入度 2)

引用 API: `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!CreateFileA`, `KERNEL32.dll!GetFileSizeEx`, `KERNEL32.dll!GetFileType`, `KERNEL32.dll!ReadFile`, `KERNEL32.dll!SetFilePointer`, `KERNEL32.dll!WriteFile`

```asm
0041CBD0  push     ebp
0041CBD1  mov      ebp, esp
0041CBD3  push     ebx
0041CBD4  push     edi
0041CBD5  push     esi
0041CBD6  sub      esp, 8
0041CBD9  mov      esi, ecx
0041CBDB  mov      edi, dword ptr [ebp + 8]
0041CBDE  mov      eax, dword ptr [esi + 4]
0041CBE1  mov      edx, dword ptr [esi]
0041CBE3  mov      ecx, eax
0041CBE5  sub      ecx, edx
0041CBE7  sar      ecx, 2
0041CBEA  imul     ebx, ecx, 0xaaaaaaab
0041CBF0  cmp      ebx, edi
0041CBF2  jbe      0x41cbfb
0041CBF4  sub      edi, ebx
0041CBF6  jmp      0x41ccad
0041CBFB  jae      0x41ccb6
0041CC01  mov      dword ptr [ebp - 0x10], esi
0041CC04  mov      esi, dword ptr [esi + 8]
0041CC07  mov      ecx, edi
0041CC09  sub      ecx, ebx
0041CC0B  mov      dword ptr [ebp - 0x14], esi
0041CC0E  sub      esi, eax
0041CC10  sar      esi, 2
```

### [api_ref_function] 0x0042B8E0 (RVA 0x2B8E0, ≈0x1790 bytes, 入度 2)

引用 API: `KERNEL32.dll!InitializeSListHead`

```asm
0042B8E0  push     ebp
0042B8E1  mov      ebp, esp
0042B8E3  push     ebx
0042B8E4  push     edi
0042B8E5  push     esi
0042B8E6  mov      eax, dword ptr [ebp + 8]
0042B8E9  mov      esi, ecx
0042B8EB  test     eax, eax
0042B8ED  je       0x42b924
0042B8EF  cmp      eax, 0x40000000
0042B8F4  jae      0x42b97c
0042B8FA  lea      eax, [eax*4]
0042B901  cmp      eax, 0x1000
0042B906  jb       0x42b928
0042B908  cmp      eax, -0x23
0042B90B  jae      0x42b97c
0042B90D  add      eax, 0x23
0042B910  push     eax
0042B911  call     0x412e40   ; -> sub_412E40 [func-start]
0042B916  add      esp, 4
0042B919  lea      edi, [eax + 0x23]
0042B91C  and      edi, 0xffffffe0
0042B91F  mov      dword ptr [edi - 4], eax
0042B922  jmp      0x42b933
0042B924  xor      edi, edi
0042B926  jmp      0x42b933
```

### [api_ref_function] 0x00401090 (RVA 0x1090, ≈0x1070 bytes, 入度 1)

引用 API: `KERNEL32.dll!DeleteFileA`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!MoveFileA`

```asm
00401090  push     ebp
00401091  mov      ebp, esp
00401093  push     ebx
00401094  push     edi
00401095  push     esi
00401096  sub      esp, 0x830
0040109C  mov      dword ptr [ebp - 0x1c], esp
0040109F  mov      dword ptr [ebp - 0x10], 0xffffffff
004010A6  mov      dword ptr [ebp - 0x14], 0x40d830
004010AD  mov      edi, dword ptr [ebp + 8]
004010B0  lea      eax, [ebp - 0x18]
004010B3  mov      ecx, dword ptr fs:[0]
004010BA  mov      dword ptr [ebp - 0x18], ecx
004010BD  mov      dword ptr fs:[0], eax
004010C3  push     0x483f24
004010C8  call     0x42f022   ; -> sub_42F022 [func-start]
004010CD  add      esp, 4
004010D0  test     eax, eax
004010D2  je       0x4010dd
004010D4  push     eax
004010D5  call     0x42f3c4   ; -> sub_42F3C4 [func-start]
004010DA  add      esp, 4
004010DD  test     edi, edi
004010DF  je       0x401c8b
004010E5  cmp      dword ptr [0x483f14], 0
004010EC  jne      0x4011f4
```

### [api_ref_function] 0x004023E0 (RVA 0x23E0, ≈0x1850 bytes, 入度 1)

引用 API: `ADVAPI32.dll!AdjustTokenPrivileges`, `ADVAPI32.dll!LookupPrivilegeValueA`, `ADVAPI32.dll!OpenProcessToken`, `KERNEL32.dll!CloseHandle`, `KERNEL32.dll!GetCurrentProcessId`, `KERNEL32.dll!GetDriveTypeA`, `KERNEL32.dll!GetModuleFileNameA`, `KERNEL32.dll!GetModuleHandleA`, `KERNEL32.dll!GetSystemInfo`, `KERNEL32.dll!OpenProcess`, `KERNEL32.dll!SetCurrentDirectoryA`, `KERNEL32.dll!SetProcessWorkingSetSize`, `USER32.dll!AdjustWindowRect`, `USER32.dll!GetClientRect`, `USER32.dll!MessageBoxA`, `USER32.dll!SendMessageA`, `USER32.dll!SetWindowPos`, `USER32.dll!SetWindowTextA`, `USER32.dll!ShowWindow`, `WINMM.dll!timeBeginPeriod`, `WINMM.dll!timeGetTime`

```asm
004023E0  push     ebp
004023E1  mov      ebp, esp
004023E3  push     ebx
004023E4  push     edi
004023E5  push     esi
004023E6  sub      esp, 0x38
004023E9  mov      dword ptr [ebp - 0x1c], esp
004023EC  mov      dword ptr [ebp - 0x10], 0xffffffff
004023F3  mov      dword ptr [ebp - 0x14], 0x40d840
004023FA  mov      esi, ecx
004023FC  lea      eax, [ebp - 0x18]
004023FF  mov      ecx, dword ptr fs:[0]
00402406  mov      dword ptr [ebp - 0x18], ecx
00402409  mov      dword ptr fs:[0], eax
0040240F  mov      ecx, dword ptr [esi + 0x398]
00402415  mov      eax, dword ptr [ecx]
00402417  push     0x467480
0040241C  call     dword ptr [eax + 0x14]
0040241F  mov      edi, eax
00402421  test     edi, edi
00402423  je       0x4024c8
00402429  mov      eax, dword ptr [edi]
0040242B  mov      ecx, edi
0040242D  push     0
0040242F  push     0x4675cf
00402434  call     dword ptr [eax + 0x10]
```

### [api_ref_function] 0x0040CDA0 (RVA 0xCDA0, ≈0x7f0 bytes, 入度 1)

引用 API: `USER32.dll!ShowCursor`

```asm
0040CDA0  push     ebp
0040CDA1  mov      ebp, esp
0040CDA3  push     ebx
0040CDA4  push     edi
0040CDA5  push     esi
0040CDA6  sub      esp, 0xc
0040CDA9  mov      eax, dword ptr [ebp + 0x18]
0040CDAC  mov      ecx, dword ptr [ebp + 0x14]
0040CDAF  cmp      ecx, eax
0040CDB1  je       0x40d44d
0040CDB7  mov      edx, eax
0040CDB9  mov      eax, dword ptr [ebp + 0x10]
0040CDBC  lea      edi, [eax + 0x10]
0040CDBF  lea      eax, [eax + 0x14]
0040CDC2  mov      dword ptr [ebp - 0x10], eax
0040CDC5  mov      eax, edx
0040CDC7  nop      word ptr [eax + eax]
0040CDD0  mov      bl, byte ptr [ecx]
0040CDD2  lea      esi, [ecx + 1]
0040CDD5  cmp      bl, 0x24
0040CDD8  jne      0x40ce20
0040CDDA  cmp      esi, eax
0040CDDC  je       0x40d3f4
0040CDE2  movsx    eax, byte ptr [esi]
0040CDE5  cmp      eax, 0x26
0040CDE8  jg       0x40ce60
```

### [api_ref_function] 0x0040FFA0 (RVA 0xFFA0, ≈0xf60 bytes, 入度 1)

引用 API: `USER32.dll!CallWindowProcA`, `USER32.dll!DefWindowProcA`, `USER32.dll!IsWindow`, `USER32.dll!SetFocus`, `USER32.dll!SetWindowLongA`

```asm
0040FFA0  push     ebp
0040FFA1  mov      ebp, esp
0040FFA3  push     ebx
0040FFA4  push     edi
0040FFA5  push     esi
0040FFA6  sub      esp, 0x20
0040FFA9  mov      dword ptr [ebp - 0x1c], esp
0040FFAC  mov      dword ptr [ebp - 0x10], 0xffffffff
0040FFB3  mov      dword ptr [ebp - 0x14], 0x412870
0040FFBA  mov      esi, ecx
0040FFBC  lea      eax, [ebp - 0x18]
0040FFBF  mov      ecx, dword ptr fs:[0]
0040FFC6  mov      dword ptr [ebp - 0x18], ecx
0040FFC9  mov      dword ptr fs:[0], eax
0040FFCF  lea      eax, [esi + 0x14]
0040FFD2  mov      dword ptr [esi], 0x468cf8
0040FFD8  mov      dword ptr [esi + 0x14], 0
0040FFDF  mov      dword ptr [esi + 0x18], 0
0040FFE6  mov      dword ptr [ebp - 0x28], eax
0040FFE9  push     0x40
0040FFEB  call     0x412e40   ; -> sub_412E40 [func-start]
0040FFF0  add      esp, 4
0040FFF3  mov      dword ptr [eax], eax
0040FFF5  mov      dword ptr [eax + 4], eax
0040FFF8  mov      dword ptr [eax + 8], eax
0040FFFB  mov      word ptr [eax + 0xc], 0x101
```

### 高入度调用枢纽 (top call-magnet)

| RVA | VA | 入度 |
|---|---|---|
| 0x12EB0 | 0x00412EB0 | 90 |
| 0x12E40 | 0x00412E40 | 57 |
| 0x6590 | 0x00406590 | 37 |
| 0x357F2 | 0x004357F2 | 26 |
| 0x2100 | 0x00402100 | 21 |
| 0x39071 | 0x00439071 | 21 |
| 0x2F7B9 | 0x0042F7B9 | 18 |
| 0x36910 | 0x00436910 | 10 |
| 0x2FCB7 | 0x0042FCB7 | 9 |
| 0x35850 | 0x00435850 | 8 |
| 0x368B4 | 0x004368B4 | 7 |
| 0x3C90 | 0x00403C90 | 7 |

## 9. Rich 编译器头

- prod_id=15834292 build=20 ×1
- prod_id=15965364 build=154 ×1
- prod_id=15899828 build=30 ×1
- prod_id=17391255 build=2 ×1
- prod_id=16997947 build=24 ×1
- prod_id=17129019 build=110 ×1
- prod_id=17063483 build=37 ×1
- prod_id=13369309 build=17 ×1
- prod_id=65536 build=204 ×1
- prod_id=0 build=33 ×1
- prod_id=16735890 build=1 ×1
- prod_id=9895936 build=1 ×1
- prod_id=16932503 build=1 ×1

## 10. 字符串分析

按编码计数(节内扫描): ASCII=1576, SJIS(CP932)=3129, UTF-16LE=577

### 文件引用(资源/存档/配置) (22 条)

- `.9.log` [.rdata]
- `.8.log` [.rdata]
- `.7.log` [.rdata]
- `.6.log` [.rdata]
- `.5.log` [.rdata]
- `.4.log` [.rdata]
- `.3.log` [.rdata]
- `.2.log` [.rdata]
- `.1.log` [.rdata]
- `app.conf` [.rdata]
- `data.cga` [.rdata]
- `data.cgb` [.rdata]
- `data.cgc` [.rdata]
- `main.pl` [.rdata]
- `C:\home\pgwork\avs.git\bin\win32\payloader.pdb` [.rdata]
- `KERNEL32.dll` [.rdata]
- `USER32.dll` [.rdata]
- `GDI32.dll` [.rdata]
- `ADVAPI32.dll` [.rdata]
- `ole32.dll` [.rdata]
- `WINMM.dll` [.rdata]
- `WINTRUST.dll` [.rdata]

### 网络对战模块 (21 条)

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
- `GetClientRect` [.rdata]
- `portuguese-brazilian` [.rdata]
- `.?AVComServer@AVS@@` [.data]
- `.?AUIComServer@AVS@@` [.data]
- `.?AVunsupported_os@Concurrency@@` [.data]

### DirectX API 相关 (2 条)

- `2&3>3D3d3q3~3` [.reloc]
- `383D3d3p3` [.reloc]

### 调试/错误消息 (4 条)

- `failed to load module: %s: ` [.rdata]
- `failed to load module` [.rdata]
- `Failed to load module` [.rdata]
- `.?AV_Node_assert@std@@` [.data]

### 日文消息(游戏文案) (80 条)

- `右琲蟲` [.text]
- `U牙SWV犠` [.text]
- `家FV襍` [.text]
- `寡SVW鎰F` [.text]
- `U牙V火克` [.text]
- `火孔鐡` [.text]
- `寡偽煖u` [.text]
- `回P云澳` [.text]
- `U牙V偽` [.text]
- `U牙V貴` [.text]
- `孝XPh誚F` [.text]
- `祈X起\` [.text]
- `祈PミT` [.text]
- `恢稿_[]` [.text]
- `祈@起PミT` [.text]
- `昂@荷獄` [.text]
- `P孝XPQWSR隍u` [.text]
- `孝X嘉S閔` [.text]
- `祈 儀$刻` [.text]
- `祈 起$+N` [.text]
- `加R鑠B` [.text]
- `果孝Hd` [.text]
- `稿_[]` [.text]
- `杵@映D` [.text]
- `1濶D$X好$` [.text]
- `記$X1鳧` [.text]
- `火1黹蔚` [.text]
- `U牙SWV火` [.text]
- `解ζH^_[]` [.text]
- `右n号` [.text]
- `?9驪89` [.text]
- `遂?9` [.text]
- `U牙V火韃` [.text]
- `烏^禍` [.text]
- `畿猊@<` [.text]
- `U牙SWVP飢` [.text]
- `U牙SV丘` [.text]
- `U牙SWV火犠` [.text]
- `回PW阮` [.text]
- `U牙SWVP急` [.text]
- `科回R右霈` [.text]
- `U牙SWV急` [.text]
- `回9` [.text]
- `回PS霙` [.text]
- `回RWV鏘` [.text]
- `疫闕u鐡` [.text]
- `講潔RPS錵` [.text]
- `F 犠煖` [.text]
- `懐u皷3畿` [.text]
- `窺熏E鐡` [.text]
- `畿澑鞣` [.text]
- `恢ζ,^_[]` [.text]
- `解ζ`^_[]` [.text]
- `庚捻閻` [.text]
- `U牙V畿` [.text]
- `孔濶M濺` [.text]
- `丘熏N,陟` [.text]
- `U牙V火` [.text]
- `右闕E鐡` [.text]
- `厭瀁ff.` [.text]

## 11. 版本指纹综合结论

- 链接器: 14.0 → VS2015
- 打包器: no strong packer indicators
- 模块栈: winmm
- 入口: RVA 0x2E47B (VA 0x0042E47B)
## 12. 补充发现(专项深挖: 加密 payload 壳结构)

- **Overlay(4,966,633B @ 0x89600, 熵 8.0)**: 接近均匀分布 → **加密/压缩载荷**,非明文资源;静态扫描无 zip/rar/7z/lha 魔数与内嵌 PE(MZ 命中 73 处均为随机巧合,无 PE 签名);.text 内无 overlay 偏移/尺寸常量 → 运行期由 PE 结构(末节尾)自行定位。
- **导入表极简 = 动态解析型加载器**: 无任何 DirectX/WS2_32/DSOUND 静态导入,但 .text 内存在 **GetProcAddress 引用 ×59**、LoadLibraryA/W 各 1、VirtualAlloc ×5、VirtualProtect ×3、MapViewOfFile ×2(含 FILE_MAP_EXECUTE 0xF001F)、CreateFileMappingA、ReadFile ×6、SetFilePointerEx —— 真实引擎(D3D9/D3D11/DSOUND/网络)在解密后的 payload 内以 GetProcAddress 动态装载。字符串 `squirrel3.0.7` 表明 payload 引擎仍用 Squirrel 脚本。
- **自保护/自更新痕迹**: WINTRUST(WinVerifyTrust 自签名校验)、DebugActiveProcess/ContinueDebugEvent(反调试)、ADVAPI32 OpenProcessToken+LookupPrivilegeValueA+AdjustTokenPrivileges(提权)、MoveFileA ×9 + DeleteFileA + GetModuleFileNameA(自替换/自更新);另见 `SetCurrentDirectoryA`(定位 data.cga)。
- **外部资源**: 字符串 `data.cga` / `data.cgb`(对应 W4 t32 拆包的两档案)。
- **网络**: 无 WS2_32 导入,但 .rdata 内嵌完整 BSD/errno 风格网络错误串(connection refused / host unreachable / not a socket …)→ payload 内自带 socket 实现或动态解析 ws2_32。
- **自定义节 `.gfids`**: 3,072B = 192 个 RVA 对(内部函数 ID 表,引擎自举用;th155 同款节)。
- **结论**: game.exe = 带加密 payload 的**自解包引擎壳**(类似商用壳思路但为自制),PE 本体仅窗口骨架+装载逻辑;payload 解密算法需动态调试(本次纯静态范围外)。VS2015 工具链,PE 时间戳 2022-10-31(1.15 更新后,同目录 th175_update_115.exe)。
