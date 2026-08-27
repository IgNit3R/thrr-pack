#============================
# フランドール ステージ1A　VS魔理沙　
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,普
,ENEMY,魔理沙,普

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_forest"");"
,Sleep,120

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,110

#シーン　魔理沙登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@魔理沙
"低地には再び黒い水が
湧いてきたという噂もあるな@"

"しかし、あの饕餮って奴の
仕業ではないみたいだし@"

"どうすりゃ良いんだ？@"

# 地面から石油が吹き出す
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

# 驚く魔理沙
"わあ！
こ、これは@"

"黒い水だー！@"

#魔理沙の背中からフラン登場
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@フラン
"ここは、魔法の森か？@"

#魔理沙フランに振り替える
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@魔理沙,R
"何だ何だ！？
一体何が始まるんだ？@"

@フラン
"流水って言っても
大したことは無いね@"

"このくらい朝飯前だ！
破壊の限りを尽くしてやる@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@フラン,L
"さあ行くよ！@"

#戦闘開始
,SqFunction,"::bgm.play(""marisa1"");"

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
