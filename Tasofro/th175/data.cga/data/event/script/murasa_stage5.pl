#============================
# 村紗 ステージ５ VSお空 冷えた灼熱地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「再加熱する前に！」"

# キャラ割り当て
,PLAYER,村紗,普
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
,Sleep,360

#左右見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@村紗
"よし、また燃え始めているけど
暑さはそれほど無い@"

"今のうちに潜ろう！@"

#回避
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#村紗しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise"");"

"ヤバイ、もうこんなに炎が？@"

#再回避
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#見上げる
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_upper"");"

@村紗,geki_10x2_lb
"って、私を狙っているな！@"

#エネミー登場
,SqFunction,"::bgm.play(""utuho1"");"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
