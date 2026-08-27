#============================
# 女苑 ステージ4 VS神奈子 石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「油田は私達の物だ」"

# キャラ割り当て
,PLAYER,女苑,怒
,PLAYER2,紫苑,怒
,ENEMY,神奈子,汗

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#フェードアウトからシーン切り替え　女苑石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,150

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@紫苑
"ここは……？@"

,Sleep,10

#石油海登場
,SqFunction,"::scene.rootenv.stage.map.message(OM_ACTION,null);"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_oil"");"

#女苑リアクション
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@女苑
"石油だ
石油の海だー！@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"良かった、石油が枯渇したわけ
じゃなかったね@"

#女苑紫苑左向き+ぐふふ笑い
,SqFunction,"::scene.rootenv.obj.player.direction_h = -1;"
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"
,SqFunction,"::scene.rootenv.obj.player2.select_motion(""event_smile"");"

"これでまだ豪遊できるわ
よーしここは私達のもんだ！@"

#神奈子登場～女苑達に気づく
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,フェイスIN_R

@神奈子顔
"は……
何故お前達がここに？@"

,エネミー紹介カットイン

,フェイスIN_L

@女苑顔
"む、私の石油を盗みに来たな？@"

:立ち絵変更L,女苑_決

,SqFunction,"::bgm.play(""kanako1"");"

,プレイヤ決めポーズ
"許さん！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
