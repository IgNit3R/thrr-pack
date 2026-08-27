#============================
# フランドール ステージ5NORMAL 饕餮戦 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ノーマルストーリークリア値を5に更新
,SqFunction,"::lib.session_data.normal_clear(5);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,惑
,PLAYER2,隠岐奈,普
,ENEMY,饕餮,汗

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

@隠岐奈
"まだまだだな
破壊を司る吸血鬼よ@"

"そんな戦い方では
この饕餮は破壊できんぞ！@"

,SqFunction,"::scene.rootenv.obj.player.cut2();"

"もっと、力を与えてやる@"

#フェードアウトから次ステージに移行
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,SqFunction,"::lib.event_control.goto_next_stage();"

,Exit
