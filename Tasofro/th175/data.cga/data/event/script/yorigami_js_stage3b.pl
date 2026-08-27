#============================
# 女苑　ステージ3 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,汗
,PLAYER2,紫苑,汗
,ENEMY,空,驚

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@空顔
"まだ燃え尽きていないとは……@"

,エネミー紹介カットイン

@空顔,geki_15x2_lb,空_決
"こうなったら自らも
燃え尽きるつもりで焼いてやる！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
