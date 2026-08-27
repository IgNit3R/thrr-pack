#============================
# 村紗 ステージ７7 VS饕餮 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# ステージ７は連戦のため見出しはありません、必要であれば表示できます。
#,ステージ見出し,"「ここに\\R[見出し|テキスト]を入れてください」"

# キャラ割り当て
,PLAYER,村紗,惑
,ENEMY,饕餮,普

#村紗笑い
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_guts"");"

#饕餮構え
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

# イベントシーン開始
:main

,SqFunction,"::bgm.play(""toutetu2"");"

,Sleep,120

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,360

#村紗指差し
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@村紗,L
"さあ、よく見よ@"

"これがお前が欲しがっている
黒い水の正体だ@"

"石油とは血の池なのよ！@"

"これに懲りたら逃げな！
ここをさっさと封印するよ@"

#饕餮肩で笑う
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮,R
"クックック
馬鹿馬鹿しい@"

"この石油が血液である事なんて
もちろん知っているさ@"

"憎悪にまみれた有機物が全て
燃料になるんだ！@"

"笑いが止まらないぞ@"

#村紗引く
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_fear"");"

@村紗
"な、お前……
ヤバくね？@"

"こんな悽惨な光景を見て
正気で居られるなんて@"

"私なんて怖すぎてもう
クラクラする……@"

#饕餮ヤンキー座り
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@饕餮
"何を怖がっているんだ？
石油なんて外の世界では使いまくってるぞ@"

"元来、石油というのは
生物由来の生成物じゃないか@"

"生命の恐怖、哀楽、憎悪、怨嗟の
全てがこの液体の正体なんだよ@"

#饕餮啖呵
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,フェイスIN

@饕餮顔
"さあ、秘密を知ったところで
お前には仕事がある@"

@饕餮顔
"お前も有機物として@"

,エネミ－決めポーズ

@饕餮顔,toge_10x2_lb
"もがき苦しんで
石油の一滴となれ！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
