#============================
# フランドールHARD ステージ２ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ハードストーリークリア値を2に更新
,SqFunction,"::lib.session_data.hard_clear(2);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,村紗,負

#　マップに石油オブジェクトを設置
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# イベントシーン開始
:main
,フェイスIN

@村紗顔
"とんでもなく強い……@"

"でも、なんでこんなことを@"

@フラン顔
"黒い水を破壊しに行くのよ@"

"この戦いもその為の試練だって
あいつに教えられたわ@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

@村紗顔
,フェイスIN_R

"消えた……@"

"で、あいつ、って誰？@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("murasa");
,Sleep,120

,Exit
