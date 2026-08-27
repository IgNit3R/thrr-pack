#============================
# 霊夢 ステージ２ インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,霊夢,驚
,ENEMY,小傘,普

# イベントシーン開始
:main
,フェイスIN

@霊夢顔
"うわ！
洞窟内なのに雨が！？@"

@小傘顔
"ほら傘が必要だったでしょ？@"

,エネミ－決めポーズ

@小傘顔,toge_15x2_lb
"準備を怠った罰よ！
もっと水びたしになると良いわ！@"


,フェイスOUT

# 戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
