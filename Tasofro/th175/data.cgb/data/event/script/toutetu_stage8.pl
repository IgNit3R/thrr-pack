#============================
# 饕餮 最終ステージ VS隠岐奈
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「そうだ、全て秘密に返そう」"

# キャラ割り当て
,PLAYER,饕餮,驚
,ENEMY,隠岐奈,怒

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_door"");"

,Sleep,120

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#饕餮登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@饕餮,L
"……背中の扉だと？@"

"なるほど、判らん@"


@隠岐奈,R
"誰にも見られていないときに
好きな場所に移動出来る扉です@"

"いわば何処でもドアですよ@"

"貴方の下に吸血鬼を
送り込めたのもこの扉のお陰です@"

#饕餮糸がらみ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@饕餮
"そうか、判ったような
判らないような@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

"お前が石油の共同管理をしたい
と言い出した時は@"

"ふざけるな！
と思ったが@"

"お前は地上に石油の存在を
隠す役目をするだけで@"

"実質的な管理は私に任せると
約束したじゃないか@"

#饕餮詰め寄る
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@饕餮,C
"お前……
何か隠し事をしていないか？@"

#隠岐奈距離を取る
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@隠岐奈,C
"最初から全部隠し事に
してるつもりだけど@"

@隠岐奈,R
"でもまあ、もちろん……@"

"あの旧地獄は秘匿すべき
存在です@"

"そしてあの場で正気を
保てるのも貴方くらい@"

"もちろん、貴方が正気なのかは
判断しかねますが@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@饕餮,L
"ならば何故
自らの約束を守らない@"

"旧血の池地獄に観光客を
送り込むなど矛盾にも程がある@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

@隠岐奈
"……@"

#饕餮座る
,SqFunction,"::scene.rootenv.obj.player.select_motion(""sit"");"

@饕餮
"お前の考えはこうか？@"

"『血の池に犠牲者を送り込み
饕餮の管理の失敗を演出させて』@"

"『完全に旧血の池地獄を支配する』@"

#饕餮立ち上がる
,SqFunction,"::scene.rootenv.obj.player.cut4();"

"『ざまーみろ、畜生の王よ』@"

@隠岐奈
"……@"

#隠岐奈眼を開ける
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@隠岐奈
"なるほど
貴方は見かけによらず\R[聡|さと]い@"

"しかし、最初の前提が
間違っていては@"

"正しい推測など出来やしません@"

"まず、背中の扉は誰でも自由に
開閉出来る訳ではありません@"

"私の操作無しで移動など……
考えられないのです@"

"それにもう一つ@"

"私は旧血の池地獄観光など
聞いた事がありません@"

"あそこに観光客を呼び込む筈も無いし
その存在も信じられません@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

"だとすると、私の推測は……@"

"全ては、混沌と貪欲の王である@"

"貴方の狂言@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"クックック
それは気持ちの良い考えだ@"

@隠岐奈
"……@"

@饕餮
"混乱に乗じてお前を倒し
石油を独り占めする、か@"

#饕餮決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut5();"

"決めた！
その方向にしよう！@"

"比類無き強欲なお前は
さぞ腹持ちが良かろうぞ！@"

,SqFunction,"::bgm.play(""okina1"");"

#隠岐奈眼を開ける
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@隠岐奈
"……畜生の本性を現したな@"

"だが、お前の背中は
嘘を吐いていない@"

"だから私はまだ
本気で狂言だとは思ってはいない@"

"貴方の腹の内を探るには……@"

# 隠岐奈が構える
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

"こうするしかないようね！@"

"我を喰らってみよ！
剛欲な畜生王よ！@"

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
