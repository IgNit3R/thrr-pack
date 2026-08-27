@echo off
setlocal
set PATH=E:\GitWorkspace\thworks\.build\thtk-install\bin;%PATH%
set OUT=E:\GitWorkspace\thworks\pushfiles\th19\th19.dat
if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%"
cd /d "%OUT%"
thdat.exe -x 19 "E:\GitWorkspace\thworks\tsa\th19\th19.dat"
if exist "%OUT%\_work_abcard_anm" rmdir /s /q "%OUT%\_work_abcard_anm"
mkdir "%OUT%\_work_abcard_anm"
copy /y "%OUT%\abcard.anm" "%OUT%\_work_abcard_anm\abcard.anm" >nul
cd /d "%OUT%\_work_abcard_anm"
thanm.exe -x 19 abcard.anm
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
thanm.exe -x 19 ability.anm
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
thanm.exe -x 19 abmenu.anm
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
thanm.exe -x 19 ascii.anm
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
thanm.exe -x 19 ascii1280.anm
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
thanm.exe -x 19 ascii_960.anm
cd /d "%OUT%"
del /q "%OUT%\ascii_960.anm"
del /q "%OUT%\_work_ascii_960_anm\ascii_960.anm"
mkdir "%OUT%\ascii_960.anm"
xcopy /e /y /q "%OUT%\_work_ascii_960_anm\*" "%OUT%\ascii_960.anm\" >nul
rmdir /s /q "%OUT%\_work_ascii_960_anm"
if exist "%OUT%\_work_aura_anm" rmdir /s /q "%OUT%\_work_aura_anm"
mkdir "%OUT%\_work_aura_anm"
copy /y "%OUT%\aura.anm" "%OUT%\_work_aura_anm\aura.anm" >nul
cd /d "%OUT%\_work_aura_anm"
thanm.exe -x 19 aura.anm
cd /d "%OUT%"
del /q "%OUT%\aura.anm"
del /q "%OUT%\_work_aura_anm\aura.anm"
mkdir "%OUT%\aura.anm"
xcopy /e /y /q "%OUT%\_work_aura_anm\*" "%OUT%\aura.anm\" >nul
rmdir /s /q "%OUT%\_work_aura_anm"
if exist "%OUT%\_work_bullet_anm" rmdir /s /q "%OUT%\_work_bullet_anm"
mkdir "%OUT%\_work_bullet_anm"
copy /y "%OUT%\bullet.anm" "%OUT%\_work_bullet_anm\bullet.anm" >nul
cd /d "%OUT%\_work_bullet_anm"
thanm.exe -x 19 bullet.anm
cd /d "%OUT%"
del /q "%OUT%\bullet.anm"
del /q "%OUT%\_work_bullet_anm\bullet.anm"
mkdir "%OUT%\bullet.anm"
xcopy /e /y /q "%OUT%\_work_bullet_anm\*" "%OUT%\bullet.anm\" >nul
rmdir /s /q "%OUT%\_work_bullet_anm"
if exist "%OUT%\_work_common_ecl" rmdir /s /q "%OUT%\_work_common_ecl"
mkdir "%OUT%\_work_common_ecl"
copy /y "%OUT%\common.ecl" "%OUT%\_work_common_ecl\common.ecl" >nul
cd /d "%OUT%\_work_common_ecl"
thecl.exe -d 19 common.ecl common.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\common.ecl"
del /q "%OUT%\_work_common_ecl\common.ecl"
mkdir "%OUT%\common.ecl"
xcopy /e /y /q "%OUT%\_work_common_ecl\*" "%OUT%\common.ecl\" >nul
rmdir /s /q "%OUT%\_work_common_ecl"
if exist "%OUT%\_work_default_ecl" rmdir /s /q "%OUT%\_work_default_ecl"
mkdir "%OUT%\_work_default_ecl"
copy /y "%OUT%\default.ecl" "%OUT%\_work_default_ecl\default.ecl" >nul
cd /d "%OUT%\_work_default_ecl"
thecl.exe -d 19 default.ecl default.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\default.ecl"
del /q "%OUT%\_work_default_ecl\default.ecl"
mkdir "%OUT%\default.ecl"
xcopy /e /y /q "%OUT%\_work_default_ecl\*" "%OUT%\default.ecl\" >nul
rmdir /s /q "%OUT%\_work_default_ecl"
if exist "%OUT%\_work_ebg00_anm" rmdir /s /q "%OUT%\_work_ebg00_anm"
mkdir "%OUT%\_work_ebg00_anm"
copy /y "%OUT%\ebg00.anm" "%OUT%\_work_ebg00_anm\ebg00.anm" >nul
cd /d "%OUT%\_work_ebg00_anm"
thanm.exe -x 19 ebg00.anm
cd /d "%OUT%"
del /q "%OUT%\ebg00.anm"
del /q "%OUT%\_work_ebg00_anm\ebg00.anm"
mkdir "%OUT%\ebg00.anm"
xcopy /e /y /q "%OUT%\_work_ebg00_anm\*" "%OUT%\ebg00.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg00_anm"
if exist "%OUT%\_work_ebg01_anm" rmdir /s /q "%OUT%\_work_ebg01_anm"
mkdir "%OUT%\_work_ebg01_anm"
copy /y "%OUT%\ebg01.anm" "%OUT%\_work_ebg01_anm\ebg01.anm" >nul
cd /d "%OUT%\_work_ebg01_anm"
thanm.exe -x 19 ebg01.anm
cd /d "%OUT%"
del /q "%OUT%\ebg01.anm"
del /q "%OUT%\_work_ebg01_anm\ebg01.anm"
mkdir "%OUT%\ebg01.anm"
xcopy /e /y /q "%OUT%\_work_ebg01_anm\*" "%OUT%\ebg01.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg01_anm"
if exist "%OUT%\_work_ebg02_anm" rmdir /s /q "%OUT%\_work_ebg02_anm"
mkdir "%OUT%\_work_ebg02_anm"
copy /y "%OUT%\ebg02.anm" "%OUT%\_work_ebg02_anm\ebg02.anm" >nul
cd /d "%OUT%\_work_ebg02_anm"
thanm.exe -x 19 ebg02.anm
cd /d "%OUT%"
del /q "%OUT%\ebg02.anm"
del /q "%OUT%\_work_ebg02_anm\ebg02.anm"
mkdir "%OUT%\ebg02.anm"
xcopy /e /y /q "%OUT%\_work_ebg02_anm\*" "%OUT%\ebg02.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg02_anm"
if exist "%OUT%\_work_ebg03_anm" rmdir /s /q "%OUT%\_work_ebg03_anm"
mkdir "%OUT%\_work_ebg03_anm"
copy /y "%OUT%\ebg03.anm" "%OUT%\_work_ebg03_anm\ebg03.anm" >nul
cd /d "%OUT%\_work_ebg03_anm"
thanm.exe -x 19 ebg03.anm
cd /d "%OUT%"
del /q "%OUT%\ebg03.anm"
del /q "%OUT%\_work_ebg03_anm\ebg03.anm"
mkdir "%OUT%\ebg03.anm"
xcopy /e /y /q "%OUT%\_work_ebg03_anm\*" "%OUT%\ebg03.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg03_anm"
if exist "%OUT%\_work_ebg04_anm" rmdir /s /q "%OUT%\_work_ebg04_anm"
mkdir "%OUT%\_work_ebg04_anm"
copy /y "%OUT%\ebg04.anm" "%OUT%\_work_ebg04_anm\ebg04.anm" >nul
cd /d "%OUT%\_work_ebg04_anm"
thanm.exe -x 19 ebg04.anm
cd /d "%OUT%"
del /q "%OUT%\ebg04.anm"
del /q "%OUT%\_work_ebg04_anm\ebg04.anm"
mkdir "%OUT%\ebg04.anm"
xcopy /e /y /q "%OUT%\_work_ebg04_anm\*" "%OUT%\ebg04.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg04_anm"
if exist "%OUT%\_work_ebg05_anm" rmdir /s /q "%OUT%\_work_ebg05_anm"
mkdir "%OUT%\_work_ebg05_anm"
copy /y "%OUT%\ebg05.anm" "%OUT%\_work_ebg05_anm\ebg05.anm" >nul
cd /d "%OUT%\_work_ebg05_anm"
thanm.exe -x 19 ebg05.anm
cd /d "%OUT%"
del /q "%OUT%\ebg05.anm"
del /q "%OUT%\_work_ebg05_anm\ebg05.anm"
mkdir "%OUT%\ebg05.anm"
xcopy /e /y /q "%OUT%\_work_ebg05_anm\*" "%OUT%\ebg05.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg05_anm"
if exist "%OUT%\_work_ebg06_anm" rmdir /s /q "%OUT%\_work_ebg06_anm"
mkdir "%OUT%\_work_ebg06_anm"
copy /y "%OUT%\ebg06.anm" "%OUT%\_work_ebg06_anm\ebg06.anm" >nul
cd /d "%OUT%\_work_ebg06_anm"
thanm.exe -x 19 ebg06.anm
cd /d "%OUT%"
del /q "%OUT%\ebg06.anm"
del /q "%OUT%\_work_ebg06_anm\ebg06.anm"
mkdir "%OUT%\ebg06.anm"
xcopy /e /y /q "%OUT%\_work_ebg06_anm\*" "%OUT%\ebg06.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg06_anm"
if exist "%OUT%\_work_ebg07_anm" rmdir /s /q "%OUT%\_work_ebg07_anm"
mkdir "%OUT%\_work_ebg07_anm"
copy /y "%OUT%\ebg07.anm" "%OUT%\_work_ebg07_anm\ebg07.anm" >nul
cd /d "%OUT%\_work_ebg07_anm"
thanm.exe -x 19 ebg07.anm
cd /d "%OUT%"
del /q "%OUT%\ebg07.anm"
del /q "%OUT%\_work_ebg07_anm\ebg07.anm"
mkdir "%OUT%\ebg07.anm"
xcopy /e /y /q "%OUT%\_work_ebg07_anm\*" "%OUT%\ebg07.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg07_anm"
if exist "%OUT%\_work_ebg08_anm" rmdir /s /q "%OUT%\_work_ebg08_anm"
mkdir "%OUT%\_work_ebg08_anm"
copy /y "%OUT%\ebg08.anm" "%OUT%\_work_ebg08_anm\ebg08.anm" >nul
cd /d "%OUT%\_work_ebg08_anm"
thanm.exe -x 19 ebg08.anm
cd /d "%OUT%"
del /q "%OUT%\ebg08.anm"
del /q "%OUT%\_work_ebg08_anm\ebg08.anm"
mkdir "%OUT%\ebg08.anm"
xcopy /e /y /q "%OUT%\_work_ebg08_anm\*" "%OUT%\ebg08.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg08_anm"
if exist "%OUT%\_work_effect_anm" rmdir /s /q "%OUT%\_work_effect_anm"
mkdir "%OUT%\_work_effect_anm"
copy /y "%OUT%\effect.anm" "%OUT%\_work_effect_anm\effect.anm" >nul
cd /d "%OUT%\_work_effect_anm"
thanm.exe -x 19 effect.anm
cd /d "%OUT%"
del /q "%OUT%\effect.anm"
del /q "%OUT%\_work_effect_anm\effect.anm"
mkdir "%OUT%\effect.anm"
xcopy /e /y /q "%OUT%\_work_effect_anm\*" "%OUT%\effect.anm\" >nul
rmdir /s /q "%OUT%\_work_effect_anm"
if exist "%OUT%\_work_end00_anm" rmdir /s /q "%OUT%\_work_end00_anm"
mkdir "%OUT%\_work_end00_anm"
copy /y "%OUT%\end00.anm" "%OUT%\_work_end00_anm\end00.anm" >nul
cd /d "%OUT%\_work_end00_anm"
thanm.exe -x 19 end00.anm
cd /d "%OUT%"
del /q "%OUT%\end00.anm"
del /q "%OUT%\_work_end00_anm\end00.anm"
mkdir "%OUT%\end00.anm"
xcopy /e /y /q "%OUT%\_work_end00_anm\*" "%OUT%\end00.anm\" >nul
rmdir /s /q "%OUT%\_work_end00_anm"
if exist "%OUT%\_work_end00_msg" rmdir /s /q "%OUT%\_work_end00_msg"
mkdir "%OUT%\_work_end00_msg"
copy /y "%OUT%\end00.msg" "%OUT%\_work_end00_msg\end00.msg" >nul
cd /d "%OUT%\_work_end00_msg"
thmsg.exe -d 19 end00.msg end00.txt
cd /d "%OUT%"
del /q "%OUT%\end00.msg"
del /q "%OUT%\_work_end00_msg\end00.msg"
mkdir "%OUT%\end00.msg"
xcopy /e /y /q "%OUT%\_work_end00_msg\*" "%OUT%\end00.msg\" >nul
rmdir /s /q "%OUT%\_work_end00_msg"
if exist "%OUT%\_work_end01_anm" rmdir /s /q "%OUT%\_work_end01_anm"
mkdir "%OUT%\_work_end01_anm"
copy /y "%OUT%\end01.anm" "%OUT%\_work_end01_anm\end01.anm" >nul
cd /d "%OUT%\_work_end01_anm"
thanm.exe -x 19 end01.anm
cd /d "%OUT%"
del /q "%OUT%\end01.anm"
del /q "%OUT%\_work_end01_anm\end01.anm"
mkdir "%OUT%\end01.anm"
xcopy /e /y /q "%OUT%\_work_end01_anm\*" "%OUT%\end01.anm\" >nul
rmdir /s /q "%OUT%\_work_end01_anm"
if exist "%OUT%\_work_end01_msg" rmdir /s /q "%OUT%\_work_end01_msg"
mkdir "%OUT%\_work_end01_msg"
copy /y "%OUT%\end01.msg" "%OUT%\_work_end01_msg\end01.msg" >nul
cd /d "%OUT%\_work_end01_msg"
thmsg.exe -d 19 end01.msg end01.txt
cd /d "%OUT%"
del /q "%OUT%\end01.msg"
del /q "%OUT%\_work_end01_msg\end01.msg"
mkdir "%OUT%\end01.msg"
xcopy /e /y /q "%OUT%\_work_end01_msg\*" "%OUT%\end01.msg\" >nul
rmdir /s /q "%OUT%\_work_end01_msg"
if exist "%OUT%\_work_end02_anm" rmdir /s /q "%OUT%\_work_end02_anm"
mkdir "%OUT%\_work_end02_anm"
copy /y "%OUT%\end02.anm" "%OUT%\_work_end02_anm\end02.anm" >nul
cd /d "%OUT%\_work_end02_anm"
thanm.exe -x 19 end02.anm
cd /d "%OUT%"
del /q "%OUT%\end02.anm"
del /q "%OUT%\_work_end02_anm\end02.anm"
mkdir "%OUT%\end02.anm"
xcopy /e /y /q "%OUT%\_work_end02_anm\*" "%OUT%\end02.anm\" >nul
rmdir /s /q "%OUT%\_work_end02_anm"
if exist "%OUT%\_work_end02_msg" rmdir /s /q "%OUT%\_work_end02_msg"
mkdir "%OUT%\_work_end02_msg"
copy /y "%OUT%\end02.msg" "%OUT%\_work_end02_msg\end02.msg" >nul
cd /d "%OUT%\_work_end02_msg"
thmsg.exe -d 19 end02.msg end02.txt
cd /d "%OUT%"
del /q "%OUT%\end02.msg"
del /q "%OUT%\_work_end02_msg\end02.msg"
mkdir "%OUT%\end02.msg"
xcopy /e /y /q "%OUT%\_work_end02_msg\*" "%OUT%\end02.msg\" >nul
rmdir /s /q "%OUT%\_work_end02_msg"
if exist "%OUT%\_work_end03_anm" rmdir /s /q "%OUT%\_work_end03_anm"
mkdir "%OUT%\_work_end03_anm"
copy /y "%OUT%\end03.anm" "%OUT%\_work_end03_anm\end03.anm" >nul
cd /d "%OUT%\_work_end03_anm"
thanm.exe -x 19 end03.anm
cd /d "%OUT%"
del /q "%OUT%\end03.anm"
del /q "%OUT%\_work_end03_anm\end03.anm"
mkdir "%OUT%\end03.anm"
xcopy /e /y /q "%OUT%\_work_end03_anm\*" "%OUT%\end03.anm\" >nul
rmdir /s /q "%OUT%\_work_end03_anm"
if exist "%OUT%\_work_end03_msg" rmdir /s /q "%OUT%\_work_end03_msg"
mkdir "%OUT%\_work_end03_msg"
copy /y "%OUT%\end03.msg" "%OUT%\_work_end03_msg\end03.msg" >nul
cd /d "%OUT%\_work_end03_msg"
thmsg.exe -d 19 end03.msg end03.txt
cd /d "%OUT%"
del /q "%OUT%\end03.msg"
del /q "%OUT%\_work_end03_msg\end03.msg"
mkdir "%OUT%\end03.msg"
xcopy /e /y /q "%OUT%\_work_end03_msg\*" "%OUT%\end03.msg\" >nul
rmdir /s /q "%OUT%\_work_end03_msg"
if exist "%OUT%\_work_end04_anm" rmdir /s /q "%OUT%\_work_end04_anm"
mkdir "%OUT%\_work_end04_anm"
copy /y "%OUT%\end04.anm" "%OUT%\_work_end04_anm\end04.anm" >nul
cd /d "%OUT%\_work_end04_anm"
thanm.exe -x 19 end04.anm
cd /d "%OUT%"
del /q "%OUT%\end04.anm"
del /q "%OUT%\_work_end04_anm\end04.anm"
mkdir "%OUT%\end04.anm"
xcopy /e /y /q "%OUT%\_work_end04_anm\*" "%OUT%\end04.anm\" >nul
rmdir /s /q "%OUT%\_work_end04_anm"
if exist "%OUT%\_work_end04_msg" rmdir /s /q "%OUT%\_work_end04_msg"
mkdir "%OUT%\_work_end04_msg"
copy /y "%OUT%\end04.msg" "%OUT%\_work_end04_msg\end04.msg" >nul
cd /d "%OUT%\_work_end04_msg"
thmsg.exe -d 19 end04.msg end04.txt
cd /d "%OUT%"
del /q "%OUT%\end04.msg"
del /q "%OUT%\_work_end04_msg\end04.msg"
mkdir "%OUT%\end04.msg"
xcopy /e /y /q "%OUT%\_work_end04_msg\*" "%OUT%\end04.msg\" >nul
rmdir /s /q "%OUT%\_work_end04_msg"
if exist "%OUT%\_work_end05_anm" rmdir /s /q "%OUT%\_work_end05_anm"
mkdir "%OUT%\_work_end05_anm"
copy /y "%OUT%\end05.anm" "%OUT%\_work_end05_anm\end05.anm" >nul
cd /d "%OUT%\_work_end05_anm"
thanm.exe -x 19 end05.anm
cd /d "%OUT%"
del /q "%OUT%\end05.anm"
del /q "%OUT%\_work_end05_anm\end05.anm"
mkdir "%OUT%\end05.anm"
xcopy /e /y /q "%OUT%\_work_end05_anm\*" "%OUT%\end05.anm\" >nul
rmdir /s /q "%OUT%\_work_end05_anm"
if exist "%OUT%\_work_end05_msg" rmdir /s /q "%OUT%\_work_end05_msg"
mkdir "%OUT%\_work_end05_msg"
copy /y "%OUT%\end05.msg" "%OUT%\_work_end05_msg\end05.msg" >nul
cd /d "%OUT%\_work_end05_msg"
thmsg.exe -d 19 end05.msg end05.txt
cd /d "%OUT%"
del /q "%OUT%\end05.msg"
del /q "%OUT%\_work_end05_msg\end05.msg"
mkdir "%OUT%\end05.msg"
xcopy /e /y /q "%OUT%\_work_end05_msg\*" "%OUT%\end05.msg\" >nul
rmdir /s /q "%OUT%\_work_end05_msg"
if exist "%OUT%\_work_end06_anm" rmdir /s /q "%OUT%\_work_end06_anm"
mkdir "%OUT%\_work_end06_anm"
copy /y "%OUT%\end06.anm" "%OUT%\_work_end06_anm\end06.anm" >nul
cd /d "%OUT%\_work_end06_anm"
thanm.exe -x 19 end06.anm
cd /d "%OUT%"
del /q "%OUT%\end06.anm"
del /q "%OUT%\_work_end06_anm\end06.anm"
mkdir "%OUT%\end06.anm"
xcopy /e /y /q "%OUT%\_work_end06_anm\*" "%OUT%\end06.anm\" >nul
rmdir /s /q "%OUT%\_work_end06_anm"
if exist "%OUT%\_work_end06_msg" rmdir /s /q "%OUT%\_work_end06_msg"
mkdir "%OUT%\_work_end06_msg"
copy /y "%OUT%\end06.msg" "%OUT%\_work_end06_msg\end06.msg" >nul
cd /d "%OUT%\_work_end06_msg"
thmsg.exe -d 19 end06.msg end06.txt
cd /d "%OUT%"
del /q "%OUT%\end06.msg"
del /q "%OUT%\_work_end06_msg\end06.msg"
mkdir "%OUT%\end06.msg"
xcopy /e /y /q "%OUT%\_work_end06_msg\*" "%OUT%\end06.msg\" >nul
rmdir /s /q "%OUT%\_work_end06_msg"
if exist "%OUT%\_work_end07_anm" rmdir /s /q "%OUT%\_work_end07_anm"
mkdir "%OUT%\_work_end07_anm"
copy /y "%OUT%\end07.anm" "%OUT%\_work_end07_anm\end07.anm" >nul
cd /d "%OUT%\_work_end07_anm"
thanm.exe -x 19 end07.anm
cd /d "%OUT%"
del /q "%OUT%\end07.anm"
del /q "%OUT%\_work_end07_anm\end07.anm"
mkdir "%OUT%\end07.anm"
xcopy /e /y /q "%OUT%\_work_end07_anm\*" "%OUT%\end07.anm\" >nul
rmdir /s /q "%OUT%\_work_end07_anm"
if exist "%OUT%\_work_end07_msg" rmdir /s /q "%OUT%\_work_end07_msg"
mkdir "%OUT%\_work_end07_msg"
copy /y "%OUT%\end07.msg" "%OUT%\_work_end07_msg\end07.msg" >nul
cd /d "%OUT%\_work_end07_msg"
thmsg.exe -d 19 end07.msg end07.txt
cd /d "%OUT%"
del /q "%OUT%\end07.msg"
del /q "%OUT%\_work_end07_msg\end07.msg"
mkdir "%OUT%\end07.msg"
xcopy /e /y /q "%OUT%\_work_end07_msg\*" "%OUT%\end07.msg\" >nul
rmdir /s /q "%OUT%\_work_end07_msg"
if exist "%OUT%\_work_end08_anm" rmdir /s /q "%OUT%\_work_end08_anm"
mkdir "%OUT%\_work_end08_anm"
copy /y "%OUT%\end08.anm" "%OUT%\_work_end08_anm\end08.anm" >nul
cd /d "%OUT%\_work_end08_anm"
thanm.exe -x 19 end08.anm
cd /d "%OUT%"
del /q "%OUT%\end08.anm"
del /q "%OUT%\_work_end08_anm\end08.anm"
mkdir "%OUT%\end08.anm"
xcopy /e /y /q "%OUT%\_work_end08_anm\*" "%OUT%\end08.anm\" >nul
rmdir /s /q "%OUT%\_work_end08_anm"
if exist "%OUT%\_work_end08_msg" rmdir /s /q "%OUT%\_work_end08_msg"
mkdir "%OUT%\_work_end08_msg"
copy /y "%OUT%\end08.msg" "%OUT%\_work_end08_msg\end08.msg" >nul
cd /d "%OUT%\_work_end08_msg"
thmsg.exe -d 19 end08.msg end08.txt
cd /d "%OUT%"
del /q "%OUT%\end08.msg"
del /q "%OUT%\_work_end08_msg\end08.msg"
mkdir "%OUT%\end08.msg"
xcopy /e /y /q "%OUT%\_work_end08_msg\*" "%OUT%\end08.msg\" >nul
rmdir /s /q "%OUT%\_work_end08_msg"
if exist "%OUT%\_work_end09_anm" rmdir /s /q "%OUT%\_work_end09_anm"
mkdir "%OUT%\_work_end09_anm"
copy /y "%OUT%\end09.anm" "%OUT%\_work_end09_anm\end09.anm" >nul
cd /d "%OUT%\_work_end09_anm"
thanm.exe -x 19 end09.anm
cd /d "%OUT%"
del /q "%OUT%\end09.anm"
del /q "%OUT%\_work_end09_anm\end09.anm"
mkdir "%OUT%\end09.anm"
xcopy /e /y /q "%OUT%\_work_end09_anm\*" "%OUT%\end09.anm\" >nul
rmdir /s /q "%OUT%\_work_end09_anm"
if exist "%OUT%\_work_end09_msg" rmdir /s /q "%OUT%\_work_end09_msg"
mkdir "%OUT%\_work_end09_msg"
copy /y "%OUT%\end09.msg" "%OUT%\_work_end09_msg\end09.msg" >nul
cd /d "%OUT%\_work_end09_msg"
thmsg.exe -d 19 end09.msg end09.txt
cd /d "%OUT%"
del /q "%OUT%\end09.msg"
del /q "%OUT%\_work_end09_msg\end09.msg"
mkdir "%OUT%\end09.msg"
xcopy /e /y /q "%OUT%\_work_end09_msg\*" "%OUT%\end09.msg\" >nul
rmdir /s /q "%OUT%\_work_end09_msg"
if exist "%OUT%\_work_end10_anm" rmdir /s /q "%OUT%\_work_end10_anm"
mkdir "%OUT%\_work_end10_anm"
copy /y "%OUT%\end10.anm" "%OUT%\_work_end10_anm\end10.anm" >nul
cd /d "%OUT%\_work_end10_anm"
thanm.exe -x 19 end10.anm
cd /d "%OUT%"
del /q "%OUT%\end10.anm"
del /q "%OUT%\_work_end10_anm\end10.anm"
mkdir "%OUT%\end10.anm"
xcopy /e /y /q "%OUT%\_work_end10_anm\*" "%OUT%\end10.anm\" >nul
rmdir /s /q "%OUT%\_work_end10_anm"
if exist "%OUT%\_work_end10_msg" rmdir /s /q "%OUT%\_work_end10_msg"
mkdir "%OUT%\_work_end10_msg"
copy /y "%OUT%\end10.msg" "%OUT%\_work_end10_msg\end10.msg" >nul
cd /d "%OUT%\_work_end10_msg"
thmsg.exe -d 19 end10.msg end10.txt
cd /d "%OUT%"
del /q "%OUT%\end10.msg"
del /q "%OUT%\_work_end10_msg\end10.msg"
mkdir "%OUT%\end10.msg"
xcopy /e /y /q "%OUT%\_work_end10_msg\*" "%OUT%\end10.msg\" >nul
rmdir /s /q "%OUT%\_work_end10_msg"
if exist "%OUT%\_work_end11_anm" rmdir /s /q "%OUT%\_work_end11_anm"
mkdir "%OUT%\_work_end11_anm"
copy /y "%OUT%\end11.anm" "%OUT%\_work_end11_anm\end11.anm" >nul
cd /d "%OUT%\_work_end11_anm"
thanm.exe -x 19 end11.anm
cd /d "%OUT%"
del /q "%OUT%\end11.anm"
del /q "%OUT%\_work_end11_anm\end11.anm"
mkdir "%OUT%\end11.anm"
xcopy /e /y /q "%OUT%\_work_end11_anm\*" "%OUT%\end11.anm\" >nul
rmdir /s /q "%OUT%\_work_end11_anm"
if exist "%OUT%\_work_end11_msg" rmdir /s /q "%OUT%\_work_end11_msg"
mkdir "%OUT%\_work_end11_msg"
copy /y "%OUT%\end11.msg" "%OUT%\_work_end11_msg\end11.msg" >nul
cd /d "%OUT%\_work_end11_msg"
thmsg.exe -d 19 end11.msg end11.txt
cd /d "%OUT%"
del /q "%OUT%\end11.msg"
del /q "%OUT%\_work_end11_msg\end11.msg"
mkdir "%OUT%\end11.msg"
xcopy /e /y /q "%OUT%\_work_end11_msg\*" "%OUT%\end11.msg\" >nul
rmdir /s /q "%OUT%\_work_end11_msg"
if exist "%OUT%\_work_end12_anm" rmdir /s /q "%OUT%\_work_end12_anm"
mkdir "%OUT%\_work_end12_anm"
copy /y "%OUT%\end12.anm" "%OUT%\_work_end12_anm\end12.anm" >nul
cd /d "%OUT%\_work_end12_anm"
thanm.exe -x 19 end12.anm
cd /d "%OUT%"
del /q "%OUT%\end12.anm"
del /q "%OUT%\_work_end12_anm\end12.anm"
mkdir "%OUT%\end12.anm"
xcopy /e /y /q "%OUT%\_work_end12_anm\*" "%OUT%\end12.anm\" >nul
rmdir /s /q "%OUT%\_work_end12_anm"
if exist "%OUT%\_work_end12_msg" rmdir /s /q "%OUT%\_work_end12_msg"
mkdir "%OUT%\_work_end12_msg"
copy /y "%OUT%\end12.msg" "%OUT%\_work_end12_msg\end12.msg" >nul
cd /d "%OUT%\_work_end12_msg"
thmsg.exe -d 19 end12.msg end12.txt
cd /d "%OUT%"
del /q "%OUT%\end12.msg"
del /q "%OUT%\_work_end12_msg\end12.msg"
mkdir "%OUT%\end12.msg"
xcopy /e /y /q "%OUT%\_work_end12_msg\*" "%OUT%\end12.msg\" >nul
rmdir /s /q "%OUT%\_work_end12_msg"
if exist "%OUT%\_work_end13_anm" rmdir /s /q "%OUT%\_work_end13_anm"
mkdir "%OUT%\_work_end13_anm"
copy /y "%OUT%\end13.anm" "%OUT%\_work_end13_anm\end13.anm" >nul
cd /d "%OUT%\_work_end13_anm"
thanm.exe -x 19 end13.anm
cd /d "%OUT%"
del /q "%OUT%\end13.anm"
del /q "%OUT%\_work_end13_anm\end13.anm"
mkdir "%OUT%\end13.anm"
xcopy /e /y /q "%OUT%\_work_end13_anm\*" "%OUT%\end13.anm\" >nul
rmdir /s /q "%OUT%\_work_end13_anm"
if exist "%OUT%\_work_end13_msg" rmdir /s /q "%OUT%\_work_end13_msg"
mkdir "%OUT%\_work_end13_msg"
copy /y "%OUT%\end13.msg" "%OUT%\_work_end13_msg\end13.msg" >nul
cd /d "%OUT%\_work_end13_msg"
thmsg.exe -d 19 end13.msg end13.txt
cd /d "%OUT%"
del /q "%OUT%\end13.msg"
del /q "%OUT%\_work_end13_msg\end13.msg"
mkdir "%OUT%\end13.msg"
xcopy /e /y /q "%OUT%\_work_end13_msg\*" "%OUT%\end13.msg\" >nul
rmdir /s /q "%OUT%\_work_end13_msg"
if exist "%OUT%\_work_end14_anm" rmdir /s /q "%OUT%\_work_end14_anm"
mkdir "%OUT%\_work_end14_anm"
copy /y "%OUT%\end14.anm" "%OUT%\_work_end14_anm\end14.anm" >nul
cd /d "%OUT%\_work_end14_anm"
thanm.exe -x 19 end14.anm
cd /d "%OUT%"
del /q "%OUT%\end14.anm"
del /q "%OUT%\_work_end14_anm\end14.anm"
mkdir "%OUT%\end14.anm"
xcopy /e /y /q "%OUT%\_work_end14_anm\*" "%OUT%\end14.anm\" >nul
rmdir /s /q "%OUT%\_work_end14_anm"
if exist "%OUT%\_work_end14_msg" rmdir /s /q "%OUT%\_work_end14_msg"
mkdir "%OUT%\_work_end14_msg"
copy /y "%OUT%\end14.msg" "%OUT%\_work_end14_msg\end14.msg" >nul
cd /d "%OUT%\_work_end14_msg"
thmsg.exe -d 19 end14.msg end14.txt
cd /d "%OUT%"
del /q "%OUT%\end14.msg"
del /q "%OUT%\_work_end14_msg\end14.msg"
mkdir "%OUT%\end14.msg"
xcopy /e /y /q "%OUT%\_work_end14_msg\*" "%OUT%\end14.msg\" >nul
rmdir /s /q "%OUT%\_work_end14_msg"
if exist "%OUT%\_work_end15_anm" rmdir /s /q "%OUT%\_work_end15_anm"
mkdir "%OUT%\_work_end15_anm"
copy /y "%OUT%\end15.anm" "%OUT%\_work_end15_anm\end15.anm" >nul
cd /d "%OUT%\_work_end15_anm"
thanm.exe -x 19 end15.anm
cd /d "%OUT%"
del /q "%OUT%\end15.anm"
del /q "%OUT%\_work_end15_anm\end15.anm"
mkdir "%OUT%\end15.anm"
xcopy /e /y /q "%OUT%\_work_end15_anm\*" "%OUT%\end15.anm\" >nul
rmdir /s /q "%OUT%\_work_end15_anm"
if exist "%OUT%\_work_end15_msg" rmdir /s /q "%OUT%\_work_end15_msg"
mkdir "%OUT%\_work_end15_msg"
copy /y "%OUT%\end15.msg" "%OUT%\_work_end15_msg\end15.msg" >nul
cd /d "%OUT%\_work_end15_msg"
thmsg.exe -d 19 end15.msg end15.txt
cd /d "%OUT%"
del /q "%OUT%\end15.msg"
del /q "%OUT%\_work_end15_msg\end15.msg"
mkdir "%OUT%\end15.msg"
xcopy /e /y /q "%OUT%\_work_end15_msg\*" "%OUT%\end15.msg\" >nul
rmdir /s /q "%OUT%\_work_end15_msg"
if exist "%OUT%\_work_end16_anm" rmdir /s /q "%OUT%\_work_end16_anm"
mkdir "%OUT%\_work_end16_anm"
copy /y "%OUT%\end16.anm" "%OUT%\_work_end16_anm\end16.anm" >nul
cd /d "%OUT%\_work_end16_anm"
thanm.exe -x 19 end16.anm
cd /d "%OUT%"
del /q "%OUT%\end16.anm"
del /q "%OUT%\_work_end16_anm\end16.anm"
mkdir "%OUT%\end16.anm"
xcopy /e /y /q "%OUT%\_work_end16_anm\*" "%OUT%\end16.anm\" >nul
rmdir /s /q "%OUT%\_work_end16_anm"
if exist "%OUT%\_work_end16_msg" rmdir /s /q "%OUT%\_work_end16_msg"
mkdir "%OUT%\_work_end16_msg"
copy /y "%OUT%\end16.msg" "%OUT%\_work_end16_msg\end16.msg" >nul
cd /d "%OUT%\_work_end16_msg"
thmsg.exe -d 19 end16.msg end16.txt
cd /d "%OUT%"
del /q "%OUT%\end16.msg"
del /q "%OUT%\_work_end16_msg\end16.msg"
mkdir "%OUT%\end16.msg"
xcopy /e /y /q "%OUT%\_work_end16_msg\*" "%OUT%\end16.msg\" >nul
rmdir /s /q "%OUT%\_work_end16_msg"
if exist "%OUT%\_work_end17_anm" rmdir /s /q "%OUT%\_work_end17_anm"
mkdir "%OUT%\_work_end17_anm"
copy /y "%OUT%\end17.anm" "%OUT%\_work_end17_anm\end17.anm" >nul
cd /d "%OUT%\_work_end17_anm"
thanm.exe -x 19 end17.anm
cd /d "%OUT%"
del /q "%OUT%\end17.anm"
del /q "%OUT%\_work_end17_anm\end17.anm"
mkdir "%OUT%\end17.anm"
xcopy /e /y /q "%OUT%\_work_end17_anm\*" "%OUT%\end17.anm\" >nul
rmdir /s /q "%OUT%\_work_end17_anm"
if exist "%OUT%\_work_end17_msg" rmdir /s /q "%OUT%\_work_end17_msg"
mkdir "%OUT%\_work_end17_msg"
copy /y "%OUT%\end17.msg" "%OUT%\_work_end17_msg\end17.msg" >nul
cd /d "%OUT%\_work_end17_msg"
thmsg.exe -d 19 end17.msg end17.txt
cd /d "%OUT%"
del /q "%OUT%\end17.msg"
del /q "%OUT%\_work_end17_msg\end17.msg"
mkdir "%OUT%\end17.msg"
xcopy /e /y /q "%OUT%\_work_end17_msg\*" "%OUT%\end17.msg\" >nul
rmdir /s /q "%OUT%\_work_end17_msg"
if exist "%OUT%\_work_end18_anm" rmdir /s /q "%OUT%\_work_end18_anm"
mkdir "%OUT%\_work_end18_anm"
copy /y "%OUT%\end18.anm" "%OUT%\_work_end18_anm\end18.anm" >nul
cd /d "%OUT%\_work_end18_anm"
thanm.exe -x 19 end18.anm
cd /d "%OUT%"
del /q "%OUT%\end18.anm"
del /q "%OUT%\_work_end18_anm\end18.anm"
mkdir "%OUT%\end18.anm"
xcopy /e /y /q "%OUT%\_work_end18_anm\*" "%OUT%\end18.anm\" >nul
rmdir /s /q "%OUT%\_work_end18_anm"
if exist "%OUT%\_work_end18_msg" rmdir /s /q "%OUT%\_work_end18_msg"
mkdir "%OUT%\_work_end18_msg"
copy /y "%OUT%\end18.msg" "%OUT%\_work_end18_msg\end18.msg" >nul
cd /d "%OUT%\_work_end18_msg"
thmsg.exe -d 19 end18.msg end18.txt
cd /d "%OUT%"
del /q "%OUT%\end18.msg"
del /q "%OUT%\_work_end18_msg\end18.msg"
mkdir "%OUT%\end18.msg"
xcopy /e /y /q "%OUT%\_work_end18_msg\*" "%OUT%\end18.msg\" >nul
rmdir /s /q "%OUT%\_work_end18_msg"
if exist "%OUT%\_work_enemy_anm" rmdir /s /q "%OUT%\_work_enemy_anm"
mkdir "%OUT%\_work_enemy_anm"
copy /y "%OUT%\enemy.anm" "%OUT%\_work_enemy_anm\enemy.anm" >nul
cd /d "%OUT%\_work_enemy_anm"
thanm.exe -x 19 enemy.anm
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
thanm.exe -x 19 front.anm
cd /d "%OUT%"
del /q "%OUT%\front.anm"
del /q "%OUT%\_work_front_anm\front.anm"
mkdir "%OUT%\front.anm"
xcopy /e /y /q "%OUT%\_work_front_anm\*" "%OUT%\front.anm\" >nul
rmdir /s /q "%OUT%\_work_front_anm"
if exist "%OUT%\_work_ghost_anm" rmdir /s /q "%OUT%\_work_ghost_anm"
mkdir "%OUT%\_work_ghost_anm"
copy /y "%OUT%\ghost.anm" "%OUT%\_work_ghost_anm\ghost.anm" >nul
cd /d "%OUT%\_work_ghost_anm"
thanm.exe -x 19 ghost.anm
cd /d "%OUT%"
del /q "%OUT%\ghost.anm"
del /q "%OUT%\_work_ghost_anm\ghost.anm"
mkdir "%OUT%\ghost.anm"
xcopy /e /y /q "%OUT%\_work_ghost_anm\*" "%OUT%\ghost.anm\" >nul
rmdir /s /q "%OUT%\_work_ghost_anm"
if exist "%OUT%\_work_help_anm" rmdir /s /q "%OUT%\_work_help_anm"
mkdir "%OUT%\_work_help_anm"
copy /y "%OUT%\help.anm" "%OUT%\_work_help_anm\help.anm" >nul
cd /d "%OUT%\_work_help_anm"
thanm.exe -x 19 help.anm
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
thanm.exe -x 19 notice.anm
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
thanm.exe -x 19 pl00.anm
cd /d "%OUT%"
del /q "%OUT%\pl00.anm"
del /q "%OUT%\_work_pl00_anm\pl00.anm"
mkdir "%OUT%\pl00.anm"
xcopy /e /y /q "%OUT%\_work_pl00_anm\*" "%OUT%\pl00.anm\" >nul
rmdir /s /q "%OUT%\_work_pl00_anm"
if exist "%OUT%\_work_pl00_ecl" rmdir /s /q "%OUT%\_work_pl00_ecl"
mkdir "%OUT%\_work_pl00_ecl"
copy /y "%OUT%\pl00.ecl" "%OUT%\_work_pl00_ecl\pl00.ecl" >nul
cd /d "%OUT%\_work_pl00_ecl"
thecl.exe -d 19 pl00.ecl pl00.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl00.ecl"
del /q "%OUT%\_work_pl00_ecl\pl00.ecl"
mkdir "%OUT%\pl00.ecl"
xcopy /e /y /q "%OUT%\_work_pl00_ecl\*" "%OUT%\pl00.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl00_ecl"
if exist "%OUT%\_work_pl00b_anm" rmdir /s /q "%OUT%\_work_pl00b_anm"
mkdir "%OUT%\_work_pl00b_anm"
copy /y "%OUT%\pl00b.anm" "%OUT%\_work_pl00b_anm\pl00b.anm" >nul
cd /d "%OUT%\_work_pl00b_anm"
thanm.exe -x 19 pl00b.anm
cd /d "%OUT%"
del /q "%OUT%\pl00b.anm"
del /q "%OUT%\_work_pl00b_anm\pl00b.anm"
mkdir "%OUT%\pl00b.anm"
xcopy /e /y /q "%OUT%\_work_pl00b_anm\*" "%OUT%\pl00b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl00b_anm"
if exist "%OUT%\_work_pl00f_anm" rmdir /s /q "%OUT%\_work_pl00f_anm"
mkdir "%OUT%\_work_pl00f_anm"
copy /y "%OUT%\pl00f.anm" "%OUT%\_work_pl00f_anm\pl00f.anm" >nul
cd /d "%OUT%\_work_pl00f_anm"
thanm.exe -x 19 pl00f.anm
cd /d "%OUT%"
del /q "%OUT%\pl00f.anm"
del /q "%OUT%\_work_pl00f_anm\pl00f.anm"
mkdir "%OUT%\pl00f.anm"
xcopy /e /y /q "%OUT%\_work_pl00f_anm\*" "%OUT%\pl00f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl00f_anm"
if exist "%OUT%\_work_pl00st_msg" rmdir /s /q "%OUT%\_work_pl00st_msg"
mkdir "%OUT%\_work_pl00st_msg"
copy /y "%OUT%\pl00st.msg" "%OUT%\_work_pl00st_msg\pl00st.msg" >nul
cd /d "%OUT%\_work_pl00st_msg"
thmsg.exe -d 19 pl00st.msg pl00st.txt
cd /d "%OUT%"
del /q "%OUT%\pl00st.msg"
del /q "%OUT%\_work_pl00st_msg\pl00st.msg"
mkdir "%OUT%\pl00st.msg"
xcopy /e /y /q "%OUT%\_work_pl00st_msg\*" "%OUT%\pl00st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl00st_msg"
if exist "%OUT%\_work_pl00vs_msg" rmdir /s /q "%OUT%\_work_pl00vs_msg"
mkdir "%OUT%\_work_pl00vs_msg"
copy /y "%OUT%\pl00vs.msg" "%OUT%\_work_pl00vs_msg\pl00vs.msg" >nul
cd /d "%OUT%\_work_pl00vs_msg"
thmsg.exe -d 19 pl00vs.msg pl00vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl00vs.msg"
del /q "%OUT%\_work_pl00vs_msg\pl00vs.msg"
mkdir "%OUT%\pl00vs.msg"
xcopy /e /y /q "%OUT%\_work_pl00vs_msg\*" "%OUT%\pl00vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl00vs_msg"
if exist "%OUT%\_work_pl01_anm" rmdir /s /q "%OUT%\_work_pl01_anm"
mkdir "%OUT%\_work_pl01_anm"
copy /y "%OUT%\pl01.anm" "%OUT%\_work_pl01_anm\pl01.anm" >nul
cd /d "%OUT%\_work_pl01_anm"
thanm.exe -x 19 pl01.anm
cd /d "%OUT%"
del /q "%OUT%\pl01.anm"
del /q "%OUT%\_work_pl01_anm\pl01.anm"
mkdir "%OUT%\pl01.anm"
xcopy /e /y /q "%OUT%\_work_pl01_anm\*" "%OUT%\pl01.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01_anm"
if exist "%OUT%\_work_pl01_ecl" rmdir /s /q "%OUT%\_work_pl01_ecl"
mkdir "%OUT%\_work_pl01_ecl"
copy /y "%OUT%\pl01.ecl" "%OUT%\_work_pl01_ecl\pl01.ecl" >nul
cd /d "%OUT%\_work_pl01_ecl"
thecl.exe -d 19 pl01.ecl pl01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl01.ecl"
del /q "%OUT%\_work_pl01_ecl\pl01.ecl"
mkdir "%OUT%\pl01.ecl"
xcopy /e /y /q "%OUT%\_work_pl01_ecl\*" "%OUT%\pl01.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl01_ecl"
if exist "%OUT%\_work_pl01b_anm" rmdir /s /q "%OUT%\_work_pl01b_anm"
mkdir "%OUT%\_work_pl01b_anm"
copy /y "%OUT%\pl01b.anm" "%OUT%\_work_pl01b_anm\pl01b.anm" >nul
cd /d "%OUT%\_work_pl01b_anm"
thanm.exe -x 19 pl01b.anm
cd /d "%OUT%"
del /q "%OUT%\pl01b.anm"
del /q "%OUT%\_work_pl01b_anm\pl01b.anm"
mkdir "%OUT%\pl01b.anm"
xcopy /e /y /q "%OUT%\_work_pl01b_anm\*" "%OUT%\pl01b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01b_anm"
if exist "%OUT%\_work_pl01f_anm" rmdir /s /q "%OUT%\_work_pl01f_anm"
mkdir "%OUT%\_work_pl01f_anm"
copy /y "%OUT%\pl01f.anm" "%OUT%\_work_pl01f_anm\pl01f.anm" >nul
cd /d "%OUT%\_work_pl01f_anm"
thanm.exe -x 19 pl01f.anm
cd /d "%OUT%"
del /q "%OUT%\pl01f.anm"
del /q "%OUT%\_work_pl01f_anm\pl01f.anm"
mkdir "%OUT%\pl01f.anm"
xcopy /e /y /q "%OUT%\_work_pl01f_anm\*" "%OUT%\pl01f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01f_anm"
if exist "%OUT%\_work_pl01st_msg" rmdir /s /q "%OUT%\_work_pl01st_msg"
mkdir "%OUT%\_work_pl01st_msg"
copy /y "%OUT%\pl01st.msg" "%OUT%\_work_pl01st_msg\pl01st.msg" >nul
cd /d "%OUT%\_work_pl01st_msg"
thmsg.exe -d 19 pl01st.msg pl01st.txt
cd /d "%OUT%"
del /q "%OUT%\pl01st.msg"
del /q "%OUT%\_work_pl01st_msg\pl01st.msg"
mkdir "%OUT%\pl01st.msg"
xcopy /e /y /q "%OUT%\_work_pl01st_msg\*" "%OUT%\pl01st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl01st_msg"
if exist "%OUT%\_work_pl01vs_msg" rmdir /s /q "%OUT%\_work_pl01vs_msg"
mkdir "%OUT%\_work_pl01vs_msg"
copy /y "%OUT%\pl01vs.msg" "%OUT%\_work_pl01vs_msg\pl01vs.msg" >nul
cd /d "%OUT%\_work_pl01vs_msg"
thmsg.exe -d 19 pl01vs.msg pl01vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl01vs.msg"
del /q "%OUT%\_work_pl01vs_msg\pl01vs.msg"
mkdir "%OUT%\pl01vs.msg"
xcopy /e /y /q "%OUT%\_work_pl01vs_msg\*" "%OUT%\pl01vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl01vs_msg"
if exist "%OUT%\_work_pl02_anm" rmdir /s /q "%OUT%\_work_pl02_anm"
mkdir "%OUT%\_work_pl02_anm"
copy /y "%OUT%\pl02.anm" "%OUT%\_work_pl02_anm\pl02.anm" >nul
cd /d "%OUT%\_work_pl02_anm"
thanm.exe -x 19 pl02.anm
cd /d "%OUT%"
del /q "%OUT%\pl02.anm"
del /q "%OUT%\_work_pl02_anm\pl02.anm"
mkdir "%OUT%\pl02.anm"
xcopy /e /y /q "%OUT%\_work_pl02_anm\*" "%OUT%\pl02.anm\" >nul
rmdir /s /q "%OUT%\_work_pl02_anm"
if exist "%OUT%\_work_pl02_ecl" rmdir /s /q "%OUT%\_work_pl02_ecl"
mkdir "%OUT%\_work_pl02_ecl"
copy /y "%OUT%\pl02.ecl" "%OUT%\_work_pl02_ecl\pl02.ecl" >nul
cd /d "%OUT%\_work_pl02_ecl"
thecl.exe -d 19 pl02.ecl pl02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl02.ecl"
del /q "%OUT%\_work_pl02_ecl\pl02.ecl"
mkdir "%OUT%\pl02.ecl"
xcopy /e /y /q "%OUT%\_work_pl02_ecl\*" "%OUT%\pl02.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl02_ecl"
if exist "%OUT%\_work_pl02b_anm" rmdir /s /q "%OUT%\_work_pl02b_anm"
mkdir "%OUT%\_work_pl02b_anm"
copy /y "%OUT%\pl02b.anm" "%OUT%\_work_pl02b_anm\pl02b.anm" >nul
cd /d "%OUT%\_work_pl02b_anm"
thanm.exe -x 19 pl02b.anm
cd /d "%OUT%"
del /q "%OUT%\pl02b.anm"
del /q "%OUT%\_work_pl02b_anm\pl02b.anm"
mkdir "%OUT%\pl02b.anm"
xcopy /e /y /q "%OUT%\_work_pl02b_anm\*" "%OUT%\pl02b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl02b_anm"
if exist "%OUT%\_work_pl02f_anm" rmdir /s /q "%OUT%\_work_pl02f_anm"
mkdir "%OUT%\_work_pl02f_anm"
copy /y "%OUT%\pl02f.anm" "%OUT%\_work_pl02f_anm\pl02f.anm" >nul
cd /d "%OUT%\_work_pl02f_anm"
thanm.exe -x 19 pl02f.anm
cd /d "%OUT%"
del /q "%OUT%\pl02f.anm"
del /q "%OUT%\_work_pl02f_anm\pl02f.anm"
mkdir "%OUT%\pl02f.anm"
xcopy /e /y /q "%OUT%\_work_pl02f_anm\*" "%OUT%\pl02f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl02f_anm"
if exist "%OUT%\_work_pl02st_msg" rmdir /s /q "%OUT%\_work_pl02st_msg"
mkdir "%OUT%\_work_pl02st_msg"
copy /y "%OUT%\pl02st.msg" "%OUT%\_work_pl02st_msg\pl02st.msg" >nul
cd /d "%OUT%\_work_pl02st_msg"
thmsg.exe -d 19 pl02st.msg pl02st.txt
cd /d "%OUT%"
del /q "%OUT%\pl02st.msg"
del /q "%OUT%\_work_pl02st_msg\pl02st.msg"
mkdir "%OUT%\pl02st.msg"
xcopy /e /y /q "%OUT%\_work_pl02st_msg\*" "%OUT%\pl02st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl02st_msg"
if exist "%OUT%\_work_pl02vs_msg" rmdir /s /q "%OUT%\_work_pl02vs_msg"
mkdir "%OUT%\_work_pl02vs_msg"
copy /y "%OUT%\pl02vs.msg" "%OUT%\_work_pl02vs_msg\pl02vs.msg" >nul
cd /d "%OUT%\_work_pl02vs_msg"
thmsg.exe -d 19 pl02vs.msg pl02vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl02vs.msg"
del /q "%OUT%\_work_pl02vs_msg\pl02vs.msg"
mkdir "%OUT%\pl02vs.msg"
xcopy /e /y /q "%OUT%\_work_pl02vs_msg\*" "%OUT%\pl02vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl02vs_msg"
if exist "%OUT%\_work_pl03_anm" rmdir /s /q "%OUT%\_work_pl03_anm"
mkdir "%OUT%\_work_pl03_anm"
copy /y "%OUT%\pl03.anm" "%OUT%\_work_pl03_anm\pl03.anm" >nul
cd /d "%OUT%\_work_pl03_anm"
thanm.exe -x 19 pl03.anm
cd /d "%OUT%"
del /q "%OUT%\pl03.anm"
del /q "%OUT%\_work_pl03_anm\pl03.anm"
mkdir "%OUT%\pl03.anm"
xcopy /e /y /q "%OUT%\_work_pl03_anm\*" "%OUT%\pl03.anm\" >nul
rmdir /s /q "%OUT%\_work_pl03_anm"
if exist "%OUT%\_work_pl03_ecl" rmdir /s /q "%OUT%\_work_pl03_ecl"
mkdir "%OUT%\_work_pl03_ecl"
copy /y "%OUT%\pl03.ecl" "%OUT%\_work_pl03_ecl\pl03.ecl" >nul
cd /d "%OUT%\_work_pl03_ecl"
thecl.exe -d 19 pl03.ecl pl03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl03.ecl"
del /q "%OUT%\_work_pl03_ecl\pl03.ecl"
mkdir "%OUT%\pl03.ecl"
xcopy /e /y /q "%OUT%\_work_pl03_ecl\*" "%OUT%\pl03.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl03_ecl"
if exist "%OUT%\_work_pl03b_anm" rmdir /s /q "%OUT%\_work_pl03b_anm"
mkdir "%OUT%\_work_pl03b_anm"
copy /y "%OUT%\pl03b.anm" "%OUT%\_work_pl03b_anm\pl03b.anm" >nul
cd /d "%OUT%\_work_pl03b_anm"
thanm.exe -x 19 pl03b.anm
cd /d "%OUT%"
del /q "%OUT%\pl03b.anm"
del /q "%OUT%\_work_pl03b_anm\pl03b.anm"
mkdir "%OUT%\pl03b.anm"
xcopy /e /y /q "%OUT%\_work_pl03b_anm\*" "%OUT%\pl03b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl03b_anm"
if exist "%OUT%\_work_pl03f_anm" rmdir /s /q "%OUT%\_work_pl03f_anm"
mkdir "%OUT%\_work_pl03f_anm"
copy /y "%OUT%\pl03f.anm" "%OUT%\_work_pl03f_anm\pl03f.anm" >nul
cd /d "%OUT%\_work_pl03f_anm"
thanm.exe -x 19 pl03f.anm
cd /d "%OUT%"
del /q "%OUT%\pl03f.anm"
del /q "%OUT%\_work_pl03f_anm\pl03f.anm"
mkdir "%OUT%\pl03f.anm"
xcopy /e /y /q "%OUT%\_work_pl03f_anm\*" "%OUT%\pl03f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl03f_anm"
if exist "%OUT%\_work_pl03st_msg" rmdir /s /q "%OUT%\_work_pl03st_msg"
mkdir "%OUT%\_work_pl03st_msg"
copy /y "%OUT%\pl03st.msg" "%OUT%\_work_pl03st_msg\pl03st.msg" >nul
cd /d "%OUT%\_work_pl03st_msg"
thmsg.exe -d 19 pl03st.msg pl03st.txt
cd /d "%OUT%"
del /q "%OUT%\pl03st.msg"
del /q "%OUT%\_work_pl03st_msg\pl03st.msg"
mkdir "%OUT%\pl03st.msg"
xcopy /e /y /q "%OUT%\_work_pl03st_msg\*" "%OUT%\pl03st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl03st_msg"
if exist "%OUT%\_work_pl03vs_msg" rmdir /s /q "%OUT%\_work_pl03vs_msg"
mkdir "%OUT%\_work_pl03vs_msg"
copy /y "%OUT%\pl03vs.msg" "%OUT%\_work_pl03vs_msg\pl03vs.msg" >nul
cd /d "%OUT%\_work_pl03vs_msg"
thmsg.exe -d 19 pl03vs.msg pl03vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl03vs.msg"
del /q "%OUT%\_work_pl03vs_msg\pl03vs.msg"
mkdir "%OUT%\pl03vs.msg"
xcopy /e /y /q "%OUT%\_work_pl03vs_msg\*" "%OUT%\pl03vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl03vs_msg"
if exist "%OUT%\_work_pl04_anm" rmdir /s /q "%OUT%\_work_pl04_anm"
mkdir "%OUT%\_work_pl04_anm"
copy /y "%OUT%\pl04.anm" "%OUT%\_work_pl04_anm\pl04.anm" >nul
cd /d "%OUT%\_work_pl04_anm"
thanm.exe -x 19 pl04.anm
cd /d "%OUT%"
del /q "%OUT%\pl04.anm"
del /q "%OUT%\_work_pl04_anm\pl04.anm"
mkdir "%OUT%\pl04.anm"
xcopy /e /y /q "%OUT%\_work_pl04_anm\*" "%OUT%\pl04.anm\" >nul
rmdir /s /q "%OUT%\_work_pl04_anm"
if exist "%OUT%\_work_pl04_ecl" rmdir /s /q "%OUT%\_work_pl04_ecl"
mkdir "%OUT%\_work_pl04_ecl"
copy /y "%OUT%\pl04.ecl" "%OUT%\_work_pl04_ecl\pl04.ecl" >nul
cd /d "%OUT%\_work_pl04_ecl"
thecl.exe -d 19 pl04.ecl pl04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl04.ecl"
del /q "%OUT%\_work_pl04_ecl\pl04.ecl"
mkdir "%OUT%\pl04.ecl"
xcopy /e /y /q "%OUT%\_work_pl04_ecl\*" "%OUT%\pl04.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl04_ecl"
if exist "%OUT%\_work_pl04b_anm" rmdir /s /q "%OUT%\_work_pl04b_anm"
mkdir "%OUT%\_work_pl04b_anm"
copy /y "%OUT%\pl04b.anm" "%OUT%\_work_pl04b_anm\pl04b.anm" >nul
cd /d "%OUT%\_work_pl04b_anm"
thanm.exe -x 19 pl04b.anm
cd /d "%OUT%"
del /q "%OUT%\pl04b.anm"
del /q "%OUT%\_work_pl04b_anm\pl04b.anm"
mkdir "%OUT%\pl04b.anm"
xcopy /e /y /q "%OUT%\_work_pl04b_anm\*" "%OUT%\pl04b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl04b_anm"
if exist "%OUT%\_work_pl04f_anm" rmdir /s /q "%OUT%\_work_pl04f_anm"
mkdir "%OUT%\_work_pl04f_anm"
copy /y "%OUT%\pl04f.anm" "%OUT%\_work_pl04f_anm\pl04f.anm" >nul
cd /d "%OUT%\_work_pl04f_anm"
thanm.exe -x 19 pl04f.anm
cd /d "%OUT%"
del /q "%OUT%\pl04f.anm"
del /q "%OUT%\_work_pl04f_anm\pl04f.anm"
mkdir "%OUT%\pl04f.anm"
xcopy /e /y /q "%OUT%\_work_pl04f_anm\*" "%OUT%\pl04f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl04f_anm"
if exist "%OUT%\_work_pl04st_msg" rmdir /s /q "%OUT%\_work_pl04st_msg"
mkdir "%OUT%\_work_pl04st_msg"
copy /y "%OUT%\pl04st.msg" "%OUT%\_work_pl04st_msg\pl04st.msg" >nul
cd /d "%OUT%\_work_pl04st_msg"
thmsg.exe -d 19 pl04st.msg pl04st.txt
cd /d "%OUT%"
del /q "%OUT%\pl04st.msg"
del /q "%OUT%\_work_pl04st_msg\pl04st.msg"
mkdir "%OUT%\pl04st.msg"
xcopy /e /y /q "%OUT%\_work_pl04st_msg\*" "%OUT%\pl04st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl04st_msg"
if exist "%OUT%\_work_pl04vs_msg" rmdir /s /q "%OUT%\_work_pl04vs_msg"
mkdir "%OUT%\_work_pl04vs_msg"
copy /y "%OUT%\pl04vs.msg" "%OUT%\_work_pl04vs_msg\pl04vs.msg" >nul
cd /d "%OUT%\_work_pl04vs_msg"
thmsg.exe -d 19 pl04vs.msg pl04vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl04vs.msg"
del /q "%OUT%\_work_pl04vs_msg\pl04vs.msg"
mkdir "%OUT%\pl04vs.msg"
xcopy /e /y /q "%OUT%\_work_pl04vs_msg\*" "%OUT%\pl04vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl04vs_msg"
if exist "%OUT%\_work_pl05_anm" rmdir /s /q "%OUT%\_work_pl05_anm"
mkdir "%OUT%\_work_pl05_anm"
copy /y "%OUT%\pl05.anm" "%OUT%\_work_pl05_anm\pl05.anm" >nul
cd /d "%OUT%\_work_pl05_anm"
thanm.exe -x 19 pl05.anm
cd /d "%OUT%"
del /q "%OUT%\pl05.anm"
del /q "%OUT%\_work_pl05_anm\pl05.anm"
mkdir "%OUT%\pl05.anm"
xcopy /e /y /q "%OUT%\_work_pl05_anm\*" "%OUT%\pl05.anm\" >nul
rmdir /s /q "%OUT%\_work_pl05_anm"
if exist "%OUT%\_work_pl05_ecl" rmdir /s /q "%OUT%\_work_pl05_ecl"
mkdir "%OUT%\_work_pl05_ecl"
copy /y "%OUT%\pl05.ecl" "%OUT%\_work_pl05_ecl\pl05.ecl" >nul
cd /d "%OUT%\_work_pl05_ecl"
thecl.exe -d 19 pl05.ecl pl05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl05.ecl"
del /q "%OUT%\_work_pl05_ecl\pl05.ecl"
mkdir "%OUT%\pl05.ecl"
xcopy /e /y /q "%OUT%\_work_pl05_ecl\*" "%OUT%\pl05.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl05_ecl"
if exist "%OUT%\_work_pl05b_anm" rmdir /s /q "%OUT%\_work_pl05b_anm"
mkdir "%OUT%\_work_pl05b_anm"
copy /y "%OUT%\pl05b.anm" "%OUT%\_work_pl05b_anm\pl05b.anm" >nul
cd /d "%OUT%\_work_pl05b_anm"
thanm.exe -x 19 pl05b.anm
cd /d "%OUT%"
del /q "%OUT%\pl05b.anm"
del /q "%OUT%\_work_pl05b_anm\pl05b.anm"
mkdir "%OUT%\pl05b.anm"
xcopy /e /y /q "%OUT%\_work_pl05b_anm\*" "%OUT%\pl05b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl05b_anm"
if exist "%OUT%\_work_pl05f_anm" rmdir /s /q "%OUT%\_work_pl05f_anm"
mkdir "%OUT%\_work_pl05f_anm"
copy /y "%OUT%\pl05f.anm" "%OUT%\_work_pl05f_anm\pl05f.anm" >nul
cd /d "%OUT%\_work_pl05f_anm"
thanm.exe -x 19 pl05f.anm
cd /d "%OUT%"
del /q "%OUT%\pl05f.anm"
del /q "%OUT%\_work_pl05f_anm\pl05f.anm"
mkdir "%OUT%\pl05f.anm"
xcopy /e /y /q "%OUT%\_work_pl05f_anm\*" "%OUT%\pl05f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl05f_anm"
if exist "%OUT%\_work_pl05st_msg" rmdir /s /q "%OUT%\_work_pl05st_msg"
mkdir "%OUT%\_work_pl05st_msg"
copy /y "%OUT%\pl05st.msg" "%OUT%\_work_pl05st_msg\pl05st.msg" >nul
cd /d "%OUT%\_work_pl05st_msg"
thmsg.exe -d 19 pl05st.msg pl05st.txt
cd /d "%OUT%"
del /q "%OUT%\pl05st.msg"
del /q "%OUT%\_work_pl05st_msg\pl05st.msg"
mkdir "%OUT%\pl05st.msg"
xcopy /e /y /q "%OUT%\_work_pl05st_msg\*" "%OUT%\pl05st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl05st_msg"
if exist "%OUT%\_work_pl05vs_msg" rmdir /s /q "%OUT%\_work_pl05vs_msg"
mkdir "%OUT%\_work_pl05vs_msg"
copy /y "%OUT%\pl05vs.msg" "%OUT%\_work_pl05vs_msg\pl05vs.msg" >nul
cd /d "%OUT%\_work_pl05vs_msg"
thmsg.exe -d 19 pl05vs.msg pl05vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl05vs.msg"
del /q "%OUT%\_work_pl05vs_msg\pl05vs.msg"
mkdir "%OUT%\pl05vs.msg"
xcopy /e /y /q "%OUT%\_work_pl05vs_msg\*" "%OUT%\pl05vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl05vs_msg"
if exist "%OUT%\_work_pl06_anm" rmdir /s /q "%OUT%\_work_pl06_anm"
mkdir "%OUT%\_work_pl06_anm"
copy /y "%OUT%\pl06.anm" "%OUT%\_work_pl06_anm\pl06.anm" >nul
cd /d "%OUT%\_work_pl06_anm"
thanm.exe -x 19 pl06.anm
cd /d "%OUT%"
del /q "%OUT%\pl06.anm"
del /q "%OUT%\_work_pl06_anm\pl06.anm"
mkdir "%OUT%\pl06.anm"
xcopy /e /y /q "%OUT%\_work_pl06_anm\*" "%OUT%\pl06.anm\" >nul
rmdir /s /q "%OUT%\_work_pl06_anm"
if exist "%OUT%\_work_pl06_ecl" rmdir /s /q "%OUT%\_work_pl06_ecl"
mkdir "%OUT%\_work_pl06_ecl"
copy /y "%OUT%\pl06.ecl" "%OUT%\_work_pl06_ecl\pl06.ecl" >nul
cd /d "%OUT%\_work_pl06_ecl"
thecl.exe -d 19 pl06.ecl pl06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl06.ecl"
del /q "%OUT%\_work_pl06_ecl\pl06.ecl"
mkdir "%OUT%\pl06.ecl"
xcopy /e /y /q "%OUT%\_work_pl06_ecl\*" "%OUT%\pl06.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl06_ecl"
if exist "%OUT%\_work_pl06b_anm" rmdir /s /q "%OUT%\_work_pl06b_anm"
mkdir "%OUT%\_work_pl06b_anm"
copy /y "%OUT%\pl06b.anm" "%OUT%\_work_pl06b_anm\pl06b.anm" >nul
cd /d "%OUT%\_work_pl06b_anm"
thanm.exe -x 19 pl06b.anm
cd /d "%OUT%"
del /q "%OUT%\pl06b.anm"
del /q "%OUT%\_work_pl06b_anm\pl06b.anm"
mkdir "%OUT%\pl06b.anm"
xcopy /e /y /q "%OUT%\_work_pl06b_anm\*" "%OUT%\pl06b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl06b_anm"
if exist "%OUT%\_work_pl06f_anm" rmdir /s /q "%OUT%\_work_pl06f_anm"
mkdir "%OUT%\_work_pl06f_anm"
copy /y "%OUT%\pl06f.anm" "%OUT%\_work_pl06f_anm\pl06f.anm" >nul
cd /d "%OUT%\_work_pl06f_anm"
thanm.exe -x 19 pl06f.anm
cd /d "%OUT%"
del /q "%OUT%\pl06f.anm"
del /q "%OUT%\_work_pl06f_anm\pl06f.anm"
mkdir "%OUT%\pl06f.anm"
xcopy /e /y /q "%OUT%\_work_pl06f_anm\*" "%OUT%\pl06f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl06f_anm"
if exist "%OUT%\_work_pl06st_msg" rmdir /s /q "%OUT%\_work_pl06st_msg"
mkdir "%OUT%\_work_pl06st_msg"
copy /y "%OUT%\pl06st.msg" "%OUT%\_work_pl06st_msg\pl06st.msg" >nul
cd /d "%OUT%\_work_pl06st_msg"
thmsg.exe -d 19 pl06st.msg pl06st.txt
cd /d "%OUT%"
del /q "%OUT%\pl06st.msg"
del /q "%OUT%\_work_pl06st_msg\pl06st.msg"
mkdir "%OUT%\pl06st.msg"
xcopy /e /y /q "%OUT%\_work_pl06st_msg\*" "%OUT%\pl06st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl06st_msg"
if exist "%OUT%\_work_pl06vs_msg" rmdir /s /q "%OUT%\_work_pl06vs_msg"
mkdir "%OUT%\_work_pl06vs_msg"
copy /y "%OUT%\pl06vs.msg" "%OUT%\_work_pl06vs_msg\pl06vs.msg" >nul
cd /d "%OUT%\_work_pl06vs_msg"
thmsg.exe -d 19 pl06vs.msg pl06vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl06vs.msg"
del /q "%OUT%\_work_pl06vs_msg\pl06vs.msg"
mkdir "%OUT%\pl06vs.msg"
xcopy /e /y /q "%OUT%\_work_pl06vs_msg\*" "%OUT%\pl06vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl06vs_msg"
if exist "%OUT%\_work_pl07_anm" rmdir /s /q "%OUT%\_work_pl07_anm"
mkdir "%OUT%\_work_pl07_anm"
copy /y "%OUT%\pl07.anm" "%OUT%\_work_pl07_anm\pl07.anm" >nul
cd /d "%OUT%\_work_pl07_anm"
thanm.exe -x 19 pl07.anm
cd /d "%OUT%"
del /q "%OUT%\pl07.anm"
del /q "%OUT%\_work_pl07_anm\pl07.anm"
mkdir "%OUT%\pl07.anm"
xcopy /e /y /q "%OUT%\_work_pl07_anm\*" "%OUT%\pl07.anm\" >nul
rmdir /s /q "%OUT%\_work_pl07_anm"
if exist "%OUT%\_work_pl07_ecl" rmdir /s /q "%OUT%\_work_pl07_ecl"
mkdir "%OUT%\_work_pl07_ecl"
copy /y "%OUT%\pl07.ecl" "%OUT%\_work_pl07_ecl\pl07.ecl" >nul
cd /d "%OUT%\_work_pl07_ecl"
thecl.exe -d 19 pl07.ecl pl07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl07.ecl"
del /q "%OUT%\_work_pl07_ecl\pl07.ecl"
mkdir "%OUT%\pl07.ecl"
xcopy /e /y /q "%OUT%\_work_pl07_ecl\*" "%OUT%\pl07.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl07_ecl"
if exist "%OUT%\_work_pl07b_anm" rmdir /s /q "%OUT%\_work_pl07b_anm"
mkdir "%OUT%\_work_pl07b_anm"
copy /y "%OUT%\pl07b.anm" "%OUT%\_work_pl07b_anm\pl07b.anm" >nul
cd /d "%OUT%\_work_pl07b_anm"
thanm.exe -x 19 pl07b.anm
cd /d "%OUT%"
del /q "%OUT%\pl07b.anm"
del /q "%OUT%\_work_pl07b_anm\pl07b.anm"
mkdir "%OUT%\pl07b.anm"
xcopy /e /y /q "%OUT%\_work_pl07b_anm\*" "%OUT%\pl07b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl07b_anm"
if exist "%OUT%\_work_pl07f_anm" rmdir /s /q "%OUT%\_work_pl07f_anm"
mkdir "%OUT%\_work_pl07f_anm"
copy /y "%OUT%\pl07f.anm" "%OUT%\_work_pl07f_anm\pl07f.anm" >nul
cd /d "%OUT%\_work_pl07f_anm"
thanm.exe -x 19 pl07f.anm
cd /d "%OUT%"
del /q "%OUT%\pl07f.anm"
del /q "%OUT%\_work_pl07f_anm\pl07f.anm"
mkdir "%OUT%\pl07f.anm"
xcopy /e /y /q "%OUT%\_work_pl07f_anm\*" "%OUT%\pl07f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl07f_anm"
if exist "%OUT%\_work_pl07st_msg" rmdir /s /q "%OUT%\_work_pl07st_msg"
mkdir "%OUT%\_work_pl07st_msg"
copy /y "%OUT%\pl07st.msg" "%OUT%\_work_pl07st_msg\pl07st.msg" >nul
cd /d "%OUT%\_work_pl07st_msg"
thmsg.exe -d 19 pl07st.msg pl07st.txt
cd /d "%OUT%"
del /q "%OUT%\pl07st.msg"
del /q "%OUT%\_work_pl07st_msg\pl07st.msg"
mkdir "%OUT%\pl07st.msg"
xcopy /e /y /q "%OUT%\_work_pl07st_msg\*" "%OUT%\pl07st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl07st_msg"
if exist "%OUT%\_work_pl07vs_msg" rmdir /s /q "%OUT%\_work_pl07vs_msg"
mkdir "%OUT%\_work_pl07vs_msg"
copy /y "%OUT%\pl07vs.msg" "%OUT%\_work_pl07vs_msg\pl07vs.msg" >nul
cd /d "%OUT%\_work_pl07vs_msg"
thmsg.exe -d 19 pl07vs.msg pl07vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl07vs.msg"
del /q "%OUT%\_work_pl07vs_msg\pl07vs.msg"
mkdir "%OUT%\pl07vs.msg"
xcopy /e /y /q "%OUT%\_work_pl07vs_msg\*" "%OUT%\pl07vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl07vs_msg"
if exist "%OUT%\_work_pl08_anm" rmdir /s /q "%OUT%\_work_pl08_anm"
mkdir "%OUT%\_work_pl08_anm"
copy /y "%OUT%\pl08.anm" "%OUT%\_work_pl08_anm\pl08.anm" >nul
cd /d "%OUT%\_work_pl08_anm"
thanm.exe -x 19 pl08.anm
cd /d "%OUT%"
del /q "%OUT%\pl08.anm"
del /q "%OUT%\_work_pl08_anm\pl08.anm"
mkdir "%OUT%\pl08.anm"
xcopy /e /y /q "%OUT%\_work_pl08_anm\*" "%OUT%\pl08.anm\" >nul
rmdir /s /q "%OUT%\_work_pl08_anm"
if exist "%OUT%\_work_pl08_ecl" rmdir /s /q "%OUT%\_work_pl08_ecl"
mkdir "%OUT%\_work_pl08_ecl"
copy /y "%OUT%\pl08.ecl" "%OUT%\_work_pl08_ecl\pl08.ecl" >nul
cd /d "%OUT%\_work_pl08_ecl"
thecl.exe -d 19 pl08.ecl pl08.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl08.ecl"
del /q "%OUT%\_work_pl08_ecl\pl08.ecl"
mkdir "%OUT%\pl08.ecl"
xcopy /e /y /q "%OUT%\_work_pl08_ecl\*" "%OUT%\pl08.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl08_ecl"
if exist "%OUT%\_work_pl08b_anm" rmdir /s /q "%OUT%\_work_pl08b_anm"
mkdir "%OUT%\_work_pl08b_anm"
copy /y "%OUT%\pl08b.anm" "%OUT%\_work_pl08b_anm\pl08b.anm" >nul
cd /d "%OUT%\_work_pl08b_anm"
thanm.exe -x 19 pl08b.anm
cd /d "%OUT%"
del /q "%OUT%\pl08b.anm"
del /q "%OUT%\_work_pl08b_anm\pl08b.anm"
mkdir "%OUT%\pl08b.anm"
xcopy /e /y /q "%OUT%\_work_pl08b_anm\*" "%OUT%\pl08b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl08b_anm"
if exist "%OUT%\_work_pl08f_anm" rmdir /s /q "%OUT%\_work_pl08f_anm"
mkdir "%OUT%\_work_pl08f_anm"
copy /y "%OUT%\pl08f.anm" "%OUT%\_work_pl08f_anm\pl08f.anm" >nul
cd /d "%OUT%\_work_pl08f_anm"
thanm.exe -x 19 pl08f.anm
cd /d "%OUT%"
del /q "%OUT%\pl08f.anm"
del /q "%OUT%\_work_pl08f_anm\pl08f.anm"
mkdir "%OUT%\pl08f.anm"
xcopy /e /y /q "%OUT%\_work_pl08f_anm\*" "%OUT%\pl08f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl08f_anm"
if exist "%OUT%\_work_pl08st_msg" rmdir /s /q "%OUT%\_work_pl08st_msg"
mkdir "%OUT%\_work_pl08st_msg"
copy /y "%OUT%\pl08st.msg" "%OUT%\_work_pl08st_msg\pl08st.msg" >nul
cd /d "%OUT%\_work_pl08st_msg"
thmsg.exe -d 19 pl08st.msg pl08st.txt
cd /d "%OUT%"
del /q "%OUT%\pl08st.msg"
del /q "%OUT%\_work_pl08st_msg\pl08st.msg"
mkdir "%OUT%\pl08st.msg"
xcopy /e /y /q "%OUT%\_work_pl08st_msg\*" "%OUT%\pl08st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl08st_msg"
if exist "%OUT%\_work_pl08vs_msg" rmdir /s /q "%OUT%\_work_pl08vs_msg"
mkdir "%OUT%\_work_pl08vs_msg"
copy /y "%OUT%\pl08vs.msg" "%OUT%\_work_pl08vs_msg\pl08vs.msg" >nul
cd /d "%OUT%\_work_pl08vs_msg"
thmsg.exe -d 19 pl08vs.msg pl08vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl08vs.msg"
del /q "%OUT%\_work_pl08vs_msg\pl08vs.msg"
mkdir "%OUT%\pl08vs.msg"
xcopy /e /y /q "%OUT%\_work_pl08vs_msg\*" "%OUT%\pl08vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl08vs_msg"
if exist "%OUT%\_work_pl09_anm" rmdir /s /q "%OUT%\_work_pl09_anm"
mkdir "%OUT%\_work_pl09_anm"
copy /y "%OUT%\pl09.anm" "%OUT%\_work_pl09_anm\pl09.anm" >nul
cd /d "%OUT%\_work_pl09_anm"
thanm.exe -x 19 pl09.anm
cd /d "%OUT%"
del /q "%OUT%\pl09.anm"
del /q "%OUT%\_work_pl09_anm\pl09.anm"
mkdir "%OUT%\pl09.anm"
xcopy /e /y /q "%OUT%\_work_pl09_anm\*" "%OUT%\pl09.anm\" >nul
rmdir /s /q "%OUT%\_work_pl09_anm"
if exist "%OUT%\_work_pl09_ecl" rmdir /s /q "%OUT%\_work_pl09_ecl"
mkdir "%OUT%\_work_pl09_ecl"
copy /y "%OUT%\pl09.ecl" "%OUT%\_work_pl09_ecl\pl09.ecl" >nul
cd /d "%OUT%\_work_pl09_ecl"
thecl.exe -d 19 pl09.ecl pl09.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl09.ecl"
del /q "%OUT%\_work_pl09_ecl\pl09.ecl"
mkdir "%OUT%\pl09.ecl"
xcopy /e /y /q "%OUT%\_work_pl09_ecl\*" "%OUT%\pl09.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl09_ecl"
if exist "%OUT%\_work_pl09b_anm" rmdir /s /q "%OUT%\_work_pl09b_anm"
mkdir "%OUT%\_work_pl09b_anm"
copy /y "%OUT%\pl09b.anm" "%OUT%\_work_pl09b_anm\pl09b.anm" >nul
cd /d "%OUT%\_work_pl09b_anm"
thanm.exe -x 19 pl09b.anm
cd /d "%OUT%"
del /q "%OUT%\pl09b.anm"
del /q "%OUT%\_work_pl09b_anm\pl09b.anm"
mkdir "%OUT%\pl09b.anm"
xcopy /e /y /q "%OUT%\_work_pl09b_anm\*" "%OUT%\pl09b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl09b_anm"
if exist "%OUT%\_work_pl09f_anm" rmdir /s /q "%OUT%\_work_pl09f_anm"
mkdir "%OUT%\_work_pl09f_anm"
copy /y "%OUT%\pl09f.anm" "%OUT%\_work_pl09f_anm\pl09f.anm" >nul
cd /d "%OUT%\_work_pl09f_anm"
thanm.exe -x 19 pl09f.anm
cd /d "%OUT%"
del /q "%OUT%\pl09f.anm"
del /q "%OUT%\_work_pl09f_anm\pl09f.anm"
mkdir "%OUT%\pl09f.anm"
xcopy /e /y /q "%OUT%\_work_pl09f_anm\*" "%OUT%\pl09f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl09f_anm"
if exist "%OUT%\_work_pl09st_msg" rmdir /s /q "%OUT%\_work_pl09st_msg"
mkdir "%OUT%\_work_pl09st_msg"
copy /y "%OUT%\pl09st.msg" "%OUT%\_work_pl09st_msg\pl09st.msg" >nul
cd /d "%OUT%\_work_pl09st_msg"
thmsg.exe -d 19 pl09st.msg pl09st.txt
cd /d "%OUT%"
del /q "%OUT%\pl09st.msg"
del /q "%OUT%\_work_pl09st_msg\pl09st.msg"
mkdir "%OUT%\pl09st.msg"
xcopy /e /y /q "%OUT%\_work_pl09st_msg\*" "%OUT%\pl09st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl09st_msg"
if exist "%OUT%\_work_pl09vs_msg" rmdir /s /q "%OUT%\_work_pl09vs_msg"
mkdir "%OUT%\_work_pl09vs_msg"
copy /y "%OUT%\pl09vs.msg" "%OUT%\_work_pl09vs_msg\pl09vs.msg" >nul
cd /d "%OUT%\_work_pl09vs_msg"
thmsg.exe -d 19 pl09vs.msg pl09vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl09vs.msg"
del /q "%OUT%\_work_pl09vs_msg\pl09vs.msg"
mkdir "%OUT%\pl09vs.msg"
xcopy /e /y /q "%OUT%\_work_pl09vs_msg\*" "%OUT%\pl09vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl09vs_msg"
if exist "%OUT%\_work_pl10_anm" rmdir /s /q "%OUT%\_work_pl10_anm"
mkdir "%OUT%\_work_pl10_anm"
copy /y "%OUT%\pl10.anm" "%OUT%\_work_pl10_anm\pl10.anm" >nul
cd /d "%OUT%\_work_pl10_anm"
thanm.exe -x 19 pl10.anm
cd /d "%OUT%"
del /q "%OUT%\pl10.anm"
del /q "%OUT%\_work_pl10_anm\pl10.anm"
mkdir "%OUT%\pl10.anm"
xcopy /e /y /q "%OUT%\_work_pl10_anm\*" "%OUT%\pl10.anm\" >nul
rmdir /s /q "%OUT%\_work_pl10_anm"
if exist "%OUT%\_work_pl10_ecl" rmdir /s /q "%OUT%\_work_pl10_ecl"
mkdir "%OUT%\_work_pl10_ecl"
copy /y "%OUT%\pl10.ecl" "%OUT%\_work_pl10_ecl\pl10.ecl" >nul
cd /d "%OUT%\_work_pl10_ecl"
thecl.exe -d 19 pl10.ecl pl10.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl10.ecl"
del /q "%OUT%\_work_pl10_ecl\pl10.ecl"
mkdir "%OUT%\pl10.ecl"
xcopy /e /y /q "%OUT%\_work_pl10_ecl\*" "%OUT%\pl10.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl10_ecl"
if exist "%OUT%\_work_pl10b_anm" rmdir /s /q "%OUT%\_work_pl10b_anm"
mkdir "%OUT%\_work_pl10b_anm"
copy /y "%OUT%\pl10b.anm" "%OUT%\_work_pl10b_anm\pl10b.anm" >nul
cd /d "%OUT%\_work_pl10b_anm"
thanm.exe -x 19 pl10b.anm
cd /d "%OUT%"
del /q "%OUT%\pl10b.anm"
del /q "%OUT%\_work_pl10b_anm\pl10b.anm"
mkdir "%OUT%\pl10b.anm"
xcopy /e /y /q "%OUT%\_work_pl10b_anm\*" "%OUT%\pl10b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl10b_anm"
if exist "%OUT%\_work_pl10f_anm" rmdir /s /q "%OUT%\_work_pl10f_anm"
mkdir "%OUT%\_work_pl10f_anm"
copy /y "%OUT%\pl10f.anm" "%OUT%\_work_pl10f_anm\pl10f.anm" >nul
cd /d "%OUT%\_work_pl10f_anm"
thanm.exe -x 19 pl10f.anm
cd /d "%OUT%"
del /q "%OUT%\pl10f.anm"
del /q "%OUT%\_work_pl10f_anm\pl10f.anm"
mkdir "%OUT%\pl10f.anm"
xcopy /e /y /q "%OUT%\_work_pl10f_anm\*" "%OUT%\pl10f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl10f_anm"
if exist "%OUT%\_work_pl10st_msg" rmdir /s /q "%OUT%\_work_pl10st_msg"
mkdir "%OUT%\_work_pl10st_msg"
copy /y "%OUT%\pl10st.msg" "%OUT%\_work_pl10st_msg\pl10st.msg" >nul
cd /d "%OUT%\_work_pl10st_msg"
thmsg.exe -d 19 pl10st.msg pl10st.txt
cd /d "%OUT%"
del /q "%OUT%\pl10st.msg"
del /q "%OUT%\_work_pl10st_msg\pl10st.msg"
mkdir "%OUT%\pl10st.msg"
xcopy /e /y /q "%OUT%\_work_pl10st_msg\*" "%OUT%\pl10st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl10st_msg"
if exist "%OUT%\_work_pl10vs_msg" rmdir /s /q "%OUT%\_work_pl10vs_msg"
mkdir "%OUT%\_work_pl10vs_msg"
copy /y "%OUT%\pl10vs.msg" "%OUT%\_work_pl10vs_msg\pl10vs.msg" >nul
cd /d "%OUT%\_work_pl10vs_msg"
thmsg.exe -d 19 pl10vs.msg pl10vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl10vs.msg"
del /q "%OUT%\_work_pl10vs_msg\pl10vs.msg"
mkdir "%OUT%\pl10vs.msg"
xcopy /e /y /q "%OUT%\_work_pl10vs_msg\*" "%OUT%\pl10vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl10vs_msg"
if exist "%OUT%\_work_pl11_anm" rmdir /s /q "%OUT%\_work_pl11_anm"
mkdir "%OUT%\_work_pl11_anm"
copy /y "%OUT%\pl11.anm" "%OUT%\_work_pl11_anm\pl11.anm" >nul
cd /d "%OUT%\_work_pl11_anm"
thanm.exe -x 19 pl11.anm
cd /d "%OUT%"
del /q "%OUT%\pl11.anm"
del /q "%OUT%\_work_pl11_anm\pl11.anm"
mkdir "%OUT%\pl11.anm"
xcopy /e /y /q "%OUT%\_work_pl11_anm\*" "%OUT%\pl11.anm\" >nul
rmdir /s /q "%OUT%\_work_pl11_anm"
if exist "%OUT%\_work_pl11_ecl" rmdir /s /q "%OUT%\_work_pl11_ecl"
mkdir "%OUT%\_work_pl11_ecl"
copy /y "%OUT%\pl11.ecl" "%OUT%\_work_pl11_ecl\pl11.ecl" >nul
cd /d "%OUT%\_work_pl11_ecl"
thecl.exe -d 19 pl11.ecl pl11.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl11.ecl"
del /q "%OUT%\_work_pl11_ecl\pl11.ecl"
mkdir "%OUT%\pl11.ecl"
xcopy /e /y /q "%OUT%\_work_pl11_ecl\*" "%OUT%\pl11.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl11_ecl"
if exist "%OUT%\_work_pl11b_anm" rmdir /s /q "%OUT%\_work_pl11b_anm"
mkdir "%OUT%\_work_pl11b_anm"
copy /y "%OUT%\pl11b.anm" "%OUT%\_work_pl11b_anm\pl11b.anm" >nul
cd /d "%OUT%\_work_pl11b_anm"
thanm.exe -x 19 pl11b.anm
cd /d "%OUT%"
del /q "%OUT%\pl11b.anm"
del /q "%OUT%\_work_pl11b_anm\pl11b.anm"
mkdir "%OUT%\pl11b.anm"
xcopy /e /y /q "%OUT%\_work_pl11b_anm\*" "%OUT%\pl11b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl11b_anm"
if exist "%OUT%\_work_pl11f_anm" rmdir /s /q "%OUT%\_work_pl11f_anm"
mkdir "%OUT%\_work_pl11f_anm"
copy /y "%OUT%\pl11f.anm" "%OUT%\_work_pl11f_anm\pl11f.anm" >nul
cd /d "%OUT%\_work_pl11f_anm"
thanm.exe -x 19 pl11f.anm
cd /d "%OUT%"
del /q "%OUT%\pl11f.anm"
del /q "%OUT%\_work_pl11f_anm\pl11f.anm"
mkdir "%OUT%\pl11f.anm"
xcopy /e /y /q "%OUT%\_work_pl11f_anm\*" "%OUT%\pl11f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl11f_anm"
if exist "%OUT%\_work_pl11st_msg" rmdir /s /q "%OUT%\_work_pl11st_msg"
mkdir "%OUT%\_work_pl11st_msg"
copy /y "%OUT%\pl11st.msg" "%OUT%\_work_pl11st_msg\pl11st.msg" >nul
cd /d "%OUT%\_work_pl11st_msg"
thmsg.exe -d 19 pl11st.msg pl11st.txt
cd /d "%OUT%"
del /q "%OUT%\pl11st.msg"
del /q "%OUT%\_work_pl11st_msg\pl11st.msg"
mkdir "%OUT%\pl11st.msg"
xcopy /e /y /q "%OUT%\_work_pl11st_msg\*" "%OUT%\pl11st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl11st_msg"
if exist "%OUT%\_work_pl11vs_msg" rmdir /s /q "%OUT%\_work_pl11vs_msg"
mkdir "%OUT%\_work_pl11vs_msg"
copy /y "%OUT%\pl11vs.msg" "%OUT%\_work_pl11vs_msg\pl11vs.msg" >nul
cd /d "%OUT%\_work_pl11vs_msg"
thmsg.exe -d 19 pl11vs.msg pl11vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl11vs.msg"
del /q "%OUT%\_work_pl11vs_msg\pl11vs.msg"
mkdir "%OUT%\pl11vs.msg"
xcopy /e /y /q "%OUT%\_work_pl11vs_msg\*" "%OUT%\pl11vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl11vs_msg"
if exist "%OUT%\_work_pl12_anm" rmdir /s /q "%OUT%\_work_pl12_anm"
mkdir "%OUT%\_work_pl12_anm"
copy /y "%OUT%\pl12.anm" "%OUT%\_work_pl12_anm\pl12.anm" >nul
cd /d "%OUT%\_work_pl12_anm"
thanm.exe -x 19 pl12.anm
cd /d "%OUT%"
del /q "%OUT%\pl12.anm"
del /q "%OUT%\_work_pl12_anm\pl12.anm"
mkdir "%OUT%\pl12.anm"
xcopy /e /y /q "%OUT%\_work_pl12_anm\*" "%OUT%\pl12.anm\" >nul
rmdir /s /q "%OUT%\_work_pl12_anm"
if exist "%OUT%\_work_pl12_ecl" rmdir /s /q "%OUT%\_work_pl12_ecl"
mkdir "%OUT%\_work_pl12_ecl"
copy /y "%OUT%\pl12.ecl" "%OUT%\_work_pl12_ecl\pl12.ecl" >nul
cd /d "%OUT%\_work_pl12_ecl"
thecl.exe -d 19 pl12.ecl pl12.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl12.ecl"
del /q "%OUT%\_work_pl12_ecl\pl12.ecl"
mkdir "%OUT%\pl12.ecl"
xcopy /e /y /q "%OUT%\_work_pl12_ecl\*" "%OUT%\pl12.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl12_ecl"
if exist "%OUT%\_work_pl12b_anm" rmdir /s /q "%OUT%\_work_pl12b_anm"
mkdir "%OUT%\_work_pl12b_anm"
copy /y "%OUT%\pl12b.anm" "%OUT%\_work_pl12b_anm\pl12b.anm" >nul
cd /d "%OUT%\_work_pl12b_anm"
thanm.exe -x 19 pl12b.anm
cd /d "%OUT%"
del /q "%OUT%\pl12b.anm"
del /q "%OUT%\_work_pl12b_anm\pl12b.anm"
mkdir "%OUT%\pl12b.anm"
xcopy /e /y /q "%OUT%\_work_pl12b_anm\*" "%OUT%\pl12b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl12b_anm"
if exist "%OUT%\_work_pl12f_anm" rmdir /s /q "%OUT%\_work_pl12f_anm"
mkdir "%OUT%\_work_pl12f_anm"
copy /y "%OUT%\pl12f.anm" "%OUT%\_work_pl12f_anm\pl12f.anm" >nul
cd /d "%OUT%\_work_pl12f_anm"
thanm.exe -x 19 pl12f.anm
cd /d "%OUT%"
del /q "%OUT%\pl12f.anm"
del /q "%OUT%\_work_pl12f_anm\pl12f.anm"
mkdir "%OUT%\pl12f.anm"
xcopy /e /y /q "%OUT%\_work_pl12f_anm\*" "%OUT%\pl12f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl12f_anm"
if exist "%OUT%\_work_pl12st_msg" rmdir /s /q "%OUT%\_work_pl12st_msg"
mkdir "%OUT%\_work_pl12st_msg"
copy /y "%OUT%\pl12st.msg" "%OUT%\_work_pl12st_msg\pl12st.msg" >nul
cd /d "%OUT%\_work_pl12st_msg"
thmsg.exe -d 19 pl12st.msg pl12st.txt
cd /d "%OUT%"
del /q "%OUT%\pl12st.msg"
del /q "%OUT%\_work_pl12st_msg\pl12st.msg"
mkdir "%OUT%\pl12st.msg"
xcopy /e /y /q "%OUT%\_work_pl12st_msg\*" "%OUT%\pl12st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl12st_msg"
if exist "%OUT%\_work_pl12vs_msg" rmdir /s /q "%OUT%\_work_pl12vs_msg"
mkdir "%OUT%\_work_pl12vs_msg"
copy /y "%OUT%\pl12vs.msg" "%OUT%\_work_pl12vs_msg\pl12vs.msg" >nul
cd /d "%OUT%\_work_pl12vs_msg"
thmsg.exe -d 19 pl12vs.msg pl12vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl12vs.msg"
del /q "%OUT%\_work_pl12vs_msg\pl12vs.msg"
mkdir "%OUT%\pl12vs.msg"
xcopy /e /y /q "%OUT%\_work_pl12vs_msg\*" "%OUT%\pl12vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl12vs_msg"
if exist "%OUT%\_work_pl13_anm" rmdir /s /q "%OUT%\_work_pl13_anm"
mkdir "%OUT%\_work_pl13_anm"
copy /y "%OUT%\pl13.anm" "%OUT%\_work_pl13_anm\pl13.anm" >nul
cd /d "%OUT%\_work_pl13_anm"
thanm.exe -x 19 pl13.anm
cd /d "%OUT%"
del /q "%OUT%\pl13.anm"
del /q "%OUT%\_work_pl13_anm\pl13.anm"
mkdir "%OUT%\pl13.anm"
xcopy /e /y /q "%OUT%\_work_pl13_anm\*" "%OUT%\pl13.anm\" >nul
rmdir /s /q "%OUT%\_work_pl13_anm"
if exist "%OUT%\_work_pl13_ecl" rmdir /s /q "%OUT%\_work_pl13_ecl"
mkdir "%OUT%\_work_pl13_ecl"
copy /y "%OUT%\pl13.ecl" "%OUT%\_work_pl13_ecl\pl13.ecl" >nul
cd /d "%OUT%\_work_pl13_ecl"
thecl.exe -d 19 pl13.ecl pl13.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl13.ecl"
del /q "%OUT%\_work_pl13_ecl\pl13.ecl"
mkdir "%OUT%\pl13.ecl"
xcopy /e /y /q "%OUT%\_work_pl13_ecl\*" "%OUT%\pl13.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl13_ecl"
if exist "%OUT%\_work_pl13b_anm" rmdir /s /q "%OUT%\_work_pl13b_anm"
mkdir "%OUT%\_work_pl13b_anm"
copy /y "%OUT%\pl13b.anm" "%OUT%\_work_pl13b_anm\pl13b.anm" >nul
cd /d "%OUT%\_work_pl13b_anm"
thanm.exe -x 19 pl13b.anm
cd /d "%OUT%"
del /q "%OUT%\pl13b.anm"
del /q "%OUT%\_work_pl13b_anm\pl13b.anm"
mkdir "%OUT%\pl13b.anm"
xcopy /e /y /q "%OUT%\_work_pl13b_anm\*" "%OUT%\pl13b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl13b_anm"
if exist "%OUT%\_work_pl13f_anm" rmdir /s /q "%OUT%\_work_pl13f_anm"
mkdir "%OUT%\_work_pl13f_anm"
copy /y "%OUT%\pl13f.anm" "%OUT%\_work_pl13f_anm\pl13f.anm" >nul
cd /d "%OUT%\_work_pl13f_anm"
thanm.exe -x 19 pl13f.anm
cd /d "%OUT%"
del /q "%OUT%\pl13f.anm"
del /q "%OUT%\_work_pl13f_anm\pl13f.anm"
mkdir "%OUT%\pl13f.anm"
xcopy /e /y /q "%OUT%\_work_pl13f_anm\*" "%OUT%\pl13f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl13f_anm"
if exist "%OUT%\_work_pl13st_msg" rmdir /s /q "%OUT%\_work_pl13st_msg"
mkdir "%OUT%\_work_pl13st_msg"
copy /y "%OUT%\pl13st.msg" "%OUT%\_work_pl13st_msg\pl13st.msg" >nul
cd /d "%OUT%\_work_pl13st_msg"
thmsg.exe -d 19 pl13st.msg pl13st.txt
cd /d "%OUT%"
del /q "%OUT%\pl13st.msg"
del /q "%OUT%\_work_pl13st_msg\pl13st.msg"
mkdir "%OUT%\pl13st.msg"
xcopy /e /y /q "%OUT%\_work_pl13st_msg\*" "%OUT%\pl13st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl13st_msg"
if exist "%OUT%\_work_pl13vs_msg" rmdir /s /q "%OUT%\_work_pl13vs_msg"
mkdir "%OUT%\_work_pl13vs_msg"
copy /y "%OUT%\pl13vs.msg" "%OUT%\_work_pl13vs_msg\pl13vs.msg" >nul
cd /d "%OUT%\_work_pl13vs_msg"
thmsg.exe -d 19 pl13vs.msg pl13vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl13vs.msg"
del /q "%OUT%\_work_pl13vs_msg\pl13vs.msg"
mkdir "%OUT%\pl13vs.msg"
xcopy /e /y /q "%OUT%\_work_pl13vs_msg\*" "%OUT%\pl13vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl13vs_msg"
if exist "%OUT%\_work_pl14_anm" rmdir /s /q "%OUT%\_work_pl14_anm"
mkdir "%OUT%\_work_pl14_anm"
copy /y "%OUT%\pl14.anm" "%OUT%\_work_pl14_anm\pl14.anm" >nul
cd /d "%OUT%\_work_pl14_anm"
thanm.exe -x 19 pl14.anm
cd /d "%OUT%"
del /q "%OUT%\pl14.anm"
del /q "%OUT%\_work_pl14_anm\pl14.anm"
mkdir "%OUT%\pl14.anm"
xcopy /e /y /q "%OUT%\_work_pl14_anm\*" "%OUT%\pl14.anm\" >nul
rmdir /s /q "%OUT%\_work_pl14_anm"
if exist "%OUT%\_work_pl14_ecl" rmdir /s /q "%OUT%\_work_pl14_ecl"
mkdir "%OUT%\_work_pl14_ecl"
copy /y "%OUT%\pl14.ecl" "%OUT%\_work_pl14_ecl\pl14.ecl" >nul
cd /d "%OUT%\_work_pl14_ecl"
thecl.exe -d 19 pl14.ecl pl14.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl14.ecl"
del /q "%OUT%\_work_pl14_ecl\pl14.ecl"
mkdir "%OUT%\pl14.ecl"
xcopy /e /y /q "%OUT%\_work_pl14_ecl\*" "%OUT%\pl14.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl14_ecl"
if exist "%OUT%\_work_pl14b_anm" rmdir /s /q "%OUT%\_work_pl14b_anm"
mkdir "%OUT%\_work_pl14b_anm"
copy /y "%OUT%\pl14b.anm" "%OUT%\_work_pl14b_anm\pl14b.anm" >nul
cd /d "%OUT%\_work_pl14b_anm"
thanm.exe -x 19 pl14b.anm
cd /d "%OUT%"
del /q "%OUT%\pl14b.anm"
del /q "%OUT%\_work_pl14b_anm\pl14b.anm"
mkdir "%OUT%\pl14b.anm"
xcopy /e /y /q "%OUT%\_work_pl14b_anm\*" "%OUT%\pl14b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl14b_anm"
if exist "%OUT%\_work_pl14f_anm" rmdir /s /q "%OUT%\_work_pl14f_anm"
mkdir "%OUT%\_work_pl14f_anm"
copy /y "%OUT%\pl14f.anm" "%OUT%\_work_pl14f_anm\pl14f.anm" >nul
cd /d "%OUT%\_work_pl14f_anm"
thanm.exe -x 19 pl14f.anm
cd /d "%OUT%"
del /q "%OUT%\pl14f.anm"
del /q "%OUT%\_work_pl14f_anm\pl14f.anm"
mkdir "%OUT%\pl14f.anm"
xcopy /e /y /q "%OUT%\_work_pl14f_anm\*" "%OUT%\pl14f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl14f_anm"
if exist "%OUT%\_work_pl14st_msg" rmdir /s /q "%OUT%\_work_pl14st_msg"
mkdir "%OUT%\_work_pl14st_msg"
copy /y "%OUT%\pl14st.msg" "%OUT%\_work_pl14st_msg\pl14st.msg" >nul
cd /d "%OUT%\_work_pl14st_msg"
thmsg.exe -d 19 pl14st.msg pl14st.txt
cd /d "%OUT%"
del /q "%OUT%\pl14st.msg"
del /q "%OUT%\_work_pl14st_msg\pl14st.msg"
mkdir "%OUT%\pl14st.msg"
xcopy /e /y /q "%OUT%\_work_pl14st_msg\*" "%OUT%\pl14st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl14st_msg"
if exist "%OUT%\_work_pl14vs_msg" rmdir /s /q "%OUT%\_work_pl14vs_msg"
mkdir "%OUT%\_work_pl14vs_msg"
copy /y "%OUT%\pl14vs.msg" "%OUT%\_work_pl14vs_msg\pl14vs.msg" >nul
cd /d "%OUT%\_work_pl14vs_msg"
thmsg.exe -d 19 pl14vs.msg pl14vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl14vs.msg"
del /q "%OUT%\_work_pl14vs_msg\pl14vs.msg"
mkdir "%OUT%\pl14vs.msg"
xcopy /e /y /q "%OUT%\_work_pl14vs_msg\*" "%OUT%\pl14vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl14vs_msg"
if exist "%OUT%\_work_pl15_anm" rmdir /s /q "%OUT%\_work_pl15_anm"
mkdir "%OUT%\_work_pl15_anm"
copy /y "%OUT%\pl15.anm" "%OUT%\_work_pl15_anm\pl15.anm" >nul
cd /d "%OUT%\_work_pl15_anm"
thanm.exe -x 19 pl15.anm
cd /d "%OUT%"
del /q "%OUT%\pl15.anm"
del /q "%OUT%\_work_pl15_anm\pl15.anm"
mkdir "%OUT%\pl15.anm"
xcopy /e /y /q "%OUT%\_work_pl15_anm\*" "%OUT%\pl15.anm\" >nul
rmdir /s /q "%OUT%\_work_pl15_anm"
if exist "%OUT%\_work_pl15_ecl" rmdir /s /q "%OUT%\_work_pl15_ecl"
mkdir "%OUT%\_work_pl15_ecl"
copy /y "%OUT%\pl15.ecl" "%OUT%\_work_pl15_ecl\pl15.ecl" >nul
cd /d "%OUT%\_work_pl15_ecl"
thecl.exe -d 19 pl15.ecl pl15.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl15.ecl"
del /q "%OUT%\_work_pl15_ecl\pl15.ecl"
mkdir "%OUT%\pl15.ecl"
xcopy /e /y /q "%OUT%\_work_pl15_ecl\*" "%OUT%\pl15.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl15_ecl"
if exist "%OUT%\_work_pl15b_anm" rmdir /s /q "%OUT%\_work_pl15b_anm"
mkdir "%OUT%\_work_pl15b_anm"
copy /y "%OUT%\pl15b.anm" "%OUT%\_work_pl15b_anm\pl15b.anm" >nul
cd /d "%OUT%\_work_pl15b_anm"
thanm.exe -x 19 pl15b.anm
cd /d "%OUT%"
del /q "%OUT%\pl15b.anm"
del /q "%OUT%\_work_pl15b_anm\pl15b.anm"
mkdir "%OUT%\pl15b.anm"
xcopy /e /y /q "%OUT%\_work_pl15b_anm\*" "%OUT%\pl15b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl15b_anm"
if exist "%OUT%\_work_pl15f_anm" rmdir /s /q "%OUT%\_work_pl15f_anm"
mkdir "%OUT%\_work_pl15f_anm"
copy /y "%OUT%\pl15f.anm" "%OUT%\_work_pl15f_anm\pl15f.anm" >nul
cd /d "%OUT%\_work_pl15f_anm"
thanm.exe -x 19 pl15f.anm
cd /d "%OUT%"
del /q "%OUT%\pl15f.anm"
del /q "%OUT%\_work_pl15f_anm\pl15f.anm"
mkdir "%OUT%\pl15f.anm"
xcopy /e /y /q "%OUT%\_work_pl15f_anm\*" "%OUT%\pl15f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl15f_anm"
if exist "%OUT%\_work_pl15st_msg" rmdir /s /q "%OUT%\_work_pl15st_msg"
mkdir "%OUT%\_work_pl15st_msg"
copy /y "%OUT%\pl15st.msg" "%OUT%\_work_pl15st_msg\pl15st.msg" >nul
cd /d "%OUT%\_work_pl15st_msg"
thmsg.exe -d 19 pl15st.msg pl15st.txt
cd /d "%OUT%"
del /q "%OUT%\pl15st.msg"
del /q "%OUT%\_work_pl15st_msg\pl15st.msg"
mkdir "%OUT%\pl15st.msg"
xcopy /e /y /q "%OUT%\_work_pl15st_msg\*" "%OUT%\pl15st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl15st_msg"
if exist "%OUT%\_work_pl15vs_msg" rmdir /s /q "%OUT%\_work_pl15vs_msg"
mkdir "%OUT%\_work_pl15vs_msg"
copy /y "%OUT%\pl15vs.msg" "%OUT%\_work_pl15vs_msg\pl15vs.msg" >nul
cd /d "%OUT%\_work_pl15vs_msg"
thmsg.exe -d 19 pl15vs.msg pl15vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl15vs.msg"
del /q "%OUT%\_work_pl15vs_msg\pl15vs.msg"
mkdir "%OUT%\pl15vs.msg"
xcopy /e /y /q "%OUT%\_work_pl15vs_msg\*" "%OUT%\pl15vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl15vs_msg"
if exist "%OUT%\_work_pl16_anm" rmdir /s /q "%OUT%\_work_pl16_anm"
mkdir "%OUT%\_work_pl16_anm"
copy /y "%OUT%\pl16.anm" "%OUT%\_work_pl16_anm\pl16.anm" >nul
cd /d "%OUT%\_work_pl16_anm"
thanm.exe -x 19 pl16.anm
cd /d "%OUT%"
del /q "%OUT%\pl16.anm"
del /q "%OUT%\_work_pl16_anm\pl16.anm"
mkdir "%OUT%\pl16.anm"
xcopy /e /y /q "%OUT%\_work_pl16_anm\*" "%OUT%\pl16.anm\" >nul
rmdir /s /q "%OUT%\_work_pl16_anm"
if exist "%OUT%\_work_pl16_ecl" rmdir /s /q "%OUT%\_work_pl16_ecl"
mkdir "%OUT%\_work_pl16_ecl"
copy /y "%OUT%\pl16.ecl" "%OUT%\_work_pl16_ecl\pl16.ecl" >nul
cd /d "%OUT%\_work_pl16_ecl"
thecl.exe -d 19 pl16.ecl pl16.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl16.ecl"
del /q "%OUT%\_work_pl16_ecl\pl16.ecl"
mkdir "%OUT%\pl16.ecl"
xcopy /e /y /q "%OUT%\_work_pl16_ecl\*" "%OUT%\pl16.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl16_ecl"
if exist "%OUT%\_work_pl16b_anm" rmdir /s /q "%OUT%\_work_pl16b_anm"
mkdir "%OUT%\_work_pl16b_anm"
copy /y "%OUT%\pl16b.anm" "%OUT%\_work_pl16b_anm\pl16b.anm" >nul
cd /d "%OUT%\_work_pl16b_anm"
thanm.exe -x 19 pl16b.anm
cd /d "%OUT%"
del /q "%OUT%\pl16b.anm"
del /q "%OUT%\_work_pl16b_anm\pl16b.anm"
mkdir "%OUT%\pl16b.anm"
xcopy /e /y /q "%OUT%\_work_pl16b_anm\*" "%OUT%\pl16b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl16b_anm"
if exist "%OUT%\_work_pl16f_anm" rmdir /s /q "%OUT%\_work_pl16f_anm"
mkdir "%OUT%\_work_pl16f_anm"
copy /y "%OUT%\pl16f.anm" "%OUT%\_work_pl16f_anm\pl16f.anm" >nul
cd /d "%OUT%\_work_pl16f_anm"
thanm.exe -x 19 pl16f.anm
cd /d "%OUT%"
del /q "%OUT%\pl16f.anm"
del /q "%OUT%\_work_pl16f_anm\pl16f.anm"
mkdir "%OUT%\pl16f.anm"
xcopy /e /y /q "%OUT%\_work_pl16f_anm\*" "%OUT%\pl16f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl16f_anm"
if exist "%OUT%\_work_pl16st_msg" rmdir /s /q "%OUT%\_work_pl16st_msg"
mkdir "%OUT%\_work_pl16st_msg"
copy /y "%OUT%\pl16st.msg" "%OUT%\_work_pl16st_msg\pl16st.msg" >nul
cd /d "%OUT%\_work_pl16st_msg"
thmsg.exe -d 19 pl16st.msg pl16st.txt
cd /d "%OUT%"
del /q "%OUT%\pl16st.msg"
del /q "%OUT%\_work_pl16st_msg\pl16st.msg"
mkdir "%OUT%\pl16st.msg"
xcopy /e /y /q "%OUT%\_work_pl16st_msg\*" "%OUT%\pl16st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl16st_msg"
if exist "%OUT%\_work_pl16vs_msg" rmdir /s /q "%OUT%\_work_pl16vs_msg"
mkdir "%OUT%\_work_pl16vs_msg"
copy /y "%OUT%\pl16vs.msg" "%OUT%\_work_pl16vs_msg\pl16vs.msg" >nul
cd /d "%OUT%\_work_pl16vs_msg"
thmsg.exe -d 19 pl16vs.msg pl16vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl16vs.msg"
del /q "%OUT%\_work_pl16vs_msg\pl16vs.msg"
mkdir "%OUT%\pl16vs.msg"
xcopy /e /y /q "%OUT%\_work_pl16vs_msg\*" "%OUT%\pl16vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl16vs_msg"
if exist "%OUT%\_work_pl17_anm" rmdir /s /q "%OUT%\_work_pl17_anm"
mkdir "%OUT%\_work_pl17_anm"
copy /y "%OUT%\pl17.anm" "%OUT%\_work_pl17_anm\pl17.anm" >nul
cd /d "%OUT%\_work_pl17_anm"
thanm.exe -x 19 pl17.anm
cd /d "%OUT%"
del /q "%OUT%\pl17.anm"
del /q "%OUT%\_work_pl17_anm\pl17.anm"
mkdir "%OUT%\pl17.anm"
xcopy /e /y /q "%OUT%\_work_pl17_anm\*" "%OUT%\pl17.anm\" >nul
rmdir /s /q "%OUT%\_work_pl17_anm"
if exist "%OUT%\_work_pl17_ecl" rmdir /s /q "%OUT%\_work_pl17_ecl"
mkdir "%OUT%\_work_pl17_ecl"
copy /y "%OUT%\pl17.ecl" "%OUT%\_work_pl17_ecl\pl17.ecl" >nul
cd /d "%OUT%\_work_pl17_ecl"
thecl.exe -d 19 pl17.ecl pl17.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl17.ecl"
del /q "%OUT%\_work_pl17_ecl\pl17.ecl"
mkdir "%OUT%\pl17.ecl"
xcopy /e /y /q "%OUT%\_work_pl17_ecl\*" "%OUT%\pl17.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl17_ecl"
if exist "%OUT%\_work_pl17b_anm" rmdir /s /q "%OUT%\_work_pl17b_anm"
mkdir "%OUT%\_work_pl17b_anm"
copy /y "%OUT%\pl17b.anm" "%OUT%\_work_pl17b_anm\pl17b.anm" >nul
cd /d "%OUT%\_work_pl17b_anm"
thanm.exe -x 19 pl17b.anm
cd /d "%OUT%"
del /q "%OUT%\pl17b.anm"
del /q "%OUT%\_work_pl17b_anm\pl17b.anm"
mkdir "%OUT%\pl17b.anm"
xcopy /e /y /q "%OUT%\_work_pl17b_anm\*" "%OUT%\pl17b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl17b_anm"
if exist "%OUT%\_work_pl17f_anm" rmdir /s /q "%OUT%\_work_pl17f_anm"
mkdir "%OUT%\_work_pl17f_anm"
copy /y "%OUT%\pl17f.anm" "%OUT%\_work_pl17f_anm\pl17f.anm" >nul
cd /d "%OUT%\_work_pl17f_anm"
thanm.exe -x 19 pl17f.anm
cd /d "%OUT%"
del /q "%OUT%\pl17f.anm"
del /q "%OUT%\_work_pl17f_anm\pl17f.anm"
mkdir "%OUT%\pl17f.anm"
xcopy /e /y /q "%OUT%\_work_pl17f_anm\*" "%OUT%\pl17f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl17f_anm"
if exist "%OUT%\_work_pl17st_msg" rmdir /s /q "%OUT%\_work_pl17st_msg"
mkdir "%OUT%\_work_pl17st_msg"
copy /y "%OUT%\pl17st.msg" "%OUT%\_work_pl17st_msg\pl17st.msg" >nul
cd /d "%OUT%\_work_pl17st_msg"
thmsg.exe -d 19 pl17st.msg pl17st.txt
cd /d "%OUT%"
del /q "%OUT%\pl17st.msg"
del /q "%OUT%\_work_pl17st_msg\pl17st.msg"
mkdir "%OUT%\pl17st.msg"
xcopy /e /y /q "%OUT%\_work_pl17st_msg\*" "%OUT%\pl17st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl17st_msg"
if exist "%OUT%\_work_pl17vs_msg" rmdir /s /q "%OUT%\_work_pl17vs_msg"
mkdir "%OUT%\_work_pl17vs_msg"
copy /y "%OUT%\pl17vs.msg" "%OUT%\_work_pl17vs_msg\pl17vs.msg" >nul
cd /d "%OUT%\_work_pl17vs_msg"
thmsg.exe -d 19 pl17vs.msg pl17vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl17vs.msg"
del /q "%OUT%\_work_pl17vs_msg\pl17vs.msg"
mkdir "%OUT%\pl17vs.msg"
xcopy /e /y /q "%OUT%\_work_pl17vs_msg\*" "%OUT%\pl17vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl17vs_msg"
if exist "%OUT%\_work_pl18_anm" rmdir /s /q "%OUT%\_work_pl18_anm"
mkdir "%OUT%\_work_pl18_anm"
copy /y "%OUT%\pl18.anm" "%OUT%\_work_pl18_anm\pl18.anm" >nul
cd /d "%OUT%\_work_pl18_anm"
thanm.exe -x 19 pl18.anm
cd /d "%OUT%"
del /q "%OUT%\pl18.anm"
del /q "%OUT%\_work_pl18_anm\pl18.anm"
mkdir "%OUT%\pl18.anm"
xcopy /e /y /q "%OUT%\_work_pl18_anm\*" "%OUT%\pl18.anm\" >nul
rmdir /s /q "%OUT%\_work_pl18_anm"
if exist "%OUT%\_work_pl18_ecl" rmdir /s /q "%OUT%\_work_pl18_ecl"
mkdir "%OUT%\_work_pl18_ecl"
copy /y "%OUT%\pl18.ecl" "%OUT%\_work_pl18_ecl\pl18.ecl" >nul
cd /d "%OUT%\_work_pl18_ecl"
thecl.exe -d 19 pl18.ecl pl18.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\pl18.ecl"
del /q "%OUT%\_work_pl18_ecl\pl18.ecl"
mkdir "%OUT%\pl18.ecl"
xcopy /e /y /q "%OUT%\_work_pl18_ecl\*" "%OUT%\pl18.ecl\" >nul
rmdir /s /q "%OUT%\_work_pl18_ecl"
if exist "%OUT%\_work_pl18b_anm" rmdir /s /q "%OUT%\_work_pl18b_anm"
mkdir "%OUT%\_work_pl18b_anm"
copy /y "%OUT%\pl18b.anm" "%OUT%\_work_pl18b_anm\pl18b.anm" >nul
cd /d "%OUT%\_work_pl18b_anm"
thanm.exe -x 19 pl18b.anm
cd /d "%OUT%"
del /q "%OUT%\pl18b.anm"
del /q "%OUT%\_work_pl18b_anm\pl18b.anm"
mkdir "%OUT%\pl18b.anm"
xcopy /e /y /q "%OUT%\_work_pl18b_anm\*" "%OUT%\pl18b.anm\" >nul
rmdir /s /q "%OUT%\_work_pl18b_anm"
if exist "%OUT%\_work_pl18f_anm" rmdir /s /q "%OUT%\_work_pl18f_anm"
mkdir "%OUT%\_work_pl18f_anm"
copy /y "%OUT%\pl18f.anm" "%OUT%\_work_pl18f_anm\pl18f.anm" >nul
cd /d "%OUT%\_work_pl18f_anm"
thanm.exe -x 19 pl18f.anm
cd /d "%OUT%"
del /q "%OUT%\pl18f.anm"
del /q "%OUT%\_work_pl18f_anm\pl18f.anm"
mkdir "%OUT%\pl18f.anm"
xcopy /e /y /q "%OUT%\_work_pl18f_anm\*" "%OUT%\pl18f.anm\" >nul
rmdir /s /q "%OUT%\_work_pl18f_anm"
if exist "%OUT%\_work_pl18st_msg" rmdir /s /q "%OUT%\_work_pl18st_msg"
mkdir "%OUT%\_work_pl18st_msg"
copy /y "%OUT%\pl18st.msg" "%OUT%\_work_pl18st_msg\pl18st.msg" >nul
cd /d "%OUT%\_work_pl18st_msg"
thmsg.exe -d 19 pl18st.msg pl18st.txt
cd /d "%OUT%"
del /q "%OUT%\pl18st.msg"
del /q "%OUT%\_work_pl18st_msg\pl18st.msg"
mkdir "%OUT%\pl18st.msg"
xcopy /e /y /q "%OUT%\_work_pl18st_msg\*" "%OUT%\pl18st.msg\" >nul
rmdir /s /q "%OUT%\_work_pl18st_msg"
if exist "%OUT%\_work_pl18vs_msg" rmdir /s /q "%OUT%\_work_pl18vs_msg"
mkdir "%OUT%\_work_pl18vs_msg"
copy /y "%OUT%\pl18vs.msg" "%OUT%\_work_pl18vs_msg\pl18vs.msg" >nul
cd /d "%OUT%\_work_pl18vs_msg"
thmsg.exe -d 19 pl18vs.msg pl18vs.txt
cd /d "%OUT%"
del /q "%OUT%\pl18vs.msg"
del /q "%OUT%\_work_pl18vs_msg\pl18vs.msg"
mkdir "%OUT%\pl18vs.msg"
xcopy /e /y /q "%OUT%\_work_pl18vs_msg\*" "%OUT%\pl18vs.msg\" >nul
rmdir /s /q "%OUT%\_work_pl18vs_msg"
if exist "%OUT%\_work_screenswitch_anm" rmdir /s /q "%OUT%\_work_screenswitch_anm"
mkdir "%OUT%\_work_screenswitch_anm"
copy /y "%OUT%\screenswitch.anm" "%OUT%\_work_screenswitch_anm\screenswitch.anm" >nul
cd /d "%OUT%\_work_screenswitch_anm"
thanm.exe -x 19 screenswitch.anm
cd /d "%OUT%"
del /q "%OUT%\screenswitch.anm"
del /q "%OUT%\_work_screenswitch_anm\screenswitch.anm"
mkdir "%OUT%\screenswitch.anm"
xcopy /e /y /q "%OUT%\_work_screenswitch_anm\*" "%OUT%\screenswitch.anm\" >nul
rmdir /s /q "%OUT%\_work_screenswitch_anm"
if exist "%OUT%\_work_sig_anm" rmdir /s /q "%OUT%\_work_sig_anm"
mkdir "%OUT%\_work_sig_anm"
copy /y "%OUT%\sig.anm" "%OUT%\_work_sig_anm\sig.anm" >nul
cd /d "%OUT%\_work_sig_anm"
thanm.exe -x 19 sig.anm
cd /d "%OUT%"
del /q "%OUT%\sig.anm"
del /q "%OUT%\_work_sig_anm\sig.anm"
mkdir "%OUT%\sig.anm"
xcopy /e /y /q "%OUT%\_work_sig_anm\*" "%OUT%\sig.anm\" >nul
rmdir /s /q "%OUT%\_work_sig_anm"
if exist "%OUT%\_work_staff_anm" rmdir /s /q "%OUT%\_work_staff_anm"
mkdir "%OUT%\_work_staff_anm"
copy /y "%OUT%\staff.anm" "%OUT%\_work_staff_anm\staff.anm" >nul
cd /d "%OUT%\_work_staff_anm"
thanm.exe -x 19 staff.anm
cd /d "%OUT%"
del /q "%OUT%\staff.anm"
del /q "%OUT%\_work_staff_anm\staff.anm"
mkdir "%OUT%\staff.anm"
xcopy /e /y /q "%OUT%\_work_staff_anm\*" "%OUT%\staff.anm\" >nul
rmdir /s /q "%OUT%\_work_staff_anm"
if exist "%OUT%\_work_staff_msg" rmdir /s /q "%OUT%\_work_staff_msg"
mkdir "%OUT%\_work_staff_msg"
copy /y "%OUT%\staff.msg" "%OUT%\_work_staff_msg\staff.msg" >nul
cd /d "%OUT%\_work_staff_msg"
thmsg.exe -d 19 staff.msg staff.txt
cd /d "%OUT%"
del /q "%OUT%\staff.msg"
del /q "%OUT%\_work_staff_msg\staff.msg"
mkdir "%OUT%\staff.msg"
xcopy /e /y /q "%OUT%\_work_staff_msg\*" "%OUT%\staff.msg\" >nul
rmdir /s /q "%OUT%\_work_staff_msg"
if exist "%OUT%\_work_title_anm" rmdir /s /q "%OUT%\_work_title_anm"
mkdir "%OUT%\_work_title_anm"
copy /y "%OUT%\title.anm" "%OUT%\_work_title_anm\title.anm" >nul
cd /d "%OUT%\_work_title_anm"
thanm.exe -x 19 title.anm
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
thanm.exe -x 19 title_v.anm
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
thanm.exe -x 19 trophy.anm
cd /d "%OUT%"
del /q "%OUT%\trophy.anm"
del /q "%OUT%\_work_trophy_anm\trophy.anm"
mkdir "%OUT%\trophy.anm"
xcopy /e /y /q "%OUT%\_work_trophy_anm\*" "%OUT%\trophy.anm\" >nul
rmdir /s /q "%OUT%\_work_trophy_anm"
if exist "%OUT%\_work_wave01_ecl" rmdir /s /q "%OUT%\_work_wave01_ecl"
mkdir "%OUT%\_work_wave01_ecl"
copy /y "%OUT%\wave01.ecl" "%OUT%\_work_wave01_ecl\wave01.ecl" >nul
cd /d "%OUT%\_work_wave01_ecl"
thecl.exe -d 19 wave01.ecl wave01.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave01.ecl"
del /q "%OUT%\_work_wave01_ecl\wave01.ecl"
mkdir "%OUT%\wave01.ecl"
xcopy /e /y /q "%OUT%\_work_wave01_ecl\*" "%OUT%\wave01.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave01_ecl"
if exist "%OUT%\_work_wave01f_ecl" rmdir /s /q "%OUT%\_work_wave01f_ecl"
mkdir "%OUT%\_work_wave01f_ecl"
copy /y "%OUT%\wave01f.ecl" "%OUT%\_work_wave01f_ecl\wave01f.ecl" >nul
cd /d "%OUT%\_work_wave01f_ecl"
thecl.exe -d 19 wave01f.ecl wave01f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave01f.ecl"
del /q "%OUT%\_work_wave01f_ecl\wave01f.ecl"
mkdir "%OUT%\wave01f.ecl"
xcopy /e /y /q "%OUT%\_work_wave01f_ecl\*" "%OUT%\wave01f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave01f_ecl"
if exist "%OUT%\_work_wave02_ecl" rmdir /s /q "%OUT%\_work_wave02_ecl"
mkdir "%OUT%\_work_wave02_ecl"
copy /y "%OUT%\wave02.ecl" "%OUT%\_work_wave02_ecl\wave02.ecl" >nul
cd /d "%OUT%\_work_wave02_ecl"
thecl.exe -d 19 wave02.ecl wave02.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave02.ecl"
del /q "%OUT%\_work_wave02_ecl\wave02.ecl"
mkdir "%OUT%\wave02.ecl"
xcopy /e /y /q "%OUT%\_work_wave02_ecl\*" "%OUT%\wave02.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave02_ecl"
if exist "%OUT%\_work_wave02f_ecl" rmdir /s /q "%OUT%\_work_wave02f_ecl"
mkdir "%OUT%\_work_wave02f_ecl"
copy /y "%OUT%\wave02f.ecl" "%OUT%\_work_wave02f_ecl\wave02f.ecl" >nul
cd /d "%OUT%\_work_wave02f_ecl"
thecl.exe -d 19 wave02f.ecl wave02f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave02f.ecl"
del /q "%OUT%\_work_wave02f_ecl\wave02f.ecl"
mkdir "%OUT%\wave02f.ecl"
xcopy /e /y /q "%OUT%\_work_wave02f_ecl\*" "%OUT%\wave02f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave02f_ecl"
if exist "%OUT%\_work_wave03_ecl" rmdir /s /q "%OUT%\_work_wave03_ecl"
mkdir "%OUT%\_work_wave03_ecl"
copy /y "%OUT%\wave03.ecl" "%OUT%\_work_wave03_ecl\wave03.ecl" >nul
cd /d "%OUT%\_work_wave03_ecl"
thecl.exe -d 19 wave03.ecl wave03.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave03.ecl"
del /q "%OUT%\_work_wave03_ecl\wave03.ecl"
mkdir "%OUT%\wave03.ecl"
xcopy /e /y /q "%OUT%\_work_wave03_ecl\*" "%OUT%\wave03.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave03_ecl"
if exist "%OUT%\_work_wave03f_ecl" rmdir /s /q "%OUT%\_work_wave03f_ecl"
mkdir "%OUT%\_work_wave03f_ecl"
copy /y "%OUT%\wave03f.ecl" "%OUT%\_work_wave03f_ecl\wave03f.ecl" >nul
cd /d "%OUT%\_work_wave03f_ecl"
thecl.exe -d 19 wave03f.ecl wave03f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave03f.ecl"
del /q "%OUT%\_work_wave03f_ecl\wave03f.ecl"
mkdir "%OUT%\wave03f.ecl"
xcopy /e /y /q "%OUT%\_work_wave03f_ecl\*" "%OUT%\wave03f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave03f_ecl"
if exist "%OUT%\_work_wave04_ecl" rmdir /s /q "%OUT%\_work_wave04_ecl"
mkdir "%OUT%\_work_wave04_ecl"
copy /y "%OUT%\wave04.ecl" "%OUT%\_work_wave04_ecl\wave04.ecl" >nul
cd /d "%OUT%\_work_wave04_ecl"
thecl.exe -d 19 wave04.ecl wave04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave04.ecl"
del /q "%OUT%\_work_wave04_ecl\wave04.ecl"
mkdir "%OUT%\wave04.ecl"
xcopy /e /y /q "%OUT%\_work_wave04_ecl\*" "%OUT%\wave04.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave04_ecl"
if exist "%OUT%\_work_wave04f_ecl" rmdir /s /q "%OUT%\_work_wave04f_ecl"
mkdir "%OUT%\_work_wave04f_ecl"
copy /y "%OUT%\wave04f.ecl" "%OUT%\_work_wave04f_ecl\wave04f.ecl" >nul
cd /d "%OUT%\_work_wave04f_ecl"
thecl.exe -d 19 wave04f.ecl wave04f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave04f.ecl"
del /q "%OUT%\_work_wave04f_ecl\wave04f.ecl"
mkdir "%OUT%\wave04f.ecl"
xcopy /e /y /q "%OUT%\_work_wave04f_ecl\*" "%OUT%\wave04f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave04f_ecl"
if exist "%OUT%\_work_wave05_ecl" rmdir /s /q "%OUT%\_work_wave05_ecl"
mkdir "%OUT%\_work_wave05_ecl"
copy /y "%OUT%\wave05.ecl" "%OUT%\_work_wave05_ecl\wave05.ecl" >nul
cd /d "%OUT%\_work_wave05_ecl"
thecl.exe -d 19 wave05.ecl wave05.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave05.ecl"
del /q "%OUT%\_work_wave05_ecl\wave05.ecl"
mkdir "%OUT%\wave05.ecl"
xcopy /e /y /q "%OUT%\_work_wave05_ecl\*" "%OUT%\wave05.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave05_ecl"
if exist "%OUT%\_work_wave05f_ecl" rmdir /s /q "%OUT%\_work_wave05f_ecl"
mkdir "%OUT%\_work_wave05f_ecl"
copy /y "%OUT%\wave05f.ecl" "%OUT%\_work_wave05f_ecl\wave05f.ecl" >nul
cd /d "%OUT%\_work_wave05f_ecl"
thecl.exe -d 19 wave05f.ecl wave05f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave05f.ecl"
del /q "%OUT%\_work_wave05f_ecl\wave05f.ecl"
mkdir "%OUT%\wave05f.ecl"
xcopy /e /y /q "%OUT%\_work_wave05f_ecl\*" "%OUT%\wave05f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave05f_ecl"
if exist "%OUT%\_work_wave06_ecl" rmdir /s /q "%OUT%\_work_wave06_ecl"
mkdir "%OUT%\_work_wave06_ecl"
copy /y "%OUT%\wave06.ecl" "%OUT%\_work_wave06_ecl\wave06.ecl" >nul
cd /d "%OUT%\_work_wave06_ecl"
thecl.exe -d 19 wave06.ecl wave06.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave06.ecl"
del /q "%OUT%\_work_wave06_ecl\wave06.ecl"
mkdir "%OUT%\wave06.ecl"
xcopy /e /y /q "%OUT%\_work_wave06_ecl\*" "%OUT%\wave06.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave06_ecl"
if exist "%OUT%\_work_wave06f_ecl" rmdir /s /q "%OUT%\_work_wave06f_ecl"
mkdir "%OUT%\_work_wave06f_ecl"
copy /y "%OUT%\wave06f.ecl" "%OUT%\_work_wave06f_ecl\wave06f.ecl" >nul
cd /d "%OUT%\_work_wave06f_ecl"
thecl.exe -d 19 wave06f.ecl wave06f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave06f.ecl"
del /q "%OUT%\_work_wave06f_ecl\wave06f.ecl"
mkdir "%OUT%\wave06f.ecl"
xcopy /e /y /q "%OUT%\_work_wave06f_ecl\*" "%OUT%\wave06f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave06f_ecl"
if exist "%OUT%\_work_wave07_ecl" rmdir /s /q "%OUT%\_work_wave07_ecl"
mkdir "%OUT%\_work_wave07_ecl"
copy /y "%OUT%\wave07.ecl" "%OUT%\_work_wave07_ecl\wave07.ecl" >nul
cd /d "%OUT%\_work_wave07_ecl"
thecl.exe -d 19 wave07.ecl wave07.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave07.ecl"
del /q "%OUT%\_work_wave07_ecl\wave07.ecl"
mkdir "%OUT%\wave07.ecl"
xcopy /e /y /q "%OUT%\_work_wave07_ecl\*" "%OUT%\wave07.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave07_ecl"
if exist "%OUT%\_work_wave07f_ecl" rmdir /s /q "%OUT%\_work_wave07f_ecl"
mkdir "%OUT%\_work_wave07f_ecl"
copy /y "%OUT%\wave07f.ecl" "%OUT%\_work_wave07f_ecl\wave07f.ecl" >nul
cd /d "%OUT%\_work_wave07f_ecl"
thecl.exe -d 19 wave07f.ecl wave07f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave07f.ecl"
del /q "%OUT%\_work_wave07f_ecl\wave07f.ecl"
mkdir "%OUT%\wave07f.ecl"
xcopy /e /y /q "%OUT%\_work_wave07f_ecl\*" "%OUT%\wave07f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave07f_ecl"
if exist "%OUT%\_work_wave08_ecl" rmdir /s /q "%OUT%\_work_wave08_ecl"
mkdir "%OUT%\_work_wave08_ecl"
copy /y "%OUT%\wave08.ecl" "%OUT%\_work_wave08_ecl\wave08.ecl" >nul
cd /d "%OUT%\_work_wave08_ecl"
thecl.exe -d 19 wave08.ecl wave08.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave08.ecl"
del /q "%OUT%\_work_wave08_ecl\wave08.ecl"
mkdir "%OUT%\wave08.ecl"
xcopy /e /y /q "%OUT%\_work_wave08_ecl\*" "%OUT%\wave08.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave08_ecl"
if exist "%OUT%\_work_wave08f_ecl" rmdir /s /q "%OUT%\_work_wave08f_ecl"
mkdir "%OUT%\_work_wave08f_ecl"
copy /y "%OUT%\wave08f.ecl" "%OUT%\_work_wave08f_ecl\wave08f.ecl" >nul
cd /d "%OUT%\_work_wave08f_ecl"
thecl.exe -d 19 wave08f.ecl wave08f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave08f.ecl"
del /q "%OUT%\_work_wave08f_ecl\wave08f.ecl"
mkdir "%OUT%\wave08f.ecl"
xcopy /e /y /q "%OUT%\_work_wave08f_ecl\*" "%OUT%\wave08f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave08f_ecl"
if exist "%OUT%\_work_wave09_ecl" rmdir /s /q "%OUT%\_work_wave09_ecl"
mkdir "%OUT%\_work_wave09_ecl"
copy /y "%OUT%\wave09.ecl" "%OUT%\_work_wave09_ecl\wave09.ecl" >nul
cd /d "%OUT%\_work_wave09_ecl"
thecl.exe -d 19 wave09.ecl wave09.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave09.ecl"
del /q "%OUT%\_work_wave09_ecl\wave09.ecl"
mkdir "%OUT%\wave09.ecl"
xcopy /e /y /q "%OUT%\_work_wave09_ecl\*" "%OUT%\wave09.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave09_ecl"
if exist "%OUT%\_work_wave09f_ecl" rmdir /s /q "%OUT%\_work_wave09f_ecl"
mkdir "%OUT%\_work_wave09f_ecl"
copy /y "%OUT%\wave09f.ecl" "%OUT%\_work_wave09f_ecl\wave09f.ecl" >nul
cd /d "%OUT%\_work_wave09f_ecl"
thecl.exe -d 19 wave09f.ecl wave09f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave09f.ecl"
del /q "%OUT%\_work_wave09f_ecl\wave09f.ecl"
mkdir "%OUT%\wave09f.ecl"
xcopy /e /y /q "%OUT%\_work_wave09f_ecl\*" "%OUT%\wave09f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave09f_ecl"
if exist "%OUT%\_work_wave10_ecl" rmdir /s /q "%OUT%\_work_wave10_ecl"
mkdir "%OUT%\_work_wave10_ecl"
copy /y "%OUT%\wave10.ecl" "%OUT%\_work_wave10_ecl\wave10.ecl" >nul
cd /d "%OUT%\_work_wave10_ecl"
thecl.exe -d 19 wave10.ecl wave10.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave10.ecl"
del /q "%OUT%\_work_wave10_ecl\wave10.ecl"
mkdir "%OUT%\wave10.ecl"
xcopy /e /y /q "%OUT%\_work_wave10_ecl\*" "%OUT%\wave10.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave10_ecl"
if exist "%OUT%\_work_wave10f_ecl" rmdir /s /q "%OUT%\_work_wave10f_ecl"
mkdir "%OUT%\_work_wave10f_ecl"
copy /y "%OUT%\wave10f.ecl" "%OUT%\_work_wave10f_ecl\wave10f.ecl" >nul
cd /d "%OUT%\_work_wave10f_ecl"
thecl.exe -d 19 wave10f.ecl wave10f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave10f.ecl"
del /q "%OUT%\_work_wave10f_ecl\wave10f.ecl"
mkdir "%OUT%\wave10f.ecl"
xcopy /e /y /q "%OUT%\_work_wave10f_ecl\*" "%OUT%\wave10f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave10f_ecl"
if exist "%OUT%\_work_wave11_ecl" rmdir /s /q "%OUT%\_work_wave11_ecl"
mkdir "%OUT%\_work_wave11_ecl"
copy /y "%OUT%\wave11.ecl" "%OUT%\_work_wave11_ecl\wave11.ecl" >nul
cd /d "%OUT%\_work_wave11_ecl"
thecl.exe -d 19 wave11.ecl wave11.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave11.ecl"
del /q "%OUT%\_work_wave11_ecl\wave11.ecl"
mkdir "%OUT%\wave11.ecl"
xcopy /e /y /q "%OUT%\_work_wave11_ecl\*" "%OUT%\wave11.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave11_ecl"
if exist "%OUT%\_work_wave11f_ecl" rmdir /s /q "%OUT%\_work_wave11f_ecl"
mkdir "%OUT%\_work_wave11f_ecl"
copy /y "%OUT%\wave11f.ecl" "%OUT%\_work_wave11f_ecl\wave11f.ecl" >nul
cd /d "%OUT%\_work_wave11f_ecl"
thecl.exe -d 19 wave11f.ecl wave11f.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\wave11f.ecl"
del /q "%OUT%\_work_wave11f_ecl\wave11f.ecl"
mkdir "%OUT%\wave11f.ecl"
xcopy /e /y /q "%OUT%\_work_wave11f_ecl\*" "%OUT%\wave11f.ecl\" >nul
rmdir /s /q "%OUT%\_work_wave11f_ecl"
if exist "%OUT%\_work_world01_anm" rmdir /s /q "%OUT%\_work_world01_anm"
mkdir "%OUT%\_work_world01_anm"
copy /y "%OUT%\world01.anm" "%OUT%\_work_world01_anm\world01.anm" >nul
cd /d "%OUT%\_work_world01_anm"
thanm.exe -x 19 world01.anm
cd /d "%OUT%"
del /q "%OUT%\world01.anm"
del /q "%OUT%\_work_world01_anm\world01.anm"
mkdir "%OUT%\world01.anm"
xcopy /e /y /q "%OUT%\_work_world01_anm\*" "%OUT%\world01.anm\" >nul
rmdir /s /q "%OUT%\_work_world01_anm"
if exist "%OUT%\_work_world01_std" rmdir /s /q "%OUT%\_work_world01_std"
mkdir "%OUT%\_work_world01_std"
copy /y "%OUT%\world01.std" "%OUT%\_work_world01_std\world01.std" >nul
cd /d "%OUT%\_work_world01_std"
thstd.exe -d 19 world01.std world01.std.txt
cd /d "%OUT%"
del /q "%OUT%\world01.std"
del /q "%OUT%\_work_world01_std\world01.std"
mkdir "%OUT%\world01.std"
xcopy /e /y /q "%OUT%\_work_world01_std\*" "%OUT%\world01.std\" >nul
rmdir /s /q "%OUT%\_work_world01_std"
if exist "%OUT%\_work_world02_anm" rmdir /s /q "%OUT%\_work_world02_anm"
mkdir "%OUT%\_work_world02_anm"
copy /y "%OUT%\world02.anm" "%OUT%\_work_world02_anm\world02.anm" >nul
cd /d "%OUT%\_work_world02_anm"
thanm.exe -x 19 world02.anm
cd /d "%OUT%"
del /q "%OUT%\world02.anm"
del /q "%OUT%\_work_world02_anm\world02.anm"
mkdir "%OUT%\world02.anm"
xcopy /e /y /q "%OUT%\_work_world02_anm\*" "%OUT%\world02.anm\" >nul
rmdir /s /q "%OUT%\_work_world02_anm"
if exist "%OUT%\_work_world02_std" rmdir /s /q "%OUT%\_work_world02_std"
mkdir "%OUT%\_work_world02_std"
copy /y "%OUT%\world02.std" "%OUT%\_work_world02_std\world02.std" >nul
cd /d "%OUT%\_work_world02_std"
thstd.exe -d 19 world02.std world02.std.txt
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
thanm.exe -x 19 world03.anm
cd /d "%OUT%"
del /q "%OUT%\world03.anm"
del /q "%OUT%\_work_world03_anm\world03.anm"
mkdir "%OUT%\world03.anm"
xcopy /e /y /q "%OUT%\_work_world03_anm\*" "%OUT%\world03.anm\" >nul
rmdir /s /q "%OUT%\_work_world03_anm"
if exist "%OUT%\_work_world03_std" rmdir /s /q "%OUT%\_work_world03_std"
mkdir "%OUT%\_work_world03_std"
copy /y "%OUT%\world03.std" "%OUT%\_work_world03_std\world03.std" >nul
cd /d "%OUT%\_work_world03_std"
thstd.exe -d 19 world03.std world03.std.txt
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
thanm.exe -x 19 world04.anm
cd /d "%OUT%"
del /q "%OUT%\world04.anm"
del /q "%OUT%\_work_world04_anm\world04.anm"
mkdir "%OUT%\world04.anm"
xcopy /e /y /q "%OUT%\_work_world04_anm\*" "%OUT%\world04.anm\" >nul
rmdir /s /q "%OUT%\_work_world04_anm"
if exist "%OUT%\_work_world04_std" rmdir /s /q "%OUT%\_work_world04_std"
mkdir "%OUT%\_work_world04_std"
copy /y "%OUT%\world04.std" "%OUT%\_work_world04_std\world04.std" >nul
cd /d "%OUT%\_work_world04_std"
thstd.exe -d 19 world04.std world04.std.txt
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
thanm.exe -x 19 world05.anm
cd /d "%OUT%"
del /q "%OUT%\world05.anm"
del /q "%OUT%\_work_world05_anm\world05.anm"
mkdir "%OUT%\world05.anm"
xcopy /e /y /q "%OUT%\_work_world05_anm\*" "%OUT%\world05.anm\" >nul
rmdir /s /q "%OUT%\_work_world05_anm"
if exist "%OUT%\_work_world05_std" rmdir /s /q "%OUT%\_work_world05_std"
mkdir "%OUT%\_work_world05_std"
copy /y "%OUT%\world05.std" "%OUT%\_work_world05_std\world05.std" >nul
cd /d "%OUT%\_work_world05_std"
thstd.exe -d 19 world05.std world05.std.txt
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
thanm.exe -x 19 world06.anm
cd /d "%OUT%"
del /q "%OUT%\world06.anm"
del /q "%OUT%\_work_world06_anm\world06.anm"
mkdir "%OUT%\world06.anm"
xcopy /e /y /q "%OUT%\_work_world06_anm\*" "%OUT%\world06.anm\" >nul
rmdir /s /q "%OUT%\_work_world06_anm"
if exist "%OUT%\_work_world06_std" rmdir /s /q "%OUT%\_work_world06_std"
mkdir "%OUT%\_work_world06_std"
copy /y "%OUT%\world06.std" "%OUT%\_work_world06_std\world06.std" >nul
cd /d "%OUT%\_work_world06_std"
thstd.exe -d 19 world06.std world06.std.txt
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
thanm.exe -x 19 world07.anm
cd /d "%OUT%"
del /q "%OUT%\world07.anm"
del /q "%OUT%\_work_world07_anm\world07.anm"
mkdir "%OUT%\world07.anm"
xcopy /e /y /q "%OUT%\_work_world07_anm\*" "%OUT%\world07.anm\" >nul
rmdir /s /q "%OUT%\_work_world07_anm"
if exist "%OUT%\_work_world07_std" rmdir /s /q "%OUT%\_work_world07_std"
mkdir "%OUT%\_work_world07_std"
copy /y "%OUT%\world07.std" "%OUT%\_work_world07_std\world07.std" >nul
cd /d "%OUT%\_work_world07_std"
thstd.exe -d 19 world07.std world07.std.txt
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
thanm.exe -x 19 world08.anm
cd /d "%OUT%"
del /q "%OUT%\world08.anm"
del /q "%OUT%\_work_world08_anm\world08.anm"
mkdir "%OUT%\world08.anm"
xcopy /e /y /q "%OUT%\_work_world08_anm\*" "%OUT%\world08.anm\" >nul
rmdir /s /q "%OUT%\_work_world08_anm"
if exist "%OUT%\_work_world08_std" rmdir /s /q "%OUT%\_work_world08_std"
mkdir "%OUT%\_work_world08_std"
copy /y "%OUT%\world08.std" "%OUT%\_work_world08_std\world08.std" >nul
cd /d "%OUT%\_work_world08_std"
thstd.exe -d 19 world08.std world08.std.txt
cd /d "%OUT%"
del /q "%OUT%\world08.std"
del /q "%OUT%\_work_world08_std\world08.std"
mkdir "%OUT%\world08.std"
xcopy /e /y /q "%OUT%\_work_world08_std\*" "%OUT%\world08.std\" >nul
rmdir /s /q "%OUT%\_work_world08_std"
if exist "%OUT%\_work_world09_anm" rmdir /s /q "%OUT%\_work_world09_anm"
mkdir "%OUT%\_work_world09_anm"
copy /y "%OUT%\world09.anm" "%OUT%\_work_world09_anm\world09.anm" >nul
cd /d "%OUT%\_work_world09_anm"
thanm.exe -x 19 world09.anm
cd /d "%OUT%"
del /q "%OUT%\world09.anm"
del /q "%OUT%\_work_world09_anm\world09.anm"
mkdir "%OUT%\world09.anm"
xcopy /e /y /q "%OUT%\_work_world09_anm\*" "%OUT%\world09.anm\" >nul
rmdir /s /q "%OUT%\_work_world09_anm"
if exist "%OUT%\_work_world09_std" rmdir /s /q "%OUT%\_work_world09_std"
mkdir "%OUT%\_work_world09_std"
copy /y "%OUT%\world09.std" "%OUT%\_work_world09_std\world09.std" >nul
cd /d "%OUT%\_work_world09_std"
thstd.exe -d 19 world09.std world09.std.txt
cd /d "%OUT%"
del /q "%OUT%\world09.std"
del /q "%OUT%\_work_world09_std\world09.std"
mkdir "%OUT%\world09.std"
xcopy /e /y /q "%OUT%\_work_world09_std\*" "%OUT%\world09.std\" >nul
rmdir /s /q "%OUT%\_work_world09_std"
if exist "%OUT%\_work_world10_anm" rmdir /s /q "%OUT%\_work_world10_anm"
mkdir "%OUT%\_work_world10_anm"
copy /y "%OUT%\world10.anm" "%OUT%\_work_world10_anm\world10.anm" >nul
cd /d "%OUT%\_work_world10_anm"
thanm.exe -x 19 world10.anm
cd /d "%OUT%"
del /q "%OUT%\world10.anm"
del /q "%OUT%\_work_world10_anm\world10.anm"
mkdir "%OUT%\world10.anm"
xcopy /e /y /q "%OUT%\_work_world10_anm\*" "%OUT%\world10.anm\" >nul
rmdir /s /q "%OUT%\_work_world10_anm"
if exist "%OUT%\_work_world10_std" rmdir /s /q "%OUT%\_work_world10_std"
mkdir "%OUT%\_work_world10_std"
copy /y "%OUT%\world10.std" "%OUT%\_work_world10_std\world10.std" >nul
cd /d "%OUT%\_work_world10_std"
thstd.exe -d 19 world10.std world10.std.txt
cd /d "%OUT%"
del /q "%OUT%\world10.std"
del /q "%OUT%\_work_world10_std\world10.std"
mkdir "%OUT%\world10.std"
xcopy /e /y /q "%OUT%\_work_world10_std\*" "%OUT%\world10.std\" >nul
rmdir /s /q "%OUT%\_work_world10_std"
if exist "%OUT%\_work_world11_anm" rmdir /s /q "%OUT%\_work_world11_anm"
mkdir "%OUT%\_work_world11_anm"
copy /y "%OUT%\world11.anm" "%OUT%\_work_world11_anm\world11.anm" >nul
cd /d "%OUT%\_work_world11_anm"
thanm.exe -x 19 world11.anm
cd /d "%OUT%"
del /q "%OUT%\world11.anm"
del /q "%OUT%\_work_world11_anm\world11.anm"
mkdir "%OUT%\world11.anm"
xcopy /e /y /q "%OUT%\_work_world11_anm\*" "%OUT%\world11.anm\" >nul
rmdir /s /q "%OUT%\_work_world11_anm"
if exist "%OUT%\_work_world11_std" rmdir /s /q "%OUT%\_work_world11_std"
mkdir "%OUT%\_work_world11_std"
copy /y "%OUT%\world11.std" "%OUT%\_work_world11_std\world11.std" >nul
cd /d "%OUT%\_work_world11_std"
thstd.exe -d 19 world11.std world11.std.txt
cd /d "%OUT%"
del /q "%OUT%\world11.std"
del /q "%OUT%\_work_world11_std\world11.std"
mkdir "%OUT%\world11.std"
xcopy /e /y /q "%OUT%\_work_world11_std\*" "%OUT%\world11.std\" >nul
rmdir /s /q "%OUT%\_work_world11_std"
if exist "%OUT%\_work_world12_anm" rmdir /s /q "%OUT%\_work_world12_anm"
mkdir "%OUT%\_work_world12_anm"
copy /y "%OUT%\world12.anm" "%OUT%\_work_world12_anm\world12.anm" >nul
cd /d "%OUT%\_work_world12_anm"
thanm.exe -x 19 world12.anm
cd /d "%OUT%"
del /q "%OUT%\world12.anm"
del /q "%OUT%\_work_world12_anm\world12.anm"
mkdir "%OUT%\world12.anm"
xcopy /e /y /q "%OUT%\_work_world12_anm\*" "%OUT%\world12.anm\" >nul
rmdir /s /q "%OUT%\_work_world12_anm"
if exist "%OUT%\_work_world12_std" rmdir /s /q "%OUT%\_work_world12_std"
mkdir "%OUT%\_work_world12_std"
copy /y "%OUT%\world12.std" "%OUT%\_work_world12_std\world12.std" >nul
cd /d "%OUT%\_work_world12_std"
thstd.exe -d 19 world12.std world12.std.txt
cd /d "%OUT%"
del /q "%OUT%\world12.std"
del /q "%OUT%\_work_world12_std\world12.std"
mkdir "%OUT%\world12.std"
xcopy /e /y /q "%OUT%\_work_world12_std\*" "%OUT%\world12.std\" >nul
rmdir /s /q "%OUT%\_work_world12_std"
if exist "%OUT%\_work_world13_anm" rmdir /s /q "%OUT%\_work_world13_anm"
mkdir "%OUT%\_work_world13_anm"
copy /y "%OUT%\world13.anm" "%OUT%\_work_world13_anm\world13.anm" >nul
cd /d "%OUT%\_work_world13_anm"
thanm.exe -x 19 world13.anm
cd /d "%OUT%"
del /q "%OUT%\world13.anm"
del /q "%OUT%\_work_world13_anm\world13.anm"
mkdir "%OUT%\world13.anm"
xcopy /e /y /q "%OUT%\_work_world13_anm\*" "%OUT%\world13.anm\" >nul
rmdir /s /q "%OUT%\_work_world13_anm"
if exist "%OUT%\_work_world13_std" rmdir /s /q "%OUT%\_work_world13_std"
mkdir "%OUT%\_work_world13_std"
copy /y "%OUT%\world13.std" "%OUT%\_work_world13_std\world13.std" >nul
cd /d "%OUT%\_work_world13_std"
thstd.exe -d 19 world13.std world13.std.txt
cd /d "%OUT%"
del /q "%OUT%\world13.std"
del /q "%OUT%\_work_world13_std\world13.std"
mkdir "%OUT%\world13.std"
xcopy /e /y /q "%OUT%\_work_world13_std\*" "%OUT%\world13.std\" >nul
rmdir /s /q "%OUT%\_work_world13_std"
if exist "%OUT%\_work_world14_anm" rmdir /s /q "%OUT%\_work_world14_anm"
mkdir "%OUT%\_work_world14_anm"
copy /y "%OUT%\world14.anm" "%OUT%\_work_world14_anm\world14.anm" >nul
cd /d "%OUT%\_work_world14_anm"
thanm.exe -x 19 world14.anm
cd /d "%OUT%"
del /q "%OUT%\world14.anm"
del /q "%OUT%\_work_world14_anm\world14.anm"
mkdir "%OUT%\world14.anm"
xcopy /e /y /q "%OUT%\_work_world14_anm\*" "%OUT%\world14.anm\" >nul
rmdir /s /q "%OUT%\_work_world14_anm"
if exist "%OUT%\_work_world14_std" rmdir /s /q "%OUT%\_work_world14_std"
mkdir "%OUT%\_work_world14_std"
copy /y "%OUT%\world14.std" "%OUT%\_work_world14_std\world14.std" >nul
cd /d "%OUT%\_work_world14_std"
thstd.exe -d 19 world14.std world14.std.txt
cd /d "%OUT%"
del /q "%OUT%\world14.std"
del /q "%OUT%\_work_world14_std\world14.std"
mkdir "%OUT%\world14.std"
xcopy /e /y /q "%OUT%\_work_world14_std\*" "%OUT%\world14.std\" >nul
rmdir /s /q "%OUT%\_work_world14_std"
if exist "%OUT%\_work_world15_anm" rmdir /s /q "%OUT%\_work_world15_anm"
mkdir "%OUT%\_work_world15_anm"
copy /y "%OUT%\world15.anm" "%OUT%\_work_world15_anm\world15.anm" >nul
cd /d "%OUT%\_work_world15_anm"
thanm.exe -x 19 world15.anm
cd /d "%OUT%"
del /q "%OUT%\world15.anm"
del /q "%OUT%\_work_world15_anm\world15.anm"
mkdir "%OUT%\world15.anm"
xcopy /e /y /q "%OUT%\_work_world15_anm\*" "%OUT%\world15.anm\" >nul
rmdir /s /q "%OUT%\_work_world15_anm"
if exist "%OUT%\_work_world15_std" rmdir /s /q "%OUT%\_work_world15_std"
mkdir "%OUT%\_work_world15_std"
copy /y "%OUT%\world15.std" "%OUT%\_work_world15_std\world15.std" >nul
cd /d "%OUT%\_work_world15_std"
thstd.exe -d 19 world15.std world15.std.txt
cd /d "%OUT%"
del /q "%OUT%\world15.std"
del /q "%OUT%\_work_world15_std\world15.std"
mkdir "%OUT%\world15.std"
xcopy /e /y /q "%OUT%\_work_world15_std\*" "%OUT%\world15.std\" >nul
rmdir /s /q "%OUT%\_work_world15_std"
if exist "%OUT%\_work_world16_anm" rmdir /s /q "%OUT%\_work_world16_anm"
mkdir "%OUT%\_work_world16_anm"
copy /y "%OUT%\world16.anm" "%OUT%\_work_world16_anm\world16.anm" >nul
cd /d "%OUT%\_work_world16_anm"
thanm.exe -x 19 world16.anm
cd /d "%OUT%"
del /q "%OUT%\world16.anm"
del /q "%OUT%\_work_world16_anm\world16.anm"
mkdir "%OUT%\world16.anm"
xcopy /e /y /q "%OUT%\_work_world16_anm\*" "%OUT%\world16.anm\" >nul
rmdir /s /q "%OUT%\_work_world16_anm"
if exist "%OUT%\_work_world16_std" rmdir /s /q "%OUT%\_work_world16_std"
mkdir "%OUT%\_work_world16_std"
copy /y "%OUT%\world16.std" "%OUT%\_work_world16_std\world16.std" >nul
cd /d "%OUT%\_work_world16_std"
thstd.exe -d 19 world16.std world16.std.txt
cd /d "%OUT%"
del /q "%OUT%\world16.std"
del /q "%OUT%\_work_world16_std\world16.std"
mkdir "%OUT%\world16.std"
xcopy /e /y /q "%OUT%\_work_world16_std\*" "%OUT%\world16.std\" >nul
rmdir /s /q "%OUT%\_work_world16_std"
if exist "%OUT%\_work_world17_anm" rmdir /s /q "%OUT%\_work_world17_anm"
mkdir "%OUT%\_work_world17_anm"
copy /y "%OUT%\world17.anm" "%OUT%\_work_world17_anm\world17.anm" >nul
cd /d "%OUT%\_work_world17_anm"
thanm.exe -x 19 world17.anm
cd /d "%OUT%"
del /q "%OUT%\world17.anm"
del /q "%OUT%\_work_world17_anm\world17.anm"
mkdir "%OUT%\world17.anm"
xcopy /e /y /q "%OUT%\_work_world17_anm\*" "%OUT%\world17.anm\" >nul
rmdir /s /q "%OUT%\_work_world17_anm"
if exist "%OUT%\_work_world17_std" rmdir /s /q "%OUT%\_work_world17_std"
mkdir "%OUT%\_work_world17_std"
copy /y "%OUT%\world17.std" "%OUT%\_work_world17_std\world17.std" >nul
cd /d "%OUT%\_work_world17_std"
thstd.exe -d 19 world17.std world17.std.txt
cd /d "%OUT%"
del /q "%OUT%\world17.std"
del /q "%OUT%\_work_world17_std\world17.std"
mkdir "%OUT%\world17.std"
xcopy /e /y /q "%OUT%\_work_world17_std\*" "%OUT%\world17.std\" >nul
rmdir /s /q "%OUT%\_work_world17_std"
echo === th19 转换完成 ===