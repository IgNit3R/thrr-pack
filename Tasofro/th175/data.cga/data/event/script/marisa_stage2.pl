#============================
# 魔理沙 ステージ２
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「瘴気に満ちた密空間」"

# キャラ割り当て
,PLAYER,魔理沙,普
,ENEMY,ヤマメ,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_underground"");"

,Sleep,20

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,10

#魔理沙登場
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut1();"
,Sleep,10


#魔理沙見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"
#,Sleep,60

@魔理沙
"この洞窟に入るのは初めてだが……
思ったより広いな@"

"旧地獄まで続いているという
噂もあるが……本当かもしれん@"

#ヤマメ遭遇デモ開始
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut2();"

"あいた！"

,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut3();"
,WaitInput
,ClearBalloon,魔理沙

@ヤマメ
"よし捕まえた！
今日の獲物は大きいぞー@"

,エネミー紹介カットイン

#ヤマメ驚く
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_suprise"");"

@ヤマメ,R
"って、魔理沙！？@"

#魔理沙起き上がる
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut4();"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@魔理沙,L
"何だ何だ！？
蜘蛛が棲んでるじゃないか@"

,SqFunction,"::bgm.play(""yamame1"");"

#魔理沙きめポーズ
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut5();"

"洞窟だって、誰か掃除しないとな@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#魔理沙操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
