#============================
# 饕餮 ステージ2 VSヤマメ 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「孤高で凄惨な仕事」"

# キャラ割り当て
,PLAYER,饕餮,普
,ENEMY,ヤマメ,決

#饕餮渋顔+困惑吹き出し
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# イベントシーン開始
:main

,SqFunction,"::bgm.play(""talk_oil"");"

#ヤマメ場外待機
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""invisible"");"

#白フェードインで血の池地獄へ
,Sleep,240

@饕餮,C
"とんだ邪魔が入ったが……@"

#饕餮立ち
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"私の表向きの仕事は石油が
漏れ出さないように管理する事@"

"実際の仕事は血の池の憎悪が
漏れ出さないようにする事だ@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

"そして、それら全てが人知れず
私と剛欲同盟の食料に……@"

#饕餮気分切り替えジャンプ+背を向けてスペルポーズで盛り上がる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#@饕餮,toge_10x2_lb
@饕餮
"何と孤高で凄惨な仕事だ！
孤独万歳！@"

#ヤマメ落下登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@ヤマメ,C
"わーお！　旧地獄に
こんなところがあったなんて@"

"地底世界は奥深いわー@"

#饕餮とヤマメ振り向いて驚く
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@饕餮,geki_10x2_lb
"誰だ！？@"

@ヤマメ
"わ！
何かいた！@"

#饕餮立ち
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@饕餮,L
"そうだ
私にはもう一つ仕事があった@"

,SqFunction,"::bgm.play(""yamame1"");"
#饕餮決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut5();"

@饕餮,toge_15x2_lb
"孤高で凄惨な仕事を邪魔する
不届き者を排除する事だ！@"

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
