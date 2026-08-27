#============================
# アイテム補給ステージ
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,隠岐奈,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -32);",# 吹き出し位置調整

:main
,SqFunction,"::bgm.play(""talk_door"");"
,Sleep,90

,SqFunction,"::scene.rootenv.obj.player.cut1();"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit

#------------------------------
:sub_talk_stop

,ClearBalloon,隠岐奈

,GoTo,sub_talk_stop
,Return
#----------------------------------

,SqFunction,"::scene.rootenv.obj.enemy.loop();"
,Exit