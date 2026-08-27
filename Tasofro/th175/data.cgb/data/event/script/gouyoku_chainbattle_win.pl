#============================
# 強欲な挑戦　連戦バトル勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

#ステージ数を追加
,SqFunction,"::lib.session_data.stage_number += 1;::lib.session_data.challenge_lv += 2;"

# イベントシーン開始
:main

,Sleep,60
,SqFunction,"::scene.rootenv.obj.player.stageclose();"
#,SqFunction,::scene.contents["story_event"].kick_result(::lib.session_data.enemy_select);
,Sleep,120

,Exit
