#============================
# 饕餮 ステージ6 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,饕餮,驚
,ENEMY,霊夢,決

# イベントシーン開始
:main

,Sleep,10

#フェードアウト+双方位置調整と初期設定
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@霊夢,R
"判った判った@"

"どうやら貴方は信じても良さそうね@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮,L
"ふん、こんな私を
信じてはいかん@"

"力こそ正義
弱肉強食こそ畜生の理@"

"私が勝った
だから私が正しいんだ@"

#饕餮黙考
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"……そうだ、お前の紅い服を
見て思い出したよ@"

#霊夢立ち上がる
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@霊夢
"？@"

,SqFunction,"::scene.rootenv.obj.player.direction_h = -1;"
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮,C
"何であの屈辱を忘れていたんだろう@"

"あの時、吸血鬼は突然現れた@"

"旧灼熱地獄を通ってきたとは
思えない涼しい顔で@"

#饕餮高笑い
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"つまり、抜け道は最初から
あったって事じゃないか！@"

#高笑い停止
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@饕餮,L

"おい霊夢@"

@霊夢
"は、はい？@"

#饕餮霊夢に詰め寄る
,SqFunction,"::scene.rootenv.obj.player.cut5();"

@饕餮,C
"吸血鬼の館まで
私を連れて行け@"

"今すぐにだ！@"

@霊夢,C
"あ、はい……@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("reimu");
,Sleep,120

,Exit
