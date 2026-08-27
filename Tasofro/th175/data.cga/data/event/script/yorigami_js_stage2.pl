#============================
# 女苑 ステージ２ VS庭渡 融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「依神姉妹の誰にも聞かせられない話」"

# キャラ割り当て
,PLAYER,女苑,汗
,PLAYER2,紫苑,汗
,ENEMY,庭渡,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

#エネミー透明状態で定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_waterhell"");"

#プレイヤー登場
,Sleep,60
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,Sleep,60

#ステージロゴ表示
#,Sleep,200

@紫苑
"ここは何処？@"

#女苑後ろを向く
,SqFunction,"::scene.rootenv.obj.player.direction_h = -1;"

@女苑,L
"ここは核融合炉の炉心内部@"

"実はね、私達の石油の産出源は
主にここだったのよ@"

"いつも燃えていて
とんでもなく危険な場所、なんだけど@"

#女苑表情　不満
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

"何これ
何で水没してるの？@"

"もしやこれが原因で
石油の産出が止まってた？@"


#紫苑表情　くたびれ
,SqFunction,"::scene.rootenv.obj.player2.select_motion(""event_tired"");"

#フキダシ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@紫苑,geki_10x2_lb
"石油が止まってた！？@"

@女苑
"しーっ！
声が大きい@"

"石油の産出が止まってた事が
バレたら私達……@"

@紫苑,C
"誰もお金を出さなくなってしまう@"

"また貧乏に戻ってしまうわ！@"

"それは絶対阻止しないと@"

#女苑表情　焦り
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze2"");"

@女苑
"この事は誰にも秘密ね@"

@女苑
"バレたらツケが返せない……@"

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

#表情　戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"
#紫苑　驚き
,SqFunction,"::scene.rootenv.obj.player2.select_motion(""event_suprise"");"
#女苑前を向く
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"

#庭渡左右見渡し
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

#フキダシ…
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,エネミー紹介カットイン

,Sleep,30

,フェイスIN_R

@庭渡顔
"よし、流水量低下を確認@"

"まもなく元通りになるでしょう@"


@庭渡顔,,庭渡_嬉
"さて、彼岸に帰るとするか@"

,フェイスIN_L

@女苑顔,,紫苑_汗
"ねえ、この鳥に今の話聞かれたんじゃない？@"

@女苑顔,,女苑_余
"ぐぬぬ、怨みはないが
私達の財産を守るためだ@"

,プレイヤ決めポーズ

,SqFunction,"::bgm.play(""niwatari1"");"

@女苑顔,toge_10x2_lb
"死ねい！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
