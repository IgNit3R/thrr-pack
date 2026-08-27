#============================
# フラン ノーマルステージ6　VS饕餮　血の池地獄
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,フラン,惑
,PLAYER2,隠岐奈,普
,ENEMY,饕餮,普

,SqFunction,"::scene.contents[""talk""].snap(""obj.player2"", ""player2"", 0, -15);",# 吹き出し位置調整

# イベントシーン開始
:main

#フランと饕餮初期演出
,SqFunction,"::scene.rootenv.obj.player.cut1();"

,Sleep,180

,SqFunction,"::_audio_play(::se[""stage_title""],1);"


,Sleep,120

,SqFunction,"::bgm.play(""toutetu2"");"

@饕餮
"おお、力が漲るぞ@"

"血の池の恐怖、哀楽、憎悪、怨嗟
全てが注ぎ込まれる様だ！@"

@フラン
"え？　え？@"

@隠岐奈
"何だ？
自分に力を注がれると思ったのか？@"

"甘ったれるな@"

"力は強欲な者に流れるだけだ@"

"強欲さは饕餮の方が上だったな@"

#饕餮気合ためを解除
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@饕餮,R
"クックック@"

,フェイスIN
@饕餮顔,,饕餮_普
"狂人がまた一人増えたな@"

@饕餮顔,,饕餮_余
"何をさせたいのか判らんが
力をくれてありがとうな@"

@饕餮顔,,饕餮_嬉
"思う存分戦えるぜ！@"

"破壊されるのはお前の方だったな！@"

@饕餮顔,,饕餮_決
"世間を舐めてると
痛い目に遭うんだぜ？@"

"吸血鬼のお嬢ちゃんよー！@"
,フェイスOUT

#隠岐奈撤収
,SqFunction,"::scene.rootenv.obj.player.cut2();"

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"

,Sleep,120

#フラン操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
