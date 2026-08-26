# msg_txt — eiya(th08) 对话脚本转换产物

- 源:`release\tsa\eiya\dat\th08\msg*.dat`(**33 个**;th08 的消息文件是 .dat 后缀,th10 起才叫 .msg)
- 工具:`tools\thtk\thtk-bin-12\thmsg.exe -d 8 <msgNx.dat> <out>`(按内容识别格式,不依赖扩展名)
- 结果:**33/33 全部转换成功**(msg1a–msg8d:各角色×各面剧情对话),entry/@ 时序+文本格式
- 转换驱动:`release\_progress\t76_convert.py`
