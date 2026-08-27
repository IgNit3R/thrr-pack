#============================
# フランドール ステージ4 HARD VS霊夢
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,他
,ENEMY,霊夢,汗

# イベントシーン開始
:main

#画面停止+カメラ右へ移動
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

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

#フランドヤ顔
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

"私はそいつを破壊しに来たんだ@"

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

,プレイヤ決めポーズ
,SetImage,霊夢顔,霊夢_驚

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
