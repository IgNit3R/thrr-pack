# th095 anm_png 目录说明(修订:按新规范每 anm 一子目录)

> 任务 t78 · extractor-e2 · 2026-08-24(修订于队内规范更新后)

## 来源与工具
- 源:`release\tsa\th095\dat\th095\*.anm`(120 个,th095.dat 拆包产物,只读)
- 工具:thtk v12 `thanm.exe -x`(输出跟随 CWD → 每 anm 独立子目录内执行)

## 产物(新规范布局)
- **120 个子目录 `anm_png\<anm基名>\`,每个 anm 独立提取**,共 **195 张 PNG**,内部按条目路径(data\...)
- 分布:83 个 anm 各 1 图、16 个各 3 图、9 个各 4 图、9 个各 2 图、1 个(enm 系)10 图、2 个 0 图(capture/text,纯 @ 条目)

## 修订说明(原平铺 → 子目录)
- 初版平铺提取后发现**跨 anm 碰撞:`data/cdbg/cdbg00.png` 同时存在于 enm3.anm 与 enm4.anm**,平铺时互相覆盖(实测两副本字节相同,内容无损,但布局违规);
- 按队长新规范全量重提为每 anm 一子目录,碰撞条目现双份齐全(enm3\data\cdbg\cdbg00.png 与 enm4\data\cdbg\cdbg00.png);
- 旧平铺 data\ 树已删除;ecl/msg/std 不受影响。

## 已知限制(不变)
- **19 个 `@` 名条目被 thanm 跳过**(capture×1/pause×1/photo×11/text×1/title×5):无文件名可写,显式提取亦无效;capture/text 因此零 PNG。如需补提须自研 VERSION 4 anm 解析器(已知缺口)。

## 关联
- 进度:`release\_progress\t78.md`;碰撞检测脚本 `release\_progress\t78_collision_check.py`
