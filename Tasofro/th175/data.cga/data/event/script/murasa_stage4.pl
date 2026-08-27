#============================
# 村紗 ステージ４ VS神奈子 核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「突撃！　となりの融合炉」"

# キャラ割り当て
,PLAYER,村紗,惑
,ENEMY,神奈子,怒

#神奈子定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

,Sleep,60

@村紗,geki_10x2_lb
"どけどけーい！
ボサッと突ったってるな！"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,ClearBalloon,村紗

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"

,Sleep,60

,Sleep,300

#エネミー登場後半
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@村紗,L
"って、おおっと
貴方は……！@"

@神奈子,R
"ふん、舟幽霊か@"

,エネミー紹介カットイン
,Sleep,30

#神奈子表情怒り
#,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"なる程な、命蓮寺の仕業だな？
舐めた真似しやがって@"

,SqFunction,"::bgm.play(""kanako1"");"

#神奈子決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,フェイスIN

@神奈子顔,geki_15x2_lb
"余計な仕事を増やした責任は
お前の溺死だけでは済まされないぞ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#村紗操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
