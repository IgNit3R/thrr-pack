#============================
# 体験版 ステージ１ 勝利
#============================
:init

# 初期設定
:main

,Sleep,60
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,SqFunction,"::lib.session_data.reset_begin_story();"# チュートリアルクリア時にストーリー開始と同じようにsession_dataにリセットを実行
,SqFunction,"::lib.event_control.goto_next_stage();"

,Exit
