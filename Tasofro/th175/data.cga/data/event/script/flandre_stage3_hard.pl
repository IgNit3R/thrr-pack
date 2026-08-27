#============================
# フランドール ステージ3HARD　VS庭渡
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,惑
,ENEMY,庭渡,驚

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_waterhell"");"

#　マップスクロール
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,240

#庭渡登場
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@庭渡
"三途の河の水量は無限です@"

"どれだけ水が漏れても
河が枯れることは無いでしょう@"

"改めて考えてみると
不思議なもんですね@"

"しかし、流れていった地の底では
どうなってるのか@"

"この先は昔に捨てられた地獄が
ある筈ですが……@"

"既に忘れ去られていたと言うのに
愁いすらも水没させてしまうでしょう@"

"無限の水量は無情ですね……@"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#庭渡びっくり
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_suprise"");"

"！？@"

@フラン
"うわあ！@"

"こんな所は無理よ、無理無理！@"

"流れる水しか無いじゃん！@"

,フェイスIN_R

@庭渡顔
"一体何処から……？
それに貴方は一体……@"

#フラン待機
,SqFunction,"::scene.rootenv.obj.player.cut3();"

,フェイスIN_L

@フラン顔
"ああ、もう帰る扉もない@"

,プレイヤ決めポーズ

"こうなったら破れかぶれだ！@"

#FIXME::「は」
,SqFunction,"::bgm.play(""niwatari1"");"

@フラン顔,toge_15x2_lb
"流水で力が消える前に
全てを破壊し尽くしてやる！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
