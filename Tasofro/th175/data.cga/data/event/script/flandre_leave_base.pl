#============================
# フランドール 開幕演出
#============================
:init

# 初期設定

:main

,Sleep,1

#プレイヤー操作停止+BGM画面フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,SqFunction,"::lib.event_control.goto_select_stage(::lib.event_control.next);"

,Exit
