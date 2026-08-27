#============================
# 村紗 ステージ5 インター2
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,村紗,汗
,ENEMY,空,決

#背景過熱状態に置き換え
#,SqFunction,"::scene.rootenv.obj.player.demo_cut1();"

# イベントシーン開始
:main
,フェイスIN

@村紗顔
"不味いな
もう暑くなって来た……@"

"灼熱地獄の火力を
見くびっていたか？@"

@空顔
"そろそろトドメだ！
焼け腐れ！@"

,フェイスOUT

#プレイヤー操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"
,SqFunction,"::scene.rootenv.obj.enemy.enable_demo = false;"

,Exit
