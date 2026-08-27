#============================
# 村紗 ステージ３ VS紫苑女苑
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「\\R[石油王|せかいをてにいれたもの]」"

# キャラ割り当て
,PLAYER,村紗,普
,ENEMY,女苑,普
,ENEMY2,紫苑,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_town"");"

,Sleep,20

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,110

#村紗登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@村紗
"旧地獄の温泉かー
懐かしいなぁ@"

,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,180

@村紗,R
"昔はここでよく
悪い遊びしてたなぁ@"

"飲泉用の柄杓の底抜いたり
風呂桶の底抜いたり……@"


#村紗立ち止まる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@村紗,C
"大浴場の底を抜いたり
って、何だ！？@"

#村紗　飛んできた石油を交わす
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#驚く
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise"");"

@村紗
"く、黒い水だ！@"

@女苑
"ごめんごめんー
かかっちゃった？"

#依神姉妹登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#女苑ニタニタ笑い
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

,ClearBalloon,女苑


,エネミー紹介カットイン

#,フェイスIN_L

@村紗,L
"……貴方達は貧乏神と疫病神ね@"

#紫苑不機嫌
,SqFunction,"::scene.rootenv.obj.enemy2.select_motion(""event_tired"");"

@紫苑,R
"もう、貧乏神って呼ばないで@"


#女苑得意げ
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_appeal"");"

@女苑,R
"浴びるくらい石油が
集まっちゃってねー@"

#紫苑ニタニタ笑い
,SqFunction,"::scene.rootenv.obj.enemy2.select_motion(""event_smile"");"

@紫苑,R
"これからは富豪神って呼んで@"

#女苑素
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@女苑
"地底ならもっと石油が取れると
思ったんだけど@"

"そうでも無いんで
温泉で豪遊しようかなと@"

#村紗通常
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

#,フェイスIN_L

@村紗
"石油……？
黒い水の事？@"

#,フェイスIN_R

#女苑　ニヤニヤ
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@女苑
"石油も知らないのー？@"

"これを持っていると王になれる
と言われている位なのに@"

"お金持ちのステイタスよ@"


@村紗
"お金持ちのステイタス？
こんな臭くてベトベトする奴が？@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_appeal"");"


@女苑
"これだから貧乏人はいやね
この高貴な香りが判らないなんて@"

# 匂いを嗅いでむせる紫苑（＊無くても良いです）

,フェイスIN_L

@村紗顔,hasen_10x2_lb,村紗_惑
"\S[14]\C[40,40,40]こいつら程、関わると損しそうな
感じがする奴らはいない@"

@村紗顔,hasen_10x2_lb,村紗_汗
"\S[14]\C[40,40,40]しかし、この黒い水……
石油って言うのか@"

#@村紗顔,LF2,村紗_普
"\S[14]\C[40,40,40]さっさと石油の噴出を止めにいこ@"

,フェイスIN_R

#依神姉妹お怒り
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_angry"");"
,SqFunction,"::scene.rootenv.obj.enemy2.select_motion(""event_angry"");"

@女苑顔,toge_10x2_lb,女苑_普
"石油の噴出を止めるだって？@"

,SqFunction,"::bgm.play(""jyoon1"");"

,エネミ－決めポーズ

@女苑顔,LF2
"聞き捨てならないな！@"

@女苑顔,,紫苑_決
"そんなことさせないぞ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,150

#村紗操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#女苑動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
