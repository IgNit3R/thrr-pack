#============================
# 村紗 ステージ5 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,村紗,惑
,ENEMY,空,普

# イベントシーン開始
:main
,フェイスIN

@空顔
"お前か
灼熱地獄を冷やしたのは！@"

,エネミー紹介カットイン

@空顔,,空_決
"お前も燃料にして
元の灼熱地獄に戻してやる！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
