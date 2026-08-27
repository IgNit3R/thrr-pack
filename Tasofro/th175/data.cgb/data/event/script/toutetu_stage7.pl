#============================
# 饕餮 ステージ7 VSフランドール 紅魔館
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「操り人形の吸血鬼」"

# キャラ割り当て
,PLAYER,饕餮,決
,ENEMY,フラン,決
#,ENEMY2,隠岐奈,余
,Alias,フラン,隠岐奈

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_scarlet"");"

#饕餮とフラン　相対している所へカットイン
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,30

@フラン,R
"あら、久しぶりー@"

"また破壊されたく
なっちゃったのかな@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮,L
"クックック
破壊されるのも悪くない@"

"リンゴも好物なんでねぇ@"

#双方構える
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@饕餮
"お前……
何か隠し事をしていないか？@"

@フラン
"最初から全部隠し事に
してるつもりだけど@"

#饕餮ヤンキー座り
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@饕餮
"お前は吸血鬼だ@"

"陽の光の下では生きられない@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"


"そもそも、石油の噴出だって
困ってなかったんじゃないか？@"

#フラン目を閉じる
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile2"");"

@フラン
"まあ、ねぇ@"

#饕餮素に戻る
,SqFunction,"::scene.rootenv.obj.player.cut4();"

@饕餮
"旧灼熱地獄のエネルギーは
実はあの太陽と同じだ@"

"旧灼熱地獄を通り抜ける事も
難しいんじゃないか？@"

#フラン驚く
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@フラン
"太陽と同じだって！？
どおりで……@"

#フランguruguru
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

"あそこで戦った後は
肌荒れが酷かった訳だわ@"

#饕餮構える
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@饕餮
"ならば何故だ@"

"何故、私の下まで辿り着けたんだ！@"

#フラン悪い顔
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_smile"");"

@フラン
"ふふふ、それは内緒@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"それは都合が良い@"

"ペラペラ喋られたり
でもしたら@"

,SqFunction,"::bgm.play(""flandre1"");"

#饕餮決め
,SqFunction,"::scene.rootenv.obj.player.cut5();"

,フェイスIN

@饕餮顔,toge_15x2_lb
"復讐する絶好の機会を
逃してしまうからな！@"

"さあ、お前の隠している事を
全て聞かせて貰うぞ！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#女苑操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
