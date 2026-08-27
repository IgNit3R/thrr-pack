#============================
# 霊夢 ステージ２ 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,霊夢,汗
,ENEMY,小傘,負

# イベントシーン開始
:main
,フェイスIN

@小傘顔
"負けたー@"

@霊夢顔
"雨が降ってきたというか
弾幕が水滴に変わっていただけじゃん@"

@小傘顔
"ええまあ@"

@小傘顔
"私も色々調べてるんでさぁ
黒い水に関してね@"

"もしかしたら私の知っている奴が
関わっているんじゃないかって……@"

@霊夢顔,,霊夢_驚
"な、なんだって！？@"

@小傘顔
"おっと、それ以上は言えないわ
私もバレると身の危険が……ね@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("kogasa");
,Sleep,120

,Exit
