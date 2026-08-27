#============================
# 霊夢 ステージ5 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"
# ステージクリア時のスコア関連session_dataの更新
,SqFunction,"::lib.session_data.score_stageclear(::scene.rootenv.obj.player.life);"

# キャラ割り当て
,PLAYER,霊夢,驚
,ENEMY,空,負

# イベントシーン開始
:main

,フェイスIN

@空顔
"はあはあ@"

@霊夢顔,,霊夢_汗
"こ、これは神奈子の言うとおり
危険だった……@"

@空顔
"灼熱地獄に紛れ込んだ不純物を
排除しないと@"

@霊夢顔,,霊夢_怒
"ちょっとまて烏弾頭！
私よ、人間よ！@"

@空顔
"ん？@"

"なんだ、地上の巫女じゃん
なんか用なの？@"

"いま、核融合炉に紛れこんだ
不純物を取り除いていたの@"

"最近、石油が紛れ込んで
炉が汚れているから@"

@霊夢顔,,霊夢_汗
"ふう……
それはご苦労さん@"

"今度から焼き尽くす前に
対象を確認してね@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("utuho");
,Sleep,120

,Exit
