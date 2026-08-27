#============================
# 村紗 ステージ6 勝利
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,村紗,汗
,ENEMY,饕餮,惑

# イベントシーン開始
:main
,フェイスIN

@村紗顔
"石油泥棒とは誤解だわ@"

@饕餮顔,,饕餮_惑
"ああ？
じゃあ何しに来たんだ？@"

@村紗顔,,村紗_惑
"この黒い水の過剰生成を
阻止するために来たのよ@"

@村紗顔,,村紗_普
"私は村紗水蜜
旧地獄のことはよく知っている@"

@村紗顔,,村紗_惑
"ここは石油の海なんかでは
なかったはずだ@"


,SqFunction,"::bgm.fadeout();"

@村紗顔,,村紗_余
"しかし、我々はこういう
事態にも備えてる@"

@村紗顔,,村紗_余
"聖様が真実を見せる
真言を教えてくれたわ@"

,Hide,村紗顔,30

#村紗決めポーズ
,SqFunction,"::scene.rootenv.obj.player.cut1();"

@村紗顔,geki_10x2_lb,村紗_決
,Show,村紗顔,30

"呪い狂った血の池地獄よ！
真実の姿を取り戻すのだ！@"

#フェードアウト
,SqFunction,"::scene.rootenv.obj.player.cut2();"

,フェイスOUT

,Sleep,60
,SqFunction,"::lib.event_control.goto_next_stage();"

,Exit
