#============================
# ALLクリア
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main
,Sleep,90

#フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,120

#,SqFunction,::scene.contents["story_event"].kick_result("toutetu");

,Exit
