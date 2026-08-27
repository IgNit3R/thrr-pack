#============================
# 剛欲モード最終バトル
#============================
:init
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main

,SqFunction,"print(""gouyoku_battle"");"
,Sleep,90

,SqFunction,"::bgm.play(""toutetu2"");"
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#プレイヤー操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
