#============================
# フラン ステージ１ノーマル 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ノーマルストーリークリア値を1に更新
,SqFunction,"::lib.session_data.normal_clear(1);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,霊夢,負

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN

@霊夢顔
"黒い水！？　フラン！？
何だこれ@"

@フラン顔
"じゃあね！
黒い水の件は私が破壊するわ@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

@霊夢顔

,フェイスIN_R

"幻覚だった……
と言うことにしよう@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("reimu");
,Sleep,120

,Exit
