# load extention modules
#,LoadModule,"modules/updater.avs",0,,true
#,LoadModule,"modules/package_loader.avs",0,,true
,LoadModule,"modules/transcoder_icu.avs",0,,true
,LoadModule,"modules/font_ft.avs",0,,true
,LoadModule,"modules/graphics_dx11.avs",0,"DirectX runtime is not installed, or too old.",true
,LoadModule,"modules/lang_squirrel3.1.avs",1,,true
,LoadModule,"modules/lang_cgs.avs",1,,true
,LoadModule,"modules/audio_xa2.avs",0,"XAudio runtime is not installed, or too old.",true
,LoadModule,"modules/input.avs",-100,,true
,LoadModule,"modules/vspace.avs",0,,true
,LoadModule,"modules/composition.avs",100,,true
,LoadModule,"modules/dynamictexture.avs",100,,true
,LoadModule,"modules/dynamicshape.avs",100,,true
,LoadModule,"modules/gameobject.avs",100,,true
,LoadModule,"modules/tilemap.avs",100,,true
,LoadModule,"modules/liquid.avs",150,,true
,LoadModule,"modules/system.avs",0,,true
,LoadModule,"modules/regex.avs",0,,true
,LoadModule,"modules/keybuffer.avs",0,,true
,LoadModule,"modules/random.avs",0,,true
#,LoadModule,"modules/fileparser.avs",0,,true
,LoadModule,"modules/plang.avs",0,,true
,LoadModule,"modules/fileparser_sq.avs",0,,true
,LoadModule,"modules/steam_api.avs",0,,skip
,Sleep,0

# boot game
,SqFunction,"
//	::_system_set_fullscreen(true);
	::_system_enable_vsync(true);

	::main <- function(){};
	local main_original = ::main;

	// execute script files
	::_exec(""lib/script/boot.nut"");

	// main loop
	if (::main != main_original) ::main();
"
