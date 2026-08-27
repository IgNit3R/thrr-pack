#============================
# 共通関数
#============================
:__UTIL_PL__TOP
,GoTo,__UTIL_PL__END

#============================
# プレイヤキャラ(霊夢)に発言用のオブジェクトを設定する
#============================
:INIT_PLAYER
,Object,%%1%%,0,0,false
,Show,%%1%%,0
,SqFunction,"::scene.contents[""talk""].snap(""%%1%%"", ""player"", 0, -50);"
,Return

:INIT_ENEMY
,Object,%%1%%,0,0,false
,Show,%%1%%,0
,SqFunction,"::scene.contents[""talk""].snap(""%%1%%"", ""enemy"", 0, -50);"
,Return

:INIT_DOT_CHARACTOR
,Object,%%2%%,0,0,false
,Show,%%2%%,0
,SqFunction,"::scene.contents[""talk""].snap(""%%2%%"", ""%%1%%"", 0, -50);"
,Return

:フェイスIN
:FACE_IN
,SetPosition,face_l,0,0&
,SetPosition,face_r,0,0
,Show,face_l,20&
,Show,face_r,20
,Return

:フェイスIN_L
:FACE_IN_L
,SetPosition,face_l,0,0
,Show,face_l,20
,Return

:フェイスIN_R
:FACE_IN_R
,SetPosition,face_r,0,0
,Show,face_r,20
,Return

:フェイスOUT
:FACE_OUT
,SetFocus,null
,Hide,face_l,20&
,Move,face_l,20,-480,0&
,Hide,face_r,20&
,Move,face_r,20,480,0
,Return

:フェイスOUT_L
:FACE_OUT_L
,SetFocus,null
,Hide,face_l,20&
,Move,face_l,20,-480,0
,Return

:フェイスOUT_R
:FACE_OUT_R
,SetFocus,null
,Hide,face_r,20&
,Move,face_r,20,480,0
,Return

:戦闘再開
,SqFunction,"::lib.event_control.restert_battle();"
,Return

:立ち絵変更L
,Hide,face_l,6
,SetImage,face_l,%%1%%
,Show,face_l,6&
,Return

:立ち絵変更R
,Hide,face_r,6
,SetImage,face_r,%%1%%
,Show,face_r,6&
,Return

:プレイヤ決めポーズ
,Hide,face_l,6
,SetImage,face_l,%%PLAYER%%_決
,Show,face_l,6&
,Return

:エネミ－決めポーズ
,Hide,face_r,6
,SetImage,face_r,%%ENEMY%%_決
,Show,face_r,6&
,Return

:PLAYER
,Alias,"obj.player",%%1%%
,Alias,face_l,%%1%%顔
,SetImage,%%1%%顔,%%1%%_%%2%%
,Set,PLAYER,%%1%%
,Return

:PLAYER2
,Alias,"obj.player2",%%1%%
,Set,PLAYER2,%%1%%
,Return

:ENEMY
,Alias,"obj.enemy",%%1%%
,Alias,face_r,%%1%%顔
,SetImage,%%1%%顔,%%1%%_%%2%%
,Set,ENEMY,%%1%%
,Return

:ENEMY2
,Alias,"obj.enemy2",%%1%%
,Set,ENEMY2,%%1%%
,Return

:ステージ見出し
,SqFunction,"
	::scene.contents[""subtitle""].story_caption = ""%%1%%"";
"
,Return

:エネミー紹介カットイン
,SqFunction,"
	::scene.push_thread(""cutin"");
	suspend();
	while (::scene.contents[""cutin""].state == SCENE_STATE_THREAD_RUNNING)
	{
		suspend();
	}
"
,Return

:ED_MSG
,SqFunction,"
	::scene.contents[""ending""].set_text(""%%1%%"", ""%%2%%"");
"
,Return

:ED_画像待ち
,SqFunction,"
		while (::scene.contents[""ending""].current_image < %%1%%) suspend();
"
,Return

:ED_背景スタート
,SqFunction,"
	// fadeout
	::scene.push_thread(""fader"");
	::scene.contents[""fader""].fadeout(120, function()
	{
		::lib.scene.cleanup();
		::scene.push_thread(""ending"");
		if (""%%1%%"" != ""<NULL>"")
		{
			::scene.contents[""ending""].load_image(""%%1%%"", 480);
		}
		if (""%%2%%"" != ""<NULL>"")
		{
			::scene.contents[""ending""].load_image(""%%2%%"", 480 + 960);
		}
		if (""%%3%%"" != ""<NULL>"")
		{
			::scene.contents[""ending""].load_image(""%%3%%"", 480 + 960 * 2);
		}
		if (""%%4%%"" != ""<NULL>"")
		{
			::scene.contents[""ending""].load_image(""%%4%%"", 480 + 960 * 3);
		}
		if (""%%5%%"" != ""<NULL>"")
		{
			::scene.contents[""ending""].load_image(""%%5%%"", 480 + 960 * 4);
		}
	}.bindenv(this));

	::scene.contents[""fader""].r = 1.0;
	::scene.contents[""fader""].g = 1.0;
	::scene.contents[""fader""].b = 1.0;
	
	::bgm.fadeout(600);

	while (::scene.contents[""ending""].state != SCENE_STATE_THREAD_RUNNING) suspend();
"
,Return

:画面フラッシュ
,SqFunction,"
	// fadeout
	::scene.push_thread(""fader"");
	::scene.contents[""fader""].fadeout(15, function()
	{
		::scene.push_thread(""fader2"");
		::scene.contents[""fader2""].fadein(15, null);

		::scene.contents[""fader2""].r = 1.0;
		::scene.contents[""fader2""].g = 1.0;
		::scene.contents[""fader2""].b = 1.0;
	});

	::scene.contents[""fader""].r = 1.0;
	::scene.contents[""fader""].g = 1.0;
	::scene.contents[""fader""].b = 1.0;
"
,Return

:ED_BGM_STOP
,SqFunction,"
	::bgm.fadeout(300);
"
,Return

:ED_BGM_SELECT
,SqFunction,"
	::scene.contents[""ending""].select_bgm(%%1%%);
"
,Return

:ED_STAFF_ROLL
,SqFunction,"
	::scene.contents[""ending""].set_staffroll(%%1%%);
"
,Return

:__UTIL_PL__END

