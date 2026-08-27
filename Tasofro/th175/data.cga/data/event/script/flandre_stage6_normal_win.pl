#============================
# フランドール ステージ5EASY 饕餮戦 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ノーマルストーリークリア値を6に更新
,SqFunction,"::lib.session_data.normal_clear(6);"

:main
,Sleep,90

#フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,120

#,SqFunction,::scene.contents["story_event"].kick_result("toutetu");

,Exit