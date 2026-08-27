#============================
# 霊夢 ステージ3　VS勇儀
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「水没した最深歓楽街」"

# キャラ割り当て
,PLAYER,霊夢,決
,ENEMY,勇儀,余

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_town"");"

#背景デフォルトで暗く
,SqFunction,"::scene.rootenv.stage.map.back_fade = 1.0;"

,Sleep,150

#霊夢登場
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut1();"
,Sleep,30

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

@霊夢
"うっ、何この強烈な匂い……
黒い水の匂いではないけど@"

"地上でも嗅いだことのある
このゆで卵のような匂い……@"

#霊夢真顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"妖怪の山で嗅いだ匂い
疲れが取れる場所で嗅いだ匂い@"

"もしかして
この心沸き立つ場所は……！？@"

,Sleep,15

#------------------------
#霊夢操作受付開始
#,SqFunction,"::scene.rootenv.obj.player.enable_move_temp();"

#霊夢一定距離右へ進むのを監視
#,SqFunction,"while(::scene.rootenv.obj.player.x < 640 + 1280)suspend();"
#,SqFunction,"::scene.rootenv.obj.player.check1();"

#操作受付を停止
#,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut3();"

#*手動途中操作パートを削除
#------------------------

#霊夢右へ歩きつつ背景が明るく変化
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut3();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

#温泉発見メッセージ
#,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut4();"

,Sleep,210

"温泉だ！
しかも街まである！@"

"地底にこんな街もあったのね
雪が降る死んだ街だけじゃないんだ@"

#勇儀遭遇デモ開始
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut5();"

,エネミー紹介カットイン

@勇儀,R
"おお、霊夢殿
今日は何の用だ？@"

@霊夢,L
"お前は……勇儀！
旧地獄の鬼の@"

@勇儀
"そう、この旧地獄温泉街の元締めだよ@"

@霊夢
"お、やっぱり温泉だったのね！
やったぁ@"

@勇儀
"なんだ？
ここを温泉だと知らないで来たのか？@"

@勇儀
"まあ良い
で、何の用だと聞いているんだが@"

@霊夢
"温泉に入りに……じゃなくて@"

@霊夢
"黒い水が地底から……@"

@勇儀
"……なる程、黒くて臭い水が
地上に湧き出ていると@"

@霊夢
"多分地底から湧いている筈なんだけど@"

#霊夢見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@霊夢
"この辺は白くて臭いお湯が
湧いているだけね@"

@勇儀
"ふっふっふ、恐らく、私には
その黒い水の正体が判るぞ@"

#霊夢見渡し終わり
,SqFunction,"::scene.rootenv.obj.player.select_motion(""stand"");"

@霊夢
"え？@"

@勇儀
"その黒い水は旧地獄の中でも
アンタッチャブルなゾーンで湧く@"

"呪いに呪われた液体だ@"

@霊夢
"やっぱり旧地獄の水だったのね@"

@勇儀
"使い方を間違えなければ
富をもたらすとも言うが……@"

"それを手にする者には
必ず禍いが起こると言われている@"

"人間の世界では何て言ったかな@"

"石のあぶらと書いて……
石油、と言ったような@"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

@霊夢
"せきゆ……？@"

@勇儀
"ただ、何故地上に湧いているのかは
見当も付かんがな@"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""stand"");"

@霊夢
"そう、情報ありがとう
やっぱり自分で確かめに行くしかなさそうね@"

@霊夢
"そのアンタッチャブルなゾーンって
何処から行くの@"

#勇儀一杯
,SqFunction,"::scene.rootenv.obj.enemy.demo_trial1_cut8();"

@勇儀
"馬鹿言うな
アンタッチャブルだと言っている@"

#霊夢構え
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut6();"

,フェイスIN_L

,SqFunction,"::bgm.play(""yuugi1"");"

@霊夢顔
"それじゃあ何にも解決しないわ
そこに案内して@"

#勇儀構え
,SqFunction,"::scene.rootenv.obj.enemy.demo_trial1_cut7();"

,フェイスIN_R

@勇儀顔
"ふふふ、舐めた真似を
これ以上旧地獄の秘密を曝かれてたまるか@"

,エネミ－決めポーズ

@勇儀顔
"怪我をする前に地上に帰りな！@"

# フェイス画像アウト
,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,150

#霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#勇儀動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
