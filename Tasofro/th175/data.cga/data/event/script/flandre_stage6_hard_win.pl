#============================
# フランドール ステージ6HARD 真饕餮戦 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ハードストーリークリア値を6に更新
,SqFunction,"::lib.session_data.hard_clear(6);"

# イベントシーン開始
:main
,Sleep,90

#フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,120

#,SqFunction,::scene.contents["story_event"].kick_result("toutetu");

,Exit