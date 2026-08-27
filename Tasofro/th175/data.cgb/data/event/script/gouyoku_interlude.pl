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

#@隠岐奈,R
#"1つ道具を選んで持って行くが良い"

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,SqFunction,"::scene.rootenv.obj.enemy.talk_select();"

:LOOP_TOP

,GoTo,LOOP_TOP

,Exit

#------------------------------
:sub_talk_stop

,ClearBalloon,隠岐奈

,GoTo,sub_talk_stop
,Return
#----------------------------------
#アイテム一つもって行く
:sub_item_take

,ClearBalloon,隠岐奈
@隠岐奈,R
"修行相手はさらに強くなります"

,Sleep,120
,ClearBalloon,隠岐奈
,Sleep,10

@隠岐奈,R
"戦いの役に立つ道具を
一つ差し上げましょう"

,GoTo,LOOP_TOP
#----------------------------------
#同一アイテム
:sub_item_same

,ClearBalloon,隠岐奈
@隠岐奈,R
"同じ物を選べば
道具はより強力になりますよ"

,GoTo,LOOP_TOP
#----------------------------------
#同一アイテム
:sub_item_many

,ClearBalloon,隠岐奈
@隠岐奈,R
"道具は10種まで
後はあなたの実力次第です"

,GoTo,LOOP_TOP
#----------------------------------
#ノーアイテム
:sub_no_item

,ClearBalloon,隠岐奈
@隠岐奈,R
"道具に頼らないのもいいでしょう"

,Sleep,120
,ClearBalloon,隠岐奈
,Sleep,10

@隠岐奈,R
"苦労するだけなのは保証しますよ"

,GoTo,LOOP_TOP
#----------------------------------
#ランダムドア
:sub_random_door

,ClearBalloon,隠岐奈
@隠岐奈,R
"ドアは思わぬ場所に
繋がることもあります"

,GoTo,LOOP_TOP
#----------------------------------
#汎用
:sub_common

,ClearBalloon,隠岐奈
@隠岐奈,R
"さぁ試練への扉を進みなさい"

,GoTo,LOOP_TOP
#----------------------------------
#汎用
:sub_common_2

,ClearBalloon,隠岐奈
@隠岐奈,R
"1つ道具を選んで持って行きなさい"

,GoTo,LOOP_TOP
#----------------------------------
,Exit