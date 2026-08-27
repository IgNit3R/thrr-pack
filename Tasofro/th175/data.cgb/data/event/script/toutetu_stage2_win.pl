#============================
# 饕餮 ステージ2 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,饕餮,普
,ENEMY,ヤマメ,負

# イベントシーン開始
:main
,フェイスIN

@饕餮顔
"……土蜘蛛、か@"

@ヤマメ顔
"そうか、あんたが噂の
畜生界から来た化物ね@"

"温泉で聞いた話と
違うじゃない@"

"知らない知らない！
私は何も見なかったわ！@"

#ヤマメ撤収
,フェイスOUT_R

@饕餮顔,,饕餮_惑
"さっきから何かおかしいな@"

"あんな虫けら風情が
落ちてくるとは……@"

"一体全体、どうやってここまで
辿り着いたんだ？@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yamame");
,Sleep,120

,Exit
