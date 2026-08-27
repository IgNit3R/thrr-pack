#============================
# 神奈子 ステージ７ VS饕餮 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# ステージ７は連戦のため見出しはありません、必要であれば表示できます。
#,ステージ見出し,"「ここに\\R[見出し|テキスト]を入れてください」"

# キャラ割り当て
,PLAYER,神奈子,普
,ENEMY,饕餮,決

# イベントシーン開始
:main

,SqFunction,"::bgm.play(""toutetu2"");"

#饕餮構え
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_spell"");"

#神奈子困惑
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_amaze"");"

#白フェードインで血の池地獄へ
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,120

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,240

@饕餮,R
"あっはっは！@"

"血の池地獄には憎悪にまみれた
有機物が無限にある！@"

"これら全てが燃料になるんだ！
笑いが止まらないぞ@"

@神奈子,L
"これが黒い水の正体か@"

"やはり、血液じゃないか
石油は地球の血液とも言うが……@"

#神奈子首振り
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_swing"");"

"眠っていた旧地獄の血の池を
掘り起こしてしまったようね@"

"地上にあふれ出したのは
呪われた血液の目覚めなのか@"

"大変な事になりそうだ……@"

#神奈子素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

#饕餮ヤンキー座り
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@饕餮
"何を怖がっている@"

"元来、石油というのは
生物由来の生成物じゃないか@"

"生命の恐怖、哀楽、憎悪、怨嗟の
全てがこの液体の正体なんだよ@"

"こんな呪い極めた石油を
有効利用しない手はないだろ？@"

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
