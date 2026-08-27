#============================
# フランドール ステージ1　HARD　VS勇儀　
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,勇儀,普

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_town"");"
,Sleep,60

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,110

# 勇儀登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@勇儀
"今日も温泉街は騒々しい@"

"あちこちから殺気立った
怒号が聞こえるな@"

,SqFunction,"::scene.rootenv.obj.enemy.direction_h = 1;"
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile"");"

"ふふん
活気があって良いことだ@"

# 石油噴出
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

# 驚く勇儀
"な、これは石油だ
何故温泉街に！？@"

#勇儀の背中からフラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@フラン
"ここは何処？@"

#勇儀フランに振り替える
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@勇儀,R
"何だお前？
一体何処から……@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_angry"");"

@フラン,L
"ここは臭いわね@"

"それに苦手な流水だらけで
長居はしたくないわ@"

#フラン振り返ってポーズ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"さっさと処理して
次に行きたいわ@"

#勇儀決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut4();"

@勇儀
"やる気か？
良いだろう、かかってこい！@"

#戦闘開始
,SqFunction,"::bgm.play(""yuugi1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
