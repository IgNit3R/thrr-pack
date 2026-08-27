#============================
# 饕餮 ステージ3 VS勇儀 地底温泉街
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「似たもの同士だ、鬼畜生め」"

# キャラ割り当て
,PLAYER,饕餮,嬉
,ENEMY,勇儀,怒

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_town"");"

#饕餮待機
,SqFunction,"::scene.rootenv.obj.player.select_motion(""invisible"");"

#勇儀場外待機
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""invisible"");"

#背景スクロールウェイト
,SqFunction,"::scene.rootenv.obj.player.pre_mapshift();"

#,Sleep,120

#饕餮上空から登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,60

@饕餮
"旧地獄の温泉とは
ここか……？@"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,170

#饕餮立ち
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"これはまた随分と
歓楽に溺れた街だな@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

"……嫌いじゃない
いや、大好物だ@"

#勇儀遭遇デモ開始
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

#勇儀驚き
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

@勇儀,R
"はっ！
お前はもしや……@"

"畜生界から来た怪物
饕餮尤魔じゃないか？@"

#饕餮振り向く
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@饕餮,L
"いかにも@"

#勇儀驚き
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@勇儀
"聞いたよ@"

"放置された旧血の池地獄を
管理する為に雇われたとか@"

"そんな仕事、地獄の鬼ですら
引き受けたがらない閑職だ@"

#勇儀笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile"");"

"あんた、貧乏くじ
引かされたねぇ@"

"どうだ？　堪忍して貰える様に
地霊殿の主に口利きしてやろうか？@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"馬鹿言うな
貧乏くじだと？@"

"あの土地の価値が
判らぬとは可哀想に@"

"それにあそこほど
心地の良い空間はないぞ@"

@勇儀
"……そいつは失礼した@"

"好きであそこに留まって
いるのなら何も言わないさ@"

#勇儀一杯
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

"しかし……@"

,フェイスIN_L

,SqFunction,"::bgm.play(""yuugi1"");"

@饕餮顔
"くっくっく、判るぞ……
鬼のお前が考えていることなんざ@"

@饕餮顔,,饕餮_普
"「地獄の鬼すら恐れる場所を
心地の良い、なんて言う奴とは」@"

@饕餮顔,,饕餮_余
"「戦いたくて溜まらねぇ」
って言うんだろう？@"

#勇儀構え
,SqFunction,"::scene.rootenv.obj.enemy.cut4();"

,フェイスIN_R

@勇儀顔,,勇儀_怒
"この下品な畜生めが！
鬼を舐めるんじゃないぞ@"

@勇儀顔,geki_15x2_lb,勇儀_嬉
"「是非、お手合わせを願いたい」
だ！@"

# フェイス画像アウト
,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
