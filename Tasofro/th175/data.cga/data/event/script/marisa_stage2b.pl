#============================
# 魔理沙 ステージ２ インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,魔理沙,普
,ENEMY,ヤマメ,普

# イベントシーン開始
:main
,フェイスIN

@ヤマメ顔
"水の扱い方
中々やるじゃん@"

,エネミ－決めポーズ

"でも真水以外ならどうかな？@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
