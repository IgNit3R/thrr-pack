#============================
# フランA ステージ１ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# イージーストーリークリア値を1に更新
,SqFunction,"::lib.session_data.easy_clear(1);"

# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,魔理沙,負

# イベントシーン開始
:main
,Sleep,60

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,10

,フェイスIN

@魔理沙顔
"わ、訳がわからん
何でお前が……@"

@フラン顔
"じゃあね！
また会うときが来るかしら？@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

@魔理沙顔
,フェイスIN_R

@魔理沙顔
"い、今のは夢、だったのか？@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("marisa");
,Sleep,120

,Exit
