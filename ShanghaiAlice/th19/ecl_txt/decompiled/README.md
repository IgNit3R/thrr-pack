# th18/185/19/20 ecl 指令级反编译产物说明

- 任务:t96 | 执行:pe-analyst2 | 日期:2026-08-24
- 解析器:`release\_progress\t96_ecl\t96_ecl_decomp.py`(纯 Python,依据 thtk 源码 thecl10.c/expr.c/value.c 自研)
- 格式表:`release\_progress\t96_ecl\ecl_fmts.py`(thtk 源码自动提取,版本继承链 th10→…→th20)

## 输出格式

```
anim { "enemy.anm"; "st01enm.anm"; }        ← 资源引用
ecli { "default.ecl"; "st01bs.ecl"; }
void MainBossSpell();                        ← 前向声明
void Cir00()                                 ← 子程序
{
    !*                                       ← rank 掩码语义化(!E/N/H/L/X/O;185/19=数字难度位)
    ins_40(0);                               ← 指令:ins_<id>(解码后参数)
    ins_12(@Cir00_400, @Cir00_356);          ← 跳转指令,标签已解析
    Cir00_400:                               ← 标签 = 子程序名_指令偏移
    ins_15("Cir00_at");                      ← 子程序调用(字符串参数 cp932 解码)
    ins_44(2.7488935);                       ← 浮点参数
    ins_42($-9987);                          ← $ = 栈引用(var 访问)
}
```

## 参数类型解码

| 格式字符 | 含义 | 输出 |
|---|---|---|
| S | int32 | 数字 |
| f | float32 | 浮点(%.9g) |
| m | u32 长 + 原始串 | "字符串"(cp932) |
| x | 同上,XOR(0x77, 每 7/16 字节) | "字符串" |
| o/t | 相对偏移 int32 | @标签 或 数字 |
| D/H | thecl_sub_param_t 8B | 数字(栈引用 $) |
| * | 重复到数据尽 | — |

## 覆盖

| 作品 | 版本 | ecl 数 | 反编译 | 目录 |
|---|---|---|---|---|
| th18 | 18 | 22 | 22/22 | th18\ecl_txt\decompiled\ |
| th185 | 185 | 114 | 114/114 | th185\ecl_txt\decompiled\ |
| th19 | 19 | 43 | 43/43 | th19\ecl_txt\decompiled\ |
| th20 | 20 | 21 | 21/21 | th20\ecl_txt\decompiled\ |

## 验证

- 与官方 thtk(th17)交叉验证:指令序列、参数、标签目标逐指令一致(差异仅在表达式合并/goto 助记符层级);
- 四作 200/200 解析,0 失败;
- 语义化增强(表达式/goto/async 助记符)未做,输出原始指令行+操作数表(任务允许口径)。
