#============================
# ALLクリア
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# イベントシーン開始
:main
,Sleep,90

#フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,120

#,SqFunction,::scene.contents["story_event"].kick_result("toutetu");

,Exit
