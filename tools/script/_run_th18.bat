@echo off
setlocal
set PATH=E:\GitWorkspace\thworks\.build\thtk-install\bin;%PATH%
set OUT=E:\GitWorkspace\thworks\pushfiles\th18\th18.dat
if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%"
cd /d "%OUT%"
thdat.exe -x 18 "E:\GitWorkspace\thworks\tsa\th18\th18.dat"
if exist "%OUT%\_work_abcard_anm" rmdir /s /q "%OUT%\_work_abcard_anm"
mkdir "%OUT%\_work_abcard_anm"
copy /y "%OUT%\abcard.anm" "%OUT%\_work_abcard_anm\abcard.anm" >nul
cd /d "%OUT%\_work_abcard_anm"
thanm.exe -x 18 abcard.anm
cd /d "%OUT%"
del /q "%OUT%\abcard.anm"
del /q "%OUT%\_work_abcard_anm\abcard.anm"
mkdir "%OUT%\abcard.anm"
xcopy /e /y /q "%OUT%\_work_abcard_anm\*" "%OUT%\abcard.anm\" >nul
rmdir /s /q "%OUT%\_work_abcard_anm"
if exist "%OUT%\_work_ability_anm" rmdir /s /q "%OUT%\_work_ability_anm"
mkdir "%OUT%\_work_ability_anm"
copy /y "%OUT%\ability.anm" "%OUT%\_work_ability_anm\ability.anm" >nul
cd /d "%OUT%\_work_ability_anm"
thanm.exe -x 18 ability.anm
cd /d "%OUT%"
del /q "%OUT%\ability.anm"
del /q "%OUT%\_work_ability_anm\ability.anm"
mkdir "%OUT%\ability.anm"
xcopy /e /y /q "%OUT%\_work_ability_anm\*" "%OUT%\ability.anm\" >nul
rmdir /s /q "%OUT%\_work_ability_anm"
if exist "%OUT%\_work_abmenu_anm" rmdir /s /q "%OUT%\_work_abmenu_anm"
mkdir "%OUT%\_work_abmenu_anm"
copy /y "%OUT%\abmenu.anm" "%OUT%\_work_abmenu_anm\abmenu.anm" >nul
cd /d "%OUT%\_work_abmenu_anm"
thanm.exe -x 18 abmenu.anm
cd /d "%OUT%"
del /q "%OUT%\abmenu.anm"
del /q "%OUT%\_work_abmenu_anm\abmenu.anm"
mkdir "%OUT%\abmenu.anm"
xcopy /e /y /q "%OUT%\_work_abmenu_anm\*" "%OUT%\abmenu.anm\" >nul
rmdir /s /q "%OUT%\_work_abmenu_anm"
if exist "%OUT%\_work_ascii_anm" rmdir /s /q "%OUT%\_work_ascii_anm"
mkdir "%OUT%\_work_ascii_anm"
copy /y "%OUT%\ascii.anm" "%OUT%\_work_ascii_anm\ascii.anm" >nul
cd /d "%OUT%\_work_ascii_anm"
thanm.exe -x 18 ascii.anm
cd /d "%OUT%"
del /q "%OUT%\ascii.anm"
del /q "%OUT%\_work_ascii_anm\ascii.anm"
mkdir "%OUT%\ascii.anm"
xcopy /e /y /q "%OUT%\_work_ascii_anm\*" "%OUT%\ascii.anm\" >nul
rmdir /s /q "%OUT%\_work_ascii_anm"
if exist "%OUT%\_work_ascii1280_anm" rmdir /s /q "%OUT%\_work_ascii1280_anm"
mkdir "%OUT%\_work_ascii1280_anm"
copy /y "%OUT%\ascii1280.anm" "%OUT%\_work_ascii1280_anm\ascii1280.anm" >nul
cd /d "%OUT%\_work_ascii1280_anm"
thanm.exe -x 18 ascii1280.anm
cd /d "%OUT%"
del /q "%OUT%\ascii1280.anm"
del /q "%OUT%\_work_ascii1280_anm\ascii1280.anm"
mkdir "%OUT%\ascii1280.anm"
xcopy /e /y /q "%OUT%\_work_ascii1280_anm\*" "%OUT%\ascii1280.anm\" >nul
rmdir /s /q "%OUT%\_work_ascii1280_anm"
if exist "%OUT%\_work_ascii_960_anm" rmdir /s /q "%OUT%\_work_ascii_960_anm"
mkdir "%OUT%\_work_ascii_960_anm"
copy /y "%OUT%\ascii_960.anm" "%OUT%\_work_ascii_960_anm\ascii_960.anm" >nul
cd /d "%OUT%\_work_ascii_960_anm"
thanm.exe -x 18 ascii_960.anm
cd /d "%OUT%"
del /q "%OUT%\ascii_960.anm"
del /q "%OUT%\_work_ascii_960_anm\ascii_960.anm"
mkdir "%OUT%\ascii_960.anm"
xcopy /e /y /q "%OUT%\_work_ascii_960_anm\*" "%OUT%\ascii_960.anm\" >nul
rmdir /s /q "%OUT%\_work_ascii_960_anm"
if exist "%OUT%\_work_bullet_anm" rmdir /s /q "%OUT%\_work_bullet_anm"
mkdir "%OUT%\_work_bullet_anm"
copy /y "%OUT%\bullet.anm" "%OUT%\_work_bullet_anm\bullet.anm" >nul
cd /d "%OUT%\_work_bullet_anm"
thanm.exe -x 18 bullet.anm
cd /d "%OUT%"
del /q "%OUT%\bullet.anm"
del /q "%OUT%\_work_bullet_anm\bullet.anm"
mkdir "%OUT%\bullet.anm"
xcopy /e /y /q "%OUT%\_work_bullet_anm\*" "%OUT%\bullet.anm\" >nul
rmdir /s /q "%OUT%\_work_bullet_anm"
if exist "%OUT%\_work_default_ecl" rmdir /s /q "%OUT%\_work_default_ecl"
mkdir "%OUT%\_work_default_ecl"
copy /y "%OUT%\default.ecl" "%OUT%\_work_default_ecl\default.ecl" >nul
cd /d "%OUT%\_work_default_ecl"
thecl.exe -d 18 default.ecl default.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\default.ecl"
del /q "%OUT%\_work_default_ecl\default.ecl"
mkdir "%OUT%\default.ecl"
xcopy /e /y /q "%OUT%\_work_default_ecl\*" "%OUT%\default.ecl\" >nul
rmdir /s /q "%OUT%\_work_default_ecl"
if exist "%OUT%\_work_e01_anm" rmdir /s /q "%OUT%\_work_e01_anm"
mkdir "%OUT%\_work_e01_anm"
copy /y "%OUT%\e01.anm" "%OUT%\_work_e01_anm\e01.anm" >nul
cd /d "%OUT%\_work_e01_anm"
thanm.exe -x 18 e01.anm
cd /d "%OUT%"
del /q "%OUT%\e01.anm"
del /q "%OUT%\_work_e01_anm\e01.anm"
mkdir "%OUT%\e01.anm"
xcopy /e /y /q "%OUT%\_work_e01_anm\*" "%OUT%\e01.anm\" >nul
rmdir /s /q "%OUT%\_work_e01_anm"
if exist "%OUT%\_work_e01_msg" rmdir /s /q "%OUT%\_work_e01_msg"
mkdir "%OUT%\_work_e01_msg"
copy /y "%OUT%\e01.msg" "%OUT%\_work_e01_msg\e01.msg" >nul
cd /d "%OUT%\_work_e01_msg"
thmsg.exe -d 18 e01.msg e01.txt
cd /d "%OUT%"
del /q "%OUT%\e01.msg"
del /q "%OUT%\_work_e01_msg\e01.msg"
mkdir "%OUT%\e01.msg"
xcopy /e /y /q "%OUT%\_work_e01_msg\*" "%OUT%\e01.msg\" >nul
rmdir /s /q "%OUT%\_work_e01_msg"
if exist "%OUT%\_work_e02_anm" rmdir /s /q "%OUT%\_work_e02_anm"
mkdir "%OUT%\_work_e02_anm"
copy /y "%OUT%\e02.anm" "%OUT%\_work_e02_anm\e02.anm" >nul
cd /d "%OUT%\_work_e02_anm"
thanm.exe -x 18 e02.anm
cd /d "%OUT%"
del /q "%OUT%\e02.anm"
del /q "%OUT%\_work_e02_anm\e02.anm"
mkdir "%OUT%\e02.anm"
xcopy /e /y /q "%OUT%\_work_e02_anm\*" "%OUT%\e02.anm\" >nul
rmdir /s /q "%OUT%\_work_e02_anm"
if exist "%OUT%\_work_e02_msg" rmdir /s /q "%OUT%\_work_e02_msg"
mkdir "%OUT%\_work_e02_msg"
copy /y "%OUT%\e02.msg" "%OUT%\_work_e02_msg\e02.msg" >nul
cd /d "%OUT%\_work_e02_msg"
thmsg.exe -d 18 e02.msg e02.txt
cd /d "%OUT%"
del /q "%OUT%\e02.msg"
del /q "%OUT%\_work_e02_msg\e02.msg"
mkdir "%OUT%\e02.msg"
xcopy /e /y /q "%OUT%\_work_e02_msg\*" "%OUT%\e02.msg\" >nul
rmdir /s /q "%OUT%\_work_e02_msg"
if exist "%OUT%\_work_e03_anm" rmdir /s /q "%OUT%\_work_e03_anm"
mkdir "%OUT%\_work_e03_anm"
copy /y "%OUT%\e03.anm" "%OUT%\_work_e03_anm\e03.anm" >nul
cd /d "%OUT%\_work_e03_anm"
thanm.exe -x 18 e03.anm
cd /d "%OUT%"
del /q "%OUT%\e03.anm"
del /q "%OUT%\_work_e03_anm\e03.anm"
mkdir "%OUT%\e03.anm"
xcopy /e /y /q "%OUT%\_work_e03_anm\*" "%OUT%\e03.anm\" >nul
rmdir /s /q "%OUT%\_work_e03_anm"
if exist "%OUT%\_work_e03_msg" rmdir /s /q "%OUT%\_work_e03_msg"
mkdir "%OUT%\_work_e03_msg"
copy /y "%OUT%\e03.msg" "%OUT%\_work_e03_msg\e03.msg" >nul
cd /d "%OUT%\_work_e03_msg"
thmsg.exe -d 18 e03.msg e03.txt
cd /d "%OUT%"
del /q "%OUT%\e03.msg"
del /q "%OUT%\_work_e03_msg\e03.msg"
mkdir "%OUT%\e03.msg"
xcopy /e /y /q "%OUT%\_work_e03_msg\*" "%OUT%\e03.msg\" >nul
rmdir /s /q "%OUT%\_work_e03_msg"
if exist "%OUT%\_work_e04_anm" rmdir /s /q "%OUT%\_work_e04_anm"
mkdir "%OUT%\_work_e04_anm"
copy /y "%OUT%\e04.anm" "%OUT%\_work_e04_anm\e04.anm" >nul
cd /d "%OUT%\_work_e04_anm"
thanm.exe -x 18 e04.anm
cd /d "%OUT%"
del /q "%OUT%\e04.anm"
del /q "%OUT%\_work_e04_anm\e04.anm"
mkdir "%OUT%\e04.anm"
xcopy /e /y /q "%OUT%\_work_e04_anm\*" "%OUT%\e04.anm\" >nul
rmdir /s /q "%OUT%\_work_e04_anm"
if exist "%OUT%\_work_e04_msg" rmdir /s /q "%OUT%\_work_e04_msg"
mkdir "%OUT%\_work_e04_msg"
copy /y "%OUT%\e04.msg" "%OUT%\_work_e04_msg\e04.msg" >nul
cd /d "%OUT%\_work_e04_msg"
thmsg.exe -d 18 e04.msg e04.txt
cd /d "%OUT%"
del /q "%OUT%\e04.msg"
del /q "%OUT%\_work_e04_msg\e04.msg"
mkdir "%OUT%\e04.msg"
xcopy /e /y /q "%OUT%\_work_e04_msg\*" "%OUT%\e04.msg\" >nul
rmdir /s /q "%OUT%\_work_e04_msg"
if exist "%OUT%\_work_e05_anm" rmdir /s /q "%OUT%\_work_e05_anm"
mkdir "%OUT%\_work_e05_anm"
copy /y "%OUT%\e05.anm" "%OUT%\_work_e05_anm\e05.anm" >nul
cd /d "%OUT%\_work_e05_anm"
thanm.exe -x 18 e05.anm
cd /d "%OUT%"
del /q "%OUT%\e05.anm"
del /q "%OUT%\_work_e05_anm\e05.anm"
mkdir "%OUT%\e05.anm"
xcopy /e /y /q "%OUT%\_work_e05_anm\*" "%OUT%\e05.anm\" >nul
rmdir /s /q "%OUT%\_work_e05_anm"
if exist "%OUT%\_work_e05_msg" rmdir /s /q "%OUT%\_work_e05_msg"
mkdir "%OUT%\_work_e05_msg"
copy /y "%OUT%\e05.msg" "%OUT%\_work_e05_msg\e05.msg" >nul
cd /d "%OUT%\_work_e05_msg"
thmsg.exe -d 18 e05.msg e05.txt
cd /d "%OUT%"
del /q "%OUT%\e05.msg"
del /q "%OUT%\_work_e05_msg\e05.msg"
mkdir "%OUT%\e05.msg"
xcopy /e /y /q "%OUT%\_work_e05_msg\*" "%OUT%\e05.msg\" >nul
rmdir /s /q "%OUT%\_work_e05_msg"
if exist "%OUT%\_work_e06_anm" rmdir /s /q "%OUT%\_work_e06_anm"
mkdir "%OUT%\_work_e06_anm"
copy /y "%OUT%\e06.anm" "%OUT%\_work_e06_anm\e06.anm" >nul
cd /d "%OUT%\_work_e06_anm"
thanm.exe -x 18 e06.anm
cd /d "%OUT%"
del /q "%OUT%\e06.anm"
del /q "%OUT%\_work_e06_anm\e06.anm"
mkdir "%OUT%\e06.anm"
xcopy /e /y /q "%OUT%\_work_e06_anm\*" "%OUT%\e06.anm\" >nul
rmdir /s /q "%OUT%\_work_e06_anm"
if exist "%OUT%\_work_e06_msg" rmdir /s /q "%OUT%\_work_e06_msg"
mkdir "%OUT%\_work_e06_msg"
copy /y "%OUT%\e06.msg" "%OUT%\_work_e06_msg\e06.msg" >nul
cd /d "%OUT%\_work_e06_msg"
thmsg.exe -d 18 e06.msg e06.txt
cd /d "%OUT%"
del /q "%OUT%\e06.msg"
del /q "%OUT%\_work_e06_msg\e06.msg"
mkdir "%OUT%\e06.msg"
xcopy /e /y /q "%OUT%\_work_e06_msg\*" "%OUT%\e06.msg\" >nul
rmdir /s /q "%OUT%\_work_e06_msg"
if exist "%OUT%\_work_e07_anm" rmdir /s /q "%OUT%\_work_e07_anm"
mkdir "%OUT%\_work_e07_anm"
copy /y "%OUT%\e07.anm" "%OUT%\_work_e07_anm\e07.anm" >nul
cd /d "%OUT%\_work_e07_anm"
thanm.exe -x 18 e07.anm
cd /d "%OUT%"
del /q "%OUT%\e07.anm"
del /q "%OUT%\_work_e07_anm\e07.anm"
mkdir "%OUT%\e07.anm"
xcopy /e /y /q "%OUT%\_work_e07_anm\*" "%OUT%\e07.anm\" >nul
rmdir /s /q "%OUT%\_work_e07_anm"
if exist "%OUT%\_work_e07_msg" rmdir /s /q "%OUT%\_work_e07_msg"
mkdir "%OUT%\_work_e07_msg"
copy /y "%OUT%\e07.msg" "%OUT%\_work_e07_msg\e07.msg" >nul
cd /d "%OUT%\_work_e07_msg"
thmsg.exe -d 18 e07.msg e07.txt
cd /d "%OUT%"
del /q "%OUT%\e07.msg"
del /q "%OUT%\_work_e07_msg\e07.msg"
mkdir "%OUT%\e07.msg"
xcopy /e /y /q "%OUT%\_work_e07_msg\*" "%OUT%\e07.msg\" >nul
rmdir /s /q "%OUT%\_work_e07_msg"
if exist "%OUT%\_work_e08_anm" rmdir /s /q "%OUT%\_work_e08_anm"
mkdir "%OUT%\_work_e08_anm"
copy /y "%OUT%\e08.anm" "%OUT%\_work_e08_anm\e08.anm" >nul
cd /d "%OUT%\_work_e08_anm"
thanm.exe -x 18 e08.anm
cd /d "%OUT%"
del /q "%OUT%\e08.anm"
del /q "%OUT%\_work_e08_anm\e08.anm"
mkdir "%OUT%\e08.anm"
xcopy /e /y /q "%OUT%\_work_e08_anm\*" "%OUT%\e08.anm\" >nul
rmdir /s /q "%OUT%\_work_e08_anm"
if exist "%OUT%\_work_e08_msg" rmdir /s /q "%OUT%\_work_e08_msg"
mkdir "%OUT%\_work_e08_msg"
copy /y "%OUT%\e08.msg" "%OUT%\_work_e08_msg\e08.msg" >nul
cd /d "%OUT%\_work_e08_msg"
thmsg.exe -d 18 e08.msg e08.txt
cd /d "%OUT%"
del /q "%OUT%\e08.msg"
del /q "%OUT%\_work_e08_msg\e08.msg"
mkdir "%OUT%\e08.msg"
xcopy /e /y /q "%OUT%\_work_e08_msg\*" "%OUT%\e08.msg\" >nul
rmdir /s /q "%OUT%\_work_e08_msg"
if exist "%OUT%\_work_e09_anm" rmdir /s /q "%OUT%\_work_e09_anm"
mkdir "%OUT%\_work_e09_anm"
copy /y "%OUT%\e09.anm" "%OUT%\_work_e09_anm\e09.anm" >nul
cd /d "%OUT%\_work_e09_anm"
thanm.exe -x 18 e09.anm
cd /d "%OUT%"
del /q "%OUT%\e09.anm"
del /q "%OUT%\_work_e09_anm\e09.anm"
mkdir "%OUT%\e09.anm"
xcopy /e /y /q "%OUT%\_work_e09_anm\*" "%OUT%\e09.anm\" >nul
rmdir /s /q "%OUT%\_work_e09_anm"
if exist "%OUT%\_work_e09_msg" rmdir /s /q "%OUT%\_work_e09_msg"
mkdir "%OUT%\_work_e09_msg"
copy /y "%OUT%\e09.msg" "%OUT%\_work_e09_msg\e09.msg" >nul
cd /d "%OUT%\_work_e09_msg"
thmsg.exe -d 18 e09.msg e09.txt
cd /d "%OUT%"
del /q "%OUT%\e09.msg"
del /q "%OUT%\_work_e09_msg\e09.msg"
mkdir "%OUT%\e09.msg"
xcopy /e /y /q "%OUT%\_work_e09_msg\*" "%OUT%\e09.msg\" >nul
rmdir /s /q "%OUT%\_work_e09_msg"
if exist "%OUT%\_work_e10_anm" rmdir /s /q "%OUT%\_work_e10_anm"
mkdir "%OUT%\_work_e10_anm"
copy /y "%OUT%\e10.anm" "%OUT%\_work_e10_anm\e10.anm" >nul
cd /d "%OUT%\_work_e10_anm"
thanm.exe -x 18 e10.anm
cd /d "%OUT%"
del /q "%OUT%\e10.anm"
del /q "%OUT%\_work_e10_anm\e10.anm"
mkdir "%OUT%\e10.anm"
xcopy /e /y /q "%OUT%\_work_e10_anm\*" "%OUT%\e10.anm\" >nul
rmdir /s /q "%OUT%\_work_e10_anm"
if exist "%OUT%\_work_e10_msg" rmdir /s /q "%OUT%\_work_e10_msg"
mkdir "%OUT%\_work_e10_msg"
copy /y "%OUT%\e10.msg" "%OUT%\_work_e10_msg\e10.msg" >nul
cd /d "%OUT%\_work_e10_msg"
thmsg.exe -d 18 e10.msg e10.txt
cd /d "%OUT%"
del /q "%OUT%\e10.msg"
del /q "%OUT%\_work_e10_msg\e10.msg"
mkdir "%OUT%\e10.msg"
xcopy /e /y /q "%OUT%\_work_e10_msg\*" "%OUT%\e10.msg\" >nul
rmdir /s /q "%OUT%\_work_e10_msg"
if exist "%OUT%\_work_e11_anm" rmdir /s /q "%OUT%\_work_e11_anm"
mkdir "%OUT%\_work_e11_anm"
copy /y "%OUT%\e11.anm" "%OUT%\_work_e11_anm\e11.anm" >nul
cd /d "%OUT%\_work_e11_anm"
thanm.exe -x 18 e11.anm
cd /d "%OUT%"
del /q "%OUT%\e11.anm"
del /q "%OUT%\_work_e11_anm\e11.anm"
mkdir "%OUT%\e11.anm"
xcopy /e /y /q "%OUT%\_work_e11_anm\*" "%OUT%\e11.anm\" >nul
rmdir /s /q "%OUT%\_work_e11_anm"
if exist "%OUT%\_work_e11_msg" rmdir /s /q "%OUT%\_work_e11_msg"
mkdir "%OUT%\_work_e11_msg"
copy /y "%OUT%\e11.msg" "%OUT%\_work_e11_msg\e11.msg" >nul
cd /d "%OUT%\_work_e11_msg"
thmsg.exe -d 18 e11.msg e11.txt
cd /d "%OUT%"
del /q "%OUT%\e11.msg"
del /q "%OUT%\_work_e11_msg\e11.msg"
mkdir "%OUT%\e11.msg"
xcopy /e /y /q "%OUT%\_work_e11_msg\*" "%OUT%\e11.msg\" >nul
rmdir /s /q "%OUT%\_work_e11_msg"
if exist "%OUT%\_work_e12_anm" rmdir /s /q "%OUT%\_work_e12_anm"
mkdir "%OUT%\_work_e12_anm"
copy /y "%OUT%\e12.anm" "%OUT%\_work_e12_anm\e12.anm" >nul
cd /d "%OUT%\_work_e12_anm"
thanm.exe -x 18 e12.anm
cd /d "%OUT%"
del /q "%OUT%\e12.anm"
del /q "%OUT%\_work_e12_anm\e12.anm"
mkdir "%OUT%\e12.anm"
xcopy /e /y /q "%OUT%\_work_e12_anm\*" "%OUT%\e12.anm\" >nul
rmdir /s /q "%OUT%\_work_e12_anm"
if exist "%OUT%\_work_e12_msg" rmdir /s /q "%OUT%\_work_e12_msg"
mkdir "%OUT%\_work_e12_msg"
copy /y "%OUT%\e12.msg" "%OUT%\_work_e12_msg\e12.msg" >nul
cd /d "%OUT%\_work_e12_msg"
thmsg.exe -d 18 e12.msg e12.txt
cd /d "%OUT%"
del /q "%OUT%\e12.msg"
del /q "%OUT%\_work_e12_msg\e12.msg"
mkdir "%OUT%\e12.msg"
xcopy /e /y /q "%OUT%\_work_e12_msg\*" "%OUT%\e12.msg\" >nul
rmdir /s /q "%OUT%\_work_e12_msg"
if exist "%OUT%\_work_effect_anm" rmdir /s /q "%OUT%\_work_effect_anm"
mkdir "%OUT%\_work_effect_anm"
copy /y "%OUT%\effect.anm" "%OUT%\_work_effect_anm\effect.anm" >nul
cd /d "%OUT%\_work_effect_anm"
thanm.exe -x 18 effect.anm
cd /d "%OUT%"
del /q "%OUT%\effect.anm"
del /q "%OUT%\_work_effect_anm\effect.anm"
mkdir "%OUT%\effect.anm"
xcopy /e /y /q "%OUT%\_work_effect_anm\*" "%OUT%\effect.anm\" >nul
rmdir /s /q "%OUT%\_work_effect_anm"
if exist "%OUT%\_work_enemy_anm" rmdir /s /q "%OUT%\_work_enemy_anm"
mkdir "%OUT%\_work_enemy_anm"
copy /y "%OUT%\enemy.anm" "%OUT%\_work_enemy_anm\enemy.anm" >nul
cd /d "%OUT%\_work_enemy_anm"
thanm.exe -x 18 enemy.anm
cd /d "%OUT%"
del /q "%OUT%\enemy.anm"
del /q "%OUT%\_work_enemy_anm\enemy.anm"
mkdir "%OUT%\enemy.anm"
xcopy /e /y /q "%OUT%\_work_enemy_anm\*" "%OUT%\enemy.anm\" >nul
rmdir /s /q "%OUT%\_work_enemy_anm"
if exist "%OUT%\_work_front_anm" rmdir /s /q "%OUT%\_work_front_anm"
mkdir "%OUT%\_work_front_anm"
copy /y "%OUT%\front.anm" "%OUT%\_work_front_anm\front.anm" >nul
cd /d "%OUT%\_work_front_anm"
thanm.exe -x 18 front.anm
cd /d "%OUT%"
del /q "%OUT%\front.anm"
del /q "%OUT%\_work_front_anm\front.anm"
mkdir "%OUT%\front.anm"
xcopy /e /y /q "%OUT%\_work_front_anm\*" "%OUT%\front.anm\" >nul
rmdir /s /q "%OUT%\_work_front_anm"
if exist "%OUT%\_work_help_anm" rmdir /s /q "%OUT%\_work_help_anm"
mkdir "%OUT%\_work_help_anm"
copy /y "%OUT%\help.anm" "%OUT%\_work_help_anm\help.anm" >nul
cd /d "%OUT%\_work_help_anm"
thanm.exe -x 18 help.anm
cd /d "%OUT%"
del /q "%OUT%\help.anm"
del /q "%OUT%\_work_help_anm\help.anm"
mkdir "%OUT%\help.anm"
xcopy /e /y /q "%OUT%\_work_help_anm\*" "%OUT%\help.anm\" >nul
rmdir /s /q "%OUT%\_work_help_anm"
if exist "%OUT%\_work_notice_anm" rmdir /s /q "%OUT%\_work_notice_anm"
mkdir "%OUT%\_work_notice_anm"
copy /y "%OUT%\notice.anm" "%OUT%\_work_notice_anm\notice.anm" >nul
cd /d "%OUT%\_work_notice_anm"
thanm.exe -x 18 notice.anm
cd /d "%OUT%"
del /q "%OUT%\notice.anm"
del /q "%OUT%\_work_notice_anm\notice.anm"
mkdir "%OUT%\notice.anm"
xcopy /e /y /q "%OUT%\_work_notice_anm\*" "%OUT%\notice.anm\" >nul
rmdir /s /q "%OUT%\_work_notice_anm"
if exist "%OUT%\_work_pl00_anm" rmdir /s /q "%OUT%\_work_pl00_anm"
mkdir "%OUT%\_work_pl00_anm"
copy /y "%OUT%\pl00.anm" "%OUT%\_work_pl00_anm\pl00.anm" >nul
cd /d "%OUT%\_work_pl00_anm"
thanm.exe -x 18 pl00.anm
cd /d "%OUT%"
del /q "%OUT%\pl00.anm"
del /q "%OUT%\_work_pl00_anm\pl00.anm"
mkdir "%OUT%\pl00.anm"
xcopy /e /y /q "%OUT%\_work_pl00_anm\*" "%OUT%\pl00.anm\" >nul
rmdir /s /q "%OUT%\_work_pl00_anm"
if exist "%OUT%\_work_pl01_anm" rmdir /s /q "%OUT%\_work_pl01_anm"
mkdir "%OUT%\_work_pl01_anm"
copy /y "%OUT%\pl01.anm" "%OUT%\_work_pl01_anm\pl01.anm" >nul
cd /d "%OUT%\_work_pl01_anm"
thanm.exe -x 18 pl01.anm
cd /d "%OUT%"
del /q "%OUT%\pl01.anm"
del /q "%OUT%\_work_pl01_anm\pl01.anm"
mkdir "%OUT%\pl01.anm"
xcopy /e /y /q "%OUT%\_work_pl01_anm\*" "%OUT%\pl01.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01_anm"
if exist "%OUT%\_work_pl02_anm" rmdir /s /q "%OUT%\_work_pl02_anm"
mkdir "%OUT%\_work_pl02_anm"
copy /y "%OUT%\pl02.anm" "%OUT%\_work_pl02_anm\pl02.anm" >nul
cd /d "%OUT%\_work_pl02_anm"
thanm.exe -x 18 pl02.anm
cd /d "%OUT%"
del /q "%OUT%\pl02.anm"
del /q "%OUT%\_work_pl02_anm\pl02.anm"
mkdir "%OUT%\pl02.anm"
xcopy /e /y /q "%OUT%\_work_pl02_anm\*" "%OUT%\pl02.anm\" >nul
rmdir /s /q "%OUT%\_work_pl02_anm"
if exist "%OUT%\_work_pl03_anm" rmdir /s /q "%OUT%\_work_pl03_anm"
mkdir "%OUT%\_work_pl03_anm"
copy /y "%OUT%\pl03.anm" "%OUT%\_work_pl03_anm\pl03.anm" >nul
cd /d "%OUT%\_work_pl03_anm"
thanm.exe -x 18 pl03.anm
cd /d "%OUT%"
del /q "%OUT%\pl03.anm"
del /q "%OUT%\_work_pl03_anm\pl03.anm"
mkdir "%OUT%\pl03.anm"
xcopy /e /y /q "%OUT%\_work_pl03_anm\*" "%OUT%\pl03.anm\" >nul
rmdir /s /q "%OUT%\_work_pl03_anm"
if exist "%OUT%\_work_sig_anm" rmdir /s /q "%OUT%\_work_sig_anm"
mkdir "%OUT%\_work_sig_anm"
copy /y "%OUT%\sig.anm" "%OUT%\_work_sig_anm\sig.anm" >nul
cd /d "%OUT%\_work_sig_anm"
thanm.exe -x 18 sig.anm
cd /d "%OUT%"
del /q "%OUT%\sig.anm"
del /q "%OUT%\_work_sig_anm\sig.anm"
mkdir "%OUT%\sig.anm"
xcopy /e /y /q "%OUT%\_work_sig_anm\*" "%OUT%\sig.anm\" >nul
rmdir /s /q "%OUT%\_work_sig_anm"
if exist "%OUT%\_work_st01_ecl" rmdir /s /q "%OUT%\_work_st01_ecl"
mkdir "%OUT%\_work_st01_ecl"
copy /y "%OUT%\st01.ecl" "%OUT%\_work_st01_ecl\st01.ecl" >nul
cd /d "%OUT%\_work_st01_ecl"
thecl.exe -d 18 st01.ecl st01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st01.ecl"
del /q "%OUT%\_work_st01_ecl\st01.ecl"
mkdir "%OUT%\st01.ecl"
xcopy /e /y /q "%OUT%\_work_st01_ecl\*" "%OUT%\st01.ecl\" >nul
rmdir /s /q "%OUT%\_work_st01_ecl"
if exist "%OUT%\_work_st01_std" rmdir /s /q "%OUT%\_work_st01_std"
mkdir "%OUT%\_work_st01_std"
copy /y "%OUT%\st01.std" "%OUT%\_work_st01_std\st01.std" >nul
cd /d "%OUT%\_work_st01_std"
thstd.exe -d 18 st01.std st01.std.txt
cd /d "%OUT%"
del /q "%OUT%\st01.std"
del /q "%OUT%\_work_st01_std\st01.std"
mkdir "%OUT%\st01.std"
xcopy /e /y /q "%OUT%\_work_st01_std\*" "%OUT%\st01.std\" >nul
rmdir /s /q "%OUT%\_work_st01_std"
if exist "%OUT%\_work_st01a_msg" rmdir /s /q "%OUT%\_work_st01a_msg"
mkdir "%OUT%\_work_st01a_msg"
copy /y "%OUT%\st01a.msg" "%OUT%\_work_st01a_msg\st01a.msg" >nul
cd /d "%OUT%\_work_st01a_msg"
thmsg.exe -d 18 st01a.msg st01a.txt
cd /d "%OUT%"
del /q "%OUT%\st01a.msg"
del /q "%OUT%\_work_st01a_msg\st01a.msg"
mkdir "%OUT%\st01a.msg"
xcopy /e /y /q "%OUT%\_work_st01a_msg\*" "%OUT%\st01a.msg\" >nul
rmdir /s /q "%OUT%\_work_st01a_msg"
if exist "%OUT%\_work_st01b_msg" rmdir /s /q "%OUT%\_work_st01b_msg"
mkdir "%OUT%\_work_st01b_msg"
copy /y "%OUT%\st01b.msg" "%OUT%\_work_st01b_msg\st01b.msg" >nul
cd /d "%OUT%\_work_st01b_msg"
thmsg.exe -d 18 st01b.msg st01b.txt
cd /d "%OUT%"
del /q "%OUT%\st01b.msg"
del /q "%OUT%\_work_st01b_msg\st01b.msg"
mkdir "%OUT%\st01b.msg"
xcopy /e /y /q "%OUT%\_work_st01b_msg\*" "%OUT%\st01b.msg\" >nul
rmdir /s /q "%OUT%\_work_st01b_msg"
if exist "%OUT%\_work_st01bs_ecl" rmdir /s /q "%OUT%\_work_st01bs_ecl"
mkdir "%OUT%\_work_st01bs_ecl"
copy /y "%OUT%\st01bs.ecl" "%OUT%\_work_st01bs_ecl\st01bs.ecl" >nul
cd /d "%OUT%\_work_st01bs_ecl"
thecl.exe -d 18 st01bs.ecl st01bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st01bs.ecl"
del /q "%OUT%\_work_st01bs_ecl\st01bs.ecl"
mkdir "%OUT%\st01bs.ecl"
xcopy /e /y /q "%OUT%\_work_st01bs_ecl\*" "%OUT%\st01bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st01bs_ecl"
if exist "%OUT%\_work_st01c_msg" rmdir /s /q "%OUT%\_work_st01c_msg"
mkdir "%OUT%\_work_st01c_msg"
copy /y "%OUT%\st01c.msg" "%OUT%\_work_st01c_msg\st01c.msg" >nul
cd /d "%OUT%\_work_st01c_msg"
thmsg.exe -d 18 st01c.msg st01c.txt
cd /d "%OUT%"
del /q "%OUT%\st01c.msg"
del /q "%OUT%\_work_st01c_msg\st01c.msg"
mkdir "%OUT%\st01c.msg"
xcopy /e /y /q "%OUT%\_work_st01c_msg\*" "%OUT%\st01c.msg\" >nul
rmdir /s /q "%OUT%\_work_st01c_msg"
if exist "%OUT%\_work_st01d_msg" rmdir /s /q "%OUT%\_work_st01d_msg"
mkdir "%OUT%\_work_st01d_msg"
copy /y "%OUT%\st01d.msg" "%OUT%\_work_st01d_msg\st01d.msg" >nul
cd /d "%OUT%\_work_st01d_msg"
thmsg.exe -d 18 st01d.msg st01d.txt
cd /d "%OUT%"
del /q "%OUT%\st01d.msg"
del /q "%OUT%\_work_st01d_msg\st01d.msg"
mkdir "%OUT%\st01d.msg"
xcopy /e /y /q "%OUT%\_work_st01d_msg\*" "%OUT%\st01d.msg\" >nul
rmdir /s /q "%OUT%\_work_st01d_msg"
if exist "%OUT%\_work_st01enm_anm" rmdir /s /q "%OUT%\_work_st01enm_anm"
mkdir "%OUT%\_work_st01enm_anm"
copy /y "%OUT%\st01enm.anm" "%OUT%\_work_st01enm_anm\st01enm.anm" >nul
cd /d "%OUT%\_work_st01enm_anm"
thanm.exe -x 18 st01enm.anm
cd /d "%OUT%"
del /q "%OUT%\st01enm.anm"
del /q "%OUT%\_work_st01enm_anm\st01enm.anm"
mkdir "%OUT%\st01enm.anm"
xcopy /e /y /q "%OUT%\_work_st01enm_anm\*" "%OUT%\st01enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st01enm_anm"
if exist "%OUT%\_work_st01logo_anm" rmdir /s /q "%OUT%\_work_st01logo_anm"
mkdir "%OUT%\_work_st01logo_anm"
copy /y "%OUT%\st01logo.anm" "%OUT%\_work_st01logo_anm\st01logo.anm" >nul
cd /d "%OUT%\_work_st01logo_anm"
thanm.exe -x 18 st01logo.anm
cd /d "%OUT%"
del /q "%OUT%\st01logo.anm"
del /q "%OUT%\_work_st01logo_anm\st01logo.anm"
mkdir "%OUT%\st01logo.anm"
xcopy /e /y /q "%OUT%\_work_st01logo_anm\*" "%OUT%\st01logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st01logo_anm"
if exist "%OUT%\_work_st01mbs_ecl" rmdir /s /q "%OUT%\_work_st01mbs_ecl"
mkdir "%OUT%\_work_st01mbs_ecl"
copy /y "%OUT%\st01mbs.ecl" "%OUT%\_work_st01mbs_ecl\st01mbs.ecl" >nul
cd /d "%OUT%\_work_st01mbs_ecl"
thecl.exe -d 18 st01mbs.ecl st01mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st01mbs.ecl"
del /q "%OUT%\_work_st01mbs_ecl\st01mbs.ecl"
mkdir "%OUT%\st01mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st01mbs_ecl\*" "%OUT%\st01mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st01mbs_ecl"
if exist "%OUT%\_work_st01wl_anm" rmdir /s /q "%OUT%\_work_st01wl_anm"
mkdir "%OUT%\_work_st01wl_anm"
copy /y "%OUT%\st01wl.anm" "%OUT%\_work_st01wl_anm\st01wl.anm" >nul
cd /d "%OUT%\_work_st01wl_anm"
thanm.exe -x 18 st01wl.anm
cd /d "%OUT%"
del /q "%OUT%\st01wl.anm"
del /q "%OUT%\_work_st01wl_anm\st01wl.anm"
mkdir "%OUT%\st01wl.anm"
xcopy /e /y /q "%OUT%\_work_st01wl_anm\*" "%OUT%\st01wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st01wl_anm"
if exist "%OUT%\_work_st02_ecl" rmdir /s /q "%OUT%\_work_st02_ecl"
mkdir "%OUT%\_work_st02_ecl"
copy /y "%OUT%\st02.ecl" "%OUT%\_work_st02_ecl\st02.ecl" >nul
cd /d "%OUT%\_work_st02_ecl"
thecl.exe -d 18 st02.ecl st02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st02.ecl"
del /q "%OUT%\_work_st02_ecl\st02.ecl"
mkdir "%OUT%\st02.ecl"
xcopy /e /y /q "%OUT%\_work_st02_ecl\*" "%OUT%\st02.ecl\" >nul
rmdir /s /q "%OUT%\_work_st02_ecl"
if exist "%OUT%\_work_st02_std" rmdir /s /q "%OUT%\_work_st02_std"
mkdir "%OUT%\_work_st02_std"
copy /y "%OUT%\st02.std" "%OUT%\_work_st02_std\st02.std" >nul
cd /d "%OUT%\_work_st02_std"
thstd.exe -d 18 st02.std st02.std.txt
cd /d "%OUT%"
del /q "%OUT%\st02.std"
del /q "%OUT%\_work_st02_std\st02.std"
mkdir "%OUT%\st02.std"
xcopy /e /y /q "%OUT%\_work_st02_std\*" "%OUT%\st02.std\" >nul
rmdir /s /q "%OUT%\_work_st02_std"
if exist "%OUT%\_work_st02a_msg" rmdir /s /q "%OUT%\_work_st02a_msg"
mkdir "%OUT%\_work_st02a_msg"
copy /y "%OUT%\st02a.msg" "%OUT%\_work_st02a_msg\st02a.msg" >nul
cd /d "%OUT%\_work_st02a_msg"
thmsg.exe -d 18 st02a.msg st02a.txt
cd /d "%OUT%"
del /q "%OUT%\st02a.msg"
del /q "%OUT%\_work_st02a_msg\st02a.msg"
mkdir "%OUT%\st02a.msg"
xcopy /e /y /q "%OUT%\_work_st02a_msg\*" "%OUT%\st02a.msg\" >nul
rmdir /s /q "%OUT%\_work_st02a_msg"
if exist "%OUT%\_work_st02b_msg" rmdir /s /q "%OUT%\_work_st02b_msg"
mkdir "%OUT%\_work_st02b_msg"
copy /y "%OUT%\st02b.msg" "%OUT%\_work_st02b_msg\st02b.msg" >nul
cd /d "%OUT%\_work_st02b_msg"
thmsg.exe -d 18 st02b.msg st02b.txt
cd /d "%OUT%"
del /q "%OUT%\st02b.msg"
del /q "%OUT%\_work_st02b_msg\st02b.msg"
mkdir "%OUT%\st02b.msg"
xcopy /e /y /q "%OUT%\_work_st02b_msg\*" "%OUT%\st02b.msg\" >nul
rmdir /s /q "%OUT%\_work_st02b_msg"
if exist "%OUT%\_work_st02bs_ecl" rmdir /s /q "%OUT%\_work_st02bs_ecl"
mkdir "%OUT%\_work_st02bs_ecl"
copy /y "%OUT%\st02bs.ecl" "%OUT%\_work_st02bs_ecl\st02bs.ecl" >nul
cd /d "%OUT%\_work_st02bs_ecl"
thecl.exe -d 18 st02bs.ecl st02bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st02bs.ecl"
del /q "%OUT%\_work_st02bs_ecl\st02bs.ecl"
mkdir "%OUT%\st02bs.ecl"
xcopy /e /y /q "%OUT%\_work_st02bs_ecl\*" "%OUT%\st02bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st02bs_ecl"
if exist "%OUT%\_work_st02c_msg" rmdir /s /q "%OUT%\_work_st02c_msg"
mkdir "%OUT%\_work_st02c_msg"
copy /y "%OUT%\st02c.msg" "%OUT%\_work_st02c_msg\st02c.msg" >nul
cd /d "%OUT%\_work_st02c_msg"
thmsg.exe -d 18 st02c.msg st02c.txt
cd /d "%OUT%"
del /q "%OUT%\st02c.msg"
del /q "%OUT%\_work_st02c_msg\st02c.msg"
mkdir "%OUT%\st02c.msg"
xcopy /e /y /q "%OUT%\_work_st02c_msg\*" "%OUT%\st02c.msg\" >nul
rmdir /s /q "%OUT%\_work_st02c_msg"
if exist "%OUT%\_work_st02d_msg" rmdir /s /q "%OUT%\_work_st02d_msg"
mkdir "%OUT%\_work_st02d_msg"
copy /y "%OUT%\st02d.msg" "%OUT%\_work_st02d_msg\st02d.msg" >nul
cd /d "%OUT%\_work_st02d_msg"
thmsg.exe -d 18 st02d.msg st02d.txt
cd /d "%OUT%"
del /q "%OUT%\st02d.msg"
del /q "%OUT%\_work_st02d_msg\st02d.msg"
mkdir "%OUT%\st02d.msg"
xcopy /e /y /q "%OUT%\_work_st02d_msg\*" "%OUT%\st02d.msg\" >nul
rmdir /s /q "%OUT%\_work_st02d_msg"
if exist "%OUT%\_work_st02enm_anm" rmdir /s /q "%OUT%\_work_st02enm_anm"
mkdir "%OUT%\_work_st02enm_anm"
copy /y "%OUT%\st02enm.anm" "%OUT%\_work_st02enm_anm\st02enm.anm" >nul
cd /d "%OUT%\_work_st02enm_anm"
thanm.exe -x 18 st02enm.anm
cd /d "%OUT%"
del /q "%OUT%\st02enm.anm"
del /q "%OUT%\_work_st02enm_anm\st02enm.anm"
mkdir "%OUT%\st02enm.anm"
xcopy /e /y /q "%OUT%\_work_st02enm_anm\*" "%OUT%\st02enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st02enm_anm"
if exist "%OUT%\_work_st02logo_anm" rmdir /s /q "%OUT%\_work_st02logo_anm"
mkdir "%OUT%\_work_st02logo_anm"
copy /y "%OUT%\st02logo.anm" "%OUT%\_work_st02logo_anm\st02logo.anm" >nul
cd /d "%OUT%\_work_st02logo_anm"
thanm.exe -x 18 st02logo.anm
cd /d "%OUT%"
del /q "%OUT%\st02logo.anm"
del /q "%OUT%\_work_st02logo_anm\st02logo.anm"
mkdir "%OUT%\st02logo.anm"
xcopy /e /y /q "%OUT%\_work_st02logo_anm\*" "%OUT%\st02logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st02logo_anm"
if exist "%OUT%\_work_st02mbs_ecl" rmdir /s /q "%OUT%\_work_st02mbs_ecl"
mkdir "%OUT%\_work_st02mbs_ecl"
copy /y "%OUT%\st02mbs.ecl" "%OUT%\_work_st02mbs_ecl\st02mbs.ecl" >nul
cd /d "%OUT%\_work_st02mbs_ecl"
thecl.exe -d 18 st02mbs.ecl st02mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st02mbs.ecl"
del /q "%OUT%\_work_st02mbs_ecl\st02mbs.ecl"
mkdir "%OUT%\st02mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st02mbs_ecl\*" "%OUT%\st02mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st02mbs_ecl"
if exist "%OUT%\_work_st02wl_anm" rmdir /s /q "%OUT%\_work_st02wl_anm"
mkdir "%OUT%\_work_st02wl_anm"
copy /y "%OUT%\st02wl.anm" "%OUT%\_work_st02wl_anm\st02wl.anm" >nul
cd /d "%OUT%\_work_st02wl_anm"
thanm.exe -x 18 st02wl.anm
cd /d "%OUT%"
del /q "%OUT%\st02wl.anm"
del /q "%OUT%\_work_st02wl_anm\st02wl.anm"
mkdir "%OUT%\st02wl.anm"
xcopy /e /y /q "%OUT%\_work_st02wl_anm\*" "%OUT%\st02wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st02wl_anm"
if exist "%OUT%\_work_st03_ecl" rmdir /s /q "%OUT%\_work_st03_ecl"
mkdir "%OUT%\_work_st03_ecl"
copy /y "%OUT%\st03.ecl" "%OUT%\_work_st03_ecl\st03.ecl" >nul
cd /d "%OUT%\_work_st03_ecl"
thecl.exe -d 18 st03.ecl st03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st03.ecl"
del /q "%OUT%\_work_st03_ecl\st03.ecl"
mkdir "%OUT%\st03.ecl"
xcopy /e /y /q "%OUT%\_work_st03_ecl\*" "%OUT%\st03.ecl\" >nul
rmdir /s /q "%OUT%\_work_st03_ecl"
if exist "%OUT%\_work_st03_std" rmdir /s /q "%OUT%\_work_st03_std"
mkdir "%OUT%\_work_st03_std"
copy /y "%OUT%\st03.std" "%OUT%\_work_st03_std\st03.std" >nul
cd /d "%OUT%\_work_st03_std"
thstd.exe -d 18 st03.std st03.std.txt
cd /d "%OUT%"
del /q "%OUT%\st03.std"
del /q "%OUT%\_work_st03_std\st03.std"
mkdir "%OUT%\st03.std"
xcopy /e /y /q "%OUT%\_work_st03_std\*" "%OUT%\st03.std\" >nul
rmdir /s /q "%OUT%\_work_st03_std"
if exist "%OUT%\_work_st03a_msg" rmdir /s /q "%OUT%\_work_st03a_msg"
mkdir "%OUT%\_work_st03a_msg"
copy /y "%OUT%\st03a.msg" "%OUT%\_work_st03a_msg\st03a.msg" >nul
cd /d "%OUT%\_work_st03a_msg"
thmsg.exe -d 18 st03a.msg st03a.txt
cd /d "%OUT%"
del /q "%OUT%\st03a.msg"
del /q "%OUT%\_work_st03a_msg\st03a.msg"
mkdir "%OUT%\st03a.msg"
xcopy /e /y /q "%OUT%\_work_st03a_msg\*" "%OUT%\st03a.msg\" >nul
rmdir /s /q "%OUT%\_work_st03a_msg"
if exist "%OUT%\_work_st03b_msg" rmdir /s /q "%OUT%\_work_st03b_msg"
mkdir "%OUT%\_work_st03b_msg"
copy /y "%OUT%\st03b.msg" "%OUT%\_work_st03b_msg\st03b.msg" >nul
cd /d "%OUT%\_work_st03b_msg"
thmsg.exe -d 18 st03b.msg st03b.txt
cd /d "%OUT%"
del /q "%OUT%\st03b.msg"
del /q "%OUT%\_work_st03b_msg\st03b.msg"
mkdir "%OUT%\st03b.msg"
xcopy /e /y /q "%OUT%\_work_st03b_msg\*" "%OUT%\st03b.msg\" >nul
rmdir /s /q "%OUT%\_work_st03b_msg"
if exist "%OUT%\_work_st03bs_ecl" rmdir /s /q "%OUT%\_work_st03bs_ecl"
mkdir "%OUT%\_work_st03bs_ecl"
copy /y "%OUT%\st03bs.ecl" "%OUT%\_work_st03bs_ecl\st03bs.ecl" >nul
cd /d "%OUT%\_work_st03bs_ecl"
thecl.exe -d 18 st03bs.ecl st03bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st03bs.ecl"
del /q "%OUT%\_work_st03bs_ecl\st03bs.ecl"
mkdir "%OUT%\st03bs.ecl"
xcopy /e /y /q "%OUT%\_work_st03bs_ecl\*" "%OUT%\st03bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st03bs_ecl"
if exist "%OUT%\_work_st03c_msg" rmdir /s /q "%OUT%\_work_st03c_msg"
mkdir "%OUT%\_work_st03c_msg"
copy /y "%OUT%\st03c.msg" "%OUT%\_work_st03c_msg\st03c.msg" >nul
cd /d "%OUT%\_work_st03c_msg"
thmsg.exe -d 18 st03c.msg st03c.txt
cd /d "%OUT%"
del /q "%OUT%\st03c.msg"
del /q "%OUT%\_work_st03c_msg\st03c.msg"
mkdir "%OUT%\st03c.msg"
xcopy /e /y /q "%OUT%\_work_st03c_msg\*" "%OUT%\st03c.msg\" >nul
rmdir /s /q "%OUT%\_work_st03c_msg"
if exist "%OUT%\_work_st03d_msg" rmdir /s /q "%OUT%\_work_st03d_msg"
mkdir "%OUT%\_work_st03d_msg"
copy /y "%OUT%\st03d.msg" "%OUT%\_work_st03d_msg\st03d.msg" >nul
cd /d "%OUT%\_work_st03d_msg"
thmsg.exe -d 18 st03d.msg st03d.txt
cd /d "%OUT%"
del /q "%OUT%\st03d.msg"
del /q "%OUT%\_work_st03d_msg\st03d.msg"
mkdir "%OUT%\st03d.msg"
xcopy /e /y /q "%OUT%\_work_st03d_msg\*" "%OUT%\st03d.msg\" >nul
rmdir /s /q "%OUT%\_work_st03d_msg"
if exist "%OUT%\_work_st03enm_anm" rmdir /s /q "%OUT%\_work_st03enm_anm"
mkdir "%OUT%\_work_st03enm_anm"
copy /y "%OUT%\st03enm.anm" "%OUT%\_work_st03enm_anm\st03enm.anm" >nul
cd /d "%OUT%\_work_st03enm_anm"
thanm.exe -x 18 st03enm.anm
cd /d "%OUT%"
del /q "%OUT%\st03enm.anm"
del /q "%OUT%\_work_st03enm_anm\st03enm.anm"
mkdir "%OUT%\st03enm.anm"
xcopy /e /y /q "%OUT%\_work_st03enm_anm\*" "%OUT%\st03enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st03enm_anm"
if exist "%OUT%\_work_st03logo_anm" rmdir /s /q "%OUT%\_work_st03logo_anm"
mkdir "%OUT%\_work_st03logo_anm"
copy /y "%OUT%\st03logo.anm" "%OUT%\_work_st03logo_anm\st03logo.anm" >nul
cd /d "%OUT%\_work_st03logo_anm"
thanm.exe -x 18 st03logo.anm
cd /d "%OUT%"
del /q "%OUT%\st03logo.anm"
del /q "%OUT%\_work_st03logo_anm\st03logo.anm"
mkdir "%OUT%\st03logo.anm"
xcopy /e /y /q "%OUT%\_work_st03logo_anm\*" "%OUT%\st03logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st03logo_anm"
if exist "%OUT%\_work_st03mbs_ecl" rmdir /s /q "%OUT%\_work_st03mbs_ecl"
mkdir "%OUT%\_work_st03mbs_ecl"
copy /y "%OUT%\st03mbs.ecl" "%OUT%\_work_st03mbs_ecl\st03mbs.ecl" >nul
cd /d "%OUT%\_work_st03mbs_ecl"
thecl.exe -d 18 st03mbs.ecl st03mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st03mbs.ecl"
del /q "%OUT%\_work_st03mbs_ecl\st03mbs.ecl"
mkdir "%OUT%\st03mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st03mbs_ecl\*" "%OUT%\st03mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st03mbs_ecl"
if exist "%OUT%\_work_st03wl_anm" rmdir /s /q "%OUT%\_work_st03wl_anm"
mkdir "%OUT%\_work_st03wl_anm"
copy /y "%OUT%\st03wl.anm" "%OUT%\_work_st03wl_anm\st03wl.anm" >nul
cd /d "%OUT%\_work_st03wl_anm"
thanm.exe -x 18 st03wl.anm
cd /d "%OUT%"
del /q "%OUT%\st03wl.anm"
del /q "%OUT%\_work_st03wl_anm\st03wl.anm"
mkdir "%OUT%\st03wl.anm"
xcopy /e /y /q "%OUT%\_work_st03wl_anm\*" "%OUT%\st03wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st03wl_anm"
if exist "%OUT%\_work_st04_ecl" rmdir /s /q "%OUT%\_work_st04_ecl"
mkdir "%OUT%\_work_st04_ecl"
copy /y "%OUT%\st04.ecl" "%OUT%\_work_st04_ecl\st04.ecl" >nul
cd /d "%OUT%\_work_st04_ecl"
thecl.exe -d 18 st04.ecl st04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04.ecl"
del /q "%OUT%\_work_st04_ecl\st04.ecl"
mkdir "%OUT%\st04.ecl"
xcopy /e /y /q "%OUT%\_work_st04_ecl\*" "%OUT%\st04.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04_ecl"
if exist "%OUT%\_work_st04_std" rmdir /s /q "%OUT%\_work_st04_std"
mkdir "%OUT%\_work_st04_std"
copy /y "%OUT%\st04.std" "%OUT%\_work_st04_std\st04.std" >nul
cd /d "%OUT%\_work_st04_std"
thstd.exe -d 18 st04.std st04.std.txt
cd /d "%OUT%"
del /q "%OUT%\st04.std"
del /q "%OUT%\_work_st04_std\st04.std"
mkdir "%OUT%\st04.std"
xcopy /e /y /q "%OUT%\_work_st04_std\*" "%OUT%\st04.std\" >nul
rmdir /s /q "%OUT%\_work_st04_std"
if exist "%OUT%\_work_st04a_msg" rmdir /s /q "%OUT%\_work_st04a_msg"
mkdir "%OUT%\_work_st04a_msg"
copy /y "%OUT%\st04a.msg" "%OUT%\_work_st04a_msg\st04a.msg" >nul
cd /d "%OUT%\_work_st04a_msg"
thmsg.exe -d 18 st04a.msg st04a.txt
cd /d "%OUT%"
del /q "%OUT%\st04a.msg"
del /q "%OUT%\_work_st04a_msg\st04a.msg"
mkdir "%OUT%\st04a.msg"
xcopy /e /y /q "%OUT%\_work_st04a_msg\*" "%OUT%\st04a.msg\" >nul
rmdir /s /q "%OUT%\_work_st04a_msg"
if exist "%OUT%\_work_st04b_msg" rmdir /s /q "%OUT%\_work_st04b_msg"
mkdir "%OUT%\_work_st04b_msg"
copy /y "%OUT%\st04b.msg" "%OUT%\_work_st04b_msg\st04b.msg" >nul
cd /d "%OUT%\_work_st04b_msg"
thmsg.exe -d 18 st04b.msg st04b.txt
cd /d "%OUT%"
del /q "%OUT%\st04b.msg"
del /q "%OUT%\_work_st04b_msg\st04b.msg"
mkdir "%OUT%\st04b.msg"
xcopy /e /y /q "%OUT%\_work_st04b_msg\*" "%OUT%\st04b.msg\" >nul
rmdir /s /q "%OUT%\_work_st04b_msg"
if exist "%OUT%\_work_st04bs_ecl" rmdir /s /q "%OUT%\_work_st04bs_ecl"
mkdir "%OUT%\_work_st04bs_ecl"
copy /y "%OUT%\st04bs.ecl" "%OUT%\_work_st04bs_ecl\st04bs.ecl" >nul
cd /d "%OUT%\_work_st04bs_ecl"
thecl.exe -d 18 st04bs.ecl st04bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04bs.ecl"
del /q "%OUT%\_work_st04bs_ecl\st04bs.ecl"
mkdir "%OUT%\st04bs.ecl"
xcopy /e /y /q "%OUT%\_work_st04bs_ecl\*" "%OUT%\st04bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04bs_ecl"
if exist "%OUT%\_work_st04c_msg" rmdir /s /q "%OUT%\_work_st04c_msg"
mkdir "%OUT%\_work_st04c_msg"
copy /y "%OUT%\st04c.msg" "%OUT%\_work_st04c_msg\st04c.msg" >nul
cd /d "%OUT%\_work_st04c_msg"
thmsg.exe -d 18 st04c.msg st04c.txt
cd /d "%OUT%"
del /q "%OUT%\st04c.msg"
del /q "%OUT%\_work_st04c_msg\st04c.msg"
mkdir "%OUT%\st04c.msg"
xcopy /e /y /q "%OUT%\_work_st04c_msg\*" "%OUT%\st04c.msg\" >nul
rmdir /s /q "%OUT%\_work_st04c_msg"
if exist "%OUT%\_work_st04d_msg" rmdir /s /q "%OUT%\_work_st04d_msg"
mkdir "%OUT%\_work_st04d_msg"
copy /y "%OUT%\st04d.msg" "%OUT%\_work_st04d_msg\st04d.msg" >nul
cd /d "%OUT%\_work_st04d_msg"
thmsg.exe -d 18 st04d.msg st04d.txt
cd /d "%OUT%"
del /q "%OUT%\st04d.msg"
del /q "%OUT%\_work_st04d_msg\st04d.msg"
mkdir "%OUT%\st04d.msg"
xcopy /e /y /q "%OUT%\_work_st04d_msg\*" "%OUT%\st04d.msg\" >nul
rmdir /s /q "%OUT%\_work_st04d_msg"
if exist "%OUT%\_work_st04enm_anm" rmdir /s /q "%OUT%\_work_st04enm_anm"
mkdir "%OUT%\_work_st04enm_anm"
copy /y "%OUT%\st04enm.anm" "%OUT%\_work_st04enm_anm\st04enm.anm" >nul
cd /d "%OUT%\_work_st04enm_anm"
thanm.exe -x 18 st04enm.anm
cd /d "%OUT%"
del /q "%OUT%\st04enm.anm"
del /q "%OUT%\_work_st04enm_anm\st04enm.anm"
mkdir "%OUT%\st04enm.anm"
xcopy /e /y /q "%OUT%\_work_st04enm_anm\*" "%OUT%\st04enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st04enm_anm"
if exist "%OUT%\_work_st04logo_anm" rmdir /s /q "%OUT%\_work_st04logo_anm"
mkdir "%OUT%\_work_st04logo_anm"
copy /y "%OUT%\st04logo.anm" "%OUT%\_work_st04logo_anm\st04logo.anm" >nul
cd /d "%OUT%\_work_st04logo_anm"
thanm.exe -x 18 st04logo.anm
cd /d "%OUT%"
del /q "%OUT%\st04logo.anm"
del /q "%OUT%\_work_st04logo_anm\st04logo.anm"
mkdir "%OUT%\st04logo.anm"
xcopy /e /y /q "%OUT%\_work_st04logo_anm\*" "%OUT%\st04logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st04logo_anm"
if exist "%OUT%\_work_st04mbs_ecl" rmdir /s /q "%OUT%\_work_st04mbs_ecl"
mkdir "%OUT%\_work_st04mbs_ecl"
copy /y "%OUT%\st04mbs.ecl" "%OUT%\_work_st04mbs_ecl\st04mbs.ecl" >nul
cd /d "%OUT%\_work_st04mbs_ecl"
thecl.exe -d 18 st04mbs.ecl st04mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04mbs.ecl"
del /q "%OUT%\_work_st04mbs_ecl\st04mbs.ecl"
mkdir "%OUT%\st04mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st04mbs_ecl\*" "%OUT%\st04mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04mbs_ecl"
if exist "%OUT%\_work_st04wl_anm" rmdir /s /q "%OUT%\_work_st04wl_anm"
mkdir "%OUT%\_work_st04wl_anm"
copy /y "%OUT%\st04wl.anm" "%OUT%\_work_st04wl_anm\st04wl.anm" >nul
cd /d "%OUT%\_work_st04wl_anm"
thanm.exe -x 18 st04wl.anm
cd /d "%OUT%"
del /q "%OUT%\st04wl.anm"
del /q "%OUT%\_work_st04wl_anm\st04wl.anm"
mkdir "%OUT%\st04wl.anm"
xcopy /e /y /q "%OUT%\_work_st04wl_anm\*" "%OUT%\st04wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st04wl_anm"
if exist "%OUT%\_work_st05_ecl" rmdir /s /q "%OUT%\_work_st05_ecl"
mkdir "%OUT%\_work_st05_ecl"
copy /y "%OUT%\st05.ecl" "%OUT%\_work_st05_ecl\st05.ecl" >nul
cd /d "%OUT%\_work_st05_ecl"
thecl.exe -d 18 st05.ecl st05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st05.ecl"
del /q "%OUT%\_work_st05_ecl\st05.ecl"
mkdir "%OUT%\st05.ecl"
xcopy /e /y /q "%OUT%\_work_st05_ecl\*" "%OUT%\st05.ecl\" >nul
rmdir /s /q "%OUT%\_work_st05_ecl"
if exist "%OUT%\_work_st05_std" rmdir /s /q "%OUT%\_work_st05_std"
mkdir "%OUT%\_work_st05_std"
copy /y "%OUT%\st05.std" "%OUT%\_work_st05_std\st05.std" >nul
cd /d "%OUT%\_work_st05_std"
thstd.exe -d 18 st05.std st05.std.txt
cd /d "%OUT%"
del /q "%OUT%\st05.std"
del /q "%OUT%\_work_st05_std\st05.std"
mkdir "%OUT%\st05.std"
xcopy /e /y /q "%OUT%\_work_st05_std\*" "%OUT%\st05.std\" >nul
rmdir /s /q "%OUT%\_work_st05_std"
if exist "%OUT%\_work_st05a_msg" rmdir /s /q "%OUT%\_work_st05a_msg"
mkdir "%OUT%\_work_st05a_msg"
copy /y "%OUT%\st05a.msg" "%OUT%\_work_st05a_msg\st05a.msg" >nul
cd /d "%OUT%\_work_st05a_msg"
thmsg.exe -d 18 st05a.msg st05a.txt
cd /d "%OUT%"
del /q "%OUT%\st05a.msg"
del /q "%OUT%\_work_st05a_msg\st05a.msg"
mkdir "%OUT%\st05a.msg"
xcopy /e /y /q "%OUT%\_work_st05a_msg\*" "%OUT%\st05a.msg\" >nul
rmdir /s /q "%OUT%\_work_st05a_msg"
if exist "%OUT%\_work_st05b_msg" rmdir /s /q "%OUT%\_work_st05b_msg"
mkdir "%OUT%\_work_st05b_msg"
copy /y "%OUT%\st05b.msg" "%OUT%\_work_st05b_msg\st05b.msg" >nul
cd /d "%OUT%\_work_st05b_msg"
thmsg.exe -d 18 st05b.msg st05b.txt
cd /d "%OUT%"
del /q "%OUT%\st05b.msg"
del /q "%OUT%\_work_st05b_msg\st05b.msg"
mkdir "%OUT%\st05b.msg"
xcopy /e /y /q "%OUT%\_work_st05b_msg\*" "%OUT%\st05b.msg\" >nul
rmdir /s /q "%OUT%\_work_st05b_msg"
if exist "%OUT%\_work_st05bs_ecl" rmdir /s /q "%OUT%\_work_st05bs_ecl"
mkdir "%OUT%\_work_st05bs_ecl"
copy /y "%OUT%\st05bs.ecl" "%OUT%\_work_st05bs_ecl\st05bs.ecl" >nul
cd /d "%OUT%\_work_st05bs_ecl"
thecl.exe -d 18 st05bs.ecl st05bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st05bs.ecl"
del /q "%OUT%\_work_st05bs_ecl\st05bs.ecl"
mkdir "%OUT%\st05bs.ecl"
xcopy /e /y /q "%OUT%\_work_st05bs_ecl\*" "%OUT%\st05bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st05bs_ecl"
if exist "%OUT%\_work_st05c_msg" rmdir /s /q "%OUT%\_work_st05c_msg"
mkdir "%OUT%\_work_st05c_msg"
copy /y "%OUT%\st05c.msg" "%OUT%\_work_st05c_msg\st05c.msg" >nul
cd /d "%OUT%\_work_st05c_msg"
thmsg.exe -d 18 st05c.msg st05c.txt
cd /d "%OUT%"
del /q "%OUT%\st05c.msg"
del /q "%OUT%\_work_st05c_msg\st05c.msg"
mkdir "%OUT%\st05c.msg"
xcopy /e /y /q "%OUT%\_work_st05c_msg\*" "%OUT%\st05c.msg\" >nul
rmdir /s /q "%OUT%\_work_st05c_msg"
if exist "%OUT%\_work_st05d_msg" rmdir /s /q "%OUT%\_work_st05d_msg"
mkdir "%OUT%\_work_st05d_msg"
copy /y "%OUT%\st05d.msg" "%OUT%\_work_st05d_msg\st05d.msg" >nul
cd /d "%OUT%\_work_st05d_msg"
thmsg.exe -d 18 st05d.msg st05d.txt
cd /d "%OUT%"
del /q "%OUT%\st05d.msg"
del /q "%OUT%\_work_st05d_msg\st05d.msg"
mkdir "%OUT%\st05d.msg"
xcopy /e /y /q "%OUT%\_work_st05d_msg\*" "%OUT%\st05d.msg\" >nul
rmdir /s /q "%OUT%\_work_st05d_msg"
if exist "%OUT%\_work_st05enm_anm" rmdir /s /q "%OUT%\_work_st05enm_anm"
mkdir "%OUT%\_work_st05enm_anm"
copy /y "%OUT%\st05enm.anm" "%OUT%\_work_st05enm_anm\st05enm.anm" >nul
cd /d "%OUT%\_work_st05enm_anm"
thanm.exe -x 18 st05enm.anm
cd /d "%OUT%"
del /q "%OUT%\st05enm.anm"
del /q "%OUT%\_work_st05enm_anm\st05enm.anm"
mkdir "%OUT%\st05enm.anm"
xcopy /e /y /q "%OUT%\_work_st05enm_anm\*" "%OUT%\st05enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st05enm_anm"
if exist "%OUT%\_work_st05enm2_anm" rmdir /s /q "%OUT%\_work_st05enm2_anm"
mkdir "%OUT%\_work_st05enm2_anm"
copy /y "%OUT%\st05enm2.anm" "%OUT%\_work_st05enm2_anm\st05enm2.anm" >nul
cd /d "%OUT%\_work_st05enm2_anm"
thanm.exe -x 18 st05enm2.anm
cd /d "%OUT%"
del /q "%OUT%\st05enm2.anm"
del /q "%OUT%\_work_st05enm2_anm\st05enm2.anm"
mkdir "%OUT%\st05enm2.anm"
xcopy /e /y /q "%OUT%\_work_st05enm2_anm\*" "%OUT%\st05enm2.anm\" >nul
rmdir /s /q "%OUT%\_work_st05enm2_anm"
if exist "%OUT%\_work_st05logo_anm" rmdir /s /q "%OUT%\_work_st05logo_anm"
mkdir "%OUT%\_work_st05logo_anm"
copy /y "%OUT%\st05logo.anm" "%OUT%\_work_st05logo_anm\st05logo.anm" >nul
cd /d "%OUT%\_work_st05logo_anm"
thanm.exe -x 18 st05logo.anm
cd /d "%OUT%"
del /q "%OUT%\st05logo.anm"
del /q "%OUT%\_work_st05logo_anm\st05logo.anm"
mkdir "%OUT%\st05logo.anm"
xcopy /e /y /q "%OUT%\_work_st05logo_anm\*" "%OUT%\st05logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st05logo_anm"
if exist "%OUT%\_work_st05mbs_ecl" rmdir /s /q "%OUT%\_work_st05mbs_ecl"
mkdir "%OUT%\_work_st05mbs_ecl"
copy /y "%OUT%\st05mbs.ecl" "%OUT%\_work_st05mbs_ecl\st05mbs.ecl" >nul
cd /d "%OUT%\_work_st05mbs_ecl"
thecl.exe -d 18 st05mbs.ecl st05mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st05mbs.ecl"
del /q "%OUT%\_work_st05mbs_ecl\st05mbs.ecl"
mkdir "%OUT%\st05mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st05mbs_ecl\*" "%OUT%\st05mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st05mbs_ecl"
if exist "%OUT%\_work_st05wl_anm" rmdir /s /q "%OUT%\_work_st05wl_anm"
mkdir "%OUT%\_work_st05wl_anm"
copy /y "%OUT%\st05wl.anm" "%OUT%\_work_st05wl_anm\st05wl.anm" >nul
cd /d "%OUT%\_work_st05wl_anm"
thanm.exe -x 18 st05wl.anm
cd /d "%OUT%"
del /q "%OUT%\st05wl.anm"
del /q "%OUT%\_work_st05wl_anm\st05wl.anm"
mkdir "%OUT%\st05wl.anm"
xcopy /e /y /q "%OUT%\_work_st05wl_anm\*" "%OUT%\st05wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st05wl_anm"
if exist "%OUT%\_work_st06_ecl" rmdir /s /q "%OUT%\_work_st06_ecl"
mkdir "%OUT%\_work_st06_ecl"
copy /y "%OUT%\st06.ecl" "%OUT%\_work_st06_ecl\st06.ecl" >nul
cd /d "%OUT%\_work_st06_ecl"
thecl.exe -d 18 st06.ecl st06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st06.ecl"
del /q "%OUT%\_work_st06_ecl\st06.ecl"
mkdir "%OUT%\st06.ecl"
xcopy /e /y /q "%OUT%\_work_st06_ecl\*" "%OUT%\st06.ecl\" >nul
rmdir /s /q "%OUT%\_work_st06_ecl"
if exist "%OUT%\_work_st06_std" rmdir /s /q "%OUT%\_work_st06_std"
mkdir "%OUT%\_work_st06_std"
copy /y "%OUT%\st06.std" "%OUT%\_work_st06_std\st06.std" >nul
cd /d "%OUT%\_work_st06_std"
thstd.exe -d 18 st06.std st06.std.txt
cd /d "%OUT%"
del /q "%OUT%\st06.std"
del /q "%OUT%\_work_st06_std\st06.std"
mkdir "%OUT%\st06.std"
xcopy /e /y /q "%OUT%\_work_st06_std\*" "%OUT%\st06.std\" >nul
rmdir /s /q "%OUT%\_work_st06_std"
if exist "%OUT%\_work_st06a_msg" rmdir /s /q "%OUT%\_work_st06a_msg"
mkdir "%OUT%\_work_st06a_msg"
copy /y "%OUT%\st06a.msg" "%OUT%\_work_st06a_msg\st06a.msg" >nul
cd /d "%OUT%\_work_st06a_msg"
thmsg.exe -d 18 st06a.msg st06a.txt
cd /d "%OUT%"
del /q "%OUT%\st06a.msg"
del /q "%OUT%\_work_st06a_msg\st06a.msg"
mkdir "%OUT%\st06a.msg"
xcopy /e /y /q "%OUT%\_work_st06a_msg\*" "%OUT%\st06a.msg\" >nul
rmdir /s /q "%OUT%\_work_st06a_msg"
if exist "%OUT%\_work_st06b_msg" rmdir /s /q "%OUT%\_work_st06b_msg"
mkdir "%OUT%\_work_st06b_msg"
copy /y "%OUT%\st06b.msg" "%OUT%\_work_st06b_msg\st06b.msg" >nul
cd /d "%OUT%\_work_st06b_msg"
thmsg.exe -d 18 st06b.msg st06b.txt
cd /d "%OUT%"
del /q "%OUT%\st06b.msg"
del /q "%OUT%\_work_st06b_msg\st06b.msg"
mkdir "%OUT%\st06b.msg"
xcopy /e /y /q "%OUT%\_work_st06b_msg\*" "%OUT%\st06b.msg\" >nul
rmdir /s /q "%OUT%\_work_st06b_msg"
if exist "%OUT%\_work_st06bs_ecl" rmdir /s /q "%OUT%\_work_st06bs_ecl"
mkdir "%OUT%\_work_st06bs_ecl"
copy /y "%OUT%\st06bs.ecl" "%OUT%\_work_st06bs_ecl\st06bs.ecl" >nul
cd /d "%OUT%\_work_st06bs_ecl"
thecl.exe -d 18 st06bs.ecl st06bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st06bs.ecl"
del /q "%OUT%\_work_st06bs_ecl\st06bs.ecl"
mkdir "%OUT%\st06bs.ecl"
xcopy /e /y /q "%OUT%\_work_st06bs_ecl\*" "%OUT%\st06bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st06bs_ecl"
if exist "%OUT%\_work_st06c_msg" rmdir /s /q "%OUT%\_work_st06c_msg"
mkdir "%OUT%\_work_st06c_msg"
copy /y "%OUT%\st06c.msg" "%OUT%\_work_st06c_msg\st06c.msg" >nul
cd /d "%OUT%\_work_st06c_msg"
thmsg.exe -d 18 st06c.msg st06c.txt
cd /d "%OUT%"
del /q "%OUT%\st06c.msg"
del /q "%OUT%\_work_st06c_msg\st06c.msg"
mkdir "%OUT%\st06c.msg"
xcopy /e /y /q "%OUT%\_work_st06c_msg\*" "%OUT%\st06c.msg\" >nul
rmdir /s /q "%OUT%\_work_st06c_msg"
if exist "%OUT%\_work_st06d_msg" rmdir /s /q "%OUT%\_work_st06d_msg"
mkdir "%OUT%\_work_st06d_msg"
copy /y "%OUT%\st06d.msg" "%OUT%\_work_st06d_msg\st06d.msg" >nul
cd /d "%OUT%\_work_st06d_msg"
thmsg.exe -d 18 st06d.msg st06d.txt
cd /d "%OUT%"
del /q "%OUT%\st06d.msg"
del /q "%OUT%\_work_st06d_msg\st06d.msg"
mkdir "%OUT%\st06d.msg"
xcopy /e /y /q "%OUT%\_work_st06d_msg\*" "%OUT%\st06d.msg\" >nul
rmdir /s /q "%OUT%\_work_st06d_msg"
if exist "%OUT%\_work_st06enm_anm" rmdir /s /q "%OUT%\_work_st06enm_anm"
mkdir "%OUT%\_work_st06enm_anm"
copy /y "%OUT%\st06enm.anm" "%OUT%\_work_st06enm_anm\st06enm.anm" >nul
cd /d "%OUT%\_work_st06enm_anm"
thanm.exe -x 18 st06enm.anm
cd /d "%OUT%"
del /q "%OUT%\st06enm.anm"
del /q "%OUT%\_work_st06enm_anm\st06enm.anm"
mkdir "%OUT%\st06enm.anm"
xcopy /e /y /q "%OUT%\_work_st06enm_anm\*" "%OUT%\st06enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st06enm_anm"
if exist "%OUT%\_work_st06logo_anm" rmdir /s /q "%OUT%\_work_st06logo_anm"
mkdir "%OUT%\_work_st06logo_anm"
copy /y "%OUT%\st06logo.anm" "%OUT%\_work_st06logo_anm\st06logo.anm" >nul
cd /d "%OUT%\_work_st06logo_anm"
thanm.exe -x 18 st06logo.anm
cd /d "%OUT%"
del /q "%OUT%\st06logo.anm"
del /q "%OUT%\_work_st06logo_anm\st06logo.anm"
mkdir "%OUT%\st06logo.anm"
xcopy /e /y /q "%OUT%\_work_st06logo_anm\*" "%OUT%\st06logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st06logo_anm"
if exist "%OUT%\_work_st06mbs_ecl" rmdir /s /q "%OUT%\_work_st06mbs_ecl"
mkdir "%OUT%\_work_st06mbs_ecl"
copy /y "%OUT%\st06mbs.ecl" "%OUT%\_work_st06mbs_ecl\st06mbs.ecl" >nul
cd /d "%OUT%\_work_st06mbs_ecl"
thecl.exe -d 18 st06mbs.ecl st06mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st06mbs.ecl"
del /q "%OUT%\_work_st06mbs_ecl\st06mbs.ecl"
mkdir "%OUT%\st06mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st06mbs_ecl\*" "%OUT%\st06mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st06mbs_ecl"
if exist "%OUT%\_work_st06wl_anm" rmdir /s /q "%OUT%\_work_st06wl_anm"
mkdir "%OUT%\_work_st06wl_anm"
copy /y "%OUT%\st06wl.anm" "%OUT%\_work_st06wl_anm\st06wl.anm" >nul
cd /d "%OUT%\_work_st06wl_anm"
thanm.exe -x 18 st06wl.anm
cd /d "%OUT%"
del /q "%OUT%\st06wl.anm"
del /q "%OUT%\_work_st06wl_anm\st06wl.anm"
mkdir "%OUT%\st06wl.anm"
xcopy /e /y /q "%OUT%\_work_st06wl_anm\*" "%OUT%\st06wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st06wl_anm"
if exist "%OUT%\_work_st07_ecl" rmdir /s /q "%OUT%\_work_st07_ecl"
mkdir "%OUT%\_work_st07_ecl"
copy /y "%OUT%\st07.ecl" "%OUT%\_work_st07_ecl\st07.ecl" >nul
cd /d "%OUT%\_work_st07_ecl"
thecl.exe -d 18 st07.ecl st07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st07.ecl"
del /q "%OUT%\_work_st07_ecl\st07.ecl"
mkdir "%OUT%\st07.ecl"
xcopy /e /y /q "%OUT%\_work_st07_ecl\*" "%OUT%\st07.ecl\" >nul
rmdir /s /q "%OUT%\_work_st07_ecl"
if exist "%OUT%\_work_st07_std" rmdir /s /q "%OUT%\_work_st07_std"
mkdir "%OUT%\_work_st07_std"
copy /y "%OUT%\st07.std" "%OUT%\_work_st07_std\st07.std" >nul
cd /d "%OUT%\_work_st07_std"
thstd.exe -d 18 st07.std st07.std.txt
cd /d "%OUT%"
del /q "%OUT%\st07.std"
del /q "%OUT%\_work_st07_std\st07.std"
mkdir "%OUT%\st07.std"
xcopy /e /y /q "%OUT%\_work_st07_std\*" "%OUT%\st07.std\" >nul
rmdir /s /q "%OUT%\_work_st07_std"
if exist "%OUT%\_work_st07a_msg" rmdir /s /q "%OUT%\_work_st07a_msg"
mkdir "%OUT%\_work_st07a_msg"
copy /y "%OUT%\st07a.msg" "%OUT%\_work_st07a_msg\st07a.msg" >nul
cd /d "%OUT%\_work_st07a_msg"
thmsg.exe -d 18 st07a.msg st07a.txt
cd /d "%OUT%"
del /q "%OUT%\st07a.msg"
del /q "%OUT%\_work_st07a_msg\st07a.msg"
mkdir "%OUT%\st07a.msg"
xcopy /e /y /q "%OUT%\_work_st07a_msg\*" "%OUT%\st07a.msg\" >nul
rmdir /s /q "%OUT%\_work_st07a_msg"
if exist "%OUT%\_work_st07b_msg" rmdir /s /q "%OUT%\_work_st07b_msg"
mkdir "%OUT%\_work_st07b_msg"
copy /y "%OUT%\st07b.msg" "%OUT%\_work_st07b_msg\st07b.msg" >nul
cd /d "%OUT%\_work_st07b_msg"
thmsg.exe -d 18 st07b.msg st07b.txt
cd /d "%OUT%"
del /q "%OUT%\st07b.msg"
del /q "%OUT%\_work_st07b_msg\st07b.msg"
mkdir "%OUT%\st07b.msg"
xcopy /e /y /q "%OUT%\_work_st07b_msg\*" "%OUT%\st07b.msg\" >nul
rmdir /s /q "%OUT%\_work_st07b_msg"
if exist "%OUT%\_work_st07bs_ecl" rmdir /s /q "%OUT%\_work_st07bs_ecl"
mkdir "%OUT%\_work_st07bs_ecl"
copy /y "%OUT%\st07bs.ecl" "%OUT%\_work_st07bs_ecl\st07bs.ecl" >nul
cd /d "%OUT%\_work_st07bs_ecl"
thecl.exe -d 18 st07bs.ecl st07bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st07bs.ecl"
del /q "%OUT%\_work_st07bs_ecl\st07bs.ecl"
mkdir "%OUT%\st07bs.ecl"
xcopy /e /y /q "%OUT%\_work_st07bs_ecl\*" "%OUT%\st07bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st07bs_ecl"
if exist "%OUT%\_work_st07c_msg" rmdir /s /q "%OUT%\_work_st07c_msg"
mkdir "%OUT%\_work_st07c_msg"
copy /y "%OUT%\st07c.msg" "%OUT%\_work_st07c_msg\st07c.msg" >nul
cd /d "%OUT%\_work_st07c_msg"
thmsg.exe -d 18 st07c.msg st07c.txt
cd /d "%OUT%"
del /q "%OUT%\st07c.msg"
del /q "%OUT%\_work_st07c_msg\st07c.msg"
mkdir "%OUT%\st07c.msg"
xcopy /e /y /q "%OUT%\_work_st07c_msg\*" "%OUT%\st07c.msg\" >nul
rmdir /s /q "%OUT%\_work_st07c_msg"
if exist "%OUT%\_work_st07d_msg" rmdir /s /q "%OUT%\_work_st07d_msg"
mkdir "%OUT%\_work_st07d_msg"
copy /y "%OUT%\st07d.msg" "%OUT%\_work_st07d_msg\st07d.msg" >nul
cd /d "%OUT%\_work_st07d_msg"
thmsg.exe -d 18 st07d.msg st07d.txt
cd /d "%OUT%"
del /q "%OUT%\st07d.msg"
del /q "%OUT%\_work_st07d_msg\st07d.msg"
mkdir "%OUT%\st07d.msg"
xcopy /e /y /q "%OUT%\_work_st07d_msg\*" "%OUT%\st07d.msg\" >nul
rmdir /s /q "%OUT%\_work_st07d_msg"
if exist "%OUT%\_work_st07enm_anm" rmdir /s /q "%OUT%\_work_st07enm_anm"
mkdir "%OUT%\_work_st07enm_anm"
copy /y "%OUT%\st07enm.anm" "%OUT%\_work_st07enm_anm\st07enm.anm" >nul
cd /d "%OUT%\_work_st07enm_anm"
thanm.exe -x 18 st07enm.anm
cd /d "%OUT%"
del /q "%OUT%\st07enm.anm"
del /q "%OUT%\_work_st07enm_anm\st07enm.anm"
mkdir "%OUT%\st07enm.anm"
xcopy /e /y /q "%OUT%\_work_st07enm_anm\*" "%OUT%\st07enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st07enm_anm"
if exist "%OUT%\_work_st07logo_anm" rmdir /s /q "%OUT%\_work_st07logo_anm"
mkdir "%OUT%\_work_st07logo_anm"
copy /y "%OUT%\st07logo.anm" "%OUT%\_work_st07logo_anm\st07logo.anm" >nul
cd /d "%OUT%\_work_st07logo_anm"
thanm.exe -x 18 st07logo.anm
cd /d "%OUT%"
del /q "%OUT%\st07logo.anm"
del /q "%OUT%\_work_st07logo_anm\st07logo.anm"
mkdir "%OUT%\st07logo.anm"
xcopy /e /y /q "%OUT%\_work_st07logo_anm\*" "%OUT%\st07logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st07logo_anm"
if exist "%OUT%\_work_st07mbs_ecl" rmdir /s /q "%OUT%\_work_st07mbs_ecl"
mkdir "%OUT%\_work_st07mbs_ecl"
copy /y "%OUT%\st07mbs.ecl" "%OUT%\_work_st07mbs_ecl\st07mbs.ecl" >nul
cd /d "%OUT%\_work_st07mbs_ecl"
thecl.exe -d 18 st07mbs.ecl st07mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st07mbs.ecl"
del /q "%OUT%\_work_st07mbs_ecl\st07mbs.ecl"
mkdir "%OUT%\st07mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st07mbs_ecl\*" "%OUT%\st07mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st07mbs_ecl"
if exist "%OUT%\_work_st07wl_anm" rmdir /s /q "%OUT%\_work_st07wl_anm"
mkdir "%OUT%\_work_st07wl_anm"
copy /y "%OUT%\st07wl.anm" "%OUT%\_work_st07wl_anm\st07wl.anm" >nul
cd /d "%OUT%\_work_st07wl_anm"
thanm.exe -x 18 st07wl.anm
cd /d "%OUT%"
del /q "%OUT%\st07wl.anm"
del /q "%OUT%\_work_st07wl_anm\st07wl.anm"
mkdir "%OUT%\st07wl.anm"
xcopy /e /y /q "%OUT%\_work_st07wl_anm\*" "%OUT%\st07wl.anm\" >nul
rmdir /s /q "%OUT%\_work_st07wl_anm"
if exist "%OUT%\_work_staff_anm" rmdir /s /q "%OUT%\_work_staff_anm"
mkdir "%OUT%\_work_staff_anm"
copy /y "%OUT%\staff.anm" "%OUT%\_work_staff_anm\staff.anm" >nul
cd /d "%OUT%\_work_staff_anm"
thanm.exe -x 18 staff.anm
cd /d "%OUT%"
del /q "%OUT%\staff.anm"
del /q "%OUT%\_work_staff_anm\staff.anm"
mkdir "%OUT%\staff.anm"
xcopy /e /y /q "%OUT%\_work_staff_anm\*" "%OUT%\staff.anm\" >nul
rmdir /s /q "%OUT%\_work_staff_anm"
if exist "%OUT%\_work_staff1_msg" rmdir /s /q "%OUT%\_work_staff1_msg"
mkdir "%OUT%\_work_staff1_msg"
copy /y "%OUT%\staff1.msg" "%OUT%\_work_staff1_msg\staff1.msg" >nul
cd /d "%OUT%\_work_staff1_msg"
thmsg.exe -d 18 staff1.msg staff1.txt
cd /d "%OUT%"
del /q "%OUT%\staff1.msg"
del /q "%OUT%\_work_staff1_msg\staff1.msg"
mkdir "%OUT%\staff1.msg"
xcopy /e /y /q "%OUT%\_work_staff1_msg\*" "%OUT%\staff1.msg\" >nul
rmdir /s /q "%OUT%\_work_staff1_msg"
if exist "%OUT%\_work_staff2_msg" rmdir /s /q "%OUT%\_work_staff2_msg"
mkdir "%OUT%\_work_staff2_msg"
copy /y "%OUT%\staff2.msg" "%OUT%\_work_staff2_msg\staff2.msg" >nul
cd /d "%OUT%\_work_staff2_msg"
thmsg.exe -d 18 staff2.msg staff2.txt
cd /d "%OUT%"
del /q "%OUT%\staff2.msg"
del /q "%OUT%\_work_staff2_msg\staff2.msg"
mkdir "%OUT%\staff2.msg"
xcopy /e /y /q "%OUT%\_work_staff2_msg\*" "%OUT%\staff2.msg\" >nul
rmdir /s /q "%OUT%\_work_staff2_msg"
if exist "%OUT%\_work_staff3_msg" rmdir /s /q "%OUT%\_work_staff3_msg"
mkdir "%OUT%\_work_staff3_msg"
copy /y "%OUT%\staff3.msg" "%OUT%\_work_staff3_msg\staff3.msg" >nul
cd /d "%OUT%\_work_staff3_msg"
thmsg.exe -d 18 staff3.msg staff3.txt
cd /d "%OUT%"
del /q "%OUT%\staff3.msg"
del /q "%OUT%\_work_staff3_msg\staff3.msg"
mkdir "%OUT%\staff3.msg"
xcopy /e /y /q "%OUT%\_work_staff3_msg\*" "%OUT%\staff3.msg\" >nul
rmdir /s /q "%OUT%\_work_staff3_msg"
if exist "%OUT%\_work_staff4_msg" rmdir /s /q "%OUT%\_work_staff4_msg"
mkdir "%OUT%\_work_staff4_msg"
copy /y "%OUT%\staff4.msg" "%OUT%\_work_staff4_msg\staff4.msg" >nul
cd /d "%OUT%\_work_staff4_msg"
thmsg.exe -d 18 staff4.msg staff4.txt
cd /d "%OUT%"
del /q "%OUT%\staff4.msg"
del /q "%OUT%\_work_staff4_msg\staff4.msg"
mkdir "%OUT%\staff4.msg"
xcopy /e /y /q "%OUT%\_work_staff4_msg\*" "%OUT%\staff4.msg\" >nul
rmdir /s /q "%OUT%\_work_staff4_msg"
if exist "%OUT%\_work_title_anm" rmdir /s /q "%OUT%\_work_title_anm"
mkdir "%OUT%\_work_title_anm"
copy /y "%OUT%\title.anm" "%OUT%\_work_title_anm\title.anm" >nul
cd /d "%OUT%\_work_title_anm"
thanm.exe -x 18 title.anm
cd /d "%OUT%"
del /q "%OUT%\title.anm"
del /q "%OUT%\_work_title_anm\title.anm"
mkdir "%OUT%\title.anm"
xcopy /e /y /q "%OUT%\_work_title_anm\*" "%OUT%\title.anm\" >nul
rmdir /s /q "%OUT%\_work_title_anm"
if exist "%OUT%\_work_title_v_anm" rmdir /s /q "%OUT%\_work_title_v_anm"
mkdir "%OUT%\_work_title_v_anm"
copy /y "%OUT%\title_v.anm" "%OUT%\_work_title_v_anm\title_v.anm" >nul
cd /d "%OUT%\_work_title_v_anm"
thanm.exe -x 18 title_v.anm
cd /d "%OUT%"
del /q "%OUT%\title_v.anm"
del /q "%OUT%\_work_title_v_anm\title_v.anm"
mkdir "%OUT%\title_v.anm"
xcopy /e /y /q "%OUT%\_work_title_v_anm\*" "%OUT%\title_v.anm\" >nul
rmdir /s /q "%OUT%\_work_title_v_anm"
if exist "%OUT%\_work_trophy_anm" rmdir /s /q "%OUT%\_work_trophy_anm"
mkdir "%OUT%\_work_trophy_anm"
copy /y "%OUT%\trophy.anm" "%OUT%\_work_trophy_anm\trophy.anm" >nul
cd /d "%OUT%\_work_trophy_anm"
thanm.exe -x 18 trophy.anm
cd /d "%OUT%"
del /q "%OUT%\trophy.anm"
del /q "%OUT%\_work_trophy_anm\trophy.anm"
mkdir "%OUT%\trophy.anm"
xcopy /e /y /q "%OUT%\_work_trophy_anm\*" "%OUT%\trophy.anm\" >nul
rmdir /s /q "%OUT%\_work_trophy_anm"
echo === th18 转换完成 ===