#============================
# 魔理沙 エピローグ
#============================
# 初期化
,Include,"data/event/script/lib/init.pl"

# イベントシーン開始
:main
,ED_背景スタート,"ed/bg_hakurei","ed/marisa-1","ed/marisa-2"
,ED_BGM_SELECT,1
,ED_STAFF_ROLL,false

# 背景：博麗神社
,ED_画像待ち,0
,Sleep,570

,ED_MSG,"博麗神社。"
,Sleep,240
,ED_MSG,"幻想郷の由緒正しき神社である。"
,Sleep,240
,ED_MSG,"幻想郷の中でも高い処に存在するからか、"
,ED_MSG,"黒い水噴出の被害には遭っていない。"
,Sleep,360
,ED_MSG," "

# 霊夢に報告する魔理沙
,ED_画像待ち,1
,Sleep,360

,ED_MSG,"霊夢　「──地の底に黒い水の海？」",R
,Sleep,240
,ED_MSG,"魔理沙「黒い水は石油って言うらしいぜ。石油の海だ。　　"
,ED_MSG,"　　　　そこから湧いてきているのは間違いないと思うぜ」",B
,Sleep,360
,ED_MSG,"霊夢　「しかし、一朝一夕で出来たわけじゃないんでしょ？"
,ED_MSG,"　　　　何故今になって急に湧いてきたのかな」　　　　　",R
,Sleep,360
,ED_MSG,"魔理沙「……」",B
,Sleep,240
,ED_MSG," "

# 考え込む魔理沙
,ED_画像待ち,2
,Sleep,120

,ED_MSG,"霊夢　「石油の海には他に怪しいものはなかったの？」",R
,Sleep,240
,ED_MSG,"魔理沙「そ、そうだなぁ。　　　　　　　　　　　　　"
,ED_MSG,"　　　　暗闇にただ黒い水が湛えていただけだったな。"
,ED_MSG,"　　　　な、なんで湧いてきているのかな」　　　　　",B
,Sleep,420
,ED_MSG,"霊夢　「自然現象なら、取り敢えず地上で"
,ED_MSG,"　　　　対処するしかないのかなぁ」　　",R
,Sleep,360
,ED_MSG,"魔理沙「いや、もう一度行ってみようかなぁ」",B
,Sleep,240
,ED_MSG,"霊夢　「？」",R
,Sleep,240

,ED_MSG,"魔理沙は饕餮と対峙した事を言えなかった。"
,Sleep,280
,ED_MSG,"戦いに勝ちきれず、気が付いたら地上まで"
,ED_MSG,"吹き飛ばされていたことが恥ずかしかったからだ。"
,Sleep,420
,ED_MSG,"何より、地の底の底の暗闇の中で一人笑っていた不気味な獣の記憶が、"
,ED_MSG,"語ることを本能的に忌避していた。"
,Sleep,420
,ED_MSG,"心の奥底で、他の誰かが解決してくれることを"
,ED_MSG,"望んでいたのかも知れない。"
,Sleep,420
,ED_MSG," "

,Sleep,30

# ここから最後まで流す
,SqFunction,"::scene.contents[""ending""].set_stop_on_lastimage(false);"
,Sleep,99999999999999

