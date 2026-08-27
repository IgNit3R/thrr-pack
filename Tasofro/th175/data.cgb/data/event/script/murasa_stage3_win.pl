#============================
# 村紗 ステージ3 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,村紗,余
,ENEMY,女苑,負
,ENEMY2,紫苑,負

# イベントシーン開始
:main
,フェイスIN

@女苑顔,,女苑_負
"負けたー@"

"でもいいや、今のうちに
たっぶり豪遊しようと@"

@女苑顔,,紫苑_負
"やったー
今日も温泉で豪遊だわー！@"

,フェイスOUT_R

@村紗顔,,村紗_汗
"刹那的な生き方をしている人と関わると
見ている方が不安なるね@"

@村紗顔,,村紗_汗
"でも、少し羨ましいかも……@"

@村紗顔,,村紗_驚
"おっと、急いで核融合炉に
行かないと@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("jyoon");
,Sleep,120

,Exit
