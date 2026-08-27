#============================
# フランドールA ステージ4 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# イージーストーリークリア値を4に更新
,SqFunction,"::lib.session_data.easy_clear(4);"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,フラン,嬉
,ENEMY,空,決

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN_L

@フラン顔
"ふっふっふ
思う存分戦えたわ！@"

"何だか身体の疲れが
取れたみたい@"

"もしかして、本番前の準備運動
として用意してくれたのかな@"

#お空再登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN_R

@空顔
"まだまだ戦える！@"

"さあ二戦目だ！@"

@フラン顔
"楽しかったんで
そうしたいけど@"

"扉が出てきちゃったから
時間切れねー@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

#お空リアクション
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@空顔,,空_惑

,フェイスIN_R

"扉？@"

"消えちゃった@"
@空顔,,空_汗

"燃え尽きてしまったか@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("utuho");
,Sleep,120

,Exit
