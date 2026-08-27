#============================
# 女苑 ステージ6　VS饕餮　石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「強欲どもの約束の地」"

# キャラ割り当て
,PLAYER,女苑,決
,PLAYER2,紫苑,決
,ENEMY,饕餮,決

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_oil"");"

#フェードアウトからシーン切り替え　女苑石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,Sleep,150

@饕餮
"……一つ掘っては金のためー
二つ掘っては国のためー@"

"三つ掘っては憎しみのため……@"

"石油に纏わる喜悦も利便も
呪詛も憎悪も欲望も全て@"

"一滴残らず私のもんだ@"

"剛欲同盟は畜生界を飛び出して
世界を支配するだろう@"

#饕餮手を止めて笑う
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

"クックック……
笑いすぎて背中がむずがゆいな@"

#饕餮の背中に扉が開き二人が飛び出してくる
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,240
#,Sleep,360

@女苑
"こ、ここは！？@"

"さっきの石油の海だ！
良かったぁ@"

#饕餮間合いを取る
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@饕餮,R
"お前達……
何処から出てきた！？@"

@女苑,L
"今度は、誰？@"

#饕餮座り込み
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""sit"");"

@饕餮
"お前達から名乗れよ@"

#紫苑ポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@紫苑
"貧乏神改め
富豪神の依神紫苑@"

#女苑ポーズ
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@女苑
"疫病神改め
石油王の依神女苑よ@"


@饕餮
"\R[饕餮|とうてつ]\R[尤魔|ゆうま]だ@"

#饕餮驚く
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_suprise"");"

@饕餮
"って石油王、だと！？@"

,エネミー紹介カットイン

#饕餮決め
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""toutetu1"");"

"ここの石油は我らが
剛欲同盟のもんだ@"

#姉妹表情更新
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_angry"");"
,SqFunction,"::scene.rootenv.obj.player2.select_motion(""event_angry"");"

@女苑
"何だって！？
ここの石油は私達のもんだ！@"



,フェイスIN

,SetFocusOffset,-100,0,-20,0
,SetFocusBrightness,100,100


@饕餮顔,toge_15x2_lb
"一滴たりともやらないよ！
一滴たりともやらんぞ！
一滴たりともやるもんか！@"

,ClearBalloon,女苑顔

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
