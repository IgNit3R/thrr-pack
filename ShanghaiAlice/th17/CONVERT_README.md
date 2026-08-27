# th17(鬼形兽 Wily Beast and Weakest Creature) 格式转换 README — t90

- 任务:t90 | 执行:extractor-d2 | 日期:2026-08-24
- 源(只读):`release\tsa\th17\dat\`(t21 拆包产物,无子目录平铺);工具:`tools\thtk\thtk-bin-12\`
- 源目录零写入;工具输出全部落 release 侧

## 产物目录
| 目录 | 数量 | 内容/方法 |
|---|---|---|
| `anm_png\` | 375 PNG / 53 anm | 每 anm 一子目录 `anm_png\<anm基名>\`(2026-08-24 规范),`thanm.exe -x`;全部合法 PNG 头 |
| `ecl_txt\` | 22 txt | `thecl.exe -d 17`(可读伪代码,anim/ecli 引用+子函数) |
| `msg_txt\` | 79 txt | `thmsg -d 17` 普通(67:e01 外 stXXa-i 等)+ **`thmsg -e -d 17` 结局对话(12:e01–e12)** |
| `std_txt\` | 7 txt | `thstd -d 17`(st01–st07,舞台背景脚本,全部成功) |

## 关键点
1. **anm 碰撞**:跨 anm 内部路径碰撞 25 处(如 ending/ebg00.png 出现于 e01/e02/e03、face/dummy.png 出现于 6 个 anm、background/stage01/st01d.png 出现于 st01wl/st02wl)。子目录结构完整保留全部 53 份输出;抽查碰撞对 SHA256 全同(平铺覆盖无内容损失,但子目录结构为规范要求且绝对安全)。
2. **msg -e 坑(th10 实证)**:th17 的 12 个结局对话 msg(e01–e12)用 `-e -d 17` dump(含 `3;<文本>` 对话行、`10;bgm/th17_15` 音乐、`7;<anm>` 立绘引用);67 个普通 msg(stXXa-i 等)用 `-d 17`。79/79 成功。
3. 版本号=17;std 7/7 无崩溃(th09 world*.std 的 thstd 崩溃问题在 th17 st*.std 上未出现)。

## 说明
- msg dump 输出为 CP932 编码文本(工具原生输出),日文需以 CP932/Shift-JIS 打开阅读。
- anm 空输出目录(无 PNG)未单独列出,见各子目录。
