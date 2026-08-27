#============================
# フランドールnormal ステージ3 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ノーマルストーリークリア値を3に更新
,SqFunction,"::lib.session_data.normal_clear(3);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,余
,ENEMY,女苑,負
,ENEMY2,紫苑,負

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy2"", ""enemy2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN

@女苑顔
"つ、強い
この前よりずっと強い@"

@フラン顔
"お前らこそな@"

@フラン顔,,フラン_嬉
"さあて、目的地は
血の池地獄かー@"

"楽しみになって来たわー@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

@女苑顔,,紫苑_負
,フェイスIN_R

"消えた……@"

"ワープ使いって良いわねぇ@"

,Sleep,30

,SqFunction,::scene.contents["story_event"].kick_result("jyoon");
,Sleep,120

,Exit
