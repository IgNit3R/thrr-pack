#============================
# 村紗 ステージ２
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「必然的に水没」"

# キャラ割り当て
,PLAYER,村紗,普
,ENEMY,小傘,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_underground"");"

#カメラ右にスクロール+ステージ背景名表示
,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@小傘
"お、溺れるー@"

"このままでは生き埋めになってしまう@"

,エネミー紹介カットイン

#村紗登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@村紗,L
"さっさと逃げて！
もうすぐ洞窟は水没するよ！@"

"でも、何故こんな所に？@"

#小傘船に乗り込む
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@小傘,R
"ムラサ……
ははーん、やっぱりね@"

"黒い水に関して命蓮寺で
怪しい動きをしていたわよね@"

@村紗
"それが何か？@"

#小傘不満ポーズ
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@小傘
"何で私も混ぜてくれないのよー
黒い水騒ぎ、面白そうじゃない@"

@村紗
"もちろん良いわよ@"

#小傘びっくりポーズ
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@小傘
"え？@"

,SqFunction,"::bgm.play(""kogasa1"");"

#村紗決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@村紗
"私に勝てたらね@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#村紗操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
