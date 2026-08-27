#============================
# フランドール 開幕演出
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「秘神と破壊神の長い一日」"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,隠岐奈,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, 0);",# 吹き出し位置調整

# イベントシーン開始
:main

,SqFunction,"::bgm.play(""talk_scarlet"");"
#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,Sleep,1

#背景横スクロール + ロゴ表示
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,60

@フラン,L
"……なるほど、地の底ではそんな
面白い事になっていたのね@"

"それで私に何をしろって？@"

@隠岐奈,R
"飲み込みが早くて助かる@"

"なんでも破壊できるという貴方には@"

"最悪の獣、饕餮を破壊して貰いたい@"

#フランはしゃぐ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン
"やったー！
楽しそう！@"

@隠岐奈
"その為には、貴方は流水の中での
戦闘に慣れる必要がある@"

#隠岐奈ドヤ顔

"その為の練習相手を用意したぞ@"

#扉出現
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

"さあ、好きな扉を選べ！@"

,Sleep,60

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,SqFunction,"::scene.rootenv.obj.enemy.loop();"

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
