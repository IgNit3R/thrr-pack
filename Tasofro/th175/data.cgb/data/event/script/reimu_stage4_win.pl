#============================
# 霊夢 ステージ4 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,霊夢,驚
,ENEMY,神奈子,負

# イベントシーン開始
:main
,フェイスIN

@神奈子顔
"もう何も言うまい@"

"そこまで本気なら行くがいい@"

@霊夢顔
"え？
あんたを倒したら終わりじゃないの？@"

@霊夢顔,,霊夢_汗
"てっきり、石油を掘り出しているのは
核融合炉の為だと@"

@神奈子顔,,神奈子_普
"それは誤解です@"

"私も石油の事に関して
調べてたの@"

"この石油の貯留層にはとんでもなく
不吉な秘密が隠されていてね@"

"正直、霊夢の手に負える
相手では無いと思ったの@"

@霊夢顔,,霊夢_惑
"なる程、それで
私を止めようと……@"

@霊夢顔,,霊夢_怒
"余計なお世話よ
じゃあね！@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("kanako");
,Sleep,120

,Exit
