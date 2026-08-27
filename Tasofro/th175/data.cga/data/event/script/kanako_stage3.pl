#============================
# 神奈子 ステージ3　VS女苑
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「\\R[石油王|せかいをてにいれたもの]」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,女苑,普
,ENEMY2,紫苑,汗

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -30);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy2"", ""enemy2"", 0, -10);",# 吹き出し位置調整

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_town"");"
#,Sleep,150

#ステージロゴ表示
#,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,Sleep,110

#神奈子上空から登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@神奈子
"旧地獄には石油が湧いていないようだな@"

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

"嫌な予感が的中したか……@"
#神奈子無限歩行モードk
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"霊夢を騙して利用してるようで
悪いけど……@"

"無事に灼熱地獄を通り抜けて
異物を排除してくれていると良いな@"

#神奈子立ち止まる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"ん？@"

#女苑遭遇デモ開始
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#神奈子驚く
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

@神奈子
"こ、これは石油！？@"

"予想では地獄には石油は
湧いていない筈だ@"

#神奈子素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"出てこい！
誰の仕業だ？@"

@女苑,R
"ごめーんごめーん
かかっちゃった？"

#女苑登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#女苑ニタニタ笑い
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

,ClearBalloon,女苑

,エネミー紹介カットイン

#,SqFunction,"::lib.event_control.set_enemy_name();"
#,Sleep,120

@神奈子,L
"……貧乏神と疫病神だと？
こんな旧地獄で何をしている@"

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

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

@神奈子
"……お気楽なこって@"

,フェイスIN_L

@神奈子顔,,神奈子_汗
"その強欲が周りに迷惑を掛けて
いる事も知らずに@"

@神奈子顔,,神奈子_惑
"だから疫病神はいつまで経っても
疫病神なのよ@"

,フェイスIN

@女苑顔,,紫苑_普
"僻め僻め
貧乏人め@"

,SqFunction,"::bgm.play(""jyoon1"");"

@女苑顔,,女苑_普
"持てる者と持たざる者の差って奴を
見せつけてやる@"

@女苑顔,,女苑_嬉
"かかってこい
貧者の蛇神よ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,150

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
