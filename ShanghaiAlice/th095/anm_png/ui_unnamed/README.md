# th095 ui_unnamed(@名 anm 条目)补提报告

> 任务 t99 · R4·th095 无文件名 UI 图补提 · extractor-e2 · 2026-08-24
> 解析器:`release\_progress\t99_anm_parse.py`(自研 VERSION 4 anm 解析器,依据 thtk `thanm.c`/`anm_types.h` 布局)

## 结论(一句话)

**19 个『@』名条目全部为「无内嵌纹理」的 sprite/script 定义条目(hasdata=0, thtxoffset=0),其纹理由游戏运行时(Direct3D)自建,不存在可从文件导出的像素数据——无图可补,输出改为「引用关系确认报告 + 映射表」。**

## 1. 依据(三重证据链)

1. **二进制直读**(自研解析器,5 个 anm 全条目解析):19/19 条 `@` 条目 `hasdata=0`、`thtxoffset=0`,即无 THTX 纹理块;仅有头声明(尺寸/格式/色键)+ sprite 列表 + 脚本;
2. **thtk 源码断言**:`thanm.c` L1102-1104 `assert((hasdata==0 || name[0]=='@') == (thtxoffset==0))`——名为 `@` 的条目在格式上被设计为无纹理条目(hasdata=0 ⇔ thtxoffset=0);`anm_extract` 对无尺寸条目直接 return(「nothing to extract」),故 thanm 跳过它们属**正确行为**;
3. **exe 字符串佐证**:th095.exe 加载 capture/text/pause/photo/title.anm,并含 `snapshot\th%.3d.bmp` 保存代码——capture 的 512×512 RGB565 纹理即截图回写目标,text 的 512×256 ARGB4444 为字体渲染板,photo 的 11 个 256×256 BGRA8888 为滤镜/合成纹理,均游戏运行时创建。

## 2. 条目映射表(mapping.csv,19 行)

| anm | 条目# | 尺寸 | 格式 | sprites | 纹理来源判定 |
|---|---|---|---|---|---|
| capture.anm | 0 | 512×512 | RGB565 | 3 | 运行时(截图框) |
| pause.anm | 0 | 128×128 | RGB565 | 1 | 运行时 |
| photo.anm | 0–10 | 256×256 ×11 | BGRA8888 | 1/条 | 运行时(滤镜/合成) |
| text.anm | 0 | 512×256 | ARGB4444 | 41 | 运行时(字体板) |
| title.anm | 1,2,3,4,13 | 256×256/256×64/512×512 | BGRA/ARGB | 1–17 | 运行时(特效/转场) |

判定口径:同文件内无「同尺寸+同格式」具名纹理条目(如 title@[1] 256×256 BGRA8888 vs 兄弟 title01.png 256×256 ARGB4444,格式不同)——故全部判运行时自建。

## 3. 被引文件确认(任务要求「确认被引文件是否已存在」)

- 上述 5 个 anm 内**具名条目**(非 @)已全部提取,确认落盘于 `anm_png\<anm>\data\...`:
  - pause → data/ascii/pause.png ✓
  - photo → data/bullet/photo.png、photo2.png、photobk.png、data/title/title00line2.png ✓
  - title → data/title/title00a/b/line、title01、02、03a/b、04、05、06 ✓
  - capture/text → **无具名条目**(纹理纯运行时,无文件可确认,属预期)
- 结论:被 @ 条目"引用"的静态纹理(若有)均已存在;运行时纹理无对应文件。

## 4. 产出

- `mapping.csv`(19 行:anm/entry_idx/name/version/hasdata/thtxoffset/width/height/format/colorkey/sprites/scripts/texture_source)
- `STRUCTURE.md`(5 个 anm 全部条目原始解析转储,含具名条目的 THTX 明细)
- 本 README

> 备注:与 t78 记录的「19 个 @ 条目被 thanm 跳过=已知缺口」形成闭环:缺口性质为「运行时不落盘纹理」,非「可导出未导出」。
