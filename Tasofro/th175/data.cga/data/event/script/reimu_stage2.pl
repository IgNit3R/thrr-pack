#============================
# 霊夢 ステージ２
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「飽和水蒸気の洞窟」"

# キャラ割り当て
,PLAYER,霊夢,普
,ENEMY,小傘,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_underground"");"

,Sleep,20

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,10

#霊夢登場
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut1();"
,Sleep,10

#霊夢見渡し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

,Sleep,60

@霊夢
"やっぱり、水びたしねぇ
長靴履いてくれば良かったかな@"

#小傘遭遇デモ開始
,SqFunction,"::scene.rootenv.obj.player.demo_trial1_cut2();"

@小傘,R
"その格好！
雨をなめているわね！"
,Sleep,120
,ClearBalloon,小傘

,エネミー紹介カットイン

#,WaitInput

,SqFunction,"::scene.rootenv.obj.player.select_motion(""stand"");"
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""stand"");"

@霊夢,L
"うわぁ、唐傘お化け！
びっくりしたぁ@"

#小傘戻り
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""stand"");"

@小傘,R
"雨が降る場所では
傘が無いと生きていけない！@"

#霊夢しかめっつら
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

@霊夢
"えー、洞窟なのに
雨の準備なんて馬鹿馬鹿しい……@"

@小傘
"ふふふ、いつ如何なるところでも
雨は降るのよ@"

,SqFunction,"::bgm.play(""kogasa1"");"

#小傘傘回し
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""attack_air_spin"");"

@小傘
"このようにね！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#霊夢操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

#中間デモまで待機
#,SqFunction,"while(1)suspend();"

#@霊夢
#"うわ！
#洞窟内に雨が！？@"

#@小傘
#"ほら傘が必要だったでしょ？
#もっと水びたしになると良いわ！@"

#プレイヤー操作受付開始
#,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
#,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
