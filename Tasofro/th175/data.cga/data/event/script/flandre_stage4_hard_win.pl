#============================
# フランドールHARD ステージ4 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ハードストーリークリア値を4に更新
,SqFunction,"::lib.session_data.hard_clear(4);"

# キャラ割り当て
,PLAYER,フラン,余
,ENEMY,霊夢,汗

# イベントシーン開始
:main
,Sleep,10

#フェードアウト
#双方位置調整と初期設定
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#フェードイン
,Sleep,60

,フェイスIN

@フラン顔
"何だ、やれば出来るじゃん@"

"それでも饕餮って奴は倒せないの？@"

@霊夢顔
"どうも、あいつは全ての攻撃を
吸収するようで……@"

"喰らっているように見えて
それ以上に回復するというか@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@霊夢顔,,霊夢_驚
"あっ、なる程
あんたが来た理由って@"

@フラン顔,,フラン_嬉
"そう、全てを破壊しにきた@"

"私の破壊の前では
吸収など意味は無いわ@"

@フラン顔,,フラン_普
"じゃあね、この辺の
何処かにいるんでしょ？@"

,フェイスOUT

#フラン飛び去る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#霊夢フランを見て疑問
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@霊夢
"誰の差し金から？@"

"フランが一人でやってくるなんて
とても思えないんだけど@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("reimu");
,Sleep,120

,Exit
