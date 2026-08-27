# MANIFEST — th175 game.exe overlay payload 解密产物

任务 t103 · extractor-f2 · 源:`tf\th175\game.exe` overlay(4,966,633 B,只读)

## 结论

overlay = **标准 th175 cga 档案**(非加密壳):55 文件 = Squirrel 脚本运行时层
(21 个 .avs PE 模块 + payloader.exe + 19 个 .nut 脚本 + 10 个着色器 + 配置/资源)。
解密算法(cga 档案级):file_key = size ^ offset_in_file,逐 dword 4 轮密钥变换 XOR
(见 report.md §1.2)。工具:`tools\135tk\135tk\th175arc.exe`(与 data.cga 同款)。

## 产物清单(55 文件,5,527,969 B)

- `modules\*.avs` ×21:PE 模块(graphics_dx11/font_ft/audio_xa2/lang_squirrel3.1/transcoder_icu/liquid/steam_api 等)
- `payloader.exe`:562,688 B(不解密特例,原样)
- `lib\script\**\*.nut` ×19:Squirrel 字节码
- `lib\shader\*.fx` ×5 + `*.spv` ×5:HLSL + SPIR-V
- `lib\resource\default_cursor.png`、`app.conf`、`main.pl`
- `unk\c0d764ba`(SPIR-V)、`unk\e26797dd`(HLSL):fileslist 未收录

详见 `report.md`。原始 game.exe 未改动;源目录零写入;未运行任何进程。
