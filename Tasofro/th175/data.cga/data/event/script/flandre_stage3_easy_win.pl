#============================
# フランドールA ステージ3 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# イージーストーリークリア値を3に更新
,SqFunction,"::lib.session_data.easy_clear(3);"

# キャラ割り当て
,PLAYER,フラン,汗
,ENEMY,神奈子,汗

# イベントシーン開始
:main

,SqFunction,"::scene.rootenv.obj.player.cut1();"

,フェイスIN

@神奈子顔
"変だな、石油を苦手そうに
しているじゃないか@"

@フラン顔
"流れる水が苦手なだけよ
石油じゃなくても@"

@神奈子顔,,神奈子_余
"ああ、確かにそうだったね
吸血鬼って@"

@神奈子顔,,神奈子_惑
"だとすると、お前は石油噴出騒動に
関わっているとは思えないな@"

@フラン顔,,フラン_嬉
"さあどうだかね@"

,フェイスOUT

#フラン扉から帰る
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,60

#神奈子にカメラ+上を見る
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@神奈子顔
,フェイスIN_R

"何だったんだ？@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_amaze"");"

"しかも何か扉みたいな物が
見えたような……@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("kanako");
,Sleep,120

,Exit
