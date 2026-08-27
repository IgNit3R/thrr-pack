#============================
# フランドール ステージ2HARD　VS村紗
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,村紗,普

#　マップに石油オブジェクトを設置
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_reactor"");"
,Sleep,20

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,10

#村紗登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"
,Sleep,10

#村紗周囲見まわし
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@村紗
"核融合炉が黒い水に
沈んでいる……@"

#村紗右をむいて頭掻き
,SqFunction,"::scene.rootenv.obj.enemy.direction_h = 1;"
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_cheat"");"

"これは私達の所為じゃない……
よね？@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン
"わあ、黒い水だらけ！@"

"こんな場所でも戦わないと
行けないの？@"

#村紗驚き
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@村紗,R
"何だ！？
どっから出てきた？@"

#フラン振り向き
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@フラン,L
"次の相手は……
うわ、私の苦手な奴だ@"

"船なんてよく乗れるわよね@"

"あんな呪われた乗り物@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@村紗
"安心して！　私の船は
乗るためにあるんじゃないわ@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@フラン
"ほう@"

#村紗決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""murasa1"");"

@村紗
"沈めるためにあるのよ！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
