#============================
# 霊夢 ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,霊夢,普
,ENEMY,魔理沙,負

# イベントシーン開始
:main
,フェイスIN

@霊夢顔
"準備運動よし！
水に入る前にはちゃんと運動しないとね@"

@魔理沙顔
"そうか、まあそうなるよな@"

"ただ、黒い水も正体不明だし
今回の地底からは不気味な気配がするぜ@"

"気を付けろよ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("marisa");
,Sleep,120

,Exit
