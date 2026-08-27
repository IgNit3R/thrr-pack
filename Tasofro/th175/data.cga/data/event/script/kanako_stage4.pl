#============================
# 神奈子 ステージ４ VS村紗 核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「青暗い核融合炉」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,村紗,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,60

@神奈子
"……何だこれは！？@"

"貧乏神達の仕業か？@"

"いや……あいつ等は石油に夢中で
こんな嫌がらせをする意味は無い@"

"そもそもこんな大量の水は
何処から持ってきたのか？@"

"尋常な手段では
核融合炉の火は消せないが@"

"こんな事が出来る能力者なんているのか……@"

#神奈子吹き出し表示+水音
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"そこに居るのは誰だ！？
隠れてないで出てこい！@"

@村紗,R
"どけどけーい！
ボサッと突ったってるな！"

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,ClearBalloon,村紗

,エネミー紹介カットイン

#エネミー登場後半
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,Sleep,30

"って、おおっと
貴方は……！@"

@神奈子,L
"舟幽霊か@"

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

"なる程な、命蓮寺の仕業だな？
舐めた真似しやがって@"

#神奈子決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"余計な仕事を増やした責任は
お前の溺死だけでは済まされないぞ！@"

,SqFunction,"::bgm.play(""murasa1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#神奈子操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
