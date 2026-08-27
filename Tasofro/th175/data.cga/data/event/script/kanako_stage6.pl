#============================
# 神奈子 ステージ６ VS饕餮 石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「呪われた液体の真の姿」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,饕餮,普

# イベントシーン開始
:main

#フェードアウトからシーン切り替え　神奈子石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,150

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,60

#石油海登場
,SqFunction,"::scene.rootenv.stage.map.message(OM_ACTION,null);"
#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_oil"");"

@神奈子
"……石油だ
石油の海だわ@"

,Sleep,10


#神奈子困惑
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

@神奈子
"ここは旧血の池地獄だと
聞いていたのに……@"

"いつの間にこんなことに@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

,Sleep,60

#饕餮乱入
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@饕餮,R
"……また石油泥棒が来たか@"

"この石油は我々剛欲同盟の
切り札になるんだ@"

"地上の奴に一滴たりともやらんぞ@"


@神奈子,L
"何者だ？@"

@饕餮
"そんなのどうでも良いだろ@"

,SqFunction,"::bgm.play(""toutetu1"");"

#饕餮決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@饕餮,toge_10x2_rb
"さっさと出て行け
石油泥棒！@"

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#神奈子操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
