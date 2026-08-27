#============================
# 魔理沙 ステージ６ VS饕餮　石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「この世で最も呪われた液体」"

# キャラ割り当て
,PLAYER,魔理沙,驚
,ENEMY,饕餮,普

# イベントシーン開始
:main
#,Sleep,120

#暗黒空間を落下開始
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,60

@魔理沙
"滝ゾーンはもう終わったみたいだが……@"

,Sleep,30

#画面外に落下
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

"どこまで落ち続けるんだー！？@"

#フェードアウトからシーン切り替え　魔理沙石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#左右見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"
,Sleep,60

"こ、ここは……@"

,Sleep,30

#石油の海登場
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_oil"");"
#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,240
,Sleep,360

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"
"黒い水？@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"
"辺り一面黒い水！
ここは石油の海だ！@"

#右に移動
,SqFunction,"::scene.rootenv.obj.player.cut5();"

#魔理沙しかめっ面
#,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

,Sleep,120

@饕餮
"……一つ掘っては金のためー
二つ掘っては国のためー@"

"三つ掘っては憎しみのため……@"

#饕餮背後に気づく
,SqFunction,"::scene.rootenv.obj.enemy.cut4();"

@饕餮,R
"誰だ？@"

#饕餮プレイヤーに向きなおる
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

"こんな所にいるなんて@"

"お前、ただ者じゃないな@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

"私と同類か？
クックック@"

@魔理沙,L
"こんな地の底にも
誰かいるなんて驚いたな@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@饕餮
"それはこっちの台詞だ@"

"あ、その格好
お前、もしかして……@"

"霧雨魔理沙だろ@"

#魔理沙驚き
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise"");"

@魔理沙
"え？
そんなに有名？@"

@饕餮
"畜生界では部下のオオワシが
お世話になったそうだな@"

#魔理沙素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

#背景明るく　饕餮の影消去
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,フェイスIN_R

@饕餮顔,,饕餮_普
"私は剛欲同盟の長
\R[饕餮|とうてつ]\R[尤魔|ゆうま]だ@"

,エネミー紹介カットイン
,Sleep,30

@饕餮顔,,饕餮_余
"\R[勁牙組|けいがぐみ]の\R[驪駒|くろこま]がお前のこと
気に入っていたぜ@"

@饕餮顔,,饕餮_惑
"あいつは単純で力馬鹿な奴を
好むからな@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮顔,,饕餮_嬉
"クックック@"

,フェイスIN_L

@魔理沙顔
"もしかして、畜生界の奴か！？@"

@魔理沙顔,,魔理沙_汗
"何故、こんな地の底に……@"

@饕餮顔,,饕餮_惑
"そうか、地上の人間も
石油に目を付けたか@"

@饕餮顔,,饕餮_余
"素晴らしいよなぁ
燃料になるし、栄養豊富だし@"

@饕餮顔,,饕餮_嬉
"何より、この世の何よりも
呪われているしね……@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

,フェイスOUT

@饕餮

"だがな、一歩遅かったなぁ@"

"ここに埋蔵されている石油は
全て私のもんだ@"

"石油に纏わる\R[喜悦|きえつ]も利便も
呪詛も憎悪も欲望も全て──@"

#饕餮決め
,Hide,饕餮顔,20
,SetImage,魔理沙顔,魔理沙_驚

,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""toutetu1"");"

,Sleep,60

@饕餮顔,toge_15x2_lb,饕餮_決
,フェイスIN_R

"一滴残らず私のもんだ！
人間なんかにくれてやるもんか！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#魔理沙操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit

