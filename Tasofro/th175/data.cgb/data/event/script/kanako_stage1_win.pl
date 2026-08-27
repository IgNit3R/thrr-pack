#============================
# 神奈子 ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,神奈子,怒
,ENEMY,ヤマメ,負

# イベントシーン開始
:main
,フェイスIN

@ヤマメ顔
"しくしくしく@"

@神奈子顔,,神奈子_怒
"戯れで邪魔するな
この害虫が@"

@神奈子顔
"今は一刻を争う事態なのです@"

@ヤマメ顔
"しくしく……ひもじいです@"

@神奈子顔,,神奈子_惑
"……判ったすぐに食べ物用意してやる@"

@神奈子顔,,神奈子_嬉
"良かったな、相手が私で@"

@神奈子顔,,神奈子_余
"諏訪子だったら
蜘蛛なんてひと呑みだったよ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yamame");
,Sleep,120

,Exit
