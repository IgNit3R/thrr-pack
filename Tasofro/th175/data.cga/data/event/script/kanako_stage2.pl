#============================
# 神奈子 ステージ2　VS霊夢　核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「過去のエネルギー」"

# キャラ割り当て
,PLAYER,神奈子,決
,ENEMY,霊夢,決

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

,Sleep,60

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

@神奈子
"やはりそうか@"

#神奈子渋い顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

"融合炉の調子が
おかしいと思ったら@"

"炉に原油が流れ込んでいる@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

# FIXME
"このままでは不純物が溜まって
廃炉になってしまう……@"

#神奈子表情戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

,Sleep,6

#右を向く
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"

,Sleep,6

@神奈子,L
"そこにいるのは何者だ！@"

,Sleep,30

#霊夢登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,エネミー紹介カットイン
,Sleep,30

"ああ、霊夢
わが核融合炉に何かご用？@"

@霊夢,R
"地上で起きている異変について
調査をしていてね……@"

@神奈子
"……@"

@霊夢
"地底から石油という黒い水が
湧いてきて困っているんだけど@"

@神奈子
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

#首を振る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

@神奈子
"……いや、何も@"

#素に戻る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

#心の声フキダシ設定
@神奈子,kumo_10x2_lb
"霊夢が石油の調査？
これは人為的な異変なのか？@"

"だとしても、今すぐに霊夢に
行かせるのは危険だ@"

"今は灼熱地獄が
暴走状態にある@"

"しらばっくれて追い返すか@"

#フキダシ通常
@神奈子,L
"石油が湧いているというのも
初めて聞いたわ@"

"核融合炉は石油のような
化石燃料を必要としないし@"

"そんなもの無くても燃え続けるからね@"

#霊夢驚く
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@霊夢
"え？　燃える？
石油って燃えるの？@"

#神奈子呆れ顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

@神奈子
"え、知らなかったの？@"

"石油は燃え続けるわよ
とんでもなく@"

#霊夢慌てる
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@霊夢
"た、大変だ
そんな物が地上のあちこちに……@"

#霊夢素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@神奈子
"と言うわけで、すぐに地上に戻って
除染作業したほうが良いんじゃない？@"

#神奈子営業スマイル
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile"");"

"核融合炉は石油を必要としない
クリーンな施設ですので@"

@霊夢
"い、いやしかし
地下深くに原因があるって情報も有るし@"

"ここからしか最下層まで
降りられないと……@"

#霊夢素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"ん？　ところで核融合炉って
何で燃え続けているの？@"

#神奈子素に戻る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@神奈子
"水素原子の核融合です
急になんですか？@"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_face"");"

@霊夢
"そうだわ@"

"無知には判らないと
思って舐められてたわ@"

"核融合って石油のことでしょ@"

@霊夢
"だから地下深くに炉があるんでしょ？
石油がある層の近くに！@"

@神奈子
"……@"

#神奈子悪い笑顔
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,フェイスIN_L

,SqFunction,"::bgm.play(""reimu1"");"

@神奈子顔
"案外、鋭いね@"

"だとしたらどうする？@"

,SetFocusOffset,0,0,0,0

#霊夢が構える
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,フェイスIN_R


#,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", -360, 0);",# 吹き出し位置調整

@霊夢顔,toge_10x2_lb
"ここを破壊して埋め立てて
石油の流出を止めてやる！@"

,フェイスOUT

#神奈子ポーズ解除
,SqFunction,"::scene.rootenv.obj.player.cut3();"
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
