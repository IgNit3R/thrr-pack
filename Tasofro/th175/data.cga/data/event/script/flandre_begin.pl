#============================
# フランドール 開幕演出
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,隠岐奈,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,Sleep,3

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

"最悪の獣、\R[饕餮|とうてつ]を破壊して貰いたい@"

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

,Exit
