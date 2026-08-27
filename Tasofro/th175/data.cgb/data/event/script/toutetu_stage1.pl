#============================
# 饕餮 ステージ1 VS魔理沙 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「故意に均衡を乱す者達」"

# キャラ割り当て
,PLAYER,饕餮,普
,ENEMY,魔理沙,決

#饕餮待機
,SqFunction,"::scene.rootenv.obj.player.select_motion(""invisible"");"

#魔理沙場外待機
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""invisible"");"

# イベントシーン開始
:main

#ステージロゴ表示



#背景自動スクロール
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,60
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,SqFunction,"::bgm.play(""talk_oil"");"
#白フェードインで血の池地獄へ
,Sleep,120

#,SqFunction,"::_audio_play(::se[""stage_title""],1);"
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,210

#饕餮登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@饕餮,C
"うむ@"

"首を絞められたかの
ような閉塞感@"

"絶望的に禍々しい
赫灼の地底海@"

#饕餮立ち上がる

"やはりいつ見ても美しい@"

#,SqFunction,"::scene.rootenv.obj.player.cut3();"
#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

"しかしあの、秘神……
隠岐奈と言ったか@"

"ここの管理を畜生界一
頑丈な私に任せるとは@"

"中々人を見る目がある奴だ@"


"普通の奴なら一日ともたない
だろうからな@"



#魔理沙落下登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"


@魔理沙,C
"うわぁ
何だここは@"

#饕餮驚く
,SqFunction,"::scene.rootenv.obj.player.cut3();"


#魔理沙着地して見渡す
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"


"昔話で聞かされていた通りの地獄だぜ！@"

"こりゃすげーな@"


@饕餮,L
"お前は……
魔理沙じゃないか@"

#饕餮威嚇
,SqFunction,"::scene.rootenv.obj.player.cut4();"

"さっさと帰りな
普通の奴が来る場所じゃないぞ@"

#魔理沙バルーン消し+対応
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@魔理沙,R
"まあまあ
暇だったんで地獄を見に来ただけだ@"

"いわゆる
怖い物見たさって奴さ@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"そうかい
じゃあ、お望み通り……@"

,SqFunction,"::bgm.play(""marisa1"");"
#饕餮決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut5();"

@饕餮,toge_15x2_lb
"地獄を見せてやろう！
後悔するなよ！@"

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
