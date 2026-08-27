#============================
# 女苑 ステージ5 VSフランドール 紅魔館
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"＊おおっと＊"

# キャラ割り当て
,PLAYER,女苑,驚
,PLAYER2,紫苑,驚
,ENEMY,フラン,怒
#,ENEMY2,隠岐奈,余
,Alias,フラン,隠岐奈

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_scarlet"");"

#女苑紫苑吹っ飛んでくる
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,30

#紫苑しかめっ面

@紫苑
"あいたたた@"

#女苑素に戻る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@女苑
"何処だ？　ここ？@"

"ムカつく山の神の背中を蹴飛ばそうとした
だけなのに……@"

@紫苑
"背中にワープトラップを
仕掛けていたなんて、やられたわ@"

#女苑振り向く
,SqFunction,"::scene.rootenv.obj.player.direction_h = -1;"

@女苑
"ワープトラップ、だと@"

#女苑お怒り
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"……なる程やられた@"

"挑発してわざと背中を蹴らせる
つもりだったんだな……@"

"まんまと載せられた@"

#女苑お怒り解除
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#フラン切りかかってくる
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

#フラン不機嫌
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_angry"");"

,フェイスIN_R

@フラン顔
"\R[躱|かわ]すな
死ねい！@"

,エネミー紹介カットイン
,Sleep,30

,フェイスIN_L

@女苑顔
"だ、誰だ！？@"

#フラン怖い顔
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile"");"

@フラン顔,,フラン_普
"こいつもやっつけて良いんでしょ？@"

,フェイスOUT_R

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,SetImage,face_r,隠岐奈_余
,フェイスIN_R

@隠岐奈顔
"もちろん@"

,ImageFile,隠岐奈顔,data/event/pic/okina/02_r.png,0,0,444,80

"標的の方から背中に
飛び込んで来る事もある@"

"思う存分、戦って良い@"

,フェイスOUT_R

#隠岐奈退場
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""flandre1"");"

,SetImage,face_r,フラン_嬉
,フェイスIN_R

@フラン顔
"よーし、久々に暴れられるわー！@"

,エネミ－決めポーズ
@フラン顔,toge_10x2_lb

"今度こそ、死ねい！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
