#============================
# 剛欲モード　石油饕餮　勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# イベントシーン開始
:main

,Sleep,60
,SqFunction,"::scene.rootenv.obj.player.stageclose();"
#,SqFunction,::scene.contents["story_event"].kick_result(::lib.session_data.enemy_select);
,Sleep,180

,Exit

,Exit
