#============================
# フランドール ステージ2normal　VSヤマメ
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,ヤマメ,普

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_underground"");"
#　マップに石油オブジェクトを設置+右スクロール∔ステージロゴ+ヤマメ登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@ヤマメ
"洞窟が汚れている……@"

"これは血の池地獄の
腐った水だわ@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_angry"");"

"この緊急事態、地霊殿の彼女じゃあ
処理しきれない問題ね@"

"あー、昔の鬼神達が戻って
来てくれないかなぁ@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

@フラン
"狭い場所だわ@"

"戦いにくくて嫌だなぁ@"

#ヤマメびっくり
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@ヤマメ,R
"誰！？@"

"もしかして
地獄からやってきた鬼神様！？@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

@フラン,L
"鬼神？
私を甘く見るなよ@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,SqFunction,"::bgm.play(""yamame1"");"

"私は全てをぶち壊す破壊神だ！@"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
