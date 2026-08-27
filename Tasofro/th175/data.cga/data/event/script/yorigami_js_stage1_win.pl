#============================
# 女苑 ステージ1 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,普
,PLAYER2,紫苑,普
,ENEMY,勇儀,負

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@女苑顔,,女苑_余
"一番高い酒を持ってこーい！@"

@女苑顔,,紫苑_余
"高い食べ物ももってこーい@"

@勇儀顔
"貸し切りには出来んが@"

"ちゃんとお金があるのなら
用意してやる@"

@女苑顔,,女苑_普
"石油王に向かって失礼な言い草ね@"

@女苑顔,,女苑_嬉
"金ならいくらでも湧いてくる@"

@勇儀顔
"あと、他のお客に迷惑を
掛けるなよ？@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("yuugi");
,Sleep,120

,Exit
