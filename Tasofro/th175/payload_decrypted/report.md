# report — th175 game.exe overlay payload 解密(静态解决,无需动态)

任务 t103 · extractor-f2 · 2026-08-24 · 源:`tf\th175\game.exe`(只读)

## 0. 结论先行

**game.exe 的 4.97MB overlay 并非「加密壳 payload」,而是标准 th175 cga 档案(与 data.cga/data.cgb 同族)**
——即游戏脚本运行时层(Squirrel 引擎模块+脚本+着色器),带 Tasofro cga 档案级混淆(偏移相关 XOR)。
**纯静态即可解密**:thtk/135tk 工具链的 `th175arc.exe` 已完整实现该格式的解密,55 个文件全部提取成功并验证合法。
**未执行动态分析**(无解密壳、无运行期解密时机问题),沙箱 .build\th175_run 已建但未运行任何进程,已清理。

## 1. 静态分析发现

### 1.1 overlay 概况

- game.exe = 5,529,321 B;PE 末节(.reloc)原始区止于 0x89600;overlay = 4,966,633 B(熵 ≈ 8.0,符合加密数据观感);
- overlay 头 64B 为高熵字节(无魔数/无 ASCII)→ 确为混淆数据(非明文 cga 头);
- 135tk 文档早已指出「game.exe 既是 exe 又是 cga 文件」——overlay 即内嵌 cga 档案。

### 1.2 cga 档案格式(依据 tools\135tk\th175arc\{read.c, common.c})

```
文件尾 0x20B file_footer_t(解密):footer_size=0x20、file_desc_size=0x18、nb_files
文件描述表(nb_files × 0x18B,解密):key=文件名 FNV1a 哈希、offset、size
各文件数据(按 desc.offset 定位,解密):decrypt(buffer, size, offset)
解密算法:file_key = size ^ offset_in_file;
  每 4B:4 轮 do_decrypt_step(tmp_key) 生成 4 字节 XOR(密钥 *= 0x5E4789C9,
  ret = (key - b*0xADC8)*0xBC8F + b*0xFFFFF2B9,负则 +0x7FFFFFFF),file_key 逐 dword +1
特例:hash == PAYLOADER_EXE_HASH 的文件不解密(原样存储)
```

### 1.3 解密结果(55 个文件,5,527,969 B)

| 类别 | 数量 | 说明 |
|---|---|---|
| modules\*.avs | 21 | **PE 可执行模块**(MZ 头,解密后合法):graphics_dx11/font_ft/audio_xa2/lang_squirrel3.1/transcoder_icu/liquid/gameobject/input 等 |
| payloader.exe | 1 | PE(不解密特例,原样存储) |
| lib\script\*.nut | 19 | Squirrel 字节码(魔数 FA FA 52 49 51 53):boot/component(asset/scene/window_manager…)/lib(action_pattern 等) |
| lib\shader\*.fx/.spv | 10 | HLSL 源(fx)+ SPIR-V 二进制(魔数 03 02 23 07) |
| app.conf / main.pl | 2 | 配置/启动脚本 |
| lib\resource\*.png | 1 | 光标图 |
| unk\* | 2 | 哈希无 fileslist 映射:SPIR-V 着色器 + HLSL 文本 |

## 2. 动态分析:判定不需要

- 解密完全在档案读取路径(文件级),无运行期密钥/内存改写;overlay 读取即解密,无「解密完成时机」问题;
- 任务预想的最坏情况(加密壳需调试器跟踪)不成立;故**未启动任何进程**,红线零风险。
- 沙箱 `.build\th175_run\`(game.exe 副本 + data.cga/cgb 硬链接)按规范预建,但从未运行,已删除。

## 3. 产物(release\tf\th175\payload_decrypted\)

55 文件按档案内路径落盘(见上表),含 MANIFEST 说明。原始 game.exe 未改动;源目录零写入。

## 4. 备注

- unk\c0d764ba、unk\e26797dd 为 fileslist.js 未收录的两条(SPIR-V/HLSL 着色器),已按魔数命名;
- 本档案与 data.cga/data.cgb(t32 已拆)共用 fileslist.js 哈希空间,命名映射复用 t32 产物副本。
