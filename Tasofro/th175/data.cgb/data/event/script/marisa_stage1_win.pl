#============================
# 魔理沙 ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,魔理沙,普
,ENEMY,霊夢,負

# イベントシーン開始
:main
,フェイスIN

@魔理沙顔,,魔理沙_嬉
"よし勝った！
もう覚悟を決めたぜ@"

@魔理沙顔,,魔理沙_余
"私が地底に降りて調査してくるぜ
お前は地上で待ってな@"

@霊夢顔
"黒い水の正体が判らないし、
敵がいるかどうかも不明よ@"

"こういう時は徒労に終わることが
多いから気を付けてね@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("reimu");
,Sleep,120

,Exit
