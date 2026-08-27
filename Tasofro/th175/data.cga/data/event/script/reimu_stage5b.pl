#============================
# 霊夢　ステージ5 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,霊夢,惑
,ENEMY,空,普

# イベントシーン開始
:main
,フェイスIN

@霊夢顔
"何で邪魔すんのよ！@"

@空顔
"不純物が喋った！@"

,エネミー紹介カットイン

@空顔,toge_10x2_lb,空_決
"消し炭も残らない超高温で
焼き尽くしてやる！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
