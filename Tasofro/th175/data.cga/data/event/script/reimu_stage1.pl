#============================
# 霊夢 ステージ１
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「魔法の森の\\R[湿地|シメジ]」"

# キャラ割り当て
,PLAYER,霊夢,普
,ENEMY,魔理沙,普

# イベントシーン開始
:main

# BGM再生開始
,SqFunction,"::bgm.play(""talk_forest"");"
#,Sleep,60

# ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,110

# 最初は霊夢の姿は無い。
# シーン　魔理沙登場～水滴で驚く
,SqFunction,"::scene.rootenv.obj.enemy.demo_trial1_cut1();"

@魔理沙
"……なんだ、ただの水か@"

"あちこちから黒い水が
湧いてきたときは焦ったが@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""stand"");"

"この辺は黒い水に冒されていないようだ@"

"と言うことは森には原因が無さそう……@"

,エネミー紹介カットイン

# 霊夢登場
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut2();"

@魔理沙,R
"おー、霊夢か
どうした？@"

@霊夢,L
"黒い水の出所を調査しに
地下に行くことに決めたわ@"

@魔理沙
"……やっぱりか
お前ならそういうと思ったよ@"

@霊夢
"魔法の森に黒い水で塞がれていない
地下洞窟の入り口があるって聞いてね@"

"それが何処にあるのか
あんたなら知っていると思って@"

@魔理沙
"それならば、私が調べに行くところさ@"

"そうだ、勝った方が先に
調査に行くってのはどうだ？@"

# 霊夢が構える
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut3();"

@霊夢,L
"良い考えね
水びたしの場所で戦う事になるだろうし@"

"あんたなら練習に丁度良いわ@"

# 魔理沙が構える
,SqFunction,"::bgm.play(""marisa1"");"
,SqFunction,"::scene.rootenv.obj.enemy.demo_trial1_cut4();"

@魔理沙
"こう見えても水の扱いには
慣れているんだ@"

"地下洞窟に行くのは私が先だ！
残念だったな！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

# 霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

# 敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
