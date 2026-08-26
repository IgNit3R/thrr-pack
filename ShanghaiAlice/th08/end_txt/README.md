# end_txt — eiya(th08) 结局脚本转存产物

- 源:`release\tsa\eiya\dat\th08\*.end`(14 个:end00a/b/c、end01a/b、end02a/b、end03a/b、end04a/b、end05a/b、end06a/b,只读)
- 方法:纯文本脚本——去 NUL 填充 → CP932→UTF-8 转存(游戏为 MIDI 时代结局演出脚本,无二进制结构)
- 结果:**14/14 转存成功** + **`end_deps.csv` 依赖清单**(每文件:引用音乐 @mbgm/<mid>、引用图片 @bdata/end/<jpg>)

依赖统计示例:end00a.end → th08_16.mid + end00.jpg;end00b.end → th08_16.mid + end00b.jpg/end00b0.jpg/end00b1.jpg(详见 CSV)。
转换驱动:`release\_progress\t76_convert.py`
