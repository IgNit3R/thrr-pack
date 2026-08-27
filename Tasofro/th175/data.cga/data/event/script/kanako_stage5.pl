#============================
# 神奈子 ステージ5 VS庭渡 三途の滝
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「地獄に落ち続ける滝」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,庭渡,普

#エネミー透明状態で定位置待機
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_waterhell"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,60

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,360

#神奈子見まわし
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

@神奈子
"……凄い
灼熱地獄が冷却化している@"

"どうやってこれだけの水量を？@"

"幻想郷が保有している水量を
超えている気もするが……@"

#神奈子表情戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_upper"");"

#エネミー登場
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

#庭渡左右見渡し
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_look"");"

@庭渡
"これはまた大きな仕事になりそうね@"

"これじゃあ、三途の河ならぬ三途の滝ね@"

@神奈子
"誰だ？@"

,フェイスIN_R

#庭渡左右見渡し
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@庭渡顔
"私は\R[庭渡|にわたり]\R[久侘歌|くたか]です
異界との往来を見張っています@"

,エネミー紹介カットイン
,Sleep,30

"貴方は？@"

,フェイスIN_L

@神奈子顔,,神奈子_驚
"ニワタリ神でしたか
これはこれは……@"

@神奈子顔,,神奈子_普
"失礼、私は八坂神奈子
山の神です@"

@庭渡顔,,庭渡_惑
"三途の河底に穴を開けたのは
何故ですか？@"

@神奈子顔,,神奈子_惑
"ほほう、三途の河底……
なる程、三途の河なら無限の水量がある@"

@庭渡顔,,庭渡_怒
"これを利用して、地獄へと
行こうというのですか？@"

#神奈子表情戻し
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@神奈子顔,,神奈子_惑
"これをやったのは
私ではないけど……@"

#神奈子首を振る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

@神奈子顔,,神奈子_汗
"そんなことは貴方には
関係無いわね@"

#神奈子素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"私はこれを利用して地の底へと
向かおうとしているんだから@"

,フェイスOUT

,SqFunction,"::bgm.play(""niwatari1"");"

@庭渡
"いくら山の神とはいえ
勝手な真似は許しません@"

#庭渡決め
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""attack_sing"");"
,Sleep,6
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""attack_sing2"");"

"ここから立ち去って貰います！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#神奈子操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
