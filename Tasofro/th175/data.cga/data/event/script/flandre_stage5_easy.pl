#============================
# フランドール ステージ5A　VS饕餮
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,PLAYER2,隠岐奈,普
,ENEMY,饕餮,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_oil"");"

#カメラ移動+饕餮登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,Sleep,150

@饕餮
"……一つ掘っては金のためー
二つ掘っては国のためー@"

"三つ掘っては憎しみのため……@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@フラン
"ここは……？@"

#饕餮背後を見る
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@饕餮,R
"ここは私のテリトリーだ@"

"お前は何処から出てきたんだ？@"

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@隠岐奈
"もう繋がってしまったな@"

"難しい試練を避けてきて
しまったような気もするが@"

"こいつが饕餮だ
思う存分、戦うが良い@"

#隠岐奈撤収　+　フラン振り返る
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@フラン,L
"なんだ、脆そうな奴じゃん@"

"何で私じゃなきゃ倒せないのかな@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"まあいいや、拍子抜けしたけど
破壊しちゃおうっと@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@饕餮
"クックック
お前も随分と狂ってる奴だな@"

#饕餮しゃがみ込む
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""sit"");"

"何故私を破壊しようとする？@"

"地上の奴らとも話は付いた@"

"私は世界に害を為す
存在では無いぞ@"

@フラン
"私は正義の味方では無いよ@"

"ただ、破壊しがたい物を
破壊したいだけ@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile"");"
,SqFunction,"::bgm.play(""toutetu1"");"

"誰もが破壊できなかったお前を
破壊したいだけだ！@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut4();"

"さあ行くよ！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
