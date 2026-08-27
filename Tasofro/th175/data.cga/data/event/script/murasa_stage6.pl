#============================
# 村紗 ステージ6 VS饕餮 石油の海
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

,ステージ見出し,"「旧地獄が隠してきた秘密」"

# キャラ割り当て
,PLAYER,村紗,普
,ENEMY,饕餮,普

# イベントシーン開始
:main

#フェードアウトからシーン切り替え　村紗石油の海に到着
,SqFunction,"::scene.rootenv.obj.player.cut1();"
,Sleep,150

#プレイヤー登場
,SqFunction,"::scene.rootenv.obj.player.cut2();"
,Sleep,10

@村紗
"ここは……
やっと辿り着いたか@"

,Sleep,10

#ステージBGMの再生開始
,SqFunction,"::bgm.play(""talk_Inferno"");"
#石油海登場
,SqFunction,"::scene.rootenv.stage.map.message(OM_ACTION,null);"
#ステージロゴ表示
,SqFunction,"::object_pool.rootenv.Spawn_StageTitle();"
,Sleep,200

,Sleep,30

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_look"");"

"聖様の予想通り
黒い水だらけね@"

,SqFunction,"::scene.rootenv.obj.player.select_motion(""event_cheat"");"

"しかし……お空の言っていた
変な獣ってのは何だ？@"

,Sleep,60

#饕餮乱入
,SqFunction,"::scene.rootenv.obj.enemy.cut1();"

@饕餮,R
"……また石油泥棒が来たか@"

,エネミー紹介カットイン

@村紗,L
"本当に居た
何者だ？@"

,フェイスIN_R

@饕餮顔
"\R[饕餮|とうてつ]\R[尤魔|ゆうま]だ
ここの石油は全て頂く@"

"この石油は我々剛欲同盟の
切り札になるんだ@"

,SqFunction,"::bgm.play(""toutetu1"");"

,フェイスOUT_R
@饕餮顔,,饕餮_決

#饕餮決めポーズ
,SqFunction,"::scene.rootenv.obj.enemy.cut3();"

#"地上の奴に一滴たりともやらんぞ@"
,フェイスIN_R

#,エネミ－決めポーズ

"さっさと出て行け
石油泥棒！@"

,フェイスOUT

#戦闘開始
,SqFunction,"::object_pool.rootenv.Spawn_Effect(320,180,""fight"");"
,Sleep,120

#村紗操作受付開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"

#敵動作開始
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
