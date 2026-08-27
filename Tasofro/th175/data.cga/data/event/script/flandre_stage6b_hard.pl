#============================
# フランステージ6ハードルート　インター　饕餮最終形態
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,隠岐奈,普
#,PLAYER2,隠岐奈,普
,ENEMY,饕餮,普

#,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
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

#操作受付開始
#,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
#,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"
#,SqFunction,"::scene.rootenv.obj.enemy.enable_demo = false;"

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
