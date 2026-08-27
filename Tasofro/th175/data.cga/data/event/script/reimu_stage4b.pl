#============================
# 霊夢 ステージ4 インター1
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# キャラ割り当て
,PLAYER,霊夢,決
,ENEMY,神奈子,普

# イベントシーン開始
:main
,フェイスIN

@霊夢顔
"本気で抵抗するのね@"

"やっぱ何か隠してるんでしょ@"

"核融合炉の事
もっと教えて貰うわよ！@"

,フェイスOUT

#戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"

,Exit
