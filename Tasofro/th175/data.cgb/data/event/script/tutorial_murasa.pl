#============================
# 村紗チュートリアルステージ
#============================
:init

,SqFunction,"
	local dl_status = null;
	do {
		suspend();
		dl_status = ::_composition_get_delayloadstatus();
	} while (dl_status.finished < dl_status.total);
"

#動作開始
,SqFunction,"::scene.rootenv.obj.player.enable_move();"
,SqFunction,"::scene.rootenv.obj.enemy.enable_move();"

,Exit
