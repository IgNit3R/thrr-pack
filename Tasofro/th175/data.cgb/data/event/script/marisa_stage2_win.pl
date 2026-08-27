#============================
# 魔理沙 ステージ２ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,魔理沙,普
,ENEMY,ヤマメ,負

# イベントシーン開始
:main
,フェイスIN

@ヤマメ顔
"やっぱり強いー
捕獲失敗！@"

@魔理沙顔,,魔理沙_汗
"土蜘蛛が棲み着いているということは
やはり旧地獄まで繋がっているんだな@"

@ヤマメ顔
"知らなかったの？@"

"ここは旧地獄との通路としては
５番目くらいに大きいのよ@"

@魔理沙顔,,魔理沙_惑
"え！？　５番目？@"

@魔理沙顔,,魔理沙_汗
"そんなに旧地獄に
行ける道があるのか……@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yamame");
,Sleep,120

,Exit
