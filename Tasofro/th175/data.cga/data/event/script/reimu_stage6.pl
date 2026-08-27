#============================
# 霊夢 ステージ6　VS饕餮　石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「この世で最も呪われた液体」"

# キャラ割り当て
,PLAYER,霊夢,汗
,ENEMY,饕餮,普

# イベントシーン開始
:main
#,Sleep,60

#暗黒空間を落下開始
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,60

@霊夢
"ふう、やっとの事で灼熱地獄を
通り過ぎたみたいね@"

"この先に石油の埋蔵源がある筈！@"

,Sleep,30

#画面外に落下
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,120

"……だけど、一体
どんだけ深いのー！？@"

#フェードアウトからシーン切り替え　霊夢石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,Sleep,60

"こ、ここは……@"

,Sleep,30

#石油の海登場
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,240
,Sleep,360

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"
"石油だ@"

"石油の海だ！
本当にあったんだ……@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"
,Sleep,60

#右に移動
,SqFunction,"::scene.rootenv.obj.player.cut5();"

,Sleep,120

@饕餮
"……一つ掘っては金のためー
二つ掘っては国のためー@"

"三つ掘っては憎しみのため……@"

#饕餮肩越し振り返り
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

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

@霊夢,L
"な、何者？
石油の海で一体何を@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""sit"");"

@饕餮
"ふふふ、勿論飲んでたのさ
栄養豊富だぜ？@"

@霊夢
"え？
の、飲めるの？@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮
"冗談だよ
クックック@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"あ、その格好
お前、もしかして……@"

"巫女って奴だな？
博麗霊夢だろ@"

#霊夢表情渋い
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

@霊夢
"何で知ってるの@"

@饕餮
"畜生界では部下のオオワシが
お世話になったそうだな@"

#背景明るく　饕餮の影消去
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,Sleep,60

,フェイスIN_R

@饕餮顔
"私は剛欲同盟の長
\R[饕餮|とうてつ]\R[尤魔|ゆうま]だ@"
@饕餮顔,,饕餮_嬉
"埴安神袿姫をやっつけてくれて
ありがとうな@"

,エネミー紹介カットイン
,Sleep,30
#饕餮肩で笑う
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮顔,,饕餮_余
"お陰で畜生界は元の
弱肉強食の世界に元通りだ@"

"クックック@"

#霊夢素に戻る
#,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

,フェイスIN_L

@霊夢顔,,霊夢_汗
"あんたは畜生界の奴かー
嫌な予感しかしないなぁ@"

#霊夢決めポーズ
,Hide,霊夢顔,10
,Sleep,20

,SqFunction,"::scene.rootenv.obj.player.cut6();"

,SetImage,霊夢顔,霊夢_決
,Show,霊夢顔,10

"さって、さくっと
こいつを倒して@"

"石油の噴出を制御する方法を
見つけよーっと@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

,フェイスOUT

@饕餮
"そうか、地上の人間も
石油に目を付けたか@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

"素晴らしいよなぁ
燃料になるし、栄養豊富だし@"

"何より、この世の何よりも
呪われているしね……@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"だがな、一歩遅かったなぁ@"

"ここに埋蔵されている石油は
全て私のもんだ@"

"石油に纏わる\R[喜悦|きえつ]も利便も
呪詛も憎悪も欲望も全て──@"

#饕餮決め
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

#霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
