#============================
# 女苑 ステージ5  勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,負
,PLAYER2,紫苑,負
,ENEMY,フラン,負

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#双方位置調整
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN_L

@女苑顔
"つ、強い……@"

,フェイスIN_R

@フラン顔
"ハアハア、久しぶりの
運動は気持ちいいわぁ@"

@女苑顔
"お前も石油を狙っているのか？@"

@フラン顔
"石油……何それ@"

@女苑顔
"私達は石油を奪おうとする
奴以外と戦う気は無い！@"

@女苑顔
"頼むから元の場所に
戻してちょうだい……@"

,フェイスOUT

#ドアが開く
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@紫苑
"女苑！
あの扉が開いたわ@"

#女苑反応
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@女苑
"飛び込め！@"

#扉に突撃
,SqFunction,"::scene.rootenv.obj.player.cut4();"

,SqFunction,::scene.contents["story_event"].kick_result("flandre");
,Sleep,120

,Exit
