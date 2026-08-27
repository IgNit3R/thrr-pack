#============================
# フランドールhard ステージ3 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ハードストーリークリア値を3に更新
,SqFunction,"::lib.session_data.hard_clear(3);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,汗
,ENEMY,庭渡,負

# イベントシーン開始
:main

,フェイスIN

@フラン顔
"勝ったよね！
帰る！@"

@庭渡顔
"ちょっと待ちなさい@"

"私は庭渡久侘歌です@"

"説明がなさ過ぎて困ります@"

@フラン顔,,フラン_驚
"ああ、それだったら後にして@"

"私はフランドール！
黙る子も泣く吸血鬼よ！@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

@庭渡顔
,フェイスIN_R

"消えた……@"

"吸血鬼って
そんなに忙しいのですね@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("niwatari");
,Sleep,120

,Exit
