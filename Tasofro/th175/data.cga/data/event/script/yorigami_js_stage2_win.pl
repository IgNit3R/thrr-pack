#============================
# 女苑 ステージ2  勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,女苑,普
,PLAYER2,紫苑,普
,ENEMY,庭渡,負

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,フェイスIN

@庭渡顔
"何なのよー
あんた達は@"

,プレイヤ決めポーズ

@女苑顔,,女苑_決
"疫病神改め
石油王の依神女苑@"

@女苑顔,,紫苑_決
"貧乏神改め
富豪神の依神紫苑よ@"

@庭渡顔
"庭渡久侘歌です@"

"私は三途の河から水が漏れて
いたのを修復しにきたのです@"


"貴方達と戦う理由なんて
ありません@"

,立ち絵変更L,女苑_普

@女苑顔
"私達がここにいたことを
誰にも言うなよ@"

@庭渡顔
"はいはい@"

# FIXME::語尾
"そんな面白くもない話
誰にするって言うんですか@"

"ちなみにまもなくここは
業火に包まれると思いますので@"

"ここに居たら危険だと思いますよ@"

,Sleep,30
,SqFunction,::scene.contents["story_event"].kick_result("niwatari");
,Sleep,120

,Exit
