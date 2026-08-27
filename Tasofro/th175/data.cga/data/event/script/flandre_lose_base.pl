#============================
# フランドール 負けベース帰還演出
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,隠岐奈,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -15);",# 吹き出し位置調整

:main
,SqFunction,"::bgm.play(""talk_scarlet"");"
,Sleep,90

,SqFunction,"::scene.rootenv.obj.player.cut1();"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@隠岐奈,R
"手酷くやられたようだな"

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Sleep,120

#吹き出し消去
,ClearBalloon,隠岐奈

@隠岐奈,R
"左の扉ほど敵は優しいぞ？"

,Sleep,600

#吹き出し消去
,ClearBalloon,隠岐奈

@隠岐奈,R
"随分迷うじゃないか？"

:LOOP_TOP

,GoTo,LOOP_TOP

,Exit

#------------------------------
:sub_talk_stop

,ClearBalloon,隠岐奈

,GoTo,sub_talk_stop
,Return
#----------------------------------

:sub_easy
,ClearBalloon,隠岐奈
@隠岐奈,R
"そこは控えめな相手への扉だな"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"登って扉の前に立てば挑戦できるぞ"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"この程度はお前さんに物足りんかもな"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,GoTo,sub_talk_stop

#----------------------------------

:sub_normal
,ClearBalloon,隠岐奈
@隠岐奈,R
"その扉の先は中々の敵に繋がっている"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"登って扉の前に立てば挑戦できるぞ"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"実戦で流水での戦いを掴んでくるのだ"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,GoTo,sub_talk_stop

#----------------------------------
:sub_hard
,ClearBalloon,隠岐奈
@隠岐奈,R
"その扉は強敵揃いだな"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"挑むのであれば苦行を覚悟するがいい"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,ClearBalloon,隠岐奈
"尤も、奴の本気はもっと強いがね"
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30
,Sleep,30

,GoTo,sub_talk_stop

#----------------------------------
,Exit