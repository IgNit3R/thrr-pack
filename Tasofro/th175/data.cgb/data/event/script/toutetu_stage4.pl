#============================
# 饕餮 ステージ4 VS神奈子　核融合炉
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「地球は大きな給湯器」"

# キャラ割り当て
,PLAYER,饕餮,余
,ENEMY,神奈子,汗

# イベントシーン開始
:main
#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_reactor"");"

#饕餮待機
,SqFunction,"::scene.rootenv.obj.player.select_motion(""invisible"");"

#神奈子場外待機
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""invisible"");"

#背景スクロールウェイト
,SqFunction,"::scene.rootenv.obj.player.pre_mapshift();"

#神奈子歩いてくる
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

,Sleep,60

@神奈子
"……水分量異常なし
不純物の濃度も異常なし@"

#神奈子目を閉じる
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_think"");"

"あの饕餮を石油の管理者に置くって
聞いたときはどうかって思ったけど@"

"今のところ毒にも薬にも
なっていない様子ね@"

#饕餮登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@神奈子,R
"む、誰！？@"

#饕餮目線
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look2"");"

@饕餮,L
"ここか、源泉は@"

"巨大な湯沸かし器じゃないか@"

"つまり人工温泉だったんだな……@"

"それを黙っているなんて
欲深いもんだねぇ@"

#神奈子汗
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

@神奈子
"饕餮……尤魔！@"

"何しに来た？@"

#饕餮立ち上がり
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#饕餮笑う
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@饕餮
"旧血の池地獄の管理だよ@"

"ここらから血の池に
繋がっていないか調べてるんだ@"

#神奈子立ち
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

@神奈子
"……って、繋がってますけど？
知らなかったの？@"

#饕餮立ち
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise"");"

@饕餮
"何だと？@"

"そりゃダメだ！
塞がないと管理なんて出来ん！@"

,フェイスIN_R

@神奈子顔
"それを塞がれると
旧灼熱地獄の燃料が尽きて@"

"核融合炉も停止します@"

"そこを塞ぐ事は
許可できません！@"

,フェイスIN_L

@饕餮顔
"そうか邪魔をすると
いうのなら……@"

,SqFunction,"::bgm.play(""kanako1"");"

#饕餮決め開始
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@饕餮顔,,饕餮_決
"\R[戦闘|これ]しかないよなぁ！@"

# フェイス画像アウト
,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
