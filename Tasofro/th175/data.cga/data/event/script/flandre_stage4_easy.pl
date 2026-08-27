#============================
# フランドール ステージ4EASY　VSお空
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,嬉
,PLAYER2,隠岐奈,普
,ENEMY,空,怒

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_Inferno"");"
,Sleep,20

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,110

#お空登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#お空顔が渋い
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

@空
"最近、何か炉が汚れているなぁ@"

"これが聞いていた石油流出って
やつなのかな@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@フラン
"おや？@"

"ここは水が余り無い@"

"こんなんで練習になるのかな@"

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@隠岐奈,L
"ここにも石油を噴出させて
みたんですが@"

"全て燃えてしまっているだけです@"

"しかし、敵の力量は十分過ぎるほどです@"

"安心して練習してください@"

#隠岐奈撤収
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,フェイスIN_L

@フラン顔
"ただ戦うだけでいいのね@"

"そりゃ楽勝だわ！@"

#右を向く
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"

,フェイスIN_R

@空顔
"聞こえたぞ！@"

"石油を流出させているのは
お前だな！@"

,SqFunction,"::bgm.play(""utuho1"");"
:エネミ－決めポーズ

@空顔
"石油とともに燃え尽きれ！@"

,フェイスOUT

#お空キック乱入
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
