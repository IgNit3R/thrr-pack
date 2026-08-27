#============================
# ステージ3 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,惑
,PLAYER2,紫苑,惑
,ENEMY,空,負

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@空顔
"はあはあ@"

"灼熱地獄に紛れ込んだ不純物を
排除する！@"

@女苑顔,,女苑_惑
"獄炎の鳥だ
こいつはまるで不死鳥だ！@"

@女苑顔,,女苑_汗
"こんな奴に構っていられない
さっさと逃げよう！@"

@女苑顔,,紫苑_汗
"逃げろ逃げろー！@"

,フェイスOUT

#プレイヤー画面下へ退避
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,60

#お空画面内に復帰
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

#お空顔を掻く
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_forget"");"

@空
"ん？
敵と戦っていた気がするけど@"

"気のせいだったか@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("utuho");
,Sleep,120

,Exit
