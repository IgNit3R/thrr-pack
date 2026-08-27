#============================
# フランドール ステージ3A　VS神奈子
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,惑
,ENEMY,神奈子,驚

#　マップに石油オブジェクトを設置
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_reactor"");"
,Sleep,20

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,180

#神奈子登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@神奈子
"緊急事態だ！@"

"全炉緊急停止！
汚染範囲を調査せよ@"

#神奈子背を向けて考え込む
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

"何故だ、何故石油が急に溢れてきた@"

#神奈子怒り
,SqFunction,"::scene.rootenv.obj.enemy.cut4();"

"石油を独り占めするから
任せろとかぬかしといて@"

"あの化け羊は一体何をしてるんだよ？@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,20

#神奈子びっくり
,SqFunction,"::scene.rootenv.obj.enemy.cut5();"

,フェイスIN_R

@神奈子顔
"誰だ！？
え……お前は@"

#フラン周囲見渡す
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,フェイスIN_L

@フラン顔
"ここは何処？@"

@神奈子顔,,神奈子_普
"ここは核融合炉です@"

@神奈子顔,,神奈子_嬉
"ははーん
立て続けの異常事態って事は@"

"この石油噴出は第三者による
意図的なものの可能性があるな@"

,SqFunction,"::bgm.play(""kanako1"");"

@神奈子顔,,神奈子_決
"舐めた真似をしやがって
許さんぞ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
