#============================
# 魔理沙 ステージ５ VS庭渡　三途の滝
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「地底の大瀑布」"

# キャラ割り当て
,PLAYER,魔理沙,汗
,ENEMY,庭渡,普

#エネミー透明状態で定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_waterhell"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
#,Sleep,60

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

@魔理沙
"こ、これは水浸しにも程があるぞ@"

#魔理沙表情戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_face"");"

"これじゃあ、最下層に石油がある
っていっても水没してるんじゃ@"

"……待てよ@"

"というか、黒い水が地上まで
湧いて出ているのは@"

"この大量の水の所為なんじゃないのか？@"

,Sleep,30

#魔理沙吹き出し表示
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,30

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

#庭渡左右見まわし
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@庭渡
"これはまた大きな仕事になりそうね@"

"これじゃあ、三途の河ならぬ三途の滝ね@"

@魔理沙
"む、お前は……確か@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@庭渡
"\R[庭渡|にわたり]\R[久侘歌|くたか]です
お久しぶりですね、魔理沙さん@"

,エネミー紹介カットイン

#庭渡威圧
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_angry"");"

"もしかして、貴方の仕業ですか？
三途の川底に穴なんて空けて@"

@魔理沙
"え？
いや、これは違う……@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

,フェイスIN

@庭渡顔
"三途の河はこの世とあの世を繋ぐ
唯一の境界です@"

"これを利用して、地獄へと
行こうというのですか？@"

"畜生界の出来事はカムフラージュだったの
でしょうか？@"

,SqFunction,"::bgm.play(""niwatari1"");"
#庭渡威圧
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_angry"");"

"なる程、やはり危険人物でしたねぇ
そんな気がしてました@"

#庭渡決め
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""attack_sing"");"
#,Sleep,10
#,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""attack_sing2"");"

,エネミ－決めポーズ

"ここから立ち去って貰います！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#魔理沙操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
