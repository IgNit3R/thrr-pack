#============================
# 剛欲モード 霊夢乱入演出バトル
#============================
:init
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_oil"");"
,Sleep,90

# プレイヤー右歩き登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# 霊夢登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::bgm.play(""reimu1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#次ステージ分岐の状況チェックと確定
,SqFunction,"::lib.event_control.gouyoku_next_check();"

#プレイヤー操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
