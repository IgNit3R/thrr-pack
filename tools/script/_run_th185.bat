@echo off
setlocal
set PATH=E:\GitWorkspace\thworks\.build\thtk-install\bin;%PATH%
set OUT=E:\GitWorkspace\thworks\pushfiles\th185\th185.dat
if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%"
cd /d "%OUT%"
thdat.exe -x 185 "E:\GitWorkspace\thworks\tsa\th185\th185.dat"
if exist "%OUT%\_work_abcard_anm" rmdir /s /q "%OUT%\_work_abcard_anm"
mkdir "%OUT%\_work_abcard_anm"
copy /y "%OUT%\abcard.anm" "%OUT%\_work_abcard_anm\abcard.anm" >nul
cd /d "%OUT%\_work_abcard_anm"
thanm.exe -x 185 abcard.anm
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
thanm.exe -x 185 ability.anm
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
thanm.exe -x 185 abmenu.anm
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
thanm.exe -x 185 ascii.anm
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
thanm.exe -x 185 ascii1280.anm
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
thanm.exe -x 185 ascii_960.anm
cd /d "%OUT%"
del /q "%OUT%\ascii_960.anm"
del /q "%OUT%\_work_ascii_960_anm\ascii_960.anm"
mkdir "%OUT%\ascii_960.anm"
xcopy /e /y /q "%OUT%\_work_ascii_960_anm\*" "%OUT%\ascii_960.anm\" >nul
rmdir /s /q "%OUT%\_work_ascii_960_anm"
if exist "%OUT%\_work_boss01_anm" rmdir /s /q "%OUT%\_work_boss01_anm"
mkdir "%OUT%\_work_boss01_anm"
copy /y "%OUT%\boss01.anm" "%OUT%\_work_boss01_anm\boss01.anm" >nul
cd /d "%OUT%\_work_boss01_anm"
thanm.exe -x 185 boss01.anm
cd /d "%OUT%"
del /q "%OUT%\boss01.anm"
del /q "%OUT%\_work_boss01_anm\boss01.anm"
mkdir "%OUT%\boss01.anm"
xcopy /e /y /q "%OUT%\_work_boss01_anm\*" "%OUT%\boss01.anm\" >nul
rmdir /s /q "%OUT%\_work_boss01_anm"
if exist "%OUT%\_work_boss01_ecl" rmdir /s /q "%OUT%\_work_boss01_ecl"
mkdir "%OUT%\_work_boss01_ecl"
copy /y "%OUT%\boss01.ecl" "%OUT%\_work_boss01_ecl\boss01.ecl" >nul
cd /d "%OUT%\_work_boss01_ecl"
thecl.exe -d 185 boss01.ecl boss01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss01.ecl"
del /q "%OUT%\_work_boss01_ecl\boss01.ecl"
mkdir "%OUT%\boss01.ecl"
xcopy /e /y /q "%OUT%\_work_boss01_ecl\*" "%OUT%\boss01.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss01_ecl"
if exist "%OUT%\_work_boss01t_anm" rmdir /s /q "%OUT%\_work_boss01t_anm"
mkdir "%OUT%\_work_boss01t_anm"
copy /y "%OUT%\boss01t.anm" "%OUT%\_work_boss01t_anm\boss01t.anm" >nul
cd /d "%OUT%\_work_boss01t_anm"
thanm.exe -x 185 boss01t.anm
cd /d "%OUT%"
del /q "%OUT%\boss01t.anm"
del /q "%OUT%\_work_boss01t_anm\boss01t.anm"
mkdir "%OUT%\boss01t.anm"
xcopy /e /y /q "%OUT%\_work_boss01t_anm\*" "%OUT%\boss01t.anm\" >nul
rmdir /s /q "%OUT%\_work_boss01t_anm"
if exist "%OUT%\_work_boss01t_ecl" rmdir /s /q "%OUT%\_work_boss01t_ecl"
mkdir "%OUT%\_work_boss01t_ecl"
copy /y "%OUT%\boss01t.ecl" "%OUT%\_work_boss01t_ecl\boss01t.ecl" >nul
cd /d "%OUT%\_work_boss01t_ecl"
thecl.exe -d 185 boss01t.ecl boss01t.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss01t.ecl"
del /q "%OUT%\_work_boss01t_ecl\boss01t.ecl"
mkdir "%OUT%\boss01t.ecl"
xcopy /e /y /q "%OUT%\_work_boss01t_ecl\*" "%OUT%\boss01t.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss01t_ecl"
if exist "%OUT%\_work_boss02_anm" rmdir /s /q "%OUT%\_work_boss02_anm"
mkdir "%OUT%\_work_boss02_anm"
copy /y "%OUT%\boss02.anm" "%OUT%\_work_boss02_anm\boss02.anm" >nul
cd /d "%OUT%\_work_boss02_anm"
thanm.exe -x 185 boss02.anm
cd /d "%OUT%"
del /q "%OUT%\boss02.anm"
del /q "%OUT%\_work_boss02_anm\boss02.anm"
mkdir "%OUT%\boss02.anm"
xcopy /e /y /q "%OUT%\_work_boss02_anm\*" "%OUT%\boss02.anm\" >nul
rmdir /s /q "%OUT%\_work_boss02_anm"
if exist "%OUT%\_work_boss02_ecl" rmdir /s /q "%OUT%\_work_boss02_ecl"
mkdir "%OUT%\_work_boss02_ecl"
copy /y "%OUT%\boss02.ecl" "%OUT%\_work_boss02_ecl\boss02.ecl" >nul
cd /d "%OUT%\_work_boss02_ecl"
thecl.exe -d 185 boss02.ecl boss02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss02.ecl"
del /q "%OUT%\_work_boss02_ecl\boss02.ecl"
mkdir "%OUT%\boss02.ecl"
xcopy /e /y /q "%OUT%\_work_boss02_ecl\*" "%OUT%\boss02.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss02_ecl"
if exist "%OUT%\_work_boss03_anm" rmdir /s /q "%OUT%\_work_boss03_anm"
mkdir "%OUT%\_work_boss03_anm"
copy /y "%OUT%\boss03.anm" "%OUT%\_work_boss03_anm\boss03.anm" >nul
cd /d "%OUT%\_work_boss03_anm"
thanm.exe -x 185 boss03.anm
cd /d "%OUT%"
del /q "%OUT%\boss03.anm"
del /q "%OUT%\_work_boss03_anm\boss03.anm"
mkdir "%OUT%\boss03.anm"
xcopy /e /y /q "%OUT%\_work_boss03_anm\*" "%OUT%\boss03.anm\" >nul
rmdir /s /q "%OUT%\_work_boss03_anm"
if exist "%OUT%\_work_boss03_ecl" rmdir /s /q "%OUT%\_work_boss03_ecl"
mkdir "%OUT%\_work_boss03_ecl"
copy /y "%OUT%\boss03.ecl" "%OUT%\_work_boss03_ecl\boss03.ecl" >nul
cd /d "%OUT%\_work_boss03_ecl"
thecl.exe -d 185 boss03.ecl boss03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss03.ecl"
del /q "%OUT%\_work_boss03_ecl\boss03.ecl"
mkdir "%OUT%\boss03.ecl"
xcopy /e /y /q "%OUT%\_work_boss03_ecl\*" "%OUT%\boss03.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss03_ecl"
if exist "%OUT%\_work_boss04_anm" rmdir /s /q "%OUT%\_work_boss04_anm"
mkdir "%OUT%\_work_boss04_anm"
copy /y "%OUT%\boss04.anm" "%OUT%\_work_boss04_anm\boss04.anm" >nul
cd /d "%OUT%\_work_boss04_anm"
thanm.exe -x 185 boss04.anm
cd /d "%OUT%"
del /q "%OUT%\boss04.anm"
del /q "%OUT%\_work_boss04_anm\boss04.anm"
mkdir "%OUT%\boss04.anm"
xcopy /e /y /q "%OUT%\_work_boss04_anm\*" "%OUT%\boss04.anm\" >nul
rmdir /s /q "%OUT%\_work_boss04_anm"
if exist "%OUT%\_work_boss04_ecl" rmdir /s /q "%OUT%\_work_boss04_ecl"
mkdir "%OUT%\_work_boss04_ecl"
copy /y "%OUT%\boss04.ecl" "%OUT%\_work_boss04_ecl\boss04.ecl" >nul
cd /d "%OUT%\_work_boss04_ecl"
thecl.exe -d 185 boss04.ecl boss04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss04.ecl"
del /q "%OUT%\_work_boss04_ecl\boss04.ecl"
mkdir "%OUT%\boss04.ecl"
xcopy /e /y /q "%OUT%\_work_boss04_ecl\*" "%OUT%\boss04.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss04_ecl"
if exist "%OUT%\_work_boss05_anm" rmdir /s /q "%OUT%\_work_boss05_anm"
mkdir "%OUT%\_work_boss05_anm"
copy /y "%OUT%\boss05.anm" "%OUT%\_work_boss05_anm\boss05.anm" >nul
cd /d "%OUT%\_work_boss05_anm"
thanm.exe -x 185 boss05.anm
cd /d "%OUT%"
del /q "%OUT%\boss05.anm"
del /q "%OUT%\_work_boss05_anm\boss05.anm"
mkdir "%OUT%\boss05.anm"
xcopy /e /y /q "%OUT%\_work_boss05_anm\*" "%OUT%\boss05.anm\" >nul
rmdir /s /q "%OUT%\_work_boss05_anm"
if exist "%OUT%\_work_boss05_ecl" rmdir /s /q "%OUT%\_work_boss05_ecl"
mkdir "%OUT%\_work_boss05_ecl"
copy /y "%OUT%\boss05.ecl" "%OUT%\_work_boss05_ecl\boss05.ecl" >nul
cd /d "%OUT%\_work_boss05_ecl"
thecl.exe -d 185 boss05.ecl boss05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss05.ecl"
del /q "%OUT%\_work_boss05_ecl\boss05.ecl"
mkdir "%OUT%\boss05.ecl"
xcopy /e /y /q "%OUT%\_work_boss05_ecl\*" "%OUT%\boss05.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss05_ecl"
if exist "%OUT%\_work_boss06_anm" rmdir /s /q "%OUT%\_work_boss06_anm"
mkdir "%OUT%\_work_boss06_anm"
copy /y "%OUT%\boss06.anm" "%OUT%\_work_boss06_anm\boss06.anm" >nul
cd /d "%OUT%\_work_boss06_anm"
thanm.exe -x 185 boss06.anm
cd /d "%OUT%"
del /q "%OUT%\boss06.anm"
del /q "%OUT%\_work_boss06_anm\boss06.anm"
mkdir "%OUT%\boss06.anm"
xcopy /e /y /q "%OUT%\_work_boss06_anm\*" "%OUT%\boss06.anm\" >nul
rmdir /s /q "%OUT%\_work_boss06_anm"
if exist "%OUT%\_work_boss06_ecl" rmdir /s /q "%OUT%\_work_boss06_ecl"
mkdir "%OUT%\_work_boss06_ecl"
copy /y "%OUT%\boss06.ecl" "%OUT%\_work_boss06_ecl\boss06.ecl" >nul
cd /d "%OUT%\_work_boss06_ecl"
thecl.exe -d 185 boss06.ecl boss06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss06.ecl"
del /q "%OUT%\_work_boss06_ecl\boss06.ecl"
mkdir "%OUT%\boss06.ecl"
xcopy /e /y /q "%OUT%\_work_boss06_ecl\*" "%OUT%\boss06.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss06_ecl"
if exist "%OUT%\_work_boss07_anm" rmdir /s /q "%OUT%\_work_boss07_anm"
mkdir "%OUT%\_work_boss07_anm"
copy /y "%OUT%\boss07.anm" "%OUT%\_work_boss07_anm\boss07.anm" >nul
cd /d "%OUT%\_work_boss07_anm"
thanm.exe -x 185 boss07.anm
cd /d "%OUT%"
del /q "%OUT%\boss07.anm"
del /q "%OUT%\_work_boss07_anm\boss07.anm"
mkdir "%OUT%\boss07.anm"
xcopy /e /y /q "%OUT%\_work_boss07_anm\*" "%OUT%\boss07.anm\" >nul
rmdir /s /q "%OUT%\_work_boss07_anm"
if exist "%OUT%\_work_boss07_ecl" rmdir /s /q "%OUT%\_work_boss07_ecl"
mkdir "%OUT%\_work_boss07_ecl"
copy /y "%OUT%\boss07.ecl" "%OUT%\_work_boss07_ecl\boss07.ecl" >nul
cd /d "%OUT%\_work_boss07_ecl"
thecl.exe -d 185 boss07.ecl boss07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss07.ecl"
del /q "%OUT%\_work_boss07_ecl\boss07.ecl"
mkdir "%OUT%\boss07.ecl"
xcopy /e /y /q "%OUT%\_work_boss07_ecl\*" "%OUT%\boss07.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss07_ecl"
if exist "%OUT%\_work_boss08_anm" rmdir /s /q "%OUT%\_work_boss08_anm"
mkdir "%OUT%\_work_boss08_anm"
copy /y "%OUT%\boss08.anm" "%OUT%\_work_boss08_anm\boss08.anm" >nul
cd /d "%OUT%\_work_boss08_anm"
thanm.exe -x 185 boss08.anm
cd /d "%OUT%"
del /q "%OUT%\boss08.anm"
del /q "%OUT%\_work_boss08_anm\boss08.anm"
mkdir "%OUT%\boss08.anm"
xcopy /e /y /q "%OUT%\_work_boss08_anm\*" "%OUT%\boss08.anm\" >nul
rmdir /s /q "%OUT%\_work_boss08_anm"
if exist "%OUT%\_work_boss08_ecl" rmdir /s /q "%OUT%\_work_boss08_ecl"
mkdir "%OUT%\_work_boss08_ecl"
copy /y "%OUT%\boss08.ecl" "%OUT%\_work_boss08_ecl\boss08.ecl" >nul
cd /d "%OUT%\_work_boss08_ecl"
thecl.exe -d 185 boss08.ecl boss08.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss08.ecl"
del /q "%OUT%\_work_boss08_ecl\boss08.ecl"
mkdir "%OUT%\boss08.ecl"
xcopy /e /y /q "%OUT%\_work_boss08_ecl\*" "%OUT%\boss08.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss08_ecl"
if exist "%OUT%\_work_boss09_anm" rmdir /s /q "%OUT%\_work_boss09_anm"
mkdir "%OUT%\_work_boss09_anm"
copy /y "%OUT%\boss09.anm" "%OUT%\_work_boss09_anm\boss09.anm" >nul
cd /d "%OUT%\_work_boss09_anm"
thanm.exe -x 185 boss09.anm
cd /d "%OUT%"
del /q "%OUT%\boss09.anm"
del /q "%OUT%\_work_boss09_anm\boss09.anm"
mkdir "%OUT%\boss09.anm"
xcopy /e /y /q "%OUT%\_work_boss09_anm\*" "%OUT%\boss09.anm\" >nul
rmdir /s /q "%OUT%\_work_boss09_anm"
if exist "%OUT%\_work_boss09_ecl" rmdir /s /q "%OUT%\_work_boss09_ecl"
mkdir "%OUT%\_work_boss09_ecl"
copy /y "%OUT%\boss09.ecl" "%OUT%\_work_boss09_ecl\boss09.ecl" >nul
cd /d "%OUT%\_work_boss09_ecl"
thecl.exe -d 185 boss09.ecl boss09.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss09.ecl"
del /q "%OUT%\_work_boss09_ecl\boss09.ecl"
mkdir "%OUT%\boss09.ecl"
xcopy /e /y /q "%OUT%\_work_boss09_ecl\*" "%OUT%\boss09.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss09_ecl"
if exist "%OUT%\_work_boss10_anm" rmdir /s /q "%OUT%\_work_boss10_anm"
mkdir "%OUT%\_work_boss10_anm"
copy /y "%OUT%\boss10.anm" "%OUT%\_work_boss10_anm\boss10.anm" >nul
cd /d "%OUT%\_work_boss10_anm"
thanm.exe -x 185 boss10.anm
cd /d "%OUT%"
del /q "%OUT%\boss10.anm"
del /q "%OUT%\_work_boss10_anm\boss10.anm"
mkdir "%OUT%\boss10.anm"
xcopy /e /y /q "%OUT%\_work_boss10_anm\*" "%OUT%\boss10.anm\" >nul
rmdir /s /q "%OUT%\_work_boss10_anm"
if exist "%OUT%\_work_boss10_ecl" rmdir /s /q "%OUT%\_work_boss10_ecl"
mkdir "%OUT%\_work_boss10_ecl"
copy /y "%OUT%\boss10.ecl" "%OUT%\_work_boss10_ecl\boss10.ecl" >nul
cd /d "%OUT%\_work_boss10_ecl"
thecl.exe -d 185 boss10.ecl boss10.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss10.ecl"
del /q "%OUT%\_work_boss10_ecl\boss10.ecl"
mkdir "%OUT%\boss10.ecl"
xcopy /e /y /q "%OUT%\_work_boss10_ecl\*" "%OUT%\boss10.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss10_ecl"
if exist "%OUT%\_work_boss11_anm" rmdir /s /q "%OUT%\_work_boss11_anm"
mkdir "%OUT%\_work_boss11_anm"
copy /y "%OUT%\boss11.anm" "%OUT%\_work_boss11_anm\boss11.anm" >nul
cd /d "%OUT%\_work_boss11_anm"
thanm.exe -x 185 boss11.anm
cd /d "%OUT%"
del /q "%OUT%\boss11.anm"
del /q "%OUT%\_work_boss11_anm\boss11.anm"
mkdir "%OUT%\boss11.anm"
xcopy /e /y /q "%OUT%\_work_boss11_anm\*" "%OUT%\boss11.anm\" >nul
rmdir /s /q "%OUT%\_work_boss11_anm"
if exist "%OUT%\_work_boss11_ecl" rmdir /s /q "%OUT%\_work_boss11_ecl"
mkdir "%OUT%\_work_boss11_ecl"
copy /y "%OUT%\boss11.ecl" "%OUT%\_work_boss11_ecl\boss11.ecl" >nul
cd /d "%OUT%\_work_boss11_ecl"
thecl.exe -d 185 boss11.ecl boss11.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss11.ecl"
del /q "%OUT%\_work_boss11_ecl\boss11.ecl"
mkdir "%OUT%\boss11.ecl"
xcopy /e /y /q "%OUT%\_work_boss11_ecl\*" "%OUT%\boss11.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss11_ecl"
if exist "%OUT%\_work_boss12_anm" rmdir /s /q "%OUT%\_work_boss12_anm"
mkdir "%OUT%\_work_boss12_anm"
copy /y "%OUT%\boss12.anm" "%OUT%\_work_boss12_anm\boss12.anm" >nul
cd /d "%OUT%\_work_boss12_anm"
thanm.exe -x 185 boss12.anm
cd /d "%OUT%"
del /q "%OUT%\boss12.anm"
del /q "%OUT%\_work_boss12_anm\boss12.anm"
mkdir "%OUT%\boss12.anm"
xcopy /e /y /q "%OUT%\_work_boss12_anm\*" "%OUT%\boss12.anm\" >nul
rmdir /s /q "%OUT%\_work_boss12_anm"
if exist "%OUT%\_work_boss12_ecl" rmdir /s /q "%OUT%\_work_boss12_ecl"
mkdir "%OUT%\_work_boss12_ecl"
copy /y "%OUT%\boss12.ecl" "%OUT%\_work_boss12_ecl\boss12.ecl" >nul
cd /d "%OUT%\_work_boss12_ecl"
thecl.exe -d 185 boss12.ecl boss12.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss12.ecl"
del /q "%OUT%\_work_boss12_ecl\boss12.ecl"
mkdir "%OUT%\boss12.ecl"
xcopy /e /y /q "%OUT%\_work_boss12_ecl\*" "%OUT%\boss12.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss12_ecl"
if exist "%OUT%\_work_boss13_anm" rmdir /s /q "%OUT%\_work_boss13_anm"
mkdir "%OUT%\_work_boss13_anm"
copy /y "%OUT%\boss13.anm" "%OUT%\_work_boss13_anm\boss13.anm" >nul
cd /d "%OUT%\_work_boss13_anm"
thanm.exe -x 185 boss13.anm
cd /d "%OUT%"
del /q "%OUT%\boss13.anm"
del /q "%OUT%\_work_boss13_anm\boss13.anm"
mkdir "%OUT%\boss13.anm"
xcopy /e /y /q "%OUT%\_work_boss13_anm\*" "%OUT%\boss13.anm\" >nul
rmdir /s /q "%OUT%\_work_boss13_anm"
if exist "%OUT%\_work_boss13_ecl" rmdir /s /q "%OUT%\_work_boss13_ecl"
mkdir "%OUT%\_work_boss13_ecl"
copy /y "%OUT%\boss13.ecl" "%OUT%\_work_boss13_ecl\boss13.ecl" >nul
cd /d "%OUT%\_work_boss13_ecl"
thecl.exe -d 185 boss13.ecl boss13.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss13.ecl"
del /q "%OUT%\_work_boss13_ecl\boss13.ecl"
mkdir "%OUT%\boss13.ecl"
xcopy /e /y /q "%OUT%\_work_boss13_ecl\*" "%OUT%\boss13.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss13_ecl"
if exist "%OUT%\_work_boss14_anm" rmdir /s /q "%OUT%\_work_boss14_anm"
mkdir "%OUT%\_work_boss14_anm"
copy /y "%OUT%\boss14.anm" "%OUT%\_work_boss14_anm\boss14.anm" >nul
cd /d "%OUT%\_work_boss14_anm"
thanm.exe -x 185 boss14.anm
cd /d "%OUT%"
del /q "%OUT%\boss14.anm"
del /q "%OUT%\_work_boss14_anm\boss14.anm"
mkdir "%OUT%\boss14.anm"
xcopy /e /y /q "%OUT%\_work_boss14_anm\*" "%OUT%\boss14.anm\" >nul
rmdir /s /q "%OUT%\_work_boss14_anm"
if exist "%OUT%\_work_boss14_ecl" rmdir /s /q "%OUT%\_work_boss14_ecl"
mkdir "%OUT%\_work_boss14_ecl"
copy /y "%OUT%\boss14.ecl" "%OUT%\_work_boss14_ecl\boss14.ecl" >nul
cd /d "%OUT%\_work_boss14_ecl"
thecl.exe -d 185 boss14.ecl boss14.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss14.ecl"
del /q "%OUT%\_work_boss14_ecl\boss14.ecl"
mkdir "%OUT%\boss14.ecl"
xcopy /e /y /q "%OUT%\_work_boss14_ecl\*" "%OUT%\boss14.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss14_ecl"
if exist "%OUT%\_work_boss15_anm" rmdir /s /q "%OUT%\_work_boss15_anm"
mkdir "%OUT%\_work_boss15_anm"
copy /y "%OUT%\boss15.anm" "%OUT%\_work_boss15_anm\boss15.anm" >nul
cd /d "%OUT%\_work_boss15_anm"
thanm.exe -x 185 boss15.anm
cd /d "%OUT%"
del /q "%OUT%\boss15.anm"
del /q "%OUT%\_work_boss15_anm\boss15.anm"
mkdir "%OUT%\boss15.anm"
xcopy /e /y /q "%OUT%\_work_boss15_anm\*" "%OUT%\boss15.anm\" >nul
rmdir /s /q "%OUT%\_work_boss15_anm"
if exist "%OUT%\_work_boss15_ecl" rmdir /s /q "%OUT%\_work_boss15_ecl"
mkdir "%OUT%\_work_boss15_ecl"
copy /y "%OUT%\boss15.ecl" "%OUT%\_work_boss15_ecl\boss15.ecl" >nul
cd /d "%OUT%\_work_boss15_ecl"
thecl.exe -d 185 boss15.ecl boss15.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss15.ecl"
del /q "%OUT%\_work_boss15_ecl\boss15.ecl"
mkdir "%OUT%\boss15.ecl"
xcopy /e /y /q "%OUT%\_work_boss15_ecl\*" "%OUT%\boss15.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss15_ecl"
if exist "%OUT%\_work_boss16_anm" rmdir /s /q "%OUT%\_work_boss16_anm"
mkdir "%OUT%\_work_boss16_anm"
copy /y "%OUT%\boss16.anm" "%OUT%\_work_boss16_anm\boss16.anm" >nul
cd /d "%OUT%\_work_boss16_anm"
thanm.exe -x 185 boss16.anm
cd /d "%OUT%"
del /q "%OUT%\boss16.anm"
del /q "%OUT%\_work_boss16_anm\boss16.anm"
mkdir "%OUT%\boss16.anm"
xcopy /e /y /q "%OUT%\_work_boss16_anm\*" "%OUT%\boss16.anm\" >nul
rmdir /s /q "%OUT%\_work_boss16_anm"
if exist "%OUT%\_work_boss16_ecl" rmdir /s /q "%OUT%\_work_boss16_ecl"
mkdir "%OUT%\_work_boss16_ecl"
copy /y "%OUT%\boss16.ecl" "%OUT%\_work_boss16_ecl\boss16.ecl" >nul
cd /d "%OUT%\_work_boss16_ecl"
thecl.exe -d 185 boss16.ecl boss16.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss16.ecl"
del /q "%OUT%\_work_boss16_ecl\boss16.ecl"
mkdir "%OUT%\boss16.ecl"
xcopy /e /y /q "%OUT%\_work_boss16_ecl\*" "%OUT%\boss16.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss16_ecl"
if exist "%OUT%\_work_boss17_anm" rmdir /s /q "%OUT%\_work_boss17_anm"
mkdir "%OUT%\_work_boss17_anm"
copy /y "%OUT%\boss17.anm" "%OUT%\_work_boss17_anm\boss17.anm" >nul
cd /d "%OUT%\_work_boss17_anm"
thanm.exe -x 185 boss17.anm
cd /d "%OUT%"
del /q "%OUT%\boss17.anm"
del /q "%OUT%\_work_boss17_anm\boss17.anm"
mkdir "%OUT%\boss17.anm"
xcopy /e /y /q "%OUT%\_work_boss17_anm\*" "%OUT%\boss17.anm\" >nul
rmdir /s /q "%OUT%\_work_boss17_anm"
if exist "%OUT%\_work_boss17_ecl" rmdir /s /q "%OUT%\_work_boss17_ecl"
mkdir "%OUT%\_work_boss17_ecl"
copy /y "%OUT%\boss17.ecl" "%OUT%\_work_boss17_ecl\boss17.ecl" >nul
cd /d "%OUT%\_work_boss17_ecl"
thecl.exe -d 185 boss17.ecl boss17.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss17.ecl"
del /q "%OUT%\_work_boss17_ecl\boss17.ecl"
mkdir "%OUT%\boss17.ecl"
xcopy /e /y /q "%OUT%\_work_boss17_ecl\*" "%OUT%\boss17.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss17_ecl"
if exist "%OUT%\_work_boss18_anm" rmdir /s /q "%OUT%\_work_boss18_anm"
mkdir "%OUT%\_work_boss18_anm"
copy /y "%OUT%\boss18.anm" "%OUT%\_work_boss18_anm\boss18.anm" >nul
cd /d "%OUT%\_work_boss18_anm"
thanm.exe -x 185 boss18.anm
cd /d "%OUT%"
del /q "%OUT%\boss18.anm"
del /q "%OUT%\_work_boss18_anm\boss18.anm"
mkdir "%OUT%\boss18.anm"
xcopy /e /y /q "%OUT%\_work_boss18_anm\*" "%OUT%\boss18.anm\" >nul
rmdir /s /q "%OUT%\_work_boss18_anm"
if exist "%OUT%\_work_boss18_ecl" rmdir /s /q "%OUT%\_work_boss18_ecl"
mkdir "%OUT%\_work_boss18_ecl"
copy /y "%OUT%\boss18.ecl" "%OUT%\_work_boss18_ecl\boss18.ecl" >nul
cd /d "%OUT%\_work_boss18_ecl"
thecl.exe -d 185 boss18.ecl boss18.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss18.ecl"
del /q "%OUT%\_work_boss18_ecl\boss18.ecl"
mkdir "%OUT%\boss18.ecl"
xcopy /e /y /q "%OUT%\_work_boss18_ecl\*" "%OUT%\boss18.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss18_ecl"
if exist "%OUT%\_work_boss19_anm" rmdir /s /q "%OUT%\_work_boss19_anm"
mkdir "%OUT%\_work_boss19_anm"
copy /y "%OUT%\boss19.anm" "%OUT%\_work_boss19_anm\boss19.anm" >nul
cd /d "%OUT%\_work_boss19_anm"
thanm.exe -x 185 boss19.anm
cd /d "%OUT%"
del /q "%OUT%\boss19.anm"
del /q "%OUT%\_work_boss19_anm\boss19.anm"
mkdir "%OUT%\boss19.anm"
xcopy /e /y /q "%OUT%\_work_boss19_anm\*" "%OUT%\boss19.anm\" >nul
rmdir /s /q "%OUT%\_work_boss19_anm"
if exist "%OUT%\_work_boss19_ecl" rmdir /s /q "%OUT%\_work_boss19_ecl"
mkdir "%OUT%\_work_boss19_ecl"
copy /y "%OUT%\boss19.ecl" "%OUT%\_work_boss19_ecl\boss19.ecl" >nul
cd /d "%OUT%\_work_boss19_ecl"
thecl.exe -d 185 boss19.ecl boss19.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss19.ecl"
del /q "%OUT%\_work_boss19_ecl\boss19.ecl"
mkdir "%OUT%\boss19.ecl"
xcopy /e /y /q "%OUT%\_work_boss19_ecl\*" "%OUT%\boss19.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss19_ecl"
if exist "%OUT%\_work_boss20_anm" rmdir /s /q "%OUT%\_work_boss20_anm"
mkdir "%OUT%\_work_boss20_anm"
copy /y "%OUT%\boss20.anm" "%OUT%\_work_boss20_anm\boss20.anm" >nul
cd /d "%OUT%\_work_boss20_anm"
thanm.exe -x 185 boss20.anm
cd /d "%OUT%"
del /q "%OUT%\boss20.anm"
del /q "%OUT%\_work_boss20_anm\boss20.anm"
mkdir "%OUT%\boss20.anm"
xcopy /e /y /q "%OUT%\_work_boss20_anm\*" "%OUT%\boss20.anm\" >nul
rmdir /s /q "%OUT%\_work_boss20_anm"
if exist "%OUT%\_work_boss20_ecl" rmdir /s /q "%OUT%\_work_boss20_ecl"
mkdir "%OUT%\_work_boss20_ecl"
copy /y "%OUT%\boss20.ecl" "%OUT%\_work_boss20_ecl\boss20.ecl" >nul
cd /d "%OUT%\_work_boss20_ecl"
thecl.exe -d 185 boss20.ecl boss20.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss20.ecl"
del /q "%OUT%\_work_boss20_ecl\boss20.ecl"
mkdir "%OUT%\boss20.ecl"
xcopy /e /y /q "%OUT%\_work_boss20_ecl\*" "%OUT%\boss20.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss20_ecl"
if exist "%OUT%\_work_boss21_anm" rmdir /s /q "%OUT%\_work_boss21_anm"
mkdir "%OUT%\_work_boss21_anm"
copy /y "%OUT%\boss21.anm" "%OUT%\_work_boss21_anm\boss21.anm" >nul
cd /d "%OUT%\_work_boss21_anm"
thanm.exe -x 185 boss21.anm
cd /d "%OUT%"
del /q "%OUT%\boss21.anm"
del /q "%OUT%\_work_boss21_anm\boss21.anm"
mkdir "%OUT%\boss21.anm"
xcopy /e /y /q "%OUT%\_work_boss21_anm\*" "%OUT%\boss21.anm\" >nul
rmdir /s /q "%OUT%\_work_boss21_anm"
if exist "%OUT%\_work_boss21_ecl" rmdir /s /q "%OUT%\_work_boss21_ecl"
mkdir "%OUT%\_work_boss21_ecl"
copy /y "%OUT%\boss21.ecl" "%OUT%\_work_boss21_ecl\boss21.ecl" >nul
cd /d "%OUT%\_work_boss21_ecl"
thecl.exe -d 185 boss21.ecl boss21.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss21.ecl"
del /q "%OUT%\_work_boss21_ecl\boss21.ecl"
mkdir "%OUT%\boss21.ecl"
xcopy /e /y /q "%OUT%\_work_boss21_ecl\*" "%OUT%\boss21.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss21_ecl"
if exist "%OUT%\_work_boss22_anm" rmdir /s /q "%OUT%\_work_boss22_anm"
mkdir "%OUT%\_work_boss22_anm"
copy /y "%OUT%\boss22.anm" "%OUT%\_work_boss22_anm\boss22.anm" >nul
cd /d "%OUT%\_work_boss22_anm"
thanm.exe -x 185 boss22.anm
cd /d "%OUT%"
del /q "%OUT%\boss22.anm"
del /q "%OUT%\_work_boss22_anm\boss22.anm"
mkdir "%OUT%\boss22.anm"
xcopy /e /y /q "%OUT%\_work_boss22_anm\*" "%OUT%\boss22.anm\" >nul
rmdir /s /q "%OUT%\_work_boss22_anm"
if exist "%OUT%\_work_boss22_ecl" rmdir /s /q "%OUT%\_work_boss22_ecl"
mkdir "%OUT%\_work_boss22_ecl"
copy /y "%OUT%\boss22.ecl" "%OUT%\_work_boss22_ecl\boss22.ecl" >nul
cd /d "%OUT%\_work_boss22_ecl"
thecl.exe -d 185 boss22.ecl boss22.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss22.ecl"
del /q "%OUT%\_work_boss22_ecl\boss22.ecl"
mkdir "%OUT%\boss22.ecl"
xcopy /e /y /q "%OUT%\_work_boss22_ecl\*" "%OUT%\boss22.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss22_ecl"
if exist "%OUT%\_work_boss23_anm" rmdir /s /q "%OUT%\_work_boss23_anm"
mkdir "%OUT%\_work_boss23_anm"
copy /y "%OUT%\boss23.anm" "%OUT%\_work_boss23_anm\boss23.anm" >nul
cd /d "%OUT%\_work_boss23_anm"
thanm.exe -x 185 boss23.anm
cd /d "%OUT%"
del /q "%OUT%\boss23.anm"
del /q "%OUT%\_work_boss23_anm\boss23.anm"
mkdir "%OUT%\boss23.anm"
xcopy /e /y /q "%OUT%\_work_boss23_anm\*" "%OUT%\boss23.anm\" >nul
rmdir /s /q "%OUT%\_work_boss23_anm"
if exist "%OUT%\_work_boss23_ecl" rmdir /s /q "%OUT%\_work_boss23_ecl"
mkdir "%OUT%\_work_boss23_ecl"
copy /y "%OUT%\boss23.ecl" "%OUT%\_work_boss23_ecl\boss23.ecl" >nul
cd /d "%OUT%\_work_boss23_ecl"
thecl.exe -d 185 boss23.ecl boss23.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss23.ecl"
del /q "%OUT%\_work_boss23_ecl\boss23.ecl"
mkdir "%OUT%\boss23.ecl"
xcopy /e /y /q "%OUT%\_work_boss23_ecl\*" "%OUT%\boss23.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss23_ecl"
if exist "%OUT%\_work_boss24_anm" rmdir /s /q "%OUT%\_work_boss24_anm"
mkdir "%OUT%\_work_boss24_anm"
copy /y "%OUT%\boss24.anm" "%OUT%\_work_boss24_anm\boss24.anm" >nul
cd /d "%OUT%\_work_boss24_anm"
thanm.exe -x 185 boss24.anm
cd /d "%OUT%"
del /q "%OUT%\boss24.anm"
del /q "%OUT%\_work_boss24_anm\boss24.anm"
mkdir "%OUT%\boss24.anm"
xcopy /e /y /q "%OUT%\_work_boss24_anm\*" "%OUT%\boss24.anm\" >nul
rmdir /s /q "%OUT%\_work_boss24_anm"
if exist "%OUT%\_work_boss24_ecl" rmdir /s /q "%OUT%\_work_boss24_ecl"
mkdir "%OUT%\_work_boss24_ecl"
copy /y "%OUT%\boss24.ecl" "%OUT%\_work_boss24_ecl\boss24.ecl" >nul
cd /d "%OUT%\_work_boss24_ecl"
thecl.exe -d 185 boss24.ecl boss24.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss24.ecl"
del /q "%OUT%\_work_boss24_ecl\boss24.ecl"
mkdir "%OUT%\boss24.ecl"
xcopy /e /y /q "%OUT%\_work_boss24_ecl\*" "%OUT%\boss24.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss24_ecl"
if exist "%OUT%\_work_boss25_anm" rmdir /s /q "%OUT%\_work_boss25_anm"
mkdir "%OUT%\_work_boss25_anm"
copy /y "%OUT%\boss25.anm" "%OUT%\_work_boss25_anm\boss25.anm" >nul
cd /d "%OUT%\_work_boss25_anm"
thanm.exe -x 185 boss25.anm
cd /d "%OUT%"
del /q "%OUT%\boss25.anm"
del /q "%OUT%\_work_boss25_anm\boss25.anm"
mkdir "%OUT%\boss25.anm"
xcopy /e /y /q "%OUT%\_work_boss25_anm\*" "%OUT%\boss25.anm\" >nul
rmdir /s /q "%OUT%\_work_boss25_anm"
if exist "%OUT%\_work_boss25_ecl" rmdir /s /q "%OUT%\_work_boss25_ecl"
mkdir "%OUT%\_work_boss25_ecl"
copy /y "%OUT%\boss25.ecl" "%OUT%\_work_boss25_ecl\boss25.ecl" >nul
cd /d "%OUT%\_work_boss25_ecl"
thecl.exe -d 185 boss25.ecl boss25.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss25.ecl"
del /q "%OUT%\_work_boss25_ecl\boss25.ecl"
mkdir "%OUT%\boss25.ecl"
xcopy /e /y /q "%OUT%\_work_boss25_ecl\*" "%OUT%\boss25.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss25_ecl"
if exist "%OUT%\_work_boss26_anm" rmdir /s /q "%OUT%\_work_boss26_anm"
mkdir "%OUT%\_work_boss26_anm"
copy /y "%OUT%\boss26.anm" "%OUT%\_work_boss26_anm\boss26.anm" >nul
cd /d "%OUT%\_work_boss26_anm"
thanm.exe -x 185 boss26.anm
cd /d "%OUT%"
del /q "%OUT%\boss26.anm"
del /q "%OUT%\_work_boss26_anm\boss26.anm"
mkdir "%OUT%\boss26.anm"
xcopy /e /y /q "%OUT%\_work_boss26_anm\*" "%OUT%\boss26.anm\" >nul
rmdir /s /q "%OUT%\_work_boss26_anm"
if exist "%OUT%\_work_boss26_ecl" rmdir /s /q "%OUT%\_work_boss26_ecl"
mkdir "%OUT%\_work_boss26_ecl"
copy /y "%OUT%\boss26.ecl" "%OUT%\_work_boss26_ecl\boss26.ecl" >nul
cd /d "%OUT%\_work_boss26_ecl"
thecl.exe -d 185 boss26.ecl boss26.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss26.ecl"
del /q "%OUT%\_work_boss26_ecl\boss26.ecl"
mkdir "%OUT%\boss26.ecl"
xcopy /e /y /q "%OUT%\_work_boss26_ecl\*" "%OUT%\boss26.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss26_ecl"
if exist "%OUT%\_work_boss27_anm" rmdir /s /q "%OUT%\_work_boss27_anm"
mkdir "%OUT%\_work_boss27_anm"
copy /y "%OUT%\boss27.anm" "%OUT%\_work_boss27_anm\boss27.anm" >nul
cd /d "%OUT%\_work_boss27_anm"
thanm.exe -x 185 boss27.anm
cd /d "%OUT%"
del /q "%OUT%\boss27.anm"
del /q "%OUT%\_work_boss27_anm\boss27.anm"
mkdir "%OUT%\boss27.anm"
xcopy /e /y /q "%OUT%\_work_boss27_anm\*" "%OUT%\boss27.anm\" >nul
rmdir /s /q "%OUT%\_work_boss27_anm"
if exist "%OUT%\_work_boss27_ecl" rmdir /s /q "%OUT%\_work_boss27_ecl"
mkdir "%OUT%\_work_boss27_ecl"
copy /y "%OUT%\boss27.ecl" "%OUT%\_work_boss27_ecl\boss27.ecl" >nul
cd /d "%OUT%\_work_boss27_ecl"
thecl.exe -d 185 boss27.ecl boss27.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\boss27.ecl"
del /q "%OUT%\_work_boss27_ecl\boss27.ecl"
mkdir "%OUT%\boss27.ecl"
xcopy /e /y /q "%OUT%\_work_boss27_ecl\*" "%OUT%\boss27.ecl\" >nul
rmdir /s /q "%OUT%\_work_boss27_ecl"
if exist "%OUT%\_work_bullet_anm" rmdir /s /q "%OUT%\_work_bullet_anm"
mkdir "%OUT%\_work_bullet_anm"
copy /y "%OUT%\bullet.anm" "%OUT%\_work_bullet_anm\bullet.anm" >nul
cd /d "%OUT%\_work_bullet_anm"
thanm.exe -x 185 bullet.anm
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
thecl.exe -d 185 default.ecl default.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\default.ecl"
del /q "%OUT%\_work_default_ecl\default.ecl"
mkdir "%OUT%\default.ecl"
xcopy /e /y /q "%OUT%\_work_default_ecl\*" "%OUT%\default.ecl\" >nul
rmdir /s /q "%OUT%\_work_default_ecl"
if exist "%OUT%\_work_effect_anm" rmdir /s /q "%OUT%\_work_effect_anm"
mkdir "%OUT%\_work_effect_anm"
copy /y "%OUT%\effect.anm" "%OUT%\_work_effect_anm\effect.anm" >nul
cd /d "%OUT%\_work_effect_anm"
thanm.exe -x 185 effect.anm
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
thanm.exe -x 185 enemy.anm
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
thanm.exe -x 185 front.anm
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
thanm.exe -x 185 help.anm
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
thanm.exe -x 185 notice.anm
cd /d "%OUT%"
del /q "%OUT%\notice.anm"
del /q "%OUT%\_work_notice_anm\notice.anm"
mkdir "%OUT%\notice.anm"
xcopy /e /y /q "%OUT%\_work_notice_anm\*" "%OUT%\notice.anm\" >nul
rmdir /s /q "%OUT%\_work_notice_anm"
if exist "%OUT%\_work_pl01_anm" rmdir /s /q "%OUT%\_work_pl01_anm"
mkdir "%OUT%\_work_pl01_anm"
copy /y "%OUT%\pl01.anm" "%OUT%\_work_pl01_anm\pl01.anm" >nul
cd /d "%OUT%\_work_pl01_anm"
thanm.exe -x 185 pl01.anm
cd /d "%OUT%"
del /q "%OUT%\pl01.anm"
del /q "%OUT%\_work_pl01_anm\pl01.anm"
mkdir "%OUT%\pl01.anm"
xcopy /e /y /q "%OUT%\_work_pl01_anm\*" "%OUT%\pl01.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01_anm"
if exist "%OUT%\_work_sig_anm" rmdir /s /q "%OUT%\_work_sig_anm"
mkdir "%OUT%\_work_sig_anm"
copy /y "%OUT%\sig.anm" "%OUT%\_work_sig_anm\sig.anm" >nul
cd /d "%OUT%\_work_sig_anm"
thanm.exe -x 185 sig.anm
cd /d "%OUT%"
del /q "%OUT%\sig.anm"
del /q "%OUT%\_work_sig_anm\sig.anm"
mkdir "%OUT%\sig.anm"
xcopy /e /y /q "%OUT%\_work_sig_anm\*" "%OUT%\sig.anm\" >nul
rmdir /s /q "%OUT%\_work_sig_anm"
if exist "%OUT%\_work_title_anm" rmdir /s /q "%OUT%\_work_title_anm"
mkdir "%OUT%\_work_title_anm"
copy /y "%OUT%\title.anm" "%OUT%\_work_title_anm\title.anm" >nul
cd /d "%OUT%\_work_title_anm"
thanm.exe -x 185 title.anm
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
thanm.exe -x 185 title_v.anm
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
thanm.exe -x 185 trophy.anm
cd /d "%OUT%"
del /q "%OUT%\trophy.anm"
del /q "%OUT%\_work_trophy_anm\trophy.anm"
mkdir "%OUT%\trophy.anm"
xcopy /e /y /q "%OUT%\_work_trophy_anm\*" "%OUT%\trophy.anm\" >nul
rmdir /s /q "%OUT%\_work_trophy_anm"
if exist "%OUT%\_work_turtrial_msg" rmdir /s /q "%OUT%\_work_turtrial_msg"
mkdir "%OUT%\_work_turtrial_msg"
copy /y "%OUT%\turtrial.msg" "%OUT%\_work_turtrial_msg\turtrial.msg" >nul
cd /d "%OUT%\_work_turtrial_msg"
thmsg.exe -d 185 turtrial.msg turtrial.txt
cd /d "%OUT%"
del /q "%OUT%\turtrial.msg"
del /q "%OUT%\_work_turtrial_msg\turtrial.msg"
mkdir "%OUT%\turtrial.msg"
xcopy /e /y /q "%OUT%\_work_turtrial_msg\*" "%OUT%\turtrial.msg\" >nul
rmdir /s /q "%OUT%\_work_turtrial_msg"
if exist "%OUT%\_work_wave01_ecl" rmdir /s /q "%OUT%\_work_wave01_ecl"
mkdir "%OUT%\_work_wave01_ecl"
copy /y "%OUT%\wave01.ecl" "%OUT%\_work_wave01_ecl\wave01.ecl" >nul
cd /d "%OUT%\_work_wave01_ecl"
thecl.exe -d 185 wave01.ecl wave01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave01.ecl"
del /q "%OUT%\_work_wave01_ecl\wave01.ecl"
mkdir "%OUT%\wave01.ecl"
xcopy /e /y /q "%OUT%\_work_wave01_ecl\*" "%OUT%\wave01.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave01_ecl"
if exist "%OUT%\_work_wave01t_ecl" rmdir /s /q "%OUT%\_work_wave01t_ecl"
mkdir "%OUT%\_work_wave01t_ecl"
copy /y "%OUT%\wave01t.ecl" "%OUT%\_work_wave01t_ecl\wave01t.ecl" >nul
cd /d "%OUT%\_work_wave01t_ecl"
thecl.exe -d 185 wave01t.ecl wave01t.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave01t.ecl"
del /q "%OUT%\_work_wave01t_ecl\wave01t.ecl"
mkdir "%OUT%\wave01t.ecl"
xcopy /e /y /q "%OUT%\_work_wave01t_ecl\*" "%OUT%\wave01t.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave01t_ecl"
if exist "%OUT%\_work_wave02_ecl" rmdir /s /q "%OUT%\_work_wave02_ecl"
mkdir "%OUT%\_work_wave02_ecl"
copy /y "%OUT%\wave02.ecl" "%OUT%\_work_wave02_ecl\wave02.ecl" >nul
cd /d "%OUT%\_work_wave02_ecl"
thecl.exe -d 185 wave02.ecl wave02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave02.ecl"
del /q "%OUT%\_work_wave02_ecl\wave02.ecl"
mkdir "%OUT%\wave02.ecl"
xcopy /e /y /q "%OUT%\_work_wave02_ecl\*" "%OUT%\wave02.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave02_ecl"
if exist "%OUT%\_work_wave02t_ecl" rmdir /s /q "%OUT%\_work_wave02t_ecl"
mkdir "%OUT%\_work_wave02t_ecl"
copy /y "%OUT%\wave02t.ecl" "%OUT%\_work_wave02t_ecl\wave02t.ecl" >nul
cd /d "%OUT%\_work_wave02t_ecl"
thecl.exe -d 185 wave02t.ecl wave02t.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave02t.ecl"
del /q "%OUT%\_work_wave02t_ecl\wave02t.ecl"
mkdir "%OUT%\wave02t.ecl"
xcopy /e /y /q "%OUT%\_work_wave02t_ecl\*" "%OUT%\wave02t.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave02t_ecl"
if exist "%OUT%\_work_wave03_ecl" rmdir /s /q "%OUT%\_work_wave03_ecl"
mkdir "%OUT%\_work_wave03_ecl"
copy /y "%OUT%\wave03.ecl" "%OUT%\_work_wave03_ecl\wave03.ecl" >nul
cd /d "%OUT%\_work_wave03_ecl"
thecl.exe -d 185 wave03.ecl wave03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave03.ecl"
del /q "%OUT%\_work_wave03_ecl\wave03.ecl"
mkdir "%OUT%\wave03.ecl"
xcopy /e /y /q "%OUT%\_work_wave03_ecl\*" "%OUT%\wave03.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave03_ecl"
if exist "%OUT%\_work_wave03t_ecl" rmdir /s /q "%OUT%\_work_wave03t_ecl"
mkdir "%OUT%\_work_wave03t_ecl"
copy /y "%OUT%\wave03t.ecl" "%OUT%\_work_wave03t_ecl\wave03t.ecl" >nul
cd /d "%OUT%\_work_wave03t_ecl"
thecl.exe -d 185 wave03t.ecl wave03t.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave03t.ecl"
del /q "%OUT%\_work_wave03t_ecl\wave03t.ecl"
mkdir "%OUT%\wave03t.ecl"
xcopy /e /y /q "%OUT%\_work_wave03t_ecl\*" "%OUT%\wave03t.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave03t_ecl"
if exist "%OUT%\_work_wave04_ecl" rmdir /s /q "%OUT%\_work_wave04_ecl"
mkdir "%OUT%\_work_wave04_ecl"
copy /y "%OUT%\wave04.ecl" "%OUT%\_work_wave04_ecl\wave04.ecl" >nul
cd /d "%OUT%\_work_wave04_ecl"
thecl.exe -d 185 wave04.ecl wave04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave04.ecl"
del /q "%OUT%\_work_wave04_ecl\wave04.ecl"
mkdir "%OUT%\wave04.ecl"
xcopy /e /y /q "%OUT%\_work_wave04_ecl\*" "%OUT%\wave04.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave04_ecl"
if exist "%OUT%\_work_wave05_ecl" rmdir /s /q "%OUT%\_work_wave05_ecl"
mkdir "%OUT%\_work_wave05_ecl"
copy /y "%OUT%\wave05.ecl" "%OUT%\_work_wave05_ecl\wave05.ecl" >nul
cd /d "%OUT%\_work_wave05_ecl"
thecl.exe -d 185 wave05.ecl wave05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave05.ecl"
del /q "%OUT%\_work_wave05_ecl\wave05.ecl"
mkdir "%OUT%\wave05.ecl"
xcopy /e /y /q "%OUT%\_work_wave05_ecl\*" "%OUT%\wave05.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave05_ecl"
if exist "%OUT%\_work_wave06_ecl" rmdir /s /q "%OUT%\_work_wave06_ecl"
mkdir "%OUT%\_work_wave06_ecl"
copy /y "%OUT%\wave06.ecl" "%OUT%\_work_wave06_ecl\wave06.ecl" >nul
cd /d "%OUT%\_work_wave06_ecl"
thecl.exe -d 185 wave06.ecl wave06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave06.ecl"
del /q "%OUT%\_work_wave06_ecl\wave06.ecl"
mkdir "%OUT%\wave06.ecl"
xcopy /e /y /q "%OUT%\_work_wave06_ecl\*" "%OUT%\wave06.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave06_ecl"
if exist "%OUT%\_work_wave07_ecl" rmdir /s /q "%OUT%\_work_wave07_ecl"
mkdir "%OUT%\_work_wave07_ecl"
copy /y "%OUT%\wave07.ecl" "%OUT%\_work_wave07_ecl\wave07.ecl" >nul
cd /d "%OUT%\_work_wave07_ecl"
thecl.exe -d 185 wave07.ecl wave07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave07.ecl"
del /q "%OUT%\_work_wave07_ecl\wave07.ecl"
mkdir "%OUT%\wave07.ecl"
xcopy /e /y /q "%OUT%\_work_wave07_ecl\*" "%OUT%\wave07.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave07_ecl"
if exist "%OUT%\_work_wave08_ecl" rmdir /s /q "%OUT%\_work_wave08_ecl"
mkdir "%OUT%\_work_wave08_ecl"
copy /y "%OUT%\wave08.ecl" "%OUT%\_work_wave08_ecl\wave08.ecl" >nul
cd /d "%OUT%\_work_wave08_ecl"
thecl.exe -d 185 wave08.ecl wave08.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave08.ecl"
del /q "%OUT%\_work_wave08_ecl\wave08.ecl"
mkdir "%OUT%\wave08.ecl"
xcopy /e /y /q "%OUT%\_work_wave08_ecl\*" "%OUT%\wave08.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave08_ecl"
if exist "%OUT%\_work_wave09_ecl" rmdir /s /q "%OUT%\_work_wave09_ecl"
mkdir "%OUT%\_work_wave09_ecl"
copy /y "%OUT%\wave09.ecl" "%OUT%\_work_wave09_ecl\wave09.ecl" >nul
cd /d "%OUT%\_work_wave09_ecl"
thecl.exe -d 185 wave09.ecl wave09.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave09.ecl"
del /q "%OUT%\_work_wave09_ecl\wave09.ecl"
mkdir "%OUT%\wave09.ecl"
xcopy /e /y /q "%OUT%\_work_wave09_ecl\*" "%OUT%\wave09.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave09_ecl"
if exist "%OUT%\_work_wave10_ecl" rmdir /s /q "%OUT%\_work_wave10_ecl"
mkdir "%OUT%\_work_wave10_ecl"
copy /y "%OUT%\wave10.ecl" "%OUT%\_work_wave10_ecl\wave10.ecl" >nul
cd /d "%OUT%\_work_wave10_ecl"
thecl.exe -d 185 wave10.ecl wave10.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave10.ecl"
del /q "%OUT%\_work_wave10_ecl\wave10.ecl"
mkdir "%OUT%\wave10.ecl"
xcopy /e /y /q "%OUT%\_work_wave10_ecl\*" "%OUT%\wave10.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave10_ecl"
if exist "%OUT%\_work_wave11_ecl" rmdir /s /q "%OUT%\_work_wave11_ecl"
mkdir "%OUT%\_work_wave11_ecl"
copy /y "%OUT%\wave11.ecl" "%OUT%\_work_wave11_ecl\wave11.ecl" >nul
cd /d "%OUT%\_work_wave11_ecl"
thecl.exe -d 185 wave11.ecl wave11.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave11.ecl"
del /q "%OUT%\_work_wave11_ecl\wave11.ecl"
mkdir "%OUT%\wave11.ecl"
xcopy /e /y /q "%OUT%\_work_wave11_ecl\*" "%OUT%\wave11.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave11_ecl"
if exist "%OUT%\_work_wave12_ecl" rmdir /s /q "%OUT%\_work_wave12_ecl"
mkdir "%OUT%\_work_wave12_ecl"
copy /y "%OUT%\wave12.ecl" "%OUT%\_work_wave12_ecl\wave12.ecl" >nul
cd /d "%OUT%\_work_wave12_ecl"
thecl.exe -d 185 wave12.ecl wave12.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave12.ecl"
del /q "%OUT%\_work_wave12_ecl\wave12.ecl"
mkdir "%OUT%\wave12.ecl"
xcopy /e /y /q "%OUT%\_work_wave12_ecl\*" "%OUT%\wave12.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave12_ecl"
if exist "%OUT%\_work_wave13_ecl" rmdir /s /q "%OUT%\_work_wave13_ecl"
mkdir "%OUT%\_work_wave13_ecl"
copy /y "%OUT%\wave13.ecl" "%OUT%\_work_wave13_ecl\wave13.ecl" >nul
cd /d "%OUT%\_work_wave13_ecl"
thecl.exe -d 185 wave13.ecl wave13.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave13.ecl"
del /q "%OUT%\_work_wave13_ecl\wave13.ecl"
mkdir "%OUT%\wave13.ecl"
xcopy /e /y /q "%OUT%\_work_wave13_ecl\*" "%OUT%\wave13.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave13_ecl"
if exist "%OUT%\_work_wave14_ecl" rmdir /s /q "%OUT%\_work_wave14_ecl"
mkdir "%OUT%\_work_wave14_ecl"
copy /y "%OUT%\wave14.ecl" "%OUT%\_work_wave14_ecl\wave14.ecl" >nul
cd /d "%OUT%\_work_wave14_ecl"
thecl.exe -d 185 wave14.ecl wave14.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave14.ecl"
del /q "%OUT%\_work_wave14_ecl\wave14.ecl"
mkdir "%OUT%\wave14.ecl"
xcopy /e /y /q "%OUT%\_work_wave14_ecl\*" "%OUT%\wave14.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave14_ecl"
if exist "%OUT%\_work_wave15_ecl" rmdir /s /q "%OUT%\_work_wave15_ecl"
mkdir "%OUT%\_work_wave15_ecl"
copy /y "%OUT%\wave15.ecl" "%OUT%\_work_wave15_ecl\wave15.ecl" >nul
cd /d "%OUT%\_work_wave15_ecl"
thecl.exe -d 185 wave15.ecl wave15.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave15.ecl"
del /q "%OUT%\_work_wave15_ecl\wave15.ecl"
mkdir "%OUT%\wave15.ecl"
xcopy /e /y /q "%OUT%\_work_wave15_ecl\*" "%OUT%\wave15.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave15_ecl"
if exist "%OUT%\_work_wave16_ecl" rmdir /s /q "%OUT%\_work_wave16_ecl"
mkdir "%OUT%\_work_wave16_ecl"
copy /y "%OUT%\wave16.ecl" "%OUT%\_work_wave16_ecl\wave16.ecl" >nul
cd /d "%OUT%\_work_wave16_ecl"
thecl.exe -d 185 wave16.ecl wave16.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave16.ecl"
del /q "%OUT%\_work_wave16_ecl\wave16.ecl"
mkdir "%OUT%\wave16.ecl"
xcopy /e /y /q "%OUT%\_work_wave16_ecl\*" "%OUT%\wave16.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave16_ecl"
if exist "%OUT%\_work_wave17_ecl" rmdir /s /q "%OUT%\_work_wave17_ecl"
mkdir "%OUT%\_work_wave17_ecl"
copy /y "%OUT%\wave17.ecl" "%OUT%\_work_wave17_ecl\wave17.ecl" >nul
cd /d "%OUT%\_work_wave17_ecl"
thecl.exe -d 185 wave17.ecl wave17.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave17.ecl"
del /q "%OUT%\_work_wave17_ecl\wave17.ecl"
mkdir "%OUT%\wave17.ecl"
xcopy /e /y /q "%OUT%\_work_wave17_ecl\*" "%OUT%\wave17.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave17_ecl"
if exist "%OUT%\_work_wave18_ecl" rmdir /s /q "%OUT%\_work_wave18_ecl"
mkdir "%OUT%\_work_wave18_ecl"
copy /y "%OUT%\wave18.ecl" "%OUT%\_work_wave18_ecl\wave18.ecl" >nul
cd /d "%OUT%\_work_wave18_ecl"
thecl.exe -d 185 wave18.ecl wave18.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave18.ecl"
del /q "%OUT%\_work_wave18_ecl\wave18.ecl"
mkdir "%OUT%\wave18.ecl"
xcopy /e /y /q "%OUT%\_work_wave18_ecl\*" "%OUT%\wave18.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave18_ecl"
if exist "%OUT%\_work_wave19_ecl" rmdir /s /q "%OUT%\_work_wave19_ecl"
mkdir "%OUT%\_work_wave19_ecl"
copy /y "%OUT%\wave19.ecl" "%OUT%\_work_wave19_ecl\wave19.ecl" >nul
cd /d "%OUT%\_work_wave19_ecl"
thecl.exe -d 185 wave19.ecl wave19.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave19.ecl"
del /q "%OUT%\_work_wave19_ecl\wave19.ecl"
mkdir "%OUT%\wave19.ecl"
xcopy /e /y /q "%OUT%\_work_wave19_ecl\*" "%OUT%\wave19.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave19_ecl"
if exist "%OUT%\_work_wave20_ecl" rmdir /s /q "%OUT%\_work_wave20_ecl"
mkdir "%OUT%\_work_wave20_ecl"
copy /y "%OUT%\wave20.ecl" "%OUT%\_work_wave20_ecl\wave20.ecl" >nul
cd /d "%OUT%\_work_wave20_ecl"
thecl.exe -d 185 wave20.ecl wave20.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave20.ecl"
del /q "%OUT%\_work_wave20_ecl\wave20.ecl"
mkdir "%OUT%\wave20.ecl"
xcopy /e /y /q "%OUT%\_work_wave20_ecl\*" "%OUT%\wave20.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave20_ecl"
if exist "%OUT%\_work_wave21_ecl" rmdir /s /q "%OUT%\_work_wave21_ecl"
mkdir "%OUT%\_work_wave21_ecl"
copy /y "%OUT%\wave21.ecl" "%OUT%\_work_wave21_ecl\wave21.ecl" >nul
cd /d "%OUT%\_work_wave21_ecl"
thecl.exe -d 185 wave21.ecl wave21.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave21.ecl"
del /q "%OUT%\_work_wave21_ecl\wave21.ecl"
mkdir "%OUT%\wave21.ecl"
xcopy /e /y /q "%OUT%\_work_wave21_ecl\*" "%OUT%\wave21.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave21_ecl"
if exist "%OUT%\_work_wave22_ecl" rmdir /s /q "%OUT%\_work_wave22_ecl"
mkdir "%OUT%\_work_wave22_ecl"
copy /y "%OUT%\wave22.ecl" "%OUT%\_work_wave22_ecl\wave22.ecl" >nul
cd /d "%OUT%\_work_wave22_ecl"
thecl.exe -d 185 wave22.ecl wave22.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave22.ecl"
del /q "%OUT%\_work_wave22_ecl\wave22.ecl"
mkdir "%OUT%\wave22.ecl"
xcopy /e /y /q "%OUT%\_work_wave22_ecl\*" "%OUT%\wave22.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave22_ecl"
if exist "%OUT%\_work_wave23_ecl" rmdir /s /q "%OUT%\_work_wave23_ecl"
mkdir "%OUT%\_work_wave23_ecl"
copy /y "%OUT%\wave23.ecl" "%OUT%\_work_wave23_ecl\wave23.ecl" >nul
cd /d "%OUT%\_work_wave23_ecl"
thecl.exe -d 185 wave23.ecl wave23.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave23.ecl"
del /q "%OUT%\_work_wave23_ecl\wave23.ecl"
mkdir "%OUT%\wave23.ecl"
xcopy /e /y /q "%OUT%\_work_wave23_ecl\*" "%OUT%\wave23.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave23_ecl"
if exist "%OUT%\_work_wave24_ecl" rmdir /s /q "%OUT%\_work_wave24_ecl"
mkdir "%OUT%\_work_wave24_ecl"
copy /y "%OUT%\wave24.ecl" "%OUT%\_work_wave24_ecl\wave24.ecl" >nul
cd /d "%OUT%\_work_wave24_ecl"
thecl.exe -d 185 wave24.ecl wave24.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave24.ecl"
del /q "%OUT%\_work_wave24_ecl\wave24.ecl"
mkdir "%OUT%\wave24.ecl"
xcopy /e /y /q "%OUT%\_work_wave24_ecl\*" "%OUT%\wave24.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave24_ecl"
if exist "%OUT%\_work_wave25_ecl" rmdir /s /q "%OUT%\_work_wave25_ecl"
mkdir "%OUT%\_work_wave25_ecl"
copy /y "%OUT%\wave25.ecl" "%OUT%\_work_wave25_ecl\wave25.ecl" >nul
cd /d "%OUT%\_work_wave25_ecl"
thecl.exe -d 185 wave25.ecl wave25.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave25.ecl"
del /q "%OUT%\_work_wave25_ecl\wave25.ecl"
mkdir "%OUT%\wave25.ecl"
xcopy /e /y /q "%OUT%\_work_wave25_ecl\*" "%OUT%\wave25.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave25_ecl"
if exist "%OUT%\_work_wave26_ecl" rmdir /s /q "%OUT%\_work_wave26_ecl"
mkdir "%OUT%\_work_wave26_ecl"
copy /y "%OUT%\wave26.ecl" "%OUT%\_work_wave26_ecl\wave26.ecl" >nul
cd /d "%OUT%\_work_wave26_ecl"
thecl.exe -d 185 wave26.ecl wave26.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave26.ecl"
del /q "%OUT%\_work_wave26_ecl\wave26.ecl"
mkdir "%OUT%\wave26.ecl"
xcopy /e /y /q "%OUT%\_work_wave26_ecl\*" "%OUT%\wave26.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave26_ecl"
if exist "%OUT%\_work_wave27_ecl" rmdir /s /q "%OUT%\_work_wave27_ecl"
mkdir "%OUT%\_work_wave27_ecl"
copy /y "%OUT%\wave27.ecl" "%OUT%\_work_wave27_ecl\wave27.ecl" >nul
cd /d "%OUT%\_work_wave27_ecl"
thecl.exe -d 185 wave27.ecl wave27.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave27.ecl"
del /q "%OUT%\_work_wave27_ecl\wave27.ecl"
mkdir "%OUT%\wave27.ecl"
xcopy /e /y /q "%OUT%\_work_wave27_ecl\*" "%OUT%\wave27.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave27_ecl"
if exist "%OUT%\_work_wave28_ecl" rmdir /s /q "%OUT%\_work_wave28_ecl"
mkdir "%OUT%\_work_wave28_ecl"
copy /y "%OUT%\wave28.ecl" "%OUT%\_work_wave28_ecl\wave28.ecl" >nul
cd /d "%OUT%\_work_wave28_ecl"
thecl.exe -d 185 wave28.ecl wave28.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave28.ecl"
del /q "%OUT%\_work_wave28_ecl\wave28.ecl"
mkdir "%OUT%\wave28.ecl"
xcopy /e /y /q "%OUT%\_work_wave28_ecl\*" "%OUT%\wave28.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave28_ecl"
if exist "%OUT%\_work_wave29_ecl" rmdir /s /q "%OUT%\_work_wave29_ecl"
mkdir "%OUT%\_work_wave29_ecl"
copy /y "%OUT%\wave29.ecl" "%OUT%\_work_wave29_ecl\wave29.ecl" >nul
cd /d "%OUT%\_work_wave29_ecl"
thecl.exe -d 185 wave29.ecl wave29.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave29.ecl"
del /q "%OUT%\_work_wave29_ecl\wave29.ecl"
mkdir "%OUT%\wave29.ecl"
xcopy /e /y /q "%OUT%\_work_wave29_ecl\*" "%OUT%\wave29.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave29_ecl"
if exist "%OUT%\_work_wave30_ecl" rmdir /s /q "%OUT%\_work_wave30_ecl"
mkdir "%OUT%\_work_wave30_ecl"
copy /y "%OUT%\wave30.ecl" "%OUT%\_work_wave30_ecl\wave30.ecl" >nul
cd /d "%OUT%\_work_wave30_ecl"
thecl.exe -d 185 wave30.ecl wave30.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave30.ecl"
del /q "%OUT%\_work_wave30_ecl\wave30.ecl"
mkdir "%OUT%\wave30.ecl"
xcopy /e /y /q "%OUT%\_work_wave30_ecl\*" "%OUT%\wave30.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave30_ecl"
if exist "%OUT%\_work_wave31_ecl" rmdir /s /q "%OUT%\_work_wave31_ecl"
mkdir "%OUT%\_work_wave31_ecl"
copy /y "%OUT%\wave31.ecl" "%OUT%\_work_wave31_ecl\wave31.ecl" >nul
cd /d "%OUT%\_work_wave31_ecl"
thecl.exe -d 185 wave31.ecl wave31.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave31.ecl"
del /q "%OUT%\_work_wave31_ecl\wave31.ecl"
mkdir "%OUT%\wave31.ecl"
xcopy /e /y /q "%OUT%\_work_wave31_ecl\*" "%OUT%\wave31.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave31_ecl"
if exist "%OUT%\_work_wave32_ecl" rmdir /s /q "%OUT%\_work_wave32_ecl"
mkdir "%OUT%\_work_wave32_ecl"
copy /y "%OUT%\wave32.ecl" "%OUT%\_work_wave32_ecl\wave32.ecl" >nul
cd /d "%OUT%\_work_wave32_ecl"
thecl.exe -d 185 wave32.ecl wave32.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave32.ecl"
del /q "%OUT%\_work_wave32_ecl\wave32.ecl"
mkdir "%OUT%\wave32.ecl"
xcopy /e /y /q "%OUT%\_work_wave32_ecl\*" "%OUT%\wave32.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave32_ecl"
if exist "%OUT%\_work_wave33_ecl" rmdir /s /q "%OUT%\_work_wave33_ecl"
mkdir "%OUT%\_work_wave33_ecl"
copy /y "%OUT%\wave33.ecl" "%OUT%\_work_wave33_ecl\wave33.ecl" >nul
cd /d "%OUT%\_work_wave33_ecl"
thecl.exe -d 185 wave33.ecl wave33.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave33.ecl"
del /q "%OUT%\_work_wave33_ecl\wave33.ecl"
mkdir "%OUT%\wave33.ecl"
xcopy /e /y /q "%OUT%\_work_wave33_ecl\*" "%OUT%\wave33.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave33_ecl"
if exist "%OUT%\_work_wave34_ecl" rmdir /s /q "%OUT%\_work_wave34_ecl"
mkdir "%OUT%\_work_wave34_ecl"
copy /y "%OUT%\wave34.ecl" "%OUT%\_work_wave34_ecl\wave34.ecl" >nul
cd /d "%OUT%\_work_wave34_ecl"
thecl.exe -d 185 wave34.ecl wave34.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave34.ecl"
del /q "%OUT%\_work_wave34_ecl\wave34.ecl"
mkdir "%OUT%\wave34.ecl"
xcopy /e /y /q "%OUT%\_work_wave34_ecl\*" "%OUT%\wave34.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave34_ecl"
if exist "%OUT%\_work_wave35_ecl" rmdir /s /q "%OUT%\_work_wave35_ecl"
mkdir "%OUT%\_work_wave35_ecl"
copy /y "%OUT%\wave35.ecl" "%OUT%\_work_wave35_ecl\wave35.ecl" >nul
cd /d "%OUT%\_work_wave35_ecl"
thecl.exe -d 185 wave35.ecl wave35.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave35.ecl"
del /q "%OUT%\_work_wave35_ecl\wave35.ecl"
mkdir "%OUT%\wave35.ecl"
xcopy /e /y /q "%OUT%\_work_wave35_ecl\*" "%OUT%\wave35.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave35_ecl"
if exist "%OUT%\_work_wave36_ecl" rmdir /s /q "%OUT%\_work_wave36_ecl"
mkdir "%OUT%\_work_wave36_ecl"
copy /y "%OUT%\wave36.ecl" "%OUT%\_work_wave36_ecl\wave36.ecl" >nul
cd /d "%OUT%\_work_wave36_ecl"
thecl.exe -d 185 wave36.ecl wave36.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave36.ecl"
del /q "%OUT%\_work_wave36_ecl\wave36.ecl"
mkdir "%OUT%\wave36.ecl"
xcopy /e /y /q "%OUT%\_work_wave36_ecl\*" "%OUT%\wave36.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave36_ecl"
if exist "%OUT%\_work_wave37_ecl" rmdir /s /q "%OUT%\_work_wave37_ecl"
mkdir "%OUT%\_work_wave37_ecl"
copy /y "%OUT%\wave37.ecl" "%OUT%\_work_wave37_ecl\wave37.ecl" >nul
cd /d "%OUT%\_work_wave37_ecl"
thecl.exe -d 185 wave37.ecl wave37.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave37.ecl"
del /q "%OUT%\_work_wave37_ecl\wave37.ecl"
mkdir "%OUT%\wave37.ecl"
xcopy /e /y /q "%OUT%\_work_wave37_ecl\*" "%OUT%\wave37.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave37_ecl"
if exist "%OUT%\_work_wave38_ecl" rmdir /s /q "%OUT%\_work_wave38_ecl"
mkdir "%OUT%\_work_wave38_ecl"
copy /y "%OUT%\wave38.ecl" "%OUT%\_work_wave38_ecl\wave38.ecl" >nul
cd /d "%OUT%\_work_wave38_ecl"
thecl.exe -d 185 wave38.ecl wave38.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave38.ecl"
del /q "%OUT%\_work_wave38_ecl\wave38.ecl"
mkdir "%OUT%\wave38.ecl"
xcopy /e /y /q "%OUT%\_work_wave38_ecl\*" "%OUT%\wave38.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave38_ecl"
if exist "%OUT%\_work_wave39_ecl" rmdir /s /q "%OUT%\_work_wave39_ecl"
mkdir "%OUT%\_work_wave39_ecl"
copy /y "%OUT%\wave39.ecl" "%OUT%\_work_wave39_ecl\wave39.ecl" >nul
cd /d "%OUT%\_work_wave39_ecl"
thecl.exe -d 185 wave39.ecl wave39.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave39.ecl"
del /q "%OUT%\_work_wave39_ecl\wave39.ecl"
mkdir "%OUT%\wave39.ecl"
xcopy /e /y /q "%OUT%\_work_wave39_ecl\*" "%OUT%\wave39.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave39_ecl"
if exist "%OUT%\_work_wave40_ecl" rmdir /s /q "%OUT%\_work_wave40_ecl"
mkdir "%OUT%\_work_wave40_ecl"
copy /y "%OUT%\wave40.ecl" "%OUT%\_work_wave40_ecl\wave40.ecl" >nul
cd /d "%OUT%\_work_wave40_ecl"
thecl.exe -d 185 wave40.ecl wave40.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave40.ecl"
del /q "%OUT%\_work_wave40_ecl\wave40.ecl"
mkdir "%OUT%\wave40.ecl"
xcopy /e /y /q "%OUT%\_work_wave40_ecl\*" "%OUT%\wave40.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave40_ecl"
if exist "%OUT%\_work_wave41_ecl" rmdir /s /q "%OUT%\_work_wave41_ecl"
mkdir "%OUT%\_work_wave41_ecl"
copy /y "%OUT%\wave41.ecl" "%OUT%\_work_wave41_ecl\wave41.ecl" >nul
cd /d "%OUT%\_work_wave41_ecl"
thecl.exe -d 185 wave41.ecl wave41.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave41.ecl"
del /q "%OUT%\_work_wave41_ecl\wave41.ecl"
mkdir "%OUT%\wave41.ecl"
xcopy /e /y /q "%OUT%\_work_wave41_ecl\*" "%OUT%\wave41.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave41_ecl"
if exist "%OUT%\_work_wave42_ecl" rmdir /s /q "%OUT%\_work_wave42_ecl"
mkdir "%OUT%\_work_wave42_ecl"
copy /y "%OUT%\wave42.ecl" "%OUT%\_work_wave42_ecl\wave42.ecl" >nul
cd /d "%OUT%\_work_wave42_ecl"
thecl.exe -d 185 wave42.ecl wave42.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave42.ecl"
del /q "%OUT%\_work_wave42_ecl\wave42.ecl"
mkdir "%OUT%\wave42.ecl"
xcopy /e /y /q "%OUT%\_work_wave42_ecl\*" "%OUT%\wave42.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave42_ecl"
if exist "%OUT%\_work_wave43_ecl" rmdir /s /q "%OUT%\_work_wave43_ecl"
mkdir "%OUT%\_work_wave43_ecl"
copy /y "%OUT%\wave43.ecl" "%OUT%\_work_wave43_ecl\wave43.ecl" >nul
cd /d "%OUT%\_work_wave43_ecl"
thecl.exe -d 185 wave43.ecl wave43.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave43.ecl"
del /q "%OUT%\_work_wave43_ecl\wave43.ecl"
mkdir "%OUT%\wave43.ecl"
xcopy /e /y /q "%OUT%\_work_wave43_ecl\*" "%OUT%\wave43.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave43_ecl"
if exist "%OUT%\_work_wave44_ecl" rmdir /s /q "%OUT%\_work_wave44_ecl"
mkdir "%OUT%\_work_wave44_ecl"
copy /y "%OUT%\wave44.ecl" "%OUT%\_work_wave44_ecl\wave44.ecl" >nul
cd /d "%OUT%\_work_wave44_ecl"
thecl.exe -d 185 wave44.ecl wave44.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave44.ecl"
del /q "%OUT%\_work_wave44_ecl\wave44.ecl"
mkdir "%OUT%\wave44.ecl"
xcopy /e /y /q "%OUT%\_work_wave44_ecl\*" "%OUT%\wave44.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave44_ecl"
if exist "%OUT%\_work_wave45_ecl" rmdir /s /q "%OUT%\_work_wave45_ecl"
mkdir "%OUT%\_work_wave45_ecl"
copy /y "%OUT%\wave45.ecl" "%OUT%\_work_wave45_ecl\wave45.ecl" >nul
cd /d "%OUT%\_work_wave45_ecl"
thecl.exe -d 185 wave45.ecl wave45.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave45.ecl"
del /q "%OUT%\_work_wave45_ecl\wave45.ecl"
mkdir "%OUT%\wave45.ecl"
xcopy /e /y /q "%OUT%\_work_wave45_ecl\*" "%OUT%\wave45.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave45_ecl"
if exist "%OUT%\_work_wave46_ecl" rmdir /s /q "%OUT%\_work_wave46_ecl"
mkdir "%OUT%\_work_wave46_ecl"
copy /y "%OUT%\wave46.ecl" "%OUT%\_work_wave46_ecl\wave46.ecl" >nul
cd /d "%OUT%\_work_wave46_ecl"
thecl.exe -d 185 wave46.ecl wave46.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave46.ecl"
del /q "%OUT%\_work_wave46_ecl\wave46.ecl"
mkdir "%OUT%\wave46.ecl"
xcopy /e /y /q "%OUT%\_work_wave46_ecl\*" "%OUT%\wave46.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave46_ecl"
if exist "%OUT%\_work_wave47_ecl" rmdir /s /q "%OUT%\_work_wave47_ecl"
mkdir "%OUT%\_work_wave47_ecl"
copy /y "%OUT%\wave47.ecl" "%OUT%\_work_wave47_ecl\wave47.ecl" >nul
cd /d "%OUT%\_work_wave47_ecl"
thecl.exe -d 185 wave47.ecl wave47.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave47.ecl"
del /q "%OUT%\_work_wave47_ecl\wave47.ecl"
mkdir "%OUT%\wave47.ecl"
xcopy /e /y /q "%OUT%\_work_wave47_ecl\*" "%OUT%\wave47.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave47_ecl"
if exist "%OUT%\_work_wave48_ecl" rmdir /s /q "%OUT%\_work_wave48_ecl"
mkdir "%OUT%\_work_wave48_ecl"
copy /y "%OUT%\wave48.ecl" "%OUT%\_work_wave48_ecl\wave48.ecl" >nul
cd /d "%OUT%\_work_wave48_ecl"
thecl.exe -d 185 wave48.ecl wave48.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave48.ecl"
del /q "%OUT%\_work_wave48_ecl\wave48.ecl"
mkdir "%OUT%\wave48.ecl"
xcopy /e /y /q "%OUT%\_work_wave48_ecl\*" "%OUT%\wave48.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave48_ecl"
if exist "%OUT%\_work_wave49_ecl" rmdir /s /q "%OUT%\_work_wave49_ecl"
mkdir "%OUT%\_work_wave49_ecl"
copy /y "%OUT%\wave49.ecl" "%OUT%\_work_wave49_ecl\wave49.ecl" >nul
cd /d "%OUT%\_work_wave49_ecl"
thecl.exe -d 185 wave49.ecl wave49.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave49.ecl"
del /q "%OUT%\_work_wave49_ecl\wave49.ecl"
mkdir "%OUT%\wave49.ecl"
xcopy /e /y /q "%OUT%\_work_wave49_ecl\*" "%OUT%\wave49.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave49_ecl"
if exist "%OUT%\_work_wave50_ecl" rmdir /s /q "%OUT%\_work_wave50_ecl"
mkdir "%OUT%\_work_wave50_ecl"
copy /y "%OUT%\wave50.ecl" "%OUT%\_work_wave50_ecl\wave50.ecl" >nul
cd /d "%OUT%\_work_wave50_ecl"
thecl.exe -d 185 wave50.ecl wave50.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave50.ecl"
del /q "%OUT%\_work_wave50_ecl\wave50.ecl"
mkdir "%OUT%\wave50.ecl"
xcopy /e /y /q "%OUT%\_work_wave50_ecl\*" "%OUT%\wave50.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave50_ecl"
if exist "%OUT%\_work_wave51_ecl" rmdir /s /q "%OUT%\_work_wave51_ecl"
mkdir "%OUT%\_work_wave51_ecl"
copy /y "%OUT%\wave51.ecl" "%OUT%\_work_wave51_ecl\wave51.ecl" >nul
cd /d "%OUT%\_work_wave51_ecl"
thecl.exe -d 185 wave51.ecl wave51.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave51.ecl"
del /q "%OUT%\_work_wave51_ecl\wave51.ecl"
mkdir "%OUT%\wave51.ecl"
xcopy /e /y /q "%OUT%\_work_wave51_ecl\*" "%OUT%\wave51.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave51_ecl"
if exist "%OUT%\_work_wave52_ecl" rmdir /s /q "%OUT%\_work_wave52_ecl"
mkdir "%OUT%\_work_wave52_ecl"
copy /y "%OUT%\wave52.ecl" "%OUT%\_work_wave52_ecl\wave52.ecl" >nul
cd /d "%OUT%\_work_wave52_ecl"
thecl.exe -d 185 wave52.ecl wave52.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave52.ecl"
del /q "%OUT%\_work_wave52_ecl\wave52.ecl"
mkdir "%OUT%\wave52.ecl"
xcopy /e /y /q "%OUT%\_work_wave52_ecl\*" "%OUT%\wave52.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave52_ecl"
if exist "%OUT%\_work_wave53_ecl" rmdir /s /q "%OUT%\_work_wave53_ecl"
mkdir "%OUT%\_work_wave53_ecl"
copy /y "%OUT%\wave53.ecl" "%OUT%\_work_wave53_ecl\wave53.ecl" >nul
cd /d "%OUT%\_work_wave53_ecl"
thecl.exe -d 185 wave53.ecl wave53.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave53.ecl"
del /q "%OUT%\_work_wave53_ecl\wave53.ecl"
mkdir "%OUT%\wave53.ecl"
xcopy /e /y /q "%OUT%\_work_wave53_ecl\*" "%OUT%\wave53.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave53_ecl"
if exist "%OUT%\_work_wave54_ecl" rmdir /s /q "%OUT%\_work_wave54_ecl"
mkdir "%OUT%\_work_wave54_ecl"
copy /y "%OUT%\wave54.ecl" "%OUT%\_work_wave54_ecl\wave54.ecl" >nul
cd /d "%OUT%\_work_wave54_ecl"
thecl.exe -d 185 wave54.ecl wave54.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave54.ecl"
del /q "%OUT%\_work_wave54_ecl\wave54.ecl"
mkdir "%OUT%\wave54.ecl"
xcopy /e /y /q "%OUT%\_work_wave54_ecl\*" "%OUT%\wave54.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave54_ecl"
if exist "%OUT%\_work_wave55_ecl" rmdir /s /q "%OUT%\_work_wave55_ecl"
mkdir "%OUT%\_work_wave55_ecl"
copy /y "%OUT%\wave55.ecl" "%OUT%\_work_wave55_ecl\wave55.ecl" >nul
cd /d "%OUT%\_work_wave55_ecl"
thecl.exe -d 185 wave55.ecl wave55.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave55.ecl"
del /q "%OUT%\_work_wave55_ecl\wave55.ecl"
mkdir "%OUT%\wave55.ecl"
xcopy /e /y /q "%OUT%\_work_wave55_ecl\*" "%OUT%\wave55.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave55_ecl"
if exist "%OUT%\_work_wave56_ecl" rmdir /s /q "%OUT%\_work_wave56_ecl"
mkdir "%OUT%\_work_wave56_ecl"
copy /y "%OUT%\wave56.ecl" "%OUT%\_work_wave56_ecl\wave56.ecl" >nul
cd /d "%OUT%\_work_wave56_ecl"
thecl.exe -d 185 wave56.ecl wave56.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave56.ecl"
del /q "%OUT%\_work_wave56_ecl\wave56.ecl"
mkdir "%OUT%\wave56.ecl"
xcopy /e /y /q "%OUT%\_work_wave56_ecl\*" "%OUT%\wave56.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave56_ecl"
if exist "%OUT%\_work_wave57_ecl" rmdir /s /q "%OUT%\_work_wave57_ecl"
mkdir "%OUT%\_work_wave57_ecl"
copy /y "%OUT%\wave57.ecl" "%OUT%\_work_wave57_ecl\wave57.ecl" >nul
cd /d "%OUT%\_work_wave57_ecl"
thecl.exe -d 185 wave57.ecl wave57.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave57.ecl"
del /q "%OUT%\_work_wave57_ecl\wave57.ecl"
mkdir "%OUT%\wave57.ecl"
xcopy /e /y /q "%OUT%\_work_wave57_ecl\*" "%OUT%\wave57.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave57_ecl"
if exist "%OUT%\_work_wave58_ecl" rmdir /s /q "%OUT%\_work_wave58_ecl"
mkdir "%OUT%\_work_wave58_ecl"
copy /y "%OUT%\wave58.ecl" "%OUT%\_work_wave58_ecl\wave58.ecl" >nul
cd /d "%OUT%\_work_wave58_ecl"
thecl.exe -d 185 wave58.ecl wave58.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave58.ecl"
del /q "%OUT%\_work_wave58_ecl\wave58.ecl"
mkdir "%OUT%\wave58.ecl"
xcopy /e /y /q "%OUT%\_work_wave58_ecl\*" "%OUT%\wave58.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave58_ecl"
if exist "%OUT%\_work_wave59_ecl" rmdir /s /q "%OUT%\_work_wave59_ecl"
mkdir "%OUT%\_work_wave59_ecl"
copy /y "%OUT%\wave59.ecl" "%OUT%\_work_wave59_ecl\wave59.ecl" >nul
cd /d "%OUT%\_work_wave59_ecl"
thecl.exe -d 185 wave59.ecl wave59.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave59.ecl"
del /q "%OUT%\_work_wave59_ecl\wave59.ecl"
mkdir "%OUT%\wave59.ecl"
xcopy /e /y /q "%OUT%\_work_wave59_ecl\*" "%OUT%\wave59.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave59_ecl"
if exist "%OUT%\_work_wave60_ecl" rmdir /s /q "%OUT%\_work_wave60_ecl"
mkdir "%OUT%\_work_wave60_ecl"
copy /y "%OUT%\wave60.ecl" "%OUT%\_work_wave60_ecl\wave60.ecl" >nul
cd /d "%OUT%\_work_wave60_ecl"
thecl.exe -d 185 wave60.ecl wave60.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave60.ecl"
del /q "%OUT%\_work_wave60_ecl\wave60.ecl"
mkdir "%OUT%\wave60.ecl"
xcopy /e /y /q "%OUT%\_work_wave60_ecl\*" "%OUT%\wave60.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave60_ecl"
if exist "%OUT%\_work_wave61_ecl" rmdir /s /q "%OUT%\_work_wave61_ecl"
mkdir "%OUT%\_work_wave61_ecl"
copy /y "%OUT%\wave61.ecl" "%OUT%\_work_wave61_ecl\wave61.ecl" >nul
cd /d "%OUT%\_work_wave61_ecl"
thecl.exe -d 185 wave61.ecl wave61.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave61.ecl"
del /q "%OUT%\_work_wave61_ecl\wave61.ecl"
mkdir "%OUT%\wave61.ecl"
xcopy /e /y /q "%OUT%\_work_wave61_ecl\*" "%OUT%\wave61.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave61_ecl"
if exist "%OUT%\_work_wave62_ecl" rmdir /s /q "%OUT%\_work_wave62_ecl"
mkdir "%OUT%\_work_wave62_ecl"
copy /y "%OUT%\wave62.ecl" "%OUT%\_work_wave62_ecl\wave62.ecl" >nul
cd /d "%OUT%\_work_wave62_ecl"
thecl.exe -d 185 wave62.ecl wave62.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave62.ecl"
del /q "%OUT%\_work_wave62_ecl\wave62.ecl"
mkdir "%OUT%\wave62.ecl"
xcopy /e /y /q "%OUT%\_work_wave62_ecl\*" "%OUT%\wave62.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave62_ecl"
if exist "%OUT%\_work_wave63_ecl" rmdir /s /q "%OUT%\_work_wave63_ecl"
mkdir "%OUT%\_work_wave63_ecl"
copy /y "%OUT%\wave63.ecl" "%OUT%\_work_wave63_ecl\wave63.ecl" >nul
cd /d "%OUT%\_work_wave63_ecl"
thecl.exe -d 185 wave63.ecl wave63.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave63.ecl"
del /q "%OUT%\_work_wave63_ecl\wave63.ecl"
mkdir "%OUT%\wave63.ecl"
xcopy /e /y /q "%OUT%\_work_wave63_ecl\*" "%OUT%\wave63.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave63_ecl"
if exist "%OUT%\_work_wave64_ecl" rmdir /s /q "%OUT%\_work_wave64_ecl"
mkdir "%OUT%\_work_wave64_ecl"
copy /y "%OUT%\wave64.ecl" "%OUT%\_work_wave64_ecl\wave64.ecl" >nul
cd /d "%OUT%\_work_wave64_ecl"
thecl.exe -d 185 wave64.ecl wave64.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave64.ecl"
del /q "%OUT%\_work_wave64_ecl\wave64.ecl"
mkdir "%OUT%\wave64.ecl"
xcopy /e /y /q "%OUT%\_work_wave64_ecl\*" "%OUT%\wave64.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave64_ecl"
if exist "%OUT%\_work_wave65_ecl" rmdir /s /q "%OUT%\_work_wave65_ecl"
mkdir "%OUT%\_work_wave65_ecl"
copy /y "%OUT%\wave65.ecl" "%OUT%\_work_wave65_ecl\wave65.ecl" >nul
cd /d "%OUT%\_work_wave65_ecl"
thecl.exe -d 185 wave65.ecl wave65.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave65.ecl"
del /q "%OUT%\_work_wave65_ecl\wave65.ecl"
mkdir "%OUT%\wave65.ecl"
xcopy /e /y /q "%OUT%\_work_wave65_ecl\*" "%OUT%\wave65.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave65_ecl"
if exist "%OUT%\_work_wave66_ecl" rmdir /s /q "%OUT%\_work_wave66_ecl"
mkdir "%OUT%\_work_wave66_ecl"
copy /y "%OUT%\wave66.ecl" "%OUT%\_work_wave66_ecl\wave66.ecl" >nul
cd /d "%OUT%\_work_wave66_ecl"
thecl.exe -d 185 wave66.ecl wave66.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave66.ecl"
del /q "%OUT%\_work_wave66_ecl\wave66.ecl"
mkdir "%OUT%\wave66.ecl"
xcopy /e /y /q "%OUT%\_work_wave66_ecl\*" "%OUT%\wave66.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave66_ecl"
if exist "%OUT%\_work_wave67_ecl" rmdir /s /q "%OUT%\_work_wave67_ecl"
mkdir "%OUT%\_work_wave67_ecl"
copy /y "%OUT%\wave67.ecl" "%OUT%\_work_wave67_ecl\wave67.ecl" >nul
cd /d "%OUT%\_work_wave67_ecl"
thecl.exe -d 185 wave67.ecl wave67.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave67.ecl"
del /q "%OUT%\_work_wave67_ecl\wave67.ecl"
mkdir "%OUT%\wave67.ecl"
xcopy /e /y /q "%OUT%\_work_wave67_ecl\*" "%OUT%\wave67.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave67_ecl"
if exist "%OUT%\_work_wave68_ecl" rmdir /s /q "%OUT%\_work_wave68_ecl"
mkdir "%OUT%\_work_wave68_ecl"
copy /y "%OUT%\wave68.ecl" "%OUT%\_work_wave68_ecl\wave68.ecl" >nul
cd /d "%OUT%\_work_wave68_ecl"
thecl.exe -d 185 wave68.ecl wave68.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave68.ecl"
del /q "%OUT%\_work_wave68_ecl\wave68.ecl"
mkdir "%OUT%\wave68.ecl"
xcopy /e /y /q "%OUT%\_work_wave68_ecl\*" "%OUT%\wave68.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave68_ecl"
if exist "%OUT%\_work_wave69_ecl" rmdir /s /q "%OUT%\_work_wave69_ecl"
mkdir "%OUT%\_work_wave69_ecl"
copy /y "%OUT%\wave69.ecl" "%OUT%\_work_wave69_ecl\wave69.ecl" >nul
cd /d "%OUT%\_work_wave69_ecl"
thecl.exe -d 185 wave69.ecl wave69.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave69.ecl"
del /q "%OUT%\_work_wave69_ecl\wave69.ecl"
mkdir "%OUT%\wave69.ecl"
xcopy /e /y /q "%OUT%\_work_wave69_ecl\*" "%OUT%\wave69.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave69_ecl"
if exist "%OUT%\_work_wave70_ecl" rmdir /s /q "%OUT%\_work_wave70_ecl"
mkdir "%OUT%\_work_wave70_ecl"
copy /y "%OUT%\wave70.ecl" "%OUT%\_work_wave70_ecl\wave70.ecl" >nul
cd /d "%OUT%\_work_wave70_ecl"
thecl.exe -d 185 wave70.ecl wave70.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave70.ecl"
del /q "%OUT%\_work_wave70_ecl\wave70.ecl"
mkdir "%OUT%\wave70.ecl"
xcopy /e /y /q "%OUT%\_work_wave70_ecl\*" "%OUT%\wave70.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave70_ecl"
if exist "%OUT%\_work_wave71_ecl" rmdir /s /q "%OUT%\_work_wave71_ecl"
mkdir "%OUT%\_work_wave71_ecl"
copy /y "%OUT%\wave71.ecl" "%OUT%\_work_wave71_ecl\wave71.ecl" >nul
cd /d "%OUT%\_work_wave71_ecl"
thecl.exe -d 185 wave71.ecl wave71.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave71.ecl"
del /q "%OUT%\_work_wave71_ecl\wave71.ecl"
mkdir "%OUT%\wave71.ecl"
xcopy /e /y /q "%OUT%\_work_wave71_ecl\*" "%OUT%\wave71.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave71_ecl"
if exist "%OUT%\_work_wave72_ecl" rmdir /s /q "%OUT%\_work_wave72_ecl"
mkdir "%OUT%\_work_wave72_ecl"
copy /y "%OUT%\wave72.ecl" "%OUT%\_work_wave72_ecl\wave72.ecl" >nul
cd /d "%OUT%\_work_wave72_ecl"
thecl.exe -d 185 wave72.ecl wave72.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave72.ecl"
del /q "%OUT%\_work_wave72_ecl\wave72.ecl"
mkdir "%OUT%\wave72.ecl"
xcopy /e /y /q "%OUT%\_work_wave72_ecl\*" "%OUT%\wave72.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave72_ecl"
if exist "%OUT%\_work_wave73_ecl" rmdir /s /q "%OUT%\_work_wave73_ecl"
mkdir "%OUT%\_work_wave73_ecl"
copy /y "%OUT%\wave73.ecl" "%OUT%\_work_wave73_ecl\wave73.ecl" >nul
cd /d "%OUT%\_work_wave73_ecl"
thecl.exe -d 185 wave73.ecl wave73.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave73.ecl"
del /q "%OUT%\_work_wave73_ecl\wave73.ecl"
mkdir "%OUT%\wave73.ecl"
xcopy /e /y /q "%OUT%\_work_wave73_ecl\*" "%OUT%\wave73.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave73_ecl"
if exist "%OUT%\_work_world01_anm" rmdir /s /q "%OUT%\_work_world01_anm"
mkdir "%OUT%\_work_world01_anm"
copy /y "%OUT%\world01.anm" "%OUT%\_work_world01_anm\world01.anm" >nul
cd /d "%OUT%\_work_world01_anm"
thanm.exe -x 185 world01.anm
cd /d "%OUT%"
del /q "%OUT%\world01.anm"
del /q "%OUT%\_work_world01_anm\world01.anm"
mkdir "%OUT%\world01.anm"
xcopy /e /y /q "%OUT%\_work_world01_anm\*" "%OUT%\world01.anm\" >nul
rmdir /s /q "%OUT%\_work_world01_anm"
if exist "%OUT%\_work_world01_ecl" rmdir /s /q "%OUT%\_work_world01_ecl"
mkdir "%OUT%\_work_world01_ecl"
copy /y "%OUT%\world01.ecl" "%OUT%\_work_world01_ecl\world01.ecl" >nul
cd /d "%OUT%\_work_world01_ecl"
thecl.exe -d 185 world01.ecl world01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world01.ecl"
del /q "%OUT%\_work_world01_ecl\world01.ecl"
mkdir "%OUT%\world01.ecl"
xcopy /e /y /q "%OUT%\_work_world01_ecl\*" "%OUT%\world01.ecl\" >nul
rmdir /s /q "%OUT%\_work_world01_ecl"
if exist "%OUT%\_work_world01_std" rmdir /s /q "%OUT%\_work_world01_std"
mkdir "%OUT%\_work_world01_std"
copy /y "%OUT%\world01.std" "%OUT%\_work_world01_std\world01.std" >nul
cd /d "%OUT%\_work_world01_std"
thstd.exe -d 185 world01.std world01.std.txt
cd /d "%OUT%"
del /q "%OUT%\world01.std"
del /q "%OUT%\_work_world01_std\world01.std"
mkdir "%OUT%\world01.std"
xcopy /e /y /q "%OUT%\_work_world01_std\*" "%OUT%\world01.std\" >nul
rmdir /s /q "%OUT%\_work_world01_std"
if exist "%OUT%\_work_world01t_anm" rmdir /s /q "%OUT%\_work_world01t_anm"
mkdir "%OUT%\_work_world01t_anm"
copy /y "%OUT%\world01t.anm" "%OUT%\_work_world01t_anm\world01t.anm" >nul
cd /d "%OUT%\_work_world01t_anm"
thanm.exe -x 185 world01t.anm
cd /d "%OUT%"
del /q "%OUT%\world01t.anm"
del /q "%OUT%\_work_world01t_anm\world01t.anm"
mkdir "%OUT%\world01t.anm"
xcopy /e /y /q "%OUT%\_work_world01t_anm\*" "%OUT%\world01t.anm\" >nul
rmdir /s /q "%OUT%\_work_world01t_anm"
if exist "%OUT%\_work_world01t_ecl" rmdir /s /q "%OUT%\_work_world01t_ecl"
mkdir "%OUT%\_work_world01t_ecl"
copy /y "%OUT%\world01t.ecl" "%OUT%\_work_world01t_ecl\world01t.ecl" >nul
cd /d "%OUT%\_work_world01t_ecl"
thecl.exe -d 185 world01t.ecl world01t.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world01t.ecl"
del /q "%OUT%\_work_world01t_ecl\world01t.ecl"
mkdir "%OUT%\world01t.ecl"
xcopy /e /y /q "%OUT%\_work_world01t_ecl\*" "%OUT%\world01t.ecl\" >nul
rmdir /s /q "%OUT%\_work_world01t_ecl"
if exist "%OUT%\_work_world01t_std" rmdir /s /q "%OUT%\_work_world01t_std"
mkdir "%OUT%\_work_world01t_std"
copy /y "%OUT%\world01t.std" "%OUT%\_work_world01t_std\world01t.std" >nul
cd /d "%OUT%\_work_world01t_std"
thstd.exe -d 185 world01t.std world01t.std.txt
cd /d "%OUT%"
del /q "%OUT%\world01t.std"
del /q "%OUT%\_work_world01t_std\world01t.std"
mkdir "%OUT%\world01t.std"
xcopy /e /y /q "%OUT%\_work_world01t_std\*" "%OUT%\world01t.std\" >nul
rmdir /s /q "%OUT%\_work_world01t_std"
if exist "%OUT%\_work_world02_anm" rmdir /s /q "%OUT%\_work_world02_anm"
mkdir "%OUT%\_work_world02_anm"
copy /y "%OUT%\world02.anm" "%OUT%\_work_world02_anm\world02.anm" >nul
cd /d "%OUT%\_work_world02_anm"
thanm.exe -x 185 world02.anm
cd /d "%OUT%"
del /q "%OUT%\world02.anm"
del /q "%OUT%\_work_world02_anm\world02.anm"
mkdir "%OUT%\world02.anm"
xcopy /e /y /q "%OUT%\_work_world02_anm\*" "%OUT%\world02.anm\" >nul
rmdir /s /q "%OUT%\_work_world02_anm"
if exist "%OUT%\_work_world02_ecl" rmdir /s /q "%OUT%\_work_world02_ecl"
mkdir "%OUT%\_work_world02_ecl"
copy /y "%OUT%\world02.ecl" "%OUT%\_work_world02_ecl\world02.ecl" >nul
cd /d "%OUT%\_work_world02_ecl"
thecl.exe -d 185 world02.ecl world02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world02.ecl"
del /q "%OUT%\_work_world02_ecl\world02.ecl"
mkdir "%OUT%\world02.ecl"
xcopy /e /y /q "%OUT%\_work_world02_ecl\*" "%OUT%\world02.ecl\" >nul
rmdir /s /q "%OUT%\_work_world02_ecl"
if exist "%OUT%\_work_world02_std" rmdir /s /q "%OUT%\_work_world02_std"
mkdir "%OUT%\_work_world02_std"
copy /y "%OUT%\world02.std" "%OUT%\_work_world02_std\world02.std" >nul
cd /d "%OUT%\_work_world02_std"
thstd.exe -d 185 world02.std world02.std.txt
cd /d "%OUT%"
del /q "%OUT%\world02.std"
del /q "%OUT%\_work_world02_std\world02.std"
mkdir "%OUT%\world02.std"
xcopy /e /y /q "%OUT%\_work_world02_std\*" "%OUT%\world02.std\" >nul
rmdir /s /q "%OUT%\_work_world02_std"
if exist "%OUT%\_work_world03_anm" rmdir /s /q "%OUT%\_work_world03_anm"
mkdir "%OUT%\_work_world03_anm"
copy /y "%OUT%\world03.anm" "%OUT%\_work_world03_anm\world03.anm" >nul
cd /d "%OUT%\_work_world03_anm"
thanm.exe -x 185 world03.anm
cd /d "%OUT%"
del /q "%OUT%\world03.anm"
del /q "%OUT%\_work_world03_anm\world03.anm"
mkdir "%OUT%\world03.anm"
xcopy /e /y /q "%OUT%\_work_world03_anm\*" "%OUT%\world03.anm\" >nul
rmdir /s /q "%OUT%\_work_world03_anm"
if exist "%OUT%\_work_world03_ecl" rmdir /s /q "%OUT%\_work_world03_ecl"
mkdir "%OUT%\_work_world03_ecl"
copy /y "%OUT%\world03.ecl" "%OUT%\_work_world03_ecl\world03.ecl" >nul
cd /d "%OUT%\_work_world03_ecl"
thecl.exe -d 185 world03.ecl world03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world03.ecl"
del /q "%OUT%\_work_world03_ecl\world03.ecl"
mkdir "%OUT%\world03.ecl"
xcopy /e /y /q "%OUT%\_work_world03_ecl\*" "%OUT%\world03.ecl\" >nul
rmdir /s /q "%OUT%\_work_world03_ecl"
if exist "%OUT%\_work_world03_std" rmdir /s /q "%OUT%\_work_world03_std"
mkdir "%OUT%\_work_world03_std"
copy /y "%OUT%\world03.std" "%OUT%\_work_world03_std\world03.std" >nul
cd /d "%OUT%\_work_world03_std"
thstd.exe -d 185 world03.std world03.std.txt
cd /d "%OUT%"
del /q "%OUT%\world03.std"
del /q "%OUT%\_work_world03_std\world03.std"
mkdir "%OUT%\world03.std"
xcopy /e /y /q "%OUT%\_work_world03_std\*" "%OUT%\world03.std\" >nul
rmdir /s /q "%OUT%\_work_world03_std"
if exist "%OUT%\_work_world04_anm" rmdir /s /q "%OUT%\_work_world04_anm"
mkdir "%OUT%\_work_world04_anm"
copy /y "%OUT%\world04.anm" "%OUT%\_work_world04_anm\world04.anm" >nul
cd /d "%OUT%\_work_world04_anm"
thanm.exe -x 185 world04.anm
cd /d "%OUT%"
del /q "%OUT%\world04.anm"
del /q "%OUT%\_work_world04_anm\world04.anm"
mkdir "%OUT%\world04.anm"
xcopy /e /y /q "%OUT%\_work_world04_anm\*" "%OUT%\world04.anm\" >nul
rmdir /s /q "%OUT%\_work_world04_anm"
if exist "%OUT%\_work_world04_ecl" rmdir /s /q "%OUT%\_work_world04_ecl"
mkdir "%OUT%\_work_world04_ecl"
copy /y "%OUT%\world04.ecl" "%OUT%\_work_world04_ecl\world04.ecl" >nul
cd /d "%OUT%\_work_world04_ecl"
thecl.exe -d 185 world04.ecl world04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world04.ecl"
del /q "%OUT%\_work_world04_ecl\world04.ecl"
mkdir "%OUT%\world04.ecl"
xcopy /e /y /q "%OUT%\_work_world04_ecl\*" "%OUT%\world04.ecl\" >nul
rmdir /s /q "%OUT%\_work_world04_ecl"
if exist "%OUT%\_work_world04_msg" rmdir /s /q "%OUT%\_work_world04_msg"
mkdir "%OUT%\_work_world04_msg"
copy /y "%OUT%\world04.msg" "%OUT%\_work_world04_msg\world04.msg" >nul
cd /d "%OUT%\_work_world04_msg"
thmsg.exe -d 185 world04.msg world04.txt
cd /d "%OUT%"
del /q "%OUT%\world04.msg"
del /q "%OUT%\_work_world04_msg\world04.msg"
mkdir "%OUT%\world04.msg"
xcopy /e /y /q "%OUT%\_work_world04_msg\*" "%OUT%\world04.msg\" >nul
rmdir /s /q "%OUT%\_work_world04_msg"
if exist "%OUT%\_work_world04_std" rmdir /s /q "%OUT%\_work_world04_std"
mkdir "%OUT%\_work_world04_std"
copy /y "%OUT%\world04.std" "%OUT%\_work_world04_std\world04.std" >nul
cd /d "%OUT%\_work_world04_std"
thstd.exe -d 185 world04.std world04.std.txt
cd /d "%OUT%"
del /q "%OUT%\world04.std"
del /q "%OUT%\_work_world04_std\world04.std"
mkdir "%OUT%\world04.std"
xcopy /e /y /q "%OUT%\_work_world04_std\*" "%OUT%\world04.std\" >nul
rmdir /s /q "%OUT%\_work_world04_std"
if exist "%OUT%\_work_world05_anm" rmdir /s /q "%OUT%\_work_world05_anm"
mkdir "%OUT%\_work_world05_anm"
copy /y "%OUT%\world05.anm" "%OUT%\_work_world05_anm\world05.anm" >nul
cd /d "%OUT%\_work_world05_anm"
thanm.exe -x 185 world05.anm
cd /d "%OUT%"
del /q "%OUT%\world05.anm"
del /q "%OUT%\_work_world05_anm\world05.anm"
mkdir "%OUT%\world05.anm"
xcopy /e /y /q "%OUT%\_work_world05_anm\*" "%OUT%\world05.anm\" >nul
rmdir /s /q "%OUT%\_work_world05_anm"
if exist "%OUT%\_work_world05_ecl" rmdir /s /q "%OUT%\_work_world05_ecl"
mkdir "%OUT%\_work_world05_ecl"
copy /y "%OUT%\world05.ecl" "%OUT%\_work_world05_ecl\world05.ecl" >nul
cd /d "%OUT%\_work_world05_ecl"
thecl.exe -d 185 world05.ecl world05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world05.ecl"
del /q "%OUT%\_work_world05_ecl\world05.ecl"
mkdir "%OUT%\world05.ecl"
xcopy /e /y /q "%OUT%\_work_world05_ecl\*" "%OUT%\world05.ecl\" >nul
rmdir /s /q "%OUT%\_work_world05_ecl"
if exist "%OUT%\_work_world05_std" rmdir /s /q "%OUT%\_work_world05_std"
mkdir "%OUT%\_work_world05_std"
copy /y "%OUT%\world05.std" "%OUT%\_work_world05_std\world05.std" >nul
cd /d "%OUT%\_work_world05_std"
thstd.exe -d 185 world05.std world05.std.txt
cd /d "%OUT%"
del /q "%OUT%\world05.std"
del /q "%OUT%\_work_world05_std\world05.std"
mkdir "%OUT%\world05.std"
xcopy /e /y /q "%OUT%\_work_world05_std\*" "%OUT%\world05.std\" >nul
rmdir /s /q "%OUT%\_work_world05_std"
if exist "%OUT%\_work_world06_anm" rmdir /s /q "%OUT%\_work_world06_anm"
mkdir "%OUT%\_work_world06_anm"
copy /y "%OUT%\world06.anm" "%OUT%\_work_world06_anm\world06.anm" >nul
cd /d "%OUT%\_work_world06_anm"
thanm.exe -x 185 world06.anm
cd /d "%OUT%"
del /q "%OUT%\world06.anm"
del /q "%OUT%\_work_world06_anm\world06.anm"
mkdir "%OUT%\world06.anm"
xcopy /e /y /q "%OUT%\_work_world06_anm\*" "%OUT%\world06.anm\" >nul
rmdir /s /q "%OUT%\_work_world06_anm"
if exist "%OUT%\_work_world06_ecl" rmdir /s /q "%OUT%\_work_world06_ecl"
mkdir "%OUT%\_work_world06_ecl"
copy /y "%OUT%\world06.ecl" "%OUT%\_work_world06_ecl\world06.ecl" >nul
cd /d "%OUT%\_work_world06_ecl"
thecl.exe -d 185 world06.ecl world06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world06.ecl"
del /q "%OUT%\_work_world06_ecl\world06.ecl"
mkdir "%OUT%\world06.ecl"
xcopy /e /y /q "%OUT%\_work_world06_ecl\*" "%OUT%\world06.ecl\" >nul
rmdir /s /q "%OUT%\_work_world06_ecl"
if exist "%OUT%\_work_world06_msg" rmdir /s /q "%OUT%\_work_world06_msg"
mkdir "%OUT%\_work_world06_msg"
copy /y "%OUT%\world06.msg" "%OUT%\_work_world06_msg\world06.msg" >nul
cd /d "%OUT%\_work_world06_msg"
thmsg.exe -d 185 world06.msg world06.txt
cd /d "%OUT%"
del /q "%OUT%\world06.msg"
del /q "%OUT%\_work_world06_msg\world06.msg"
mkdir "%OUT%\world06.msg"
xcopy /e /y /q "%OUT%\_work_world06_msg\*" "%OUT%\world06.msg\" >nul
rmdir /s /q "%OUT%\_work_world06_msg"
if exist "%OUT%\_work_world06_std" rmdir /s /q "%OUT%\_work_world06_std"
mkdir "%OUT%\_work_world06_std"
copy /y "%OUT%\world06.std" "%OUT%\_work_world06_std\world06.std" >nul
cd /d "%OUT%\_work_world06_std"
thstd.exe -d 185 world06.std world06.std.txt
cd /d "%OUT%"
del /q "%OUT%\world06.std"
del /q "%OUT%\_work_world06_std\world06.std"
mkdir "%OUT%\world06.std"
xcopy /e /y /q "%OUT%\_work_world06_std\*" "%OUT%\world06.std\" >nul
rmdir /s /q "%OUT%\_work_world06_std"
if exist "%OUT%\_work_world07_anm" rmdir /s /q "%OUT%\_work_world07_anm"
mkdir "%OUT%\_work_world07_anm"
copy /y "%OUT%\world07.anm" "%OUT%\_work_world07_anm\world07.anm" >nul
cd /d "%OUT%\_work_world07_anm"
thanm.exe -x 185 world07.anm
cd /d "%OUT%"
del /q "%OUT%\world07.anm"
del /q "%OUT%\_work_world07_anm\world07.anm"
mkdir "%OUT%\world07.anm"
xcopy /e /y /q "%OUT%\_work_world07_anm\*" "%OUT%\world07.anm\" >nul
rmdir /s /q "%OUT%\_work_world07_anm"
if exist "%OUT%\_work_world07_ecl" rmdir /s /q "%OUT%\_work_world07_ecl"
mkdir "%OUT%\_work_world07_ecl"
copy /y "%OUT%\world07.ecl" "%OUT%\_work_world07_ecl\world07.ecl" >nul
cd /d "%OUT%\_work_world07_ecl"
thecl.exe -d 185 world07.ecl world07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world07.ecl"
del /q "%OUT%\_work_world07_ecl\world07.ecl"
mkdir "%OUT%\world07.ecl"
xcopy /e /y /q "%OUT%\_work_world07_ecl\*" "%OUT%\world07.ecl\" >nul
rmdir /s /q "%OUT%\_work_world07_ecl"
if exist "%OUT%\_work_world07_msg" rmdir /s /q "%OUT%\_work_world07_msg"
mkdir "%OUT%\_work_world07_msg"
copy /y "%OUT%\world07.msg" "%OUT%\_work_world07_msg\world07.msg" >nul
cd /d "%OUT%\_work_world07_msg"
thmsg.exe -d 185 world07.msg world07.txt
cd /d "%OUT%"
del /q "%OUT%\world07.msg"
del /q "%OUT%\_work_world07_msg\world07.msg"
mkdir "%OUT%\world07.msg"
xcopy /e /y /q "%OUT%\_work_world07_msg\*" "%OUT%\world07.msg\" >nul
rmdir /s /q "%OUT%\_work_world07_msg"
if exist "%OUT%\_work_world07_std" rmdir /s /q "%OUT%\_work_world07_std"
mkdir "%OUT%\_work_world07_std"
copy /y "%OUT%\world07.std" "%OUT%\_work_world07_std\world07.std" >nul
cd /d "%OUT%\_work_world07_std"
thstd.exe -d 185 world07.std world07.std.txt
cd /d "%OUT%"
del /q "%OUT%\world07.std"
del /q "%OUT%\_work_world07_std\world07.std"
mkdir "%OUT%\world07.std"
xcopy /e /y /q "%OUT%\_work_world07_std\*" "%OUT%\world07.std\" >nul
rmdir /s /q "%OUT%\_work_world07_std"
if exist "%OUT%\_work_world08_anm" rmdir /s /q "%OUT%\_work_world08_anm"
mkdir "%OUT%\_work_world08_anm"
copy /y "%OUT%\world08.anm" "%OUT%\_work_world08_anm\world08.anm" >nul
cd /d "%OUT%\_work_world08_anm"
thanm.exe -x 185 world08.anm
cd /d "%OUT%"
del /q "%OUT%\world08.anm"
del /q "%OUT%\_work_world08_anm\world08.anm"
mkdir "%OUT%\world08.anm"
xcopy /e /y /q "%OUT%\_work_world08_anm\*" "%OUT%\world08.anm\" >nul
rmdir /s /q "%OUT%\_work_world08_anm"
if exist "%OUT%\_work_world08_ecl" rmdir /s /q "%OUT%\_work_world08_ecl"
mkdir "%OUT%\_work_world08_ecl"
copy /y "%OUT%\world08.ecl" "%OUT%\_work_world08_ecl\world08.ecl" >nul
cd /d "%OUT%\_work_world08_ecl"
thecl.exe -d 185 world08.ecl world08.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\world08.ecl"
del /q "%OUT%\_work_world08_ecl\world08.ecl"
mkdir "%OUT%\world08.ecl"
xcopy /e /y /q "%OUT%\_work_world08_ecl\*" "%OUT%\world08.ecl\" >nul
rmdir /s /q "%OUT%\_work_world08_ecl"
if exist "%OUT%\_work_world08_std" rmdir /s /q "%OUT%\_work_world08_std"
mkdir "%OUT%\_work_world08_std"
copy /y "%OUT%\world08.std" "%OUT%\_work_world08_std\world08.std" >nul
cd /d "%OUT%\_work_world08_std"
thstd.exe -d 185 world08.std world08.std.txt
cd /d "%OUT%"
del /q "%OUT%\world08.std"
del /q "%OUT%\_work_world08_std\world08.std"
mkdir "%OUT%\world08.std"
xcopy /e /y /q "%OUT%\_work_world08_std\*" "%OUT%\world08.std\" >nul
rmdir /s /q "%OUT%\_work_world08_std"
echo === th185 转换完成 ===