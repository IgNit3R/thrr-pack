# release\tf\ 解包产物总览(t110 扫描)

- 任务:t110 | 执行:extractor-b2 | 日期:2026-08-24
- 性质:只读扫描;目录树见 `_tree.md`,全量清单见 `_inventory_tf.tsv`(91,991 行)
- **总量:91,991 文件 / 8,258,634,386 B(7,876.0 MB ≈ 7.7 GiB)**

---

## th075(萃梦想,东方萃梦想)
- **拆包来源**:t26(brightmoon 识别 Suica 格式 + 自研 Python 解析器)
- **档案/条目数**:th075.dat→215、th075b.dat→37、th075c.dat→122、th075bgm.dat→34(BGM PCM,均为合法 RIFF/WAVE);二次提取 th075_wave_extracted 233 文件
- **关键格式**:Suica(档案格式,自研解析:u16 count + 108B/条 name[100]+size+offset,滚动 XOR k=0x64 步进+0x4D);报告 `dat\_FORMAT_REPORT_th075.md`
- **整合**:无补丁(仅 _111s exe 变体,见 exe\compare.md)
- **已知缺口**:th075bgm 内层音频二次解析(见 _FORMAT_REPORT);replay 目录无 .rep 样本(t36)

## th105(绯想天)
- **拆包来源**:t27(thdat v105 官方模块;brightmoon 探测失败)
- **档案/条目数**:th105a.dat→11,937、th105b.dat→63、th105c.dat→703(合计 12,703)
- **关键格式**:`.cv2`(图像序列,th105a ×11,185 / th105c ×523)、`.cv3`(SE 音效,×418)、`.cv0/.cv1/.pat/.pal`(辅助)——Tasofro SWR 引擎私有容器(非 thanm 可读);详见 `dat\README.md`
- **补丁**:patch\106a(Inno 解树,app+dat_unpack+exe+text;t43)
- **整合**:源目录=整合版 1.06a(补丁与源一致,t43 核验)
- **已知缺口**:cv2/cv3 无现成解码器(需社区工具或自研)

## th123(非想天则)
- **拆包来源**:t28(thdat 105 系源码参考 + 自研;brightmoon/thdat 二进制均失败)
- **档案/条目数**:th123a.dat→10,626、th123b.dat→50、th123c.dat→990(合计 11,666)
- **关键格式**:`.cv2/.cv3`(同 SWR 引擎族);详见 `dat\README.md`
- **补丁**:patch\110a(Inno 解树,t43;1.10a 为最终版)
- **整合**:源目录=整合版 1.10a(与补丁一致)
- **replay/save**:replay 仅 index.csv+README(t36:score123.rpy 为存档副本非录像);save 为 t39 存档分析
- **已知缺口**:cv2/cv3 解码器缺失;录像样本缺失

## th135(心绮楼)
- **拆包来源**:t29(th135arc-alt;brightmoon 不支持 tasofro pak)
- **档案/条目数**:th135.pak→9,571、th135b.pak→1,996、th135c.pak→2,864(合计 14,431)
- **关键格式**:`TFBM`(图像,部分配 TFPA 调色板)、`TFWA`(音频=OGG 容器,改扩展名可提取)、`.nut`(Squirrel 脚本)/`.act`、`.csv`(TFCS 表)、`.pat`;工具 TFBMTool-alt/extractBM-alt/act-nut-tool
- **补丁**:patch\134b(Inno 解树,t43)
- **已知缺口**:TFBM 8bpp 需配套 TFPA 调色板;nut/act 需外部工具解析

## th145(深秘录)
- **拆包来源**:t30(th145arc)+ t107 整合
- **档案/条目数**:th145.pak→14,064、th145b.pak→112(本体 1.01);整合后 th145b_v141→598(补丁 1.41)
- **关键格式**:`TFBM/TFWA`、`.nut`(Squirrel)、TFPK v1 档案;详见 `dat\README.md`
- **整合**:`dat\integration_th145.md`(t107):1.01→1.41,以补丁 1.41 为准;原 1.01 备份于 th145b_v101_backup(112)
- **补丁**:patch\141(Inno 解树,t43)
- **已知缺口**:nut 脚本语义解析;部分 cv/TFBM 需工具

## th155(凭依华)
- **拆包来源**:t31(th145arc,直接支持 TFPK v1)
- **档案/条目数**:th155.pak→17,507、th155b.pak→1,245(合计 18,752)
- **关键格式**:`TFBM/TFWA`、`.nut`、TFPK v1;详见 `dat\README.md`
- **补丁**:patch\110d + 121b(Inno 解树,t43;两版 exe SHA256 一致,121b 主要更新 pak)
- **整合**:源目录=整合版 1.10d(110d 与源一致);121b 为更新版可正向应用
- **已知缺口**:nut 语义;TFBM 调色板配套

## th175(刚欲异闻)
- **拆包来源**:t32(th175arc;需 fileslist.js hash→文件名映射)+ t108 整合
- **档案/条目数**:data.cga→4,976、data.cgb→2,115(原版 1.14);data.cgb_v115→2,194(补丁 1.15)
- **关键格式**:`.nut`(Squirrel)、Kanako 系;详见 `dat\README.md`
- **整合**:`dat\integration_th175.md`(t108):主线 data.cgb 保持 1.14 不动,原版备份 v114_backup,补丁 1.15 完整内容 v115
- **补丁**:patch\115(Inno 解树,t43)+ payload_decrypted(t103:payloader/lib/modules 解密载荷)
- **已知缺口**:nut 语义;fileslist 映射依赖(unk 目录散件)

---

## 附:tf 侧总览统计
| 作品 | 文件数 | 体积 |
|---|---|---|
| th075 | 662 | 1,626.8 MB |
| th105 | 12,973 | 1,081.0 MB |
| th123 | 12,675 | 1,187.5 MB |
| th135 | 16,462 | 857.7 MB |
| th145 | 15,517 | 994.5 MB |
| th155 | 20,024 | 1,380.4 MB |
| th175 | 13,677 | 748.1 MB |
| **合计** | **91,991** | **7,876.0 MB** |

## 格式体系小结
- 早期(th075):**Suica** 档案 + PCM BGM(brightmoon/自研)
- 中期(th105/th123):**SWR 引擎 .cv2/.cv3** 容器(thdat v105 / 自研拆包)
- 后期(th135/th145/th155/th175):**TFPK 档案 + TFBM/TFWA + .nut** 脚本(th135arc 系工具)
- 补丁全家:**Inno Setup 安装器**(t43 实证,7 件全部,非 tsa 的 UDM/LUMP 差分)
- 整合线:t107(th145)、t108(th175)已产出 integration 文档;其余作源目录即整合版
