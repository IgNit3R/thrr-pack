#============================
# 村紗 ステージ１
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「ついでの水没」"

# キャラ割り当て
,PLAYER,村紗,普
,ENEMY,魔理沙,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_forest"");"

#カメラ右にスクロール+ステージ背景名表示
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#魔理沙登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#魔理沙周辺を見回す
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

,Sleep,60

@魔理沙
"なんだこの水は……@"

"あちこちで黒い水が
湧いてきたときは焦ったが@"

"これは真水だな……@"


,エネミー紹介カットイン

#魔理沙素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

#村紗登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@村紗,L
"あ、魔理沙
丁度良かった@"

"森の中の洞窟って
何処にあったっけ？@"

#魔理沙怒り
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@魔理沙,R
"お前の仕業か？@"

"船だけでなくて
森その物を沈没させる気か！@"

,SqFunction,"::bgm.play(""marisa1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#魔理沙操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
