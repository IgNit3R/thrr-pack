#============================
# 剛欲モード通常バトル
#============================
:init
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main

,SqFunction,"print(""gouyoku_battle"");"
,Sleep,90

,SqFunction,"if(::lib.session_data.enemy_select != null){if(::lib.session_data.enemy_select == ""toutetu"" && ::scene.rootenv.obj.player.water_type == ST_BLOOD){::bgm.play(""toutetu2"");}else ::bgm.play(::lib.session_data.enemy_select + ""1"");}"
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#次ステージ分岐の状況チェックと確定
,SqFunction,"::lib.event_control.gouyoku_next_check();"

#プレイヤー操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
