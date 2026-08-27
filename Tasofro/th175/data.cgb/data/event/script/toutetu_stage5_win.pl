#============================
# 饕餮 ステージ5 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,饕餮,驚
,ENEMY,空,決

# イベントシーン開始
:main

,フェイスIN

@空顔
"これはまた手強い、ならば……@"

@饕餮顔
"判った、もう降参だ！
これ以上闘うつもりは無い@"

@空顔
"およ？@"

@饕餮顔,,饕餮_普
"灼熱の炎と
こいつがいる限り@"

"この通路は塞がれて
いるのも同然だな@"

@饕餮顔,,饕餮_余
"お前は侵入者を確実に
排除する忠実な番犬だ@"

@空顔,,空_怒
"犬じゃないよ鴉だよ@"

@饕餮顔,,饕餮_汗
"……頼りにしてるよ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("utuho");
,Sleep,120

,Exit
