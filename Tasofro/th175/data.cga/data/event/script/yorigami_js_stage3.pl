#============================
# 女苑 ステージ３ VSお空 灼熱地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「獄炎の鳥」"

# キャラ割り当て
,PLAYER,女苑,普
,PLAYER2,紫苑,普
,ENEMY,空,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_Inferno"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,Sleep,90

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

,SqFunction,"::scene.rootenv.obj.player.cut2();"

@女苑
"熱い熱い！@"

"凄い勢いで水が引いたと
思ったら、すぐにこれとは@"


@紫苑
"さっきの鳥の言うとおりに
なったわね@"

"でも本当にこの先に石油があるのー？@"

@女苑
"それは間違いないわ@"

#回避
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#女苑驚き
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_angry"");"

"危ない！@"

#再回避
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#頭上見上げ
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_upper"");"

@女苑,toge_10x2_lb
"何だ！
誰の仕業だ！@"

#エネミー登場
,SqFunction,"::bgm.play(""utuho1"");"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
