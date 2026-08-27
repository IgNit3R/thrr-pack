#============================
# 女苑　ステージ5 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,汗
,PLAYER2,紫苑,汗
,ENEMY,フラン,余

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@フラン顔
"中々やるじゃないの@"

"準備運動にしてはちょっと
過剰かもしれないわ@"

,SetImage,女苑顔,女苑_驚
,エネミ－決めポーズ


@フラン顔,toge_10x2_lb
"そろそろ終わりに
しましょう！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
