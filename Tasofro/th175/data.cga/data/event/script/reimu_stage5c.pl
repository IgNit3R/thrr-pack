#============================
# 霊夢　ステージ5 インター2
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,霊夢,汗
,ENEMY,空,決

# イベントシーン開始
:main
,フェイスIN

@空顔
"まだ燃え尽きていないとは……@"

"こうなったら自らも
燃え尽きるつもりで焼いてやる！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
