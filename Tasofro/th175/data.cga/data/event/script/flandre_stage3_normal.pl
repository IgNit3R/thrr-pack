#============================
# フランドール ステージ3normal　VS女苑
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,決
,ENEMY,女苑,決
,ENEMY2,紫苑,決

,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy"", ""enemy"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.enemy2"", ""enemy2"", 10, -15);",# 吹き出し位置調整

#　マップに石油オブジェクトを設置
,SqFunction,"::scene.rootenv.obj.player.cut1();"

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_town"");"
,Sleep,20

#カメラ移動+ステージタイトル表示
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@女苑
"あっはっは
石油がまた湧き始めたじゃん！@"

@紫苑
"これで私達の富は約束されたわね！@"

@女苑
"饕餮なんて、何でも無い奴
だったのかねぇ@"

#紫苑びっくり
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

#フラン登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@紫苑
"な、何！？@"

@フラン
"わあ、流れる水だらけだわ@"

#フラン不機嫌表情
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_angry"");"

"ここはサクッと破壊して行きたい……@"

#フランびっくり顔
,SqFunction,"::scene.rootenv.obj.player.direction_h = 1;"
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_suprise2"");"

@フラン,L
"ん？　お前達はこの間の！@"

#女苑振り返り+びっくり
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

@女苑,R
"あー、ワープトラップで
出てきた謎の敵だ！@"

#紫苑怒り
,SqFunction,"::scene.rootenv.obj.enemy2.select_motion(""event_angry"");"

@紫苑,R
"またワープしてきたわね@"

"謎の妖怪め@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_smile2"");"

@フラン
"謎の妖怪？
私を誰だと思ってる@"

#フラン決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@フラン顔
,フェイスIN_L

"フランドール・スカーレット
黙る子も泣く吸血鬼だ！@"

#女苑紫苑決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut4();"
,Sleep,40

,フェイスIN_R

@女苑顔
"我らは泣く子も儲かる
石油王の依神姉妹！@"

@女苑顔,,女苑_余
"なる程、吸血鬼、か
合点がいった@"

@女苑顔,,紫苑_余
"マジで？
女苑ったら頭が良いわ@"

@女苑顔,,女苑_怒
"地底にある血の池地獄の
血液を狙っているんだろ？@"

"地上の生き血だけに飽き足らず
とんでもない強欲な奴め！@"

@フラン顔,,フラン_驚
"血の池地獄……
ははーん@"

@フラン顔,,フラン_他
"あの慇懃無礼な秘神が@"

"私を引っ張り出してきた
理由はそこだったのかな@"

@女苑顔,,女苑_嬉
"でも諦めな！　強欲な吸血鬼よ！
あれはすでに生物の血液ではない@"

,SqFunction,"::bgm.play(""jyoon1"");"

@女苑顔,,女苑_決
"我々の石油だ！@"

,フェイスOUT

,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
