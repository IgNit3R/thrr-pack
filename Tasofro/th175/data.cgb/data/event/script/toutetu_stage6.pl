#============================
# 霊夢 ステージ6 VS霊夢 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「生まれ変わる前の紅い記憶」"

# キャラ割り当て
,PLAYER,饕餮,惑
,ENEMY,霊夢,怒

# イベントシーン開始
:main

,SqFunction,"::bgm.play(""talk_oil"");"

,Sleep,210

#饕餮急降下で帰ってくる
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@饕餮
"なるほど、あの通路は
ザコが通り抜けるには難しい@"

#→移動
,SqFunction,"::scene.rootenv.obj.player.cut2();"

"だとすると他の抜け道があると
言う事なのか？@"

"そういえば、石油が地上に
吹き出していたと言うのも@"

"結局原因は判らなかった……@"

#立ち止まる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"何かがおかしいな@"

"……考えても仕方が無いか@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

"あの番犬、いや番鴉よろしく
侵入者を見つけ次第排除するだけだ@"

"そう思うと、秘密の抜け道も
有難いもんだ@"

"適度な運動を
与えてくれるんだもんな！@"

"そうだ！
あの鴉、剛欲同盟に勧誘するか……@"

#霊夢登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@霊夢,R
"うわ！
ここが旧血の池地獄！？@"

#饕餮ビックリ
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@饕餮,L
"うわ！
ビックリした@"

#饕餮素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"霊夢か……いつの間に？@"

#霊夢素
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@霊夢
"いや、地上で血の池ツアーの噂が
話題になっていて@"

"まともに見た事無かったら
見に来たんだけど……@"

#饕餮素
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@饕餮
"何だと？
血の池ツアーだと！？@"

"誰がそんなことを……@"

@霊夢
"噂だからね
細かい事は知らない@"

#霊夢渋い顔
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_tired"");"

"それにしても
最強に気持ち悪いところね@"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"な、最高だろ？@"

@霊夢
"こんなところにわざわざ観光に来る
意味がわからないわ@"

#霊夢上を見る
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_upper"");"

"それにここに無傷で来るなんて
誰かの保護がなければ難しい@"

#霊夢渋い顔
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_tired"");"

"だから、あんたが企画してると
思っているんだけど……@"

#饕餮威嚇
,SqFunction,"::scene.rootenv.obj.player.cut5();"

,フェイスIN_L

@饕餮顔
"ふざけるなよ@"

@饕餮顔,,饕餮_怒
"私はここに何人たりとも
近寄らせるなと言われてるんだ@"

#霊夢啖呵
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

,フェイスIN_R

,SqFunction,"::bgm.play(""reimu1"");"

@霊夢顔
"どうだか！@"

"大方、生け贄を増やして
燃料の足しにしたいとか?@"

@霊夢顔,toge_15x2_lb,霊夢_決

"何にしても、調べさせて貰うわ！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
