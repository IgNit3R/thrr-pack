#============================
# 饕餮 ステージ7 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,饕餮,驚
,ENEMY,フラン,他
#,Alias,フラン,隠岐奈

#,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy2"", ""enemy2"", 0, -45);",# 吹き出し位置調整

# イベントシーン開始
:main

,Sleep,10

#フェードアウト+双方位置調整と初期設定
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@饕餮,L
"さあもういいだろう
私の実力が判ったはずだ@"

"質問に答えて貰うぞ@"

"旧血の池地獄にどうやって来た？@"

#フラン笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile2"");"

@フラン,R
"ふっふっふ、そうねぇ
どうしようかなぁ@"

"別に秘密にしろとは
言われてないけど……@"

"それを知ってどうするの？@"

#饕餮渋い顔
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@饕餮
"その通路を使って命知らずの
ザコどもが観光にきている@"

"この状態では旧血の池地獄の
管理は難しい！@"

,Sleep,15

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.enemy2.cut1();"

,Sleep,90

,SetImage,face_r,隠岐奈_他
,フェイスIN_R

@face_r
"旧血の池地獄に観光？@"

,フェイスIN_L
@饕餮顔
"おう、お前は……@"

,フェイスOUT
,SqFunction,"::bgm.fadeout();"
#画面フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("flandre");
,Sleep,120

,Exit
