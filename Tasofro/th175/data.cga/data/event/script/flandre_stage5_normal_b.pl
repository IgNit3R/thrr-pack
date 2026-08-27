#============================
# フランドール ステージ5normal　VS饕餮後半
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,惑
,PLAYER2,隠岐奈,普
,ENEMY,饕餮,汗

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,Sleep,20

#画面停止+カメラ右へ移動 饕餮石油を掘っている
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@饕餮
"……一つ掘っては金のためー
二つ掘っては国のためー@"

"三つ掘っては憎しみのため……@"

#饕餮背後を見る
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

"誰だ？@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン,L
"見ーつけた@"

"お前が饕餮って奴だね？@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮,R
"クックック
……お前は誰だ？@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@フラン
"私はフランドール・スカーレット
饕餮を破壊する為にやってきた@"

"もう一度問う
お前が饕餮だね？@"

@饕餮
"クックック@"

#饕餮威嚇
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,フェイスIN_R

@饕餮顔
"私の名前を知っていて
見て判らんのか@"

@饕餮顔,,饕餮_普
"我こそが剛欲同盟長
饕餮尤魔だ@"

,フェイスIN_L

@フラン顔
"なんだ、脆そうな奴じゃん@"

"何で私じゃなきゃ倒せない
って思ったのかな@"

@フラン顔,,フラン_嬉
"まあいいや、拍子抜けしたけど
破壊しちゃおうっと@"

@饕餮顔,,饕餮_嬉
"クックック
お前も随分と狂ってる奴だな@"

@饕餮顔,,饕餮_驚
"何故私を破壊しようとする？@"

"地上の奴らとも話は付いた@"

@饕餮顔,,饕餮_余
"私は世界に害を為す
存在では無いぞ@"

@フラン顔,,フラン_普
"私は正義の味方では無いよ@"

@フラン顔,,フラン_余
"ただ、破壊しがたい物を
破壊したいだけ@"

,SqFunction,"::bgm.play(""toutetu1"");"

@フラン顔,,フラン_他
"誰もが破壊できなかったお前を
破壊したいだけだ！@"

,プレイヤ決めポーズ

"さあ行くよ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
