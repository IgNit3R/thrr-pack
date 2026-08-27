#============================
# 霊夢 ステージ４　VS神奈子　核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「未来のエネルギー」"

# キャラ割り当て
,PLAYER,霊夢,決
,ENEMY,神奈子,決

#神奈子透明状態で定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,Sleep,60

#霊夢見渡す
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@霊夢
"ここは……@"

#霊夢表情渋い
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"ここは知っている@"

"そうか、旧地獄の最下層に
繋がっている場所って……@"

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

#霊夢表情怒り
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"旧地獄核融合炉！@"

"守矢神社の施設ね……
嫌な予感がするわ@"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,Sleep,200

#霊夢表情戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

#霊夢吹き出し表示
,SqFunction,"::scene.rootenv.obj.player.cut2();"
@神奈子,R
"何者だ@"

#,Sleep,30

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,エネミー紹介カットイン

,Sleep,30

@神奈子

"ああ、霊夢
わが核融合炉に何かご用？@"

@霊夢,L
"地上で起きている異変について
調査をしていてね……@"

@神奈子,C
"……@"

@霊夢
"地底から石油という黒い水が
湧いてきて困っているんだけど@"

@神奈子,R
"……へえ@"

@霊夢
"旧地獄の鬼が言うには
石油は最下層に近い部分にあるとか@"

"最下層に行くにはここから
しかいけないって@"

"何か聞いてない？@"

#無言表示
#,SqFunction,"::scene.rootenv.obj.enemy.cut3();"
,Sleep,30

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_swing"");"

@神奈子,R
"……いや、何も@"

#神奈子素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"石油が湧いているというのも
初めて聞いたわ@"

"核融合炉は石油のような
化石燃料を必要としないし@"

"無くても燃え続けるからね@"

#霊夢驚く
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut3();"

@霊夢
"え？　燃える？
石油って燃えるの？@"

#神奈子呆れ顔
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"
@神奈子
"え、知らなかったの？@"

"石油は燃え続けるわよ
とんでもなく@"

#霊夢慌てる
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@霊夢
"た、大変だ
そんな物が地上のあちこちに……@"

#神奈子素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@神奈子
"と言うわけで、すぐに地上に戻って
除染作業したほうが良いんじゃない？@"

#神奈子営業スマイル
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile"");"

"核融合炉は石油を必要としない
クリーンな施設ですので@"

@霊夢
"い、いやしかし
地下深くに原因があるって情報も有るし@"

"ここからしか最下層まで
降りられないと……@"

#霊夢素に戻る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"ん？　ところで核融合炉って
何で燃え続けているの？@"

#神奈子素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@神奈子
"水素原子の核融合です
急になんですか？@"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

@霊夢
"そうだわ@"

"無知には判らないと
思って舐められてたわ@"

"核融合って石油のことでしょ@"

"だから地下深くに炉があるんでしょ？
石油がある層の近くに！@"

@神奈子,C
"……"

#神奈子悪い笑顔
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"
,ClearBalloon,神奈子
,Sleep,20

,フェイスIN_R

,SqFunction,"::bgm.play(""kanako1"");"

@神奈子顔
"案外、鋭いね@"

"だとしたらどうする？@"

#霊夢が構える
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut4();"

,フェイスIN_L

@霊夢顔,toge_10x2_lb
"ここを破壊して埋め立てて
石油の流出を止めてやる！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
