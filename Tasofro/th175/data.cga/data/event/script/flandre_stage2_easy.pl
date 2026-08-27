#============================
# フランドール ステージ2A　VS小傘
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,小傘,普

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_underground"");"
#　マップに石油オブジェクトを設置+右スクロール∔ステージロゴ
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@小傘
"ムラサは黒い水を止めるとか
言っていたけど全然じゃない@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_grad"");"

"ま、こっちは楽しめるから
良いけどね@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@フラン
"洞窟！@"

"こういう狭い場所で
水が流れるのは嫌だなぁ@"

#小傘びっくり
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@小傘,R
"え！？
いつの間に@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン,L
"さくっと破壊しようっと@"

,SqFunction,"::bgm.play(""kogasa1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
