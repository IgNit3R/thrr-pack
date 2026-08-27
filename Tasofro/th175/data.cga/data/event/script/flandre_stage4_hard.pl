#============================
# フランドール ステージ4 HARD VS霊夢
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,PLAYER2,隠岐奈,普
,ENEMY,霊夢,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_oil"");"
,Sleep,120

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,300

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@フラン
"ここは？@"

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@隠岐奈
"地底の底の底……
貴方の旅の終着点です@"

@フラン
"それで、私に破壊させたい奴は
何処にいるの？@"

@隠岐奈
"今探している
ちょっと待ってなさい@"

#隠岐奈撤収
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,Sleep,60

#フラン右移動ループ
,SqFunction,"::scene.rootenv.obj.player.cut4();"

,Sleep,60

@フラン
"この世の憎悪が集まった様な
何とも重苦しい場所だねぇ@"

"居心地は悪くない@"

,Sleep,30

#画面停止+カメラ右へ移動
,SqFunction,"::scene.rootenv.obj.player.cut5();"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut6();"

#霊夢驚き
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@霊夢,R
"え！？
フランドール！？@"

#フランびっくり
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise2"");"

@フラン,L
"霊夢？@"

"って事は、ここは神社？@"

#フランドヤ顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

"随分とスッキリさせたわね@"

#霊夢お怒り
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@霊夢
"そんな訳無いでしょ@"

#感情エフェクト消去
,SqFunction,"::lib.story.clear_emotion(::scene.rootenv.obj.enemy);"
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

"ここは石油の海よ
何であんたがこんな所に……@"

#フラン見まわし
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@フラン
"ここに誰にも倒せなかった
獣がいるって聞いてね@"

"私はそいつを破壊しに来たんだ@"

#フランドヤ顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

"それこそ霊夢にも
倒せなかったんでしょ？@"

#霊夢しかめっ面
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_face"");"

,フェイスIN_R

@霊夢顔,,霊夢_汗
"ぐっ、そんな噂が
広まっているとは……@"

"誰にも知られていないと思ったのに@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_stand"");"

@霊夢顔,,霊夢_余
"ただ、石油噴出は饕餮の所為では
無さそうなので@"

"倒さなくてもいいかなーと@"

#フラン通常
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_stand"");"

,フェイスIN_L

@フラン顔
"ふっ、馬鹿な@"

"敵は倒さないと行けないに
決まっている@"

@フラン顔,,フラン_怒
"いつからそんな
腑抜けになったのよ@"

"私の処へやってきたあんたは
全てを破壊する目をしていたわ！@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut7();"

,SetImage,霊夢顔,霊夢_驚
,SqFunction,"::bgm.play(""reimu1"");"

@フラン顔,,フラン_決
"その頃を思い出せ！
敵は殲滅せよ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit

