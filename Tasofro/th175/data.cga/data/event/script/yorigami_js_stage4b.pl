#============================
# 女苑　ステージ4 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,怒
,PLAYER2,紫苑,怒
,ENEMY,神奈子,怒

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@神奈子顔
"石油に群がる亡者め！@"

"さっきの羊といい
疫病神といい@"

"お前達みたいのが勝手な行動を
取るから事態が悪化するんだ！@"

,エネミ－決めポーズ

#@神奈子顔,geki_10x2_lb
"石油に溺れて死ね！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
