#============================
# 女苑 ステージ4  勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,女苑,怒
,PLAYER2,紫苑,怒
,ENEMY,神奈子,汗

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#双方位置調整と初期設定
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,60

,フェイスIN_L

@女苑顔
"石油は一滴たりとも渡さないぞ！@"

,フェイスIN_R

@神奈子顔
"さっきの饕餮って奴と
同じことを言いやがって……@"

"強欲な奴は思考が一緒なんだな@"

@女苑顔,,女苑_惑
"さっきの饕餮？@"

"私達の他にも石油を
狙っている奴がいるのかも@"

@女苑顔
"それはゆゆしき問題ね@"

"そいつは何処にいる？@"

@神奈子顔,,神奈子_普
"お前達が来るよりも早く@"

"ずっと前からここに
棲み着いていたみたいよ@"

@女苑顔,,女苑_怒
"なる程……@"

"そいつの所為で石油の噴出が
止まったのか@"

@神奈子顔,,神奈子_惑
"お前達……@"

"地上が汚染されているのが
判らんのか？@"

@女苑顔,,女苑_余
"だから何よ@"

@女苑顔,,紫苑_余
"石油は絶対に社会を
裕福にするわ@"

@女苑顔,,紫苑_嬉
"貧困に勝る悪はない@"

"裕福なお前には
判らないんだろうけど！@"

#フェイス会話解除
,フェイスOUT

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_swing"");"

#フキダシ糸がらみ
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@神奈子,R
"……しょうもない@"

#神奈子素に戻る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"饕餮って奴に喰われるがいい@"

"あいつの方がまだ話が出来た@"

#神奈子背を向けて立ち去ろうとする
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

"さらば、この世界で
一番底辺な神よ@"

#女苑背中に奇襲開始
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@女苑
"うるさい
死ねい！@"

#女苑神奈子の背中の襲い掛かって吸い込まれる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#紫苑驚き
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@紫苑
"え？
女苑、何処に行ったの！？"

#紫苑背中に近寄る
,SqFunction,"::scene.rootenv.obj.player.cut5();"

,WaitInput

#吹き出し消去
,ClearBalloon,紫苑

@紫苑
"あーれー……"

#紫苑吸い込まれる
,SqFunction,"::scene.rootenv.obj.player.cut6();"

#吹き出し消去
,ClearBalloon,紫苑

#神奈子振り返る
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@神奈子,C
"あれ？　居なくなったか@"

"もう饕餮を探しに行ったのかな？@"

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_swing"");"

"行動力だけはある奴らだねぇ
そこだけは尊敬できるが……@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("kanako");
,Sleep,120

,Exit
