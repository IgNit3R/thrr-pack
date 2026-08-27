#============================
# フランドールA ステージ２ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# イージーストーリークリア値を2に更新
,SqFunction,"::lib.session_data.easy_clear(2);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,小傘,負

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN

@小傘顔
"つ、強すぎる@"

@フラン顔
"黒い水を止めるにはこの位で
怯む訳にはいかないのね@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

@小傘顔
,フェイスIN_R

"消えた……@"

"黒い水を止めるって言ってたわね@"

"今のも聖様が用意した刺客なのかな@"

"……@"

"趣味が変わったなぁ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("kogasa");
,Sleep,120

,Exit
