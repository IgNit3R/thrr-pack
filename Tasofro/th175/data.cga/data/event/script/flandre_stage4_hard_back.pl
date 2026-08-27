#============================
# フランドール ステージ4 HARD VS霊夢
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,PLAYER2,隠岐奈,普
,ENEMY,霊夢,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_oil"");"
,Sleep,120

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,300

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@フラン
"ここは？@"

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@隠岐奈
"地底の底の底……
貴方の旅の終着点です@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

@フラン
"それで、私に破壊させたい奴は
何処にいるの？@"

@隠岐奈
"今探している
ちょっと待ってなさい@"

#隠岐奈撤収
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"

@フラン
"この世の憎悪が集まった様な
何とも重苦しい場所だねぇ@"

"居心地は悪くない@"

,Sleep,30

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit

