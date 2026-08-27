#============================
# 体験版 ステージ１ 勝利
#============================
:init

# 初期設定
:main

,Sleep,60
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,SqFunction,"::lib.event_control.goto_next_stage();"

,Exit
