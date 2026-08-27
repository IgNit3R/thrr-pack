#============================
# 神奈子 ステージ１　VSヤマメ
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「慈悲の心」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,ヤマメ,普

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_underground"");"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
#,Sleep,160

#カメラ移動
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@神奈子,L
"邪魔よ
急いでいるの@"


#ヤマメ怒り抗議
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@ヤマメ,R
"今日は朝から何にも食べてないの@"

#ヤマメが構える
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

"こうなったら蛇でも何でも良いわ！@"

,SqFunction,"::bgm.play(""yamame1"");"

,エネミー紹介カットイン


,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
