#============================
# 剛欲モード　霊夢開始
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「強欲なる挑戦へようこそ」"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,隠岐奈,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -15);",# 吹き出し位置調整

:main
,SqFunction,"::bgm.play(""talk_door"");"
,Sleep,90

,SqFunction,"::scene.rootenv.obj.player.cut1();"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#@隠岐奈,R
#"さぁ腕試しの扉をくぐるが良い"

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Sleep,15

,GoTo,SUB_TALK

:LOOP_TOP

,GoTo,LOOP_TOP

,Exit

#------------------------------
:SUB_TALK

,ClearBalloon,隠岐奈
@隠岐奈,R
"剛欲のドアを開いたようですね"

,Sleep,120
,ClearBalloon,隠岐奈
,Sleep,10

@隠岐奈,R
"そんな欲深いあなたには
とびきりの修行相手を用意しました"

,Sleep,120
,ClearBalloon,隠岐奈
,Sleep,10

@隠岐奈,R
"さぁ試練への扉を進みなさい"

,GoTo,LOOP_TOP
#----------------------------------

,Exit