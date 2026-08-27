#============================
# 神奈子 ステージ3 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,女苑,余,ENEMY2,紫苑,汗

:main
#,フェイスIN_R
,フェイスIN

@女苑顔
"石油も使いこなせない原始人が中々やるな！@"

,エネミ－決めポーズ

"ノッて来た！燃えてきたぜ！@"

"覚悟しろ！石油王の真価を見せてやる！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
