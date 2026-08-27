#============================
# フランドール ステージ1ノーマル　VS霊夢　
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,霊夢,普

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_forest"");"
,Sleep,60

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,110

#霊夢登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@霊夢
"再び黒い水が吹き出してきたのね@"

"うーん、でもまた地底に行って
饕餮と戦っても……@"

"どうやら吹き出している
原因は別らしいし……@"

# 地面から石油が吹き出す
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

# 驚く霊夢
"え！？
森にも黒い水が！@"

#霊夢の背中からフラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@フラン
"ここは、魔法の森か？@"

#霊夢フランに振り替える
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@霊夢,R
"一体何が始まるって言うの！？@"

#フラン振り返る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン,L
"なる程相手はあんたか@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,SqFunction,"::bgm.play(""reimu1"");"

"まあ、ちょちょいと破壊していくか@"

#戦闘開始

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
