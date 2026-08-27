#============================
# 剛欲モード 隠岐奈演出バトル
#============================
:init
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main
#,SqFunction,"::bgm.play(""talk_scarlet"");"
,Sleep,10

# プレイヤー右歩き登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,90

# 隠岐奈登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""okina1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#プレイヤー操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
