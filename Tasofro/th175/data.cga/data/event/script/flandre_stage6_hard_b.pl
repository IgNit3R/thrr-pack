#============================
# フラン ステージ6C　VS饕餮最終攻撃　血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,隠岐奈,余
,ENEMY,饕餮,普

# イベントシーン開始
:main

#隠岐奈登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,30

,フェイスIN_L

@隠岐奈顔,,隠岐奈_余
"よし、よく頑張った@"

@隠岐奈顔,,隠岐奈_惑
"あいつはもう空腹だろう
これから吸収のみのターンに入る@"

@隠岐奈顔,,隠岐奈_嬉
"いま、まさに留めを刺すときだ！@"

@隠岐奈顔,,隠岐奈_嬉
"やれ！　フランドールよ！
全てを破壊する弾を撃ち込め！@"

,フェイスOUT

#隠岐奈撤収
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,Sleep,30

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
