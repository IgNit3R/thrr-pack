#============================
# 女苑 ステージ７ VS饕餮 血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# ステージ７は連戦のため見出しはありません、必要であれば表示できます。
#,ステージ見出し,"「ここに\\R[見出し|テキスト]を入れてください」"

# キャラ割り当て
,PLAYER,女苑,決
,PLAYER2,紫苑,決
,ENEMY,饕餮,決

,SqFunction,"::scene.contents[""talk""].snap(""obj.player"", ""player"", 0, -45);",# 吹き出し位置調整
,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 10, -15);",# 吹き出し位置調整

,SqFunction,"::bgm.stop();"

# イベントシーン開始
:main

#白フェードインで血の池地獄へ
,Sleep,180

#,SqFunction,"::_audio_play(::se[""stage_title""],1);"
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,210

,SqFunction,"::bgm.play(""toutetu2"");"


@女苑,L
"こ、これは……！？
血の池地獄！？@"

,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""event_laugh"");"

@饕餮,R
"クックック……
この石油の正体は呪われた血液だ@"

"強欲な奴をみると
生前を思い出してざわつくんだ@"

"欲こそが、生きている証だからな@"

#女苑紫苑青ざめる
,SqFunction,"::scene.rootenv.obj.player.cut2();"

@紫苑
"き、気持ち悪い……@"

#女苑青ざめる
,SqFunction,"::scene.rootenv.obj.player.cut3();"

@女苑
"石油って、こういう物だったの？@"

#饕餮ヤンキー座り
,SqFunction,"::scene.rootenv.obj.enemy.select_motion(""sit"");"

@饕餮
"無論、こういう物さ@"

"外の世界では
それを承知で使いまくってるぞ@"

"元来、石油というのは
生物由来の生成物なんだ@"

"生命の恐怖、哀楽、憎悪、怨嗟の
全てがこの液体の正体なんだよ@"

"私のように欲を喰らって
生きる者じゃない限り扱えん@"

#饕餮啖呵
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

"永遠の貧乏人は去れ！@"

#表情解除
,SqFunction,"::scene.rootenv.obj.player.cut4();"

#紫苑ぶちきれ
,SqFunction,"::scene.rootenv.obj.player.cut5();"


,Sleep,60

@紫苑,geki_10x2_lb
"誰が貧乏人だ！@"

"貧乏のことは言うなー！@"

#女苑目が点

@女苑
"あ、キレた@"

@紫苑,L
"石油だろうが血液だろうが関係無い！@"

"貧困からの脱却の為にも
石油を全てよこせー！@"

#フェイスセット準備
,SqFunction,"::scene.rootenv.obj.player.cut6();"

,フェイスIN_L

@女苑顔
"姉さんがキレたらもう
やるしか無いね@"

"やっぱり石油がどんな物であれ
一滴たりとも譲らない！@"

,フェイスIN_R
,SetFocusOffset,-60,0,-20,0

@饕餮顔
"その強欲さ、大好物だ@"

"石油にくれてやるには勿体ない@"

"クックック、栄養価が高そうだから
私が呑み込んでやろう@"

@饕餮顔,toge_10x2_lb
"最高に胃袋が喜ぶ夜に
なりそうだ！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
