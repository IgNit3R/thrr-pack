#============================
# 饕餮 ステージ5　VSお空　灼熱地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「畜生界ではよくある無駄戦闘」"

# キャラ割り当て
,PLAYER,饕餮,普
,ENEMY,空,普

# イベントシーン開始
:main

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_Inferno"");"

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,90

@饕餮
"そうか、血の池に人間やザコが
降ってきた忘れていたが@"

"血の池の上空は
灼熱地獄だったな@"

"こんな場所、簡単に
通り抜けられる訳が無い@"

"となると、他に抜け道が……？@"

"！？@"

#回避
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#ジャンプ迎撃
,SqFunction,"::scene.rootenv.obj.player.cut3();"

#エネミー登場
,SqFunction,"::bgm.play(""utuho1"");"
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#饕餮操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
