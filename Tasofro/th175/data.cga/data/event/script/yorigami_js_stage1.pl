#============================
# 女苑 ステージ１
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「夢の大豪遊」"

# キャラ割り当て
,PLAYER,女苑,普
,PLAYER2,紫苑,普
,ENEMY,勇儀,決

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

# イベントシーン開始
:main
,SqFunction,"::bgm.play(""talk_town"");"


#カメラ移動+ロゴ表示
,SqFunction,"::scene.rootenv.obj.player.cut1();"

#女苑登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@女苑
"うわぁ凄い
本当に温泉だ！@"

#紫苑登場
,SqFunction,"::scene.rootenv.obj.player.cut2b();"

@紫苑
"噂の通りね
地底に温泉街があるって@"

#女苑左向き+ぐふふ笑い
,SqFunction,"::scene.rootenv.obj.player.direction_h = -1;"
,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_laugh"");"

@女苑
"この世の全てが買える程の富豪になるという
石油が手に入ったんだし@"

"今日はここで大豪遊しよう！@"

#紫苑ぐふふ笑い
,SqFunction,"::scene.rootenv.obj.player2.select_motion(""event_smile"");"

@紫苑
"やったー
今夜はおだいじーん！@"

#勇儀歩きで登場　
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@勇儀,R
"ようこそ
旧地獄温泉街へ@"

,エネミー紹介カットイン

"今日はどちらに行くか
決まってるのかい？@"

@女苑,L
"全部、全部@"

"今日は貸し切りよ！@"

#女苑石油をばらまく
,SqFunction,"::scene.rootenv.obj.player.cut3();"

"金ならいくらでも湧くからね！@"

@紫苑
"キャー痺れるー！@"

#勇儀お怒り
,SqFunction,"::scene.rootenv.obj.enemy.cut2();"

@勇儀
"ふふふ、ご冗談を……@"

"そんな臭い水で温泉が
買えると思うな@"

#紫苑女苑アクション停止
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#勇儀啖呵
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

,SqFunction,"::bgm.play(""yuugi1"");"
@勇儀,geki_10x2_rb
"どうかお帰りくだせえ！@"


,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#勇儀操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
