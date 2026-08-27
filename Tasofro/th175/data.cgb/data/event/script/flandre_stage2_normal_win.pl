#============================
# フランドールnormal ステージ２ ヤマメ勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ノーマルストーリークリア値を2に更新
,SqFunction,"::lib.session_data.normal_clear(2);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,汗
,ENEMY,ヤマメ,負

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN

@ヤマメ顔
"つ、強い……！@"

"でも、このくらい強くないと
血の池地獄には行けないね@"

@フラン顔
"この黒い水
身体に付くと落ちないわ@"

"早く破壊したいわー@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

@ヤマメ顔
,フェイスIN_R

"地獄からヘルプが来たから
もう大丈夫ね@"

"やっぱり血の池地獄が
一番最初に暴走したかー@"

"これだから臭いもんに蓋をする
施策は駄目なんだよねー@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yamame");
,Sleep,120

,Exit
