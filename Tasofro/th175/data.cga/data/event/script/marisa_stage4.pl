#============================
# 魔理沙 ステージ４ VS村紗　核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「機能停止した核融合炉」"

# キャラ割り当て
,PLAYER,魔理沙,普
,ENEMY,村紗,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

#エネミー透明状態で定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,60

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,240

@魔理沙
"ここが……神奈子が管理する
あの地下核融合炉、か？@"

#魔理沙表情渋い
#,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"しかし寒いな……
ここは確か超高温だったと思うんだが@"

"しかも水没している
一体何が……@"

,Sleep,30

#魔理沙表情戻し
#,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

#魔理沙吹き出し表示
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

@村紗,R
"どけどけーい！
ボサッと突ったってるな！"

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,ClearBalloon,村紗

,エネミー紹介カットイン

#魔理沙怒り
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_angry"");"

@魔理沙,toge_10x2_lb
"何だと！
危ないのはどっちだ！@"

#村紗真剣
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_hate"");"

@村紗,C
"事態は一刻を争うんだ！
核融合炉の火が消えている時間は少ない！@"

#魔理沙怒りマーク
,SqFunction,"::scene.rootenv.obj.player.Spawn_Emotion(::scene.rootenv.obj.player.x - 16, ::scene.rootenv.obj.player.y - 64, EM_ANGRY);"
,Sleep,20

@魔理沙,L
"このやろう
謝ることも出来ないのか……@"

"慌てていれば何でも
許されると思うなよ！@"

,SqFunction,"::bgm.play(""murasa1"");"

#魔理沙構え
,SqFunction,"::scene.rootenv.obj.player.cut3();"
,Sleep,30

"礼儀を教えてやる！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#魔理沙操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
