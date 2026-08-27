#============================
# 霊夢 ステージ5　VSお空　灼熱地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「今日も地底は熱すぎる！」"

# キャラ割り当て
,PLAYER,霊夢,普
,ENEMY,空,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_Inferno"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,90

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,240
,Sleep,360

@霊夢
"あ、熱い！
熱すぎる！@"

#左右見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

"本当にここを通るしかないの！？@"

#回避
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"危ないなぁ
火も降ってくるし@"

#再回避
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#左右見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

"って、私を狙っている！？@"

#エネミー登場
,SqFunction,"::bgm.play(""utuho1"");"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
