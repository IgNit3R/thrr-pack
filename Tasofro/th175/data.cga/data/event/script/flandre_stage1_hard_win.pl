#============================
# フランHARD ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ハードストーリークリア値を1に更新
,SqFunction,"::lib.session_data.hard_clear(1);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,勇儀,負

# イベントシーン開始
:main
,フェイスIN

@フラン顔
"よーし、こんなもんで
良いでしょ@"

"次の扉を選ぼうっと@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

@勇儀顔

,フェイスIN_R

"……@"

"温泉街は今日も騒々しくて良い@"

"混沌は安泰だ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yuugi");
,Sleep,120

,Exit
