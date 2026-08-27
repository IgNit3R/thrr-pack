#============================
# 饕餮 ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,饕餮,嬉
,ENEMY,魔理沙,負

# イベントシーン開始
:main
,フェイスIN

@魔理沙顔
"いやー
やっぱり強いなー@"

@饕餮顔
"クックック
手加減しすぎたな@"


@饕餮顔,,饕餮_惑
"ところで何の用だ？@"

@魔理沙顔
"いや、本当に
ただ見に来ただけだぜ@"

"いわゆる旧地獄巡りだ@"

@饕餮顔,,饕餮_汗
"うーむ、いつから旧地獄は
観光地になったんだ？@"

@饕餮顔,,饕餮_嬉
"ここはおぞましい場所だ！
さっさと帰れ！@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("marisa");
,Sleep,120

,Exit
