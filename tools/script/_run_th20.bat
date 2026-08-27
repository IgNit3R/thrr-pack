@echo off
setlocal
set PATH=E:\GitWorkspace\thworks\.build\thtk-install\bin;%PATH%
set OUT=E:\GitWorkspace\thworks\pushfiles\th20\th20.dat
if exist "%OUT%" rmdir /s /q "%OUT%"
mkdir "%OUT%"
cd /d "%OUT%"
thdat.exe -x 20 "E:\GitWorkspace\thworks\tsa\th20\th20.dat"
if exist "%OUT%\_work_ascii_anm" rmdir /s /q "%OUT%\_work_ascii_anm"
mkdir "%OUT%\_work_ascii_anm"
copy /y "%OUT%\ascii.anm" "%OUT%\_work_ascii_anm\ascii.anm" >nul
cd /d "%OUT%\_work_ascii_anm"
thanm.exe -x 20 ascii.anm
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
thanm.exe -x 20 ascii1280.anm
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
thanm.exe -x 20 ascii_960.anm
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
thanm.exe -x 20 aura.anm
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
thanm.exe -x 20 bullet.anm
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
thecl.exe -d 20 common.ecl common.ecl.txt
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
thecl.exe -d 20 default.ecl default.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\default.ecl"
del /q "%OUT%\_work_default_ecl\default.ecl"
mkdir "%OUT%\default.ecl"
xcopy /e /y /q "%OUT%\_work_default_ecl\*" "%OUT%\default.ecl\" >nul
rmdir /s /q "%OUT%\_work_default_ecl"
if exist "%OUT%\_work_e00a0_anm" rmdir /s /q "%OUT%\_work_e00a0_anm"
mkdir "%OUT%\_work_e00a0_anm"
copy /y "%OUT%\e00a0.anm" "%OUT%\_work_e00a0_anm\e00a0.anm" >nul
cd /d "%OUT%\_work_e00a0_anm"
thanm.exe -x 20 e00a0.anm
cd /d "%OUT%"
del /q "%OUT%\e00a0.anm"
del /q "%OUT%\_work_e00a0_anm\e00a0.anm"
mkdir "%OUT%\e00a0.anm"
xcopy /e /y /q "%OUT%\_work_e00a0_anm\*" "%OUT%\e00a0.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a0_anm"
if exist "%OUT%\_work_e00a0_msg" rmdir /s /q "%OUT%\_work_e00a0_msg"
mkdir "%OUT%\_work_e00a0_msg"
copy /y "%OUT%\e00a0.msg" "%OUT%\_work_e00a0_msg\e00a0.msg" >nul
cd /d "%OUT%\_work_e00a0_msg"
thmsg.exe -d 20 e00a0.msg e00a0.txt
cd /d "%OUT%"
del /q "%OUT%\e00a0.msg"
del /q "%OUT%\_work_e00a0_msg\e00a0.msg"
mkdir "%OUT%\e00a0.msg"
xcopy /e /y /q "%OUT%\_work_e00a0_msg\*" "%OUT%\e00a0.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a0_msg"
if exist "%OUT%\_work_e00a1_anm" rmdir /s /q "%OUT%\_work_e00a1_anm"
mkdir "%OUT%\_work_e00a1_anm"
copy /y "%OUT%\e00a1.anm" "%OUT%\_work_e00a1_anm\e00a1.anm" >nul
cd /d "%OUT%\_work_e00a1_anm"
thanm.exe -x 20 e00a1.anm
cd /d "%OUT%"
del /q "%OUT%\e00a1.anm"
del /q "%OUT%\_work_e00a1_anm\e00a1.anm"
mkdir "%OUT%\e00a1.anm"
xcopy /e /y /q "%OUT%\_work_e00a1_anm\*" "%OUT%\e00a1.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a1_anm"
if exist "%OUT%\_work_e00a1_msg" rmdir /s /q "%OUT%\_work_e00a1_msg"
mkdir "%OUT%\_work_e00a1_msg"
copy /y "%OUT%\e00a1.msg" "%OUT%\_work_e00a1_msg\e00a1.msg" >nul
cd /d "%OUT%\_work_e00a1_msg"
thmsg.exe -d 20 e00a1.msg e00a1.txt
cd /d "%OUT%"
del /q "%OUT%\e00a1.msg"
del /q "%OUT%\_work_e00a1_msg\e00a1.msg"
mkdir "%OUT%\e00a1.msg"
xcopy /e /y /q "%OUT%\_work_e00a1_msg\*" "%OUT%\e00a1.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a1_msg"
if exist "%OUT%\_work_e00a2_anm" rmdir /s /q "%OUT%\_work_e00a2_anm"
mkdir "%OUT%\_work_e00a2_anm"
copy /y "%OUT%\e00a2.anm" "%OUT%\_work_e00a2_anm\e00a2.anm" >nul
cd /d "%OUT%\_work_e00a2_anm"
thanm.exe -x 20 e00a2.anm
cd /d "%OUT%"
del /q "%OUT%\e00a2.anm"
del /q "%OUT%\_work_e00a2_anm\e00a2.anm"
mkdir "%OUT%\e00a2.anm"
xcopy /e /y /q "%OUT%\_work_e00a2_anm\*" "%OUT%\e00a2.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a2_anm"
if exist "%OUT%\_work_e00a2_msg" rmdir /s /q "%OUT%\_work_e00a2_msg"
mkdir "%OUT%\_work_e00a2_msg"
copy /y "%OUT%\e00a2.msg" "%OUT%\_work_e00a2_msg\e00a2.msg" >nul
cd /d "%OUT%\_work_e00a2_msg"
thmsg.exe -d 20 e00a2.msg e00a2.txt
cd /d "%OUT%"
del /q "%OUT%\e00a2.msg"
del /q "%OUT%\_work_e00a2_msg\e00a2.msg"
mkdir "%OUT%\e00a2.msg"
xcopy /e /y /q "%OUT%\_work_e00a2_msg\*" "%OUT%\e00a2.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a2_msg"
if exist "%OUT%\_work_e00a3_anm" rmdir /s /q "%OUT%\_work_e00a3_anm"
mkdir "%OUT%\_work_e00a3_anm"
copy /y "%OUT%\e00a3.anm" "%OUT%\_work_e00a3_anm\e00a3.anm" >nul
cd /d "%OUT%\_work_e00a3_anm"
thanm.exe -x 20 e00a3.anm
cd /d "%OUT%"
del /q "%OUT%\e00a3.anm"
del /q "%OUT%\_work_e00a3_anm\e00a3.anm"
mkdir "%OUT%\e00a3.anm"
xcopy /e /y /q "%OUT%\_work_e00a3_anm\*" "%OUT%\e00a3.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a3_anm"
if exist "%OUT%\_work_e00a3_msg" rmdir /s /q "%OUT%\_work_e00a3_msg"
mkdir "%OUT%\_work_e00a3_msg"
copy /y "%OUT%\e00a3.msg" "%OUT%\_work_e00a3_msg\e00a3.msg" >nul
cd /d "%OUT%\_work_e00a3_msg"
thmsg.exe -d 20 e00a3.msg e00a3.txt
cd /d "%OUT%"
del /q "%OUT%\e00a3.msg"
del /q "%OUT%\_work_e00a3_msg\e00a3.msg"
mkdir "%OUT%\e00a3.msg"
xcopy /e /y /q "%OUT%\_work_e00a3_msg\*" "%OUT%\e00a3.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a3_msg"
if exist "%OUT%\_work_e00a4_anm" rmdir /s /q "%OUT%\_work_e00a4_anm"
mkdir "%OUT%\_work_e00a4_anm"
copy /y "%OUT%\e00a4.anm" "%OUT%\_work_e00a4_anm\e00a4.anm" >nul
cd /d "%OUT%\_work_e00a4_anm"
thanm.exe -x 20 e00a4.anm
cd /d "%OUT%"
del /q "%OUT%\e00a4.anm"
del /q "%OUT%\_work_e00a4_anm\e00a4.anm"
mkdir "%OUT%\e00a4.anm"
xcopy /e /y /q "%OUT%\_work_e00a4_anm\*" "%OUT%\e00a4.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a4_anm"
if exist "%OUT%\_work_e00a4_msg" rmdir /s /q "%OUT%\_work_e00a4_msg"
mkdir "%OUT%\_work_e00a4_msg"
copy /y "%OUT%\e00a4.msg" "%OUT%\_work_e00a4_msg\e00a4.msg" >nul
cd /d "%OUT%\_work_e00a4_msg"
thmsg.exe -d 20 e00a4.msg e00a4.txt
cd /d "%OUT%"
del /q "%OUT%\e00a4.msg"
del /q "%OUT%\_work_e00a4_msg\e00a4.msg"
mkdir "%OUT%\e00a4.msg"
xcopy /e /y /q "%OUT%\_work_e00a4_msg\*" "%OUT%\e00a4.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a4_msg"
if exist "%OUT%\_work_e00a5_anm" rmdir /s /q "%OUT%\_work_e00a5_anm"
mkdir "%OUT%\_work_e00a5_anm"
copy /y "%OUT%\e00a5.anm" "%OUT%\_work_e00a5_anm\e00a5.anm" >nul
cd /d "%OUT%\_work_e00a5_anm"
thanm.exe -x 20 e00a5.anm
cd /d "%OUT%"
del /q "%OUT%\e00a5.anm"
del /q "%OUT%\_work_e00a5_anm\e00a5.anm"
mkdir "%OUT%\e00a5.anm"
xcopy /e /y /q "%OUT%\_work_e00a5_anm\*" "%OUT%\e00a5.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a5_anm"
if exist "%OUT%\_work_e00a5_msg" rmdir /s /q "%OUT%\_work_e00a5_msg"
mkdir "%OUT%\_work_e00a5_msg"
copy /y "%OUT%\e00a5.msg" "%OUT%\_work_e00a5_msg\e00a5.msg" >nul
cd /d "%OUT%\_work_e00a5_msg"
thmsg.exe -d 20 e00a5.msg e00a5.txt
cd /d "%OUT%"
del /q "%OUT%\e00a5.msg"
del /q "%OUT%\_work_e00a5_msg\e00a5.msg"
mkdir "%OUT%\e00a5.msg"
xcopy /e /y /q "%OUT%\_work_e00a5_msg\*" "%OUT%\e00a5.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a5_msg"
if exist "%OUT%\_work_e00a6_anm" rmdir /s /q "%OUT%\_work_e00a6_anm"
mkdir "%OUT%\_work_e00a6_anm"
copy /y "%OUT%\e00a6.anm" "%OUT%\_work_e00a6_anm\e00a6.anm" >nul
cd /d "%OUT%\_work_e00a6_anm"
thanm.exe -x 20 e00a6.anm
cd /d "%OUT%"
del /q "%OUT%\e00a6.anm"
del /q "%OUT%\_work_e00a6_anm\e00a6.anm"
mkdir "%OUT%\e00a6.anm"
xcopy /e /y /q "%OUT%\_work_e00a6_anm\*" "%OUT%\e00a6.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a6_anm"
if exist "%OUT%\_work_e00a6_msg" rmdir /s /q "%OUT%\_work_e00a6_msg"
mkdir "%OUT%\_work_e00a6_msg"
copy /y "%OUT%\e00a6.msg" "%OUT%\_work_e00a6_msg\e00a6.msg" >nul
cd /d "%OUT%\_work_e00a6_msg"
thmsg.exe -d 20 e00a6.msg e00a6.txt
cd /d "%OUT%"
del /q "%OUT%\e00a6.msg"
del /q "%OUT%\_work_e00a6_msg\e00a6.msg"
mkdir "%OUT%\e00a6.msg"
xcopy /e /y /q "%OUT%\_work_e00a6_msg\*" "%OUT%\e00a6.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a6_msg"
if exist "%OUT%\_work_e00a7_anm" rmdir /s /q "%OUT%\_work_e00a7_anm"
mkdir "%OUT%\_work_e00a7_anm"
copy /y "%OUT%\e00a7.anm" "%OUT%\_work_e00a7_anm\e00a7.anm" >nul
cd /d "%OUT%\_work_e00a7_anm"
thanm.exe -x 20 e00a7.anm
cd /d "%OUT%"
del /q "%OUT%\e00a7.anm"
del /q "%OUT%\_work_e00a7_anm\e00a7.anm"
mkdir "%OUT%\e00a7.anm"
xcopy /e /y /q "%OUT%\_work_e00a7_anm\*" "%OUT%\e00a7.anm\" >nul
rmdir /s /q "%OUT%\_work_e00a7_anm"
if exist "%OUT%\_work_e00a7_msg" rmdir /s /q "%OUT%\_work_e00a7_msg"
mkdir "%OUT%\_work_e00a7_msg"
copy /y "%OUT%\e00a7.msg" "%OUT%\_work_e00a7_msg\e00a7.msg" >nul
cd /d "%OUT%\_work_e00a7_msg"
thmsg.exe -d 20 e00a7.msg e00a7.txt
cd /d "%OUT%"
del /q "%OUT%\e00a7.msg"
del /q "%OUT%\_work_e00a7_msg\e00a7.msg"
mkdir "%OUT%\e00a7.msg"
xcopy /e /y /q "%OUT%\_work_e00a7_msg\*" "%OUT%\e00a7.msg\" >nul
rmdir /s /q "%OUT%\_work_e00a7_msg"
if exist "%OUT%\_work_e00b_anm" rmdir /s /q "%OUT%\_work_e00b_anm"
mkdir "%OUT%\_work_e00b_anm"
copy /y "%OUT%\e00b.anm" "%OUT%\_work_e00b_anm\e00b.anm" >nul
cd /d "%OUT%\_work_e00b_anm"
thanm.exe -x 20 e00b.anm
cd /d "%OUT%"
del /q "%OUT%\e00b.anm"
del /q "%OUT%\_work_e00b_anm\e00b.anm"
mkdir "%OUT%\e00b.anm"
xcopy /e /y /q "%OUT%\_work_e00b_anm\*" "%OUT%\e00b.anm\" >nul
rmdir /s /q "%OUT%\_work_e00b_anm"
if exist "%OUT%\_work_e00b_msg" rmdir /s /q "%OUT%\_work_e00b_msg"
mkdir "%OUT%\_work_e00b_msg"
copy /y "%OUT%\e00b.msg" "%OUT%\_work_e00b_msg\e00b.msg" >nul
cd /d "%OUT%\_work_e00b_msg"
thmsg.exe -d 20 e00b.msg e00b.txt
cd /d "%OUT%"
del /q "%OUT%\e00b.msg"
del /q "%OUT%\_work_e00b_msg\e00b.msg"
mkdir "%OUT%\e00b.msg"
xcopy /e /y /q "%OUT%\_work_e00b_msg\*" "%OUT%\e00b.msg\" >nul
rmdir /s /q "%OUT%\_work_e00b_msg"
if exist "%OUT%\_work_e01a0_anm" rmdir /s /q "%OUT%\_work_e01a0_anm"
mkdir "%OUT%\_work_e01a0_anm"
copy /y "%OUT%\e01a0.anm" "%OUT%\_work_e01a0_anm\e01a0.anm" >nul
cd /d "%OUT%\_work_e01a0_anm"
thanm.exe -x 20 e01a0.anm
cd /d "%OUT%"
del /q "%OUT%\e01a0.anm"
del /q "%OUT%\_work_e01a0_anm\e01a0.anm"
mkdir "%OUT%\e01a0.anm"
xcopy /e /y /q "%OUT%\_work_e01a0_anm\*" "%OUT%\e01a0.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a0_anm"
if exist "%OUT%\_work_e01a0_msg" rmdir /s /q "%OUT%\_work_e01a0_msg"
mkdir "%OUT%\_work_e01a0_msg"
copy /y "%OUT%\e01a0.msg" "%OUT%\_work_e01a0_msg\e01a0.msg" >nul
cd /d "%OUT%\_work_e01a0_msg"
thmsg.exe -d 20 e01a0.msg e01a0.txt
cd /d "%OUT%"
del /q "%OUT%\e01a0.msg"
del /q "%OUT%\_work_e01a0_msg\e01a0.msg"
mkdir "%OUT%\e01a0.msg"
xcopy /e /y /q "%OUT%\_work_e01a0_msg\*" "%OUT%\e01a0.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a0_msg"
if exist "%OUT%\_work_e01a1_anm" rmdir /s /q "%OUT%\_work_e01a1_anm"
mkdir "%OUT%\_work_e01a1_anm"
copy /y "%OUT%\e01a1.anm" "%OUT%\_work_e01a1_anm\e01a1.anm" >nul
cd /d "%OUT%\_work_e01a1_anm"
thanm.exe -x 20 e01a1.anm
cd /d "%OUT%"
del /q "%OUT%\e01a1.anm"
del /q "%OUT%\_work_e01a1_anm\e01a1.anm"
mkdir "%OUT%\e01a1.anm"
xcopy /e /y /q "%OUT%\_work_e01a1_anm\*" "%OUT%\e01a1.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a1_anm"
if exist "%OUT%\_work_e01a1_msg" rmdir /s /q "%OUT%\_work_e01a1_msg"
mkdir "%OUT%\_work_e01a1_msg"
copy /y "%OUT%\e01a1.msg" "%OUT%\_work_e01a1_msg\e01a1.msg" >nul
cd /d "%OUT%\_work_e01a1_msg"
thmsg.exe -d 20 e01a1.msg e01a1.txt
cd /d "%OUT%"
del /q "%OUT%\e01a1.msg"
del /q "%OUT%\_work_e01a1_msg\e01a1.msg"
mkdir "%OUT%\e01a1.msg"
xcopy /e /y /q "%OUT%\_work_e01a1_msg\*" "%OUT%\e01a1.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a1_msg"
if exist "%OUT%\_work_e01a2_anm" rmdir /s /q "%OUT%\_work_e01a2_anm"
mkdir "%OUT%\_work_e01a2_anm"
copy /y "%OUT%\e01a2.anm" "%OUT%\_work_e01a2_anm\e01a2.anm" >nul
cd /d "%OUT%\_work_e01a2_anm"
thanm.exe -x 20 e01a2.anm
cd /d "%OUT%"
del /q "%OUT%\e01a2.anm"
del /q "%OUT%\_work_e01a2_anm\e01a2.anm"
mkdir "%OUT%\e01a2.anm"
xcopy /e /y /q "%OUT%\_work_e01a2_anm\*" "%OUT%\e01a2.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a2_anm"
if exist "%OUT%\_work_e01a2_msg" rmdir /s /q "%OUT%\_work_e01a2_msg"
mkdir "%OUT%\_work_e01a2_msg"
copy /y "%OUT%\e01a2.msg" "%OUT%\_work_e01a2_msg\e01a2.msg" >nul
cd /d "%OUT%\_work_e01a2_msg"
thmsg.exe -d 20 e01a2.msg e01a2.txt
cd /d "%OUT%"
del /q "%OUT%\e01a2.msg"
del /q "%OUT%\_work_e01a2_msg\e01a2.msg"
mkdir "%OUT%\e01a2.msg"
xcopy /e /y /q "%OUT%\_work_e01a2_msg\*" "%OUT%\e01a2.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a2_msg"
if exist "%OUT%\_work_e01a3_anm" rmdir /s /q "%OUT%\_work_e01a3_anm"
mkdir "%OUT%\_work_e01a3_anm"
copy /y "%OUT%\e01a3.anm" "%OUT%\_work_e01a3_anm\e01a3.anm" >nul
cd /d "%OUT%\_work_e01a3_anm"
thanm.exe -x 20 e01a3.anm
cd /d "%OUT%"
del /q "%OUT%\e01a3.anm"
del /q "%OUT%\_work_e01a3_anm\e01a3.anm"
mkdir "%OUT%\e01a3.anm"
xcopy /e /y /q "%OUT%\_work_e01a3_anm\*" "%OUT%\e01a3.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a3_anm"
if exist "%OUT%\_work_e01a3_msg" rmdir /s /q "%OUT%\_work_e01a3_msg"
mkdir "%OUT%\_work_e01a3_msg"
copy /y "%OUT%\e01a3.msg" "%OUT%\_work_e01a3_msg\e01a3.msg" >nul
cd /d "%OUT%\_work_e01a3_msg"
thmsg.exe -d 20 e01a3.msg e01a3.txt
cd /d "%OUT%"
del /q "%OUT%\e01a3.msg"
del /q "%OUT%\_work_e01a3_msg\e01a3.msg"
mkdir "%OUT%\e01a3.msg"
xcopy /e /y /q "%OUT%\_work_e01a3_msg\*" "%OUT%\e01a3.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a3_msg"
if exist "%OUT%\_work_e01a4_anm" rmdir /s /q "%OUT%\_work_e01a4_anm"
mkdir "%OUT%\_work_e01a4_anm"
copy /y "%OUT%\e01a4.anm" "%OUT%\_work_e01a4_anm\e01a4.anm" >nul
cd /d "%OUT%\_work_e01a4_anm"
thanm.exe -x 20 e01a4.anm
cd /d "%OUT%"
del /q "%OUT%\e01a4.anm"
del /q "%OUT%\_work_e01a4_anm\e01a4.anm"
mkdir "%OUT%\e01a4.anm"
xcopy /e /y /q "%OUT%\_work_e01a4_anm\*" "%OUT%\e01a4.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a4_anm"
if exist "%OUT%\_work_e01a4_msg" rmdir /s /q "%OUT%\_work_e01a4_msg"
mkdir "%OUT%\_work_e01a4_msg"
copy /y "%OUT%\e01a4.msg" "%OUT%\_work_e01a4_msg\e01a4.msg" >nul
cd /d "%OUT%\_work_e01a4_msg"
thmsg.exe -d 20 e01a4.msg e01a4.txt
cd /d "%OUT%"
del /q "%OUT%\e01a4.msg"
del /q "%OUT%\_work_e01a4_msg\e01a4.msg"
mkdir "%OUT%\e01a4.msg"
xcopy /e /y /q "%OUT%\_work_e01a4_msg\*" "%OUT%\e01a4.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a4_msg"
if exist "%OUT%\_work_e01a5_anm" rmdir /s /q "%OUT%\_work_e01a5_anm"
mkdir "%OUT%\_work_e01a5_anm"
copy /y "%OUT%\e01a5.anm" "%OUT%\_work_e01a5_anm\e01a5.anm" >nul
cd /d "%OUT%\_work_e01a5_anm"
thanm.exe -x 20 e01a5.anm
cd /d "%OUT%"
del /q "%OUT%\e01a5.anm"
del /q "%OUT%\_work_e01a5_anm\e01a5.anm"
mkdir "%OUT%\e01a5.anm"
xcopy /e /y /q "%OUT%\_work_e01a5_anm\*" "%OUT%\e01a5.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a5_anm"
if exist "%OUT%\_work_e01a5_msg" rmdir /s /q "%OUT%\_work_e01a5_msg"
mkdir "%OUT%\_work_e01a5_msg"
copy /y "%OUT%\e01a5.msg" "%OUT%\_work_e01a5_msg\e01a5.msg" >nul
cd /d "%OUT%\_work_e01a5_msg"
thmsg.exe -d 20 e01a5.msg e01a5.txt
cd /d "%OUT%"
del /q "%OUT%\e01a5.msg"
del /q "%OUT%\_work_e01a5_msg\e01a5.msg"
mkdir "%OUT%\e01a5.msg"
xcopy /e /y /q "%OUT%\_work_e01a5_msg\*" "%OUT%\e01a5.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a5_msg"
if exist "%OUT%\_work_e01a6_anm" rmdir /s /q "%OUT%\_work_e01a6_anm"
mkdir "%OUT%\_work_e01a6_anm"
copy /y "%OUT%\e01a6.anm" "%OUT%\_work_e01a6_anm\e01a6.anm" >nul
cd /d "%OUT%\_work_e01a6_anm"
thanm.exe -x 20 e01a6.anm
cd /d "%OUT%"
del /q "%OUT%\e01a6.anm"
del /q "%OUT%\_work_e01a6_anm\e01a6.anm"
mkdir "%OUT%\e01a6.anm"
xcopy /e /y /q "%OUT%\_work_e01a6_anm\*" "%OUT%\e01a6.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a6_anm"
if exist "%OUT%\_work_e01a6_msg" rmdir /s /q "%OUT%\_work_e01a6_msg"
mkdir "%OUT%\_work_e01a6_msg"
copy /y "%OUT%\e01a6.msg" "%OUT%\_work_e01a6_msg\e01a6.msg" >nul
cd /d "%OUT%\_work_e01a6_msg"
thmsg.exe -d 20 e01a6.msg e01a6.txt
cd /d "%OUT%"
del /q "%OUT%\e01a6.msg"
del /q "%OUT%\_work_e01a6_msg\e01a6.msg"
mkdir "%OUT%\e01a6.msg"
xcopy /e /y /q "%OUT%\_work_e01a6_msg\*" "%OUT%\e01a6.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a6_msg"
if exist "%OUT%\_work_e01a7_anm" rmdir /s /q "%OUT%\_work_e01a7_anm"
mkdir "%OUT%\_work_e01a7_anm"
copy /y "%OUT%\e01a7.anm" "%OUT%\_work_e01a7_anm\e01a7.anm" >nul
cd /d "%OUT%\_work_e01a7_anm"
thanm.exe -x 20 e01a7.anm
cd /d "%OUT%"
del /q "%OUT%\e01a7.anm"
del /q "%OUT%\_work_e01a7_anm\e01a7.anm"
mkdir "%OUT%\e01a7.anm"
xcopy /e /y /q "%OUT%\_work_e01a7_anm\*" "%OUT%\e01a7.anm\" >nul
rmdir /s /q "%OUT%\_work_e01a7_anm"
if exist "%OUT%\_work_e01a7_msg" rmdir /s /q "%OUT%\_work_e01a7_msg"
mkdir "%OUT%\_work_e01a7_msg"
copy /y "%OUT%\e01a7.msg" "%OUT%\_work_e01a7_msg\e01a7.msg" >nul
cd /d "%OUT%\_work_e01a7_msg"
thmsg.exe -d 20 e01a7.msg e01a7.txt
cd /d "%OUT%"
del /q "%OUT%\e01a7.msg"
del /q "%OUT%\_work_e01a7_msg\e01a7.msg"
mkdir "%OUT%\e01a7.msg"
xcopy /e /y /q "%OUT%\_work_e01a7_msg\*" "%OUT%\e01a7.msg\" >nul
rmdir /s /q "%OUT%\_work_e01a7_msg"
if exist "%OUT%\_work_e01b_anm" rmdir /s /q "%OUT%\_work_e01b_anm"
mkdir "%OUT%\_work_e01b_anm"
copy /y "%OUT%\e01b.anm" "%OUT%\_work_e01b_anm\e01b.anm" >nul
cd /d "%OUT%\_work_e01b_anm"
thanm.exe -x 20 e01b.anm
cd /d "%OUT%"
del /q "%OUT%\e01b.anm"
del /q "%OUT%\_work_e01b_anm\e01b.anm"
mkdir "%OUT%\e01b.anm"
xcopy /e /y /q "%OUT%\_work_e01b_anm\*" "%OUT%\e01b.anm\" >nul
rmdir /s /q "%OUT%\_work_e01b_anm"
if exist "%OUT%\_work_e01b_msg" rmdir /s /q "%OUT%\_work_e01b_msg"
mkdir "%OUT%\_work_e01b_msg"
copy /y "%OUT%\e01b.msg" "%OUT%\_work_e01b_msg\e01b.msg" >nul
cd /d "%OUT%\_work_e01b_msg"
thmsg.exe -d 20 e01b.msg e01b.txt
cd /d "%OUT%"
del /q "%OUT%\e01b.msg"
del /q "%OUT%\_work_e01b_msg\e01b.msg"
mkdir "%OUT%\e01b.msg"
xcopy /e /y /q "%OUT%\_work_e01b_msg\*" "%OUT%\e01b.msg\" >nul
rmdir /s /q "%OUT%\_work_e01b_msg"
if exist "%OUT%\_work_ebg00_anm" rmdir /s /q "%OUT%\_work_ebg00_anm"
mkdir "%OUT%\_work_ebg00_anm"
copy /y "%OUT%\ebg00.anm" "%OUT%\_work_ebg00_anm\ebg00.anm" >nul
cd /d "%OUT%\_work_ebg00_anm"
thanm.exe -x 20 ebg00.anm
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
thanm.exe -x 20 ebg01.anm
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
thanm.exe -x 20 ebg02.anm
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
thanm.exe -x 20 ebg03.anm
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
thanm.exe -x 20 ebg04.anm
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
thanm.exe -x 20 ebg05.anm
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
thanm.exe -x 20 ebg06.anm
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
thanm.exe -x 20 ebg07.anm
cd /d "%OUT%"
del /q "%OUT%\ebg07.anm"
del /q "%OUT%\_work_ebg07_anm\ebg07.anm"
mkdir "%OUT%\ebg07.anm"
xcopy /e /y /q "%OUT%\_work_ebg07_anm\*" "%OUT%\ebg07.anm\" >nul
rmdir /s /q "%OUT%\_work_ebg07_anm"
if exist "%OUT%\_work_effect_anm" rmdir /s /q "%OUT%\_work_effect_anm"
mkdir "%OUT%\_work_effect_anm"
copy /y "%OUT%\effect.anm" "%OUT%\_work_effect_anm\effect.anm" >nul
cd /d "%OUT%\_work_effect_anm"
thanm.exe -x 20 effect.anm
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
thanm.exe -x 20 enemy.anm
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
thanm.exe -x 20 front.anm
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
thanm.exe -x 20 ghost.anm
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
thanm.exe -x 20 help.anm
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
thanm.exe -x 20 notice.anm
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
thanm.exe -x 20 pl00.anm
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
thanm.exe -x 20 pl01.anm
cd /d "%OUT%"
del /q "%OUT%\pl01.anm"
del /q "%OUT%\_work_pl01_anm\pl01.anm"
mkdir "%OUT%\pl01.anm"
xcopy /e /y /q "%OUT%\_work_pl01_anm\*" "%OUT%\pl01.anm\" >nul
rmdir /s /q "%OUT%\_work_pl01_anm"
if exist "%OUT%\_work_screenswitch_anm" rmdir /s /q "%OUT%\_work_screenswitch_anm"
mkdir "%OUT%\_work_screenswitch_anm"
copy /y "%OUT%\screenswitch.anm" "%OUT%\_work_screenswitch_anm\screenswitch.anm" >nul
cd /d "%OUT%\_work_screenswitch_anm"
thanm.exe -x 20 screenswitch.anm
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
thanm.exe -x 20 sig.anm
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
thecl.exe -d 20 st01.ecl st01.ecl.txt
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
thstd.exe -d 20 st01.std st01.std.txt
cd /d "%OUT%"
del /q "%OUT%\st01.std"
del /q "%OUT%\_work_st01_std\st01.std"
mkdir "%OUT%\st01.std"
xcopy /e /y /q "%OUT%\_work_st01_std\*" "%OUT%\st01.std\" >nul
rmdir /s /q "%OUT%\_work_st01_std"
if exist "%OUT%\_work_st01bs_ecl" rmdir /s /q "%OUT%\_work_st01bs_ecl"
mkdir "%OUT%\_work_st01bs_ecl"
copy /y "%OUT%\st01bs.ecl" "%OUT%\_work_st01bs_ecl\st01bs.ecl" >nul
cd /d "%OUT%\_work_st01bs_ecl"
thecl.exe -d 20 st01bs.ecl st01bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st01bs.ecl"
del /q "%OUT%\_work_st01bs_ecl\st01bs.ecl"
mkdir "%OUT%\st01bs.ecl"
xcopy /e /y /q "%OUT%\_work_st01bs_ecl\*" "%OUT%\st01bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st01bs_ecl"
if exist "%OUT%\_work_st01enm_anm" rmdir /s /q "%OUT%\_work_st01enm_anm"
mkdir "%OUT%\_work_st01enm_anm"
copy /y "%OUT%\st01enm.anm" "%OUT%\_work_st01enm_anm\st01enm.anm" >nul
cd /d "%OUT%\_work_st01enm_anm"
thanm.exe -x 20 st01enm.anm
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
thanm.exe -x 20 st01logo.anm
cd /d "%OUT%"
del /q "%OUT%\st01logo.anm"
del /q "%OUT%\_work_st01logo_anm\st01logo.anm"
mkdir "%OUT%\st01logo.anm"
xcopy /e /y /q "%OUT%\_work_st01logo_anm\*" "%OUT%\st01logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st01logo_anm"
if exist "%OUT%\_work_st01m0_msg" rmdir /s /q "%OUT%\_work_st01m0_msg"
mkdir "%OUT%\_work_st01m0_msg"
copy /y "%OUT%\st01m0.msg" "%OUT%\_work_st01m0_msg\st01m0.msg" >nul
cd /d "%OUT%\_work_st01m0_msg"
thmsg.exe -d 20 st01m0.msg st01m0.txt
cd /d "%OUT%"
del /q "%OUT%\st01m0.msg"
del /q "%OUT%\_work_st01m0_msg\st01m0.msg"
mkdir "%OUT%\st01m0.msg"
xcopy /e /y /q "%OUT%\_work_st01m0_msg\*" "%OUT%\st01m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st01m0_msg"
if exist "%OUT%\_work_st01m1_msg" rmdir /s /q "%OUT%\_work_st01m1_msg"
mkdir "%OUT%\_work_st01m1_msg"
copy /y "%OUT%\st01m1.msg" "%OUT%\_work_st01m1_msg\st01m1.msg" >nul
cd /d "%OUT%\_work_st01m1_msg"
thmsg.exe -d 20 st01m1.msg st01m1.txt
cd /d "%OUT%"
del /q "%OUT%\st01m1.msg"
del /q "%OUT%\_work_st01m1_msg\st01m1.msg"
mkdir "%OUT%\st01m1.msg"
xcopy /e /y /q "%OUT%\_work_st01m1_msg\*" "%OUT%\st01m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st01m1_msg"
if exist "%OUT%\_work_st01m2_msg" rmdir /s /q "%OUT%\_work_st01m2_msg"
mkdir "%OUT%\_work_st01m2_msg"
copy /y "%OUT%\st01m2.msg" "%OUT%\_work_st01m2_msg\st01m2.msg" >nul
cd /d "%OUT%\_work_st01m2_msg"
thmsg.exe -d 20 st01m2.msg st01m2.txt
cd /d "%OUT%"
del /q "%OUT%\st01m2.msg"
del /q "%OUT%\_work_st01m2_msg\st01m2.msg"
mkdir "%OUT%\st01m2.msg"
xcopy /e /y /q "%OUT%\_work_st01m2_msg\*" "%OUT%\st01m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st01m2_msg"
if exist "%OUT%\_work_st01m3_msg" rmdir /s /q "%OUT%\_work_st01m3_msg"
mkdir "%OUT%\_work_st01m3_msg"
copy /y "%OUT%\st01m3.msg" "%OUT%\_work_st01m3_msg\st01m3.msg" >nul
cd /d "%OUT%\_work_st01m3_msg"
thmsg.exe -d 20 st01m3.msg st01m3.txt
cd /d "%OUT%"
del /q "%OUT%\st01m3.msg"
del /q "%OUT%\_work_st01m3_msg\st01m3.msg"
mkdir "%OUT%\st01m3.msg"
xcopy /e /y /q "%OUT%\_work_st01m3_msg\*" "%OUT%\st01m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st01m3_msg"
if exist "%OUT%\_work_st01mbs_ecl" rmdir /s /q "%OUT%\_work_st01mbs_ecl"
mkdir "%OUT%\_work_st01mbs_ecl"
copy /y "%OUT%\st01mbs.ecl" "%OUT%\_work_st01mbs_ecl\st01mbs.ecl" >nul
cd /d "%OUT%\_work_st01mbs_ecl"
thecl.exe -d 20 st01mbs.ecl st01mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st01mbs.ecl"
del /q "%OUT%\_work_st01mbs_ecl\st01mbs.ecl"
mkdir "%OUT%\st01mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st01mbs_ecl\*" "%OUT%\st01mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st01mbs_ecl"
if exist "%OUT%\_work_st01r0_msg" rmdir /s /q "%OUT%\_work_st01r0_msg"
mkdir "%OUT%\_work_st01r0_msg"
copy /y "%OUT%\st01r0.msg" "%OUT%\_work_st01r0_msg\st01r0.msg" >nul
cd /d "%OUT%\_work_st01r0_msg"
thmsg.exe -d 20 st01r0.msg st01r0.txt
cd /d "%OUT%"
del /q "%OUT%\st01r0.msg"
del /q "%OUT%\_work_st01r0_msg\st01r0.msg"
mkdir "%OUT%\st01r0.msg"
xcopy /e /y /q "%OUT%\_work_st01r0_msg\*" "%OUT%\st01r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st01r0_msg"
if exist "%OUT%\_work_st01r1_msg" rmdir /s /q "%OUT%\_work_st01r1_msg"
mkdir "%OUT%\_work_st01r1_msg"
copy /y "%OUT%\st01r1.msg" "%OUT%\_work_st01r1_msg\st01r1.msg" >nul
cd /d "%OUT%\_work_st01r1_msg"
thmsg.exe -d 20 st01r1.msg st01r1.txt
cd /d "%OUT%"
del /q "%OUT%\st01r1.msg"
del /q "%OUT%\_work_st01r1_msg\st01r1.msg"
mkdir "%OUT%\st01r1.msg"
xcopy /e /y /q "%OUT%\_work_st01r1_msg\*" "%OUT%\st01r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st01r1_msg"
if exist "%OUT%\_work_st01r2_msg" rmdir /s /q "%OUT%\_work_st01r2_msg"
mkdir "%OUT%\_work_st01r2_msg"
copy /y "%OUT%\st01r2.msg" "%OUT%\_work_st01r2_msg\st01r2.msg" >nul
cd /d "%OUT%\_work_st01r2_msg"
thmsg.exe -d 20 st01r2.msg st01r2.txt
cd /d "%OUT%"
del /q "%OUT%\st01r2.msg"
del /q "%OUT%\_work_st01r2_msg\st01r2.msg"
mkdir "%OUT%\st01r2.msg"
xcopy /e /y /q "%OUT%\_work_st01r2_msg\*" "%OUT%\st01r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st01r2_msg"
if exist "%OUT%\_work_st01r3_msg" rmdir /s /q "%OUT%\_work_st01r3_msg"
mkdir "%OUT%\_work_st01r3_msg"
copy /y "%OUT%\st01r3.msg" "%OUT%\_work_st01r3_msg\st01r3.msg" >nul
cd /d "%OUT%\_work_st01r3_msg"
thmsg.exe -d 20 st01r3.msg st01r3.txt
cd /d "%OUT%"
del /q "%OUT%\st01r3.msg"
del /q "%OUT%\_work_st01r3_msg\st01r3.msg"
mkdir "%OUT%\st01r3.msg"
xcopy /e /y /q "%OUT%\_work_st01r3_msg\*" "%OUT%\st01r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st01r3_msg"
if exist "%OUT%\_work_st01wl_anm" rmdir /s /q "%OUT%\_work_st01wl_anm"
mkdir "%OUT%\_work_st01wl_anm"
copy /y "%OUT%\st01wl.anm" "%OUT%\_work_st01wl_anm\st01wl.anm" >nul
cd /d "%OUT%\_work_st01wl_anm"
thanm.exe -x 20 st01wl.anm
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
thecl.exe -d 20 st02.ecl st02.ecl.txt
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
thstd.exe -d 20 st02.std st02.std.txt
cd /d "%OUT%"
del /q "%OUT%\st02.std"
del /q "%OUT%\_work_st02_std\st02.std"
mkdir "%OUT%\st02.std"
xcopy /e /y /q "%OUT%\_work_st02_std\*" "%OUT%\st02.std\" >nul
rmdir /s /q "%OUT%\_work_st02_std"
if exist "%OUT%\_work_st02bs_ecl" rmdir /s /q "%OUT%\_work_st02bs_ecl"
mkdir "%OUT%\_work_st02bs_ecl"
copy /y "%OUT%\st02bs.ecl" "%OUT%\_work_st02bs_ecl\st02bs.ecl" >nul
cd /d "%OUT%\_work_st02bs_ecl"
thecl.exe -d 20 st02bs.ecl st02bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st02bs.ecl"
del /q "%OUT%\_work_st02bs_ecl\st02bs.ecl"
mkdir "%OUT%\st02bs.ecl"
xcopy /e /y /q "%OUT%\_work_st02bs_ecl\*" "%OUT%\st02bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st02bs_ecl"
if exist "%OUT%\_work_st02enm_anm" rmdir /s /q "%OUT%\_work_st02enm_anm"
mkdir "%OUT%\_work_st02enm_anm"
copy /y "%OUT%\st02enm.anm" "%OUT%\_work_st02enm_anm\st02enm.anm" >nul
cd /d "%OUT%\_work_st02enm_anm"
thanm.exe -x 20 st02enm.anm
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
thanm.exe -x 20 st02logo.anm
cd /d "%OUT%"
del /q "%OUT%\st02logo.anm"
del /q "%OUT%\_work_st02logo_anm\st02logo.anm"
mkdir "%OUT%\st02logo.anm"
xcopy /e /y /q "%OUT%\_work_st02logo_anm\*" "%OUT%\st02logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st02logo_anm"
if exist "%OUT%\_work_st02m0_msg" rmdir /s /q "%OUT%\_work_st02m0_msg"
mkdir "%OUT%\_work_st02m0_msg"
copy /y "%OUT%\st02m0.msg" "%OUT%\_work_st02m0_msg\st02m0.msg" >nul
cd /d "%OUT%\_work_st02m0_msg"
thmsg.exe -d 20 st02m0.msg st02m0.txt
cd /d "%OUT%"
del /q "%OUT%\st02m0.msg"
del /q "%OUT%\_work_st02m0_msg\st02m0.msg"
mkdir "%OUT%\st02m0.msg"
xcopy /e /y /q "%OUT%\_work_st02m0_msg\*" "%OUT%\st02m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st02m0_msg"
if exist "%OUT%\_work_st02m1_msg" rmdir /s /q "%OUT%\_work_st02m1_msg"
mkdir "%OUT%\_work_st02m1_msg"
copy /y "%OUT%\st02m1.msg" "%OUT%\_work_st02m1_msg\st02m1.msg" >nul
cd /d "%OUT%\_work_st02m1_msg"
thmsg.exe -d 20 st02m1.msg st02m1.txt
cd /d "%OUT%"
del /q "%OUT%\st02m1.msg"
del /q "%OUT%\_work_st02m1_msg\st02m1.msg"
mkdir "%OUT%\st02m1.msg"
xcopy /e /y /q "%OUT%\_work_st02m1_msg\*" "%OUT%\st02m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st02m1_msg"
if exist "%OUT%\_work_st02m2_msg" rmdir /s /q "%OUT%\_work_st02m2_msg"
mkdir "%OUT%\_work_st02m2_msg"
copy /y "%OUT%\st02m2.msg" "%OUT%\_work_st02m2_msg\st02m2.msg" >nul
cd /d "%OUT%\_work_st02m2_msg"
thmsg.exe -d 20 st02m2.msg st02m2.txt
cd /d "%OUT%"
del /q "%OUT%\st02m2.msg"
del /q "%OUT%\_work_st02m2_msg\st02m2.msg"
mkdir "%OUT%\st02m2.msg"
xcopy /e /y /q "%OUT%\_work_st02m2_msg\*" "%OUT%\st02m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st02m2_msg"
if exist "%OUT%\_work_st02m3_msg" rmdir /s /q "%OUT%\_work_st02m3_msg"
mkdir "%OUT%\_work_st02m3_msg"
copy /y "%OUT%\st02m3.msg" "%OUT%\_work_st02m3_msg\st02m3.msg" >nul
cd /d "%OUT%\_work_st02m3_msg"
thmsg.exe -d 20 st02m3.msg st02m3.txt
cd /d "%OUT%"
del /q "%OUT%\st02m3.msg"
del /q "%OUT%\_work_st02m3_msg\st02m3.msg"
mkdir "%OUT%\st02m3.msg"
xcopy /e /y /q "%OUT%\_work_st02m3_msg\*" "%OUT%\st02m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st02m3_msg"
if exist "%OUT%\_work_st02mbs_ecl" rmdir /s /q "%OUT%\_work_st02mbs_ecl"
mkdir "%OUT%\_work_st02mbs_ecl"
copy /y "%OUT%\st02mbs.ecl" "%OUT%\_work_st02mbs_ecl\st02mbs.ecl" >nul
cd /d "%OUT%\_work_st02mbs_ecl"
thecl.exe -d 20 st02mbs.ecl st02mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st02mbs.ecl"
del /q "%OUT%\_work_st02mbs_ecl\st02mbs.ecl"
mkdir "%OUT%\st02mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st02mbs_ecl\*" "%OUT%\st02mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st02mbs_ecl"
if exist "%OUT%\_work_st02r0_msg" rmdir /s /q "%OUT%\_work_st02r0_msg"
mkdir "%OUT%\_work_st02r0_msg"
copy /y "%OUT%\st02r0.msg" "%OUT%\_work_st02r0_msg\st02r0.msg" >nul
cd /d "%OUT%\_work_st02r0_msg"
thmsg.exe -d 20 st02r0.msg st02r0.txt
cd /d "%OUT%"
del /q "%OUT%\st02r0.msg"
del /q "%OUT%\_work_st02r0_msg\st02r0.msg"
mkdir "%OUT%\st02r0.msg"
xcopy /e /y /q "%OUT%\_work_st02r0_msg\*" "%OUT%\st02r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st02r0_msg"
if exist "%OUT%\_work_st02r1_msg" rmdir /s /q "%OUT%\_work_st02r1_msg"
mkdir "%OUT%\_work_st02r1_msg"
copy /y "%OUT%\st02r1.msg" "%OUT%\_work_st02r1_msg\st02r1.msg" >nul
cd /d "%OUT%\_work_st02r1_msg"
thmsg.exe -d 20 st02r1.msg st02r1.txt
cd /d "%OUT%"
del /q "%OUT%\st02r1.msg"
del /q "%OUT%\_work_st02r1_msg\st02r1.msg"
mkdir "%OUT%\st02r1.msg"
xcopy /e /y /q "%OUT%\_work_st02r1_msg\*" "%OUT%\st02r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st02r1_msg"
if exist "%OUT%\_work_st02r2_msg" rmdir /s /q "%OUT%\_work_st02r2_msg"
mkdir "%OUT%\_work_st02r2_msg"
copy /y "%OUT%\st02r2.msg" "%OUT%\_work_st02r2_msg\st02r2.msg" >nul
cd /d "%OUT%\_work_st02r2_msg"
thmsg.exe -d 20 st02r2.msg st02r2.txt
cd /d "%OUT%"
del /q "%OUT%\st02r2.msg"
del /q "%OUT%\_work_st02r2_msg\st02r2.msg"
mkdir "%OUT%\st02r2.msg"
xcopy /e /y /q "%OUT%\_work_st02r2_msg\*" "%OUT%\st02r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st02r2_msg"
if exist "%OUT%\_work_st02r3_msg" rmdir /s /q "%OUT%\_work_st02r3_msg"
mkdir "%OUT%\_work_st02r3_msg"
copy /y "%OUT%\st02r3.msg" "%OUT%\_work_st02r3_msg\st02r3.msg" >nul
cd /d "%OUT%\_work_st02r3_msg"
thmsg.exe -d 20 st02r3.msg st02r3.txt
cd /d "%OUT%"
del /q "%OUT%\st02r3.msg"
del /q "%OUT%\_work_st02r3_msg\st02r3.msg"
mkdir "%OUT%\st02r3.msg"
xcopy /e /y /q "%OUT%\_work_st02r3_msg\*" "%OUT%\st02r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st02r3_msg"
if exist "%OUT%\_work_st02wl_anm" rmdir /s /q "%OUT%\_work_st02wl_anm"
mkdir "%OUT%\_work_st02wl_anm"
copy /y "%OUT%\st02wl.anm" "%OUT%\_work_st02wl_anm\st02wl.anm" >nul
cd /d "%OUT%\_work_st02wl_anm"
thanm.exe -x 20 st02wl.anm
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
thecl.exe -d 20 st03.ecl st03.ecl.txt
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
thstd.exe -d 20 st03.std st03.std.txt
cd /d "%OUT%"
del /q "%OUT%\st03.std"
del /q "%OUT%\_work_st03_std\st03.std"
mkdir "%OUT%\st03.std"
xcopy /e /y /q "%OUT%\_work_st03_std\*" "%OUT%\st03.std\" >nul
rmdir /s /q "%OUT%\_work_st03_std"
if exist "%OUT%\_work_st03bs_ecl" rmdir /s /q "%OUT%\_work_st03bs_ecl"
mkdir "%OUT%\_work_st03bs_ecl"
copy /y "%OUT%\st03bs.ecl" "%OUT%\_work_st03bs_ecl\st03bs.ecl" >nul
cd /d "%OUT%\_work_st03bs_ecl"
thecl.exe -d 20 st03bs.ecl st03bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st03bs.ecl"
del /q "%OUT%\_work_st03bs_ecl\st03bs.ecl"
mkdir "%OUT%\st03bs.ecl"
xcopy /e /y /q "%OUT%\_work_st03bs_ecl\*" "%OUT%\st03bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st03bs_ecl"
if exist "%OUT%\_work_st03enm_anm" rmdir /s /q "%OUT%\_work_st03enm_anm"
mkdir "%OUT%\_work_st03enm_anm"
copy /y "%OUT%\st03enm.anm" "%OUT%\_work_st03enm_anm\st03enm.anm" >nul
cd /d "%OUT%\_work_st03enm_anm"
thanm.exe -x 20 st03enm.anm
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
thanm.exe -x 20 st03logo.anm
cd /d "%OUT%"
del /q "%OUT%\st03logo.anm"
del /q "%OUT%\_work_st03logo_anm\st03logo.anm"
mkdir "%OUT%\st03logo.anm"
xcopy /e /y /q "%OUT%\_work_st03logo_anm\*" "%OUT%\st03logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st03logo_anm"
if exist "%OUT%\_work_st03m0_msg" rmdir /s /q "%OUT%\_work_st03m0_msg"
mkdir "%OUT%\_work_st03m0_msg"
copy /y "%OUT%\st03m0.msg" "%OUT%\_work_st03m0_msg\st03m0.msg" >nul
cd /d "%OUT%\_work_st03m0_msg"
thmsg.exe -d 20 st03m0.msg st03m0.txt
cd /d "%OUT%"
del /q "%OUT%\st03m0.msg"
del /q "%OUT%\_work_st03m0_msg\st03m0.msg"
mkdir "%OUT%\st03m0.msg"
xcopy /e /y /q "%OUT%\_work_st03m0_msg\*" "%OUT%\st03m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st03m0_msg"
if exist "%OUT%\_work_st03m1_msg" rmdir /s /q "%OUT%\_work_st03m1_msg"
mkdir "%OUT%\_work_st03m1_msg"
copy /y "%OUT%\st03m1.msg" "%OUT%\_work_st03m1_msg\st03m1.msg" >nul
cd /d "%OUT%\_work_st03m1_msg"
thmsg.exe -d 20 st03m1.msg st03m1.txt
cd /d "%OUT%"
del /q "%OUT%\st03m1.msg"
del /q "%OUT%\_work_st03m1_msg\st03m1.msg"
mkdir "%OUT%\st03m1.msg"
xcopy /e /y /q "%OUT%\_work_st03m1_msg\*" "%OUT%\st03m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st03m1_msg"
if exist "%OUT%\_work_st03m2_msg" rmdir /s /q "%OUT%\_work_st03m2_msg"
mkdir "%OUT%\_work_st03m2_msg"
copy /y "%OUT%\st03m2.msg" "%OUT%\_work_st03m2_msg\st03m2.msg" >nul
cd /d "%OUT%\_work_st03m2_msg"
thmsg.exe -d 20 st03m2.msg st03m2.txt
cd /d "%OUT%"
del /q "%OUT%\st03m2.msg"
del /q "%OUT%\_work_st03m2_msg\st03m2.msg"
mkdir "%OUT%\st03m2.msg"
xcopy /e /y /q "%OUT%\_work_st03m2_msg\*" "%OUT%\st03m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st03m2_msg"
if exist "%OUT%\_work_st03m3_msg" rmdir /s /q "%OUT%\_work_st03m3_msg"
mkdir "%OUT%\_work_st03m3_msg"
copy /y "%OUT%\st03m3.msg" "%OUT%\_work_st03m3_msg\st03m3.msg" >nul
cd /d "%OUT%\_work_st03m3_msg"
thmsg.exe -d 20 st03m3.msg st03m3.txt
cd /d "%OUT%"
del /q "%OUT%\st03m3.msg"
del /q "%OUT%\_work_st03m3_msg\st03m3.msg"
mkdir "%OUT%\st03m3.msg"
xcopy /e /y /q "%OUT%\_work_st03m3_msg\*" "%OUT%\st03m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st03m3_msg"
if exist "%OUT%\_work_st03r0_msg" rmdir /s /q "%OUT%\_work_st03r0_msg"
mkdir "%OUT%\_work_st03r0_msg"
copy /y "%OUT%\st03r0.msg" "%OUT%\_work_st03r0_msg\st03r0.msg" >nul
cd /d "%OUT%\_work_st03r0_msg"
thmsg.exe -d 20 st03r0.msg st03r0.txt
cd /d "%OUT%"
del /q "%OUT%\st03r0.msg"
del /q "%OUT%\_work_st03r0_msg\st03r0.msg"
mkdir "%OUT%\st03r0.msg"
xcopy /e /y /q "%OUT%\_work_st03r0_msg\*" "%OUT%\st03r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st03r0_msg"
if exist "%OUT%\_work_st03r1_msg" rmdir /s /q "%OUT%\_work_st03r1_msg"
mkdir "%OUT%\_work_st03r1_msg"
copy /y "%OUT%\st03r1.msg" "%OUT%\_work_st03r1_msg\st03r1.msg" >nul
cd /d "%OUT%\_work_st03r1_msg"
thmsg.exe -d 20 st03r1.msg st03r1.txt
cd /d "%OUT%"
del /q "%OUT%\st03r1.msg"
del /q "%OUT%\_work_st03r1_msg\st03r1.msg"
mkdir "%OUT%\st03r1.msg"
xcopy /e /y /q "%OUT%\_work_st03r1_msg\*" "%OUT%\st03r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st03r1_msg"
if exist "%OUT%\_work_st03r2_msg" rmdir /s /q "%OUT%\_work_st03r2_msg"
mkdir "%OUT%\_work_st03r2_msg"
copy /y "%OUT%\st03r2.msg" "%OUT%\_work_st03r2_msg\st03r2.msg" >nul
cd /d "%OUT%\_work_st03r2_msg"
thmsg.exe -d 20 st03r2.msg st03r2.txt
cd /d "%OUT%"
del /q "%OUT%\st03r2.msg"
del /q "%OUT%\_work_st03r2_msg\st03r2.msg"
mkdir "%OUT%\st03r2.msg"
xcopy /e /y /q "%OUT%\_work_st03r2_msg\*" "%OUT%\st03r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st03r2_msg"
if exist "%OUT%\_work_st03r3_msg" rmdir /s /q "%OUT%\_work_st03r3_msg"
mkdir "%OUT%\_work_st03r3_msg"
copy /y "%OUT%\st03r3.msg" "%OUT%\_work_st03r3_msg\st03r3.msg" >nul
cd /d "%OUT%\_work_st03r3_msg"
thmsg.exe -d 20 st03r3.msg st03r3.txt
cd /d "%OUT%"
del /q "%OUT%\st03r3.msg"
del /q "%OUT%\_work_st03r3_msg\st03r3.msg"
mkdir "%OUT%\st03r3.msg"
xcopy /e /y /q "%OUT%\_work_st03r3_msg\*" "%OUT%\st03r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st03r3_msg"
if exist "%OUT%\_work_st03wl_anm" rmdir /s /q "%OUT%\_work_st03wl_anm"
mkdir "%OUT%\_work_st03wl_anm"
copy /y "%OUT%\st03wl.anm" "%OUT%\_work_st03wl_anm\st03wl.anm" >nul
cd /d "%OUT%\_work_st03wl_anm"
thanm.exe -x 20 st03wl.anm
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
thecl.exe -d 20 st04.ecl st04.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04.ecl"
del /q "%OUT%\_work_st04_ecl\st04.ecl"
mkdir "%OUT%\st04.ecl"
xcopy /e /y /q "%OUT%\_work_st04_ecl\*" "%OUT%\st04.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04_ecl"
if exist "%OUT%\_work_st04a_std" rmdir /s /q "%OUT%\_work_st04a_std"
mkdir "%OUT%\_work_st04a_std"
copy /y "%OUT%\st04a.std" "%OUT%\_work_st04a_std\st04a.std" >nul
cd /d "%OUT%\_work_st04a_std"
thstd.exe -d 20 st04a.std st04a.std.txt
cd /d "%OUT%"
del /q "%OUT%\st04a.std"
del /q "%OUT%\_work_st04a_std\st04a.std"
mkdir "%OUT%\st04a.std"
xcopy /e /y /q "%OUT%\_work_st04a_std\*" "%OUT%\st04a.std\" >nul
rmdir /s /q "%OUT%\_work_st04a_std"
if exist "%OUT%\_work_st04b_std" rmdir /s /q "%OUT%\_work_st04b_std"
mkdir "%OUT%\_work_st04b_std"
copy /y "%OUT%\st04b.std" "%OUT%\_work_st04b_std\st04b.std" >nul
cd /d "%OUT%\_work_st04b_std"
thstd.exe -d 20 st04b.std st04b.std.txt
cd /d "%OUT%"
del /q "%OUT%\st04b.std"
del /q "%OUT%\_work_st04b_std\st04b.std"
mkdir "%OUT%\st04b.std"
xcopy /e /y /q "%OUT%\_work_st04b_std\*" "%OUT%\st04b.std\" >nul
rmdir /s /q "%OUT%\_work_st04b_std"
if exist "%OUT%\_work_st04bs_ecl" rmdir /s /q "%OUT%\_work_st04bs_ecl"
mkdir "%OUT%\_work_st04bs_ecl"
copy /y "%OUT%\st04bs.ecl" "%OUT%\_work_st04bs_ecl\st04bs.ecl" >nul
cd /d "%OUT%\_work_st04bs_ecl"
thecl.exe -d 20 st04bs.ecl st04bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04bs.ecl"
del /q "%OUT%\_work_st04bs_ecl\st04bs.ecl"
mkdir "%OUT%\st04bs.ecl"
xcopy /e /y /q "%OUT%\_work_st04bs_ecl\*" "%OUT%\st04bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04bs_ecl"
if exist "%OUT%\_work_st04c_std" rmdir /s /q "%OUT%\_work_st04c_std"
mkdir "%OUT%\_work_st04c_std"
copy /y "%OUT%\st04c.std" "%OUT%\_work_st04c_std\st04c.std" >nul
cd /d "%OUT%\_work_st04c_std"
thstd.exe -d 20 st04c.std st04c.std.txt
cd /d "%OUT%"
del /q "%OUT%\st04c.std"
del /q "%OUT%\_work_st04c_std\st04c.std"
mkdir "%OUT%\st04c.std"
xcopy /e /y /q "%OUT%\_work_st04c_std\*" "%OUT%\st04c.std\" >nul
rmdir /s /q "%OUT%\_work_st04c_std"
if exist "%OUT%\_work_st04d_std" rmdir /s /q "%OUT%\_work_st04d_std"
mkdir "%OUT%\_work_st04d_std"
copy /y "%OUT%\st04d.std" "%OUT%\_work_st04d_std\st04d.std" >nul
cd /d "%OUT%\_work_st04d_std"
thstd.exe -d 20 st04d.std st04d.std.txt
cd /d "%OUT%"
del /q "%OUT%\st04d.std"
del /q "%OUT%\_work_st04d_std\st04d.std"
mkdir "%OUT%\st04d.std"
xcopy /e /y /q "%OUT%\_work_st04d_std\*" "%OUT%\st04d.std\" >nul
rmdir /s /q "%OUT%\_work_st04d_std"
if exist "%OUT%\_work_st04enm_anm" rmdir /s /q "%OUT%\_work_st04enm_anm"
mkdir "%OUT%\_work_st04enm_anm"
copy /y "%OUT%\st04enm.anm" "%OUT%\_work_st04enm_anm\st04enm.anm" >nul
cd /d "%OUT%\_work_st04enm_anm"
thanm.exe -x 20 st04enm.anm
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
thanm.exe -x 20 st04logo.anm
cd /d "%OUT%"
del /q "%OUT%\st04logo.anm"
del /q "%OUT%\_work_st04logo_anm\st04logo.anm"
mkdir "%OUT%\st04logo.anm"
xcopy /e /y /q "%OUT%\_work_st04logo_anm\*" "%OUT%\st04logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st04logo_anm"
if exist "%OUT%\_work_st04m0_msg" rmdir /s /q "%OUT%\_work_st04m0_msg"
mkdir "%OUT%\_work_st04m0_msg"
copy /y "%OUT%\st04m0.msg" "%OUT%\_work_st04m0_msg\st04m0.msg" >nul
cd /d "%OUT%\_work_st04m0_msg"
thmsg.exe -d 20 st04m0.msg st04m0.txt
cd /d "%OUT%"
del /q "%OUT%\st04m0.msg"
del /q "%OUT%\_work_st04m0_msg\st04m0.msg"
mkdir "%OUT%\st04m0.msg"
xcopy /e /y /q "%OUT%\_work_st04m0_msg\*" "%OUT%\st04m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st04m0_msg"
if exist "%OUT%\_work_st04m1_msg" rmdir /s /q "%OUT%\_work_st04m1_msg"
mkdir "%OUT%\_work_st04m1_msg"
copy /y "%OUT%\st04m1.msg" "%OUT%\_work_st04m1_msg\st04m1.msg" >nul
cd /d "%OUT%\_work_st04m1_msg"
thmsg.exe -d 20 st04m1.msg st04m1.txt
cd /d "%OUT%"
del /q "%OUT%\st04m1.msg"
del /q "%OUT%\_work_st04m1_msg\st04m1.msg"
mkdir "%OUT%\st04m1.msg"
xcopy /e /y /q "%OUT%\_work_st04m1_msg\*" "%OUT%\st04m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st04m1_msg"
if exist "%OUT%\_work_st04m2_msg" rmdir /s /q "%OUT%\_work_st04m2_msg"
mkdir "%OUT%\_work_st04m2_msg"
copy /y "%OUT%\st04m2.msg" "%OUT%\_work_st04m2_msg\st04m2.msg" >nul
cd /d "%OUT%\_work_st04m2_msg"
thmsg.exe -d 20 st04m2.msg st04m2.txt
cd /d "%OUT%"
del /q "%OUT%\st04m2.msg"
del /q "%OUT%\_work_st04m2_msg\st04m2.msg"
mkdir "%OUT%\st04m2.msg"
xcopy /e /y /q "%OUT%\_work_st04m2_msg\*" "%OUT%\st04m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st04m2_msg"
if exist "%OUT%\_work_st04m3_msg" rmdir /s /q "%OUT%\_work_st04m3_msg"
mkdir "%OUT%\_work_st04m3_msg"
copy /y "%OUT%\st04m3.msg" "%OUT%\_work_st04m3_msg\st04m3.msg" >nul
cd /d "%OUT%\_work_st04m3_msg"
thmsg.exe -d 20 st04m3.msg st04m3.txt
cd /d "%OUT%"
del /q "%OUT%\st04m3.msg"
del /q "%OUT%\_work_st04m3_msg\st04m3.msg"
mkdir "%OUT%\st04m3.msg"
xcopy /e /y /q "%OUT%\_work_st04m3_msg\*" "%OUT%\st04m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st04m3_msg"
if exist "%OUT%\_work_st04mbs_ecl" rmdir /s /q "%OUT%\_work_st04mbs_ecl"
mkdir "%OUT%\_work_st04mbs_ecl"
copy /y "%OUT%\st04mbs.ecl" "%OUT%\_work_st04mbs_ecl\st04mbs.ecl" >nul
cd /d "%OUT%\_work_st04mbs_ecl"
thecl.exe -d 20 st04mbs.ecl st04mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st04mbs.ecl"
del /q "%OUT%\_work_st04mbs_ecl\st04mbs.ecl"
mkdir "%OUT%\st04mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st04mbs_ecl\*" "%OUT%\st04mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st04mbs_ecl"
if exist "%OUT%\_work_st04menm_anm" rmdir /s /q "%OUT%\_work_st04menm_anm"
mkdir "%OUT%\_work_st04menm_anm"
copy /y "%OUT%\st04menm.anm" "%OUT%\_work_st04menm_anm\st04menm.anm" >nul
cd /d "%OUT%\_work_st04menm_anm"
thanm.exe -x 20 st04menm.anm
cd /d "%OUT%"
del /q "%OUT%\st04menm.anm"
del /q "%OUT%\_work_st04menm_anm\st04menm.anm"
mkdir "%OUT%\st04menm.anm"
xcopy /e /y /q "%OUT%\_work_st04menm_anm\*" "%OUT%\st04menm.anm\" >nul
rmdir /s /q "%OUT%\_work_st04menm_anm"
if exist "%OUT%\_work_st04r0_msg" rmdir /s /q "%OUT%\_work_st04r0_msg"
mkdir "%OUT%\_work_st04r0_msg"
copy /y "%OUT%\st04r0.msg" "%OUT%\_work_st04r0_msg\st04r0.msg" >nul
cd /d "%OUT%\_work_st04r0_msg"
thmsg.exe -d 20 st04r0.msg st04r0.txt
cd /d "%OUT%"
del /q "%OUT%\st04r0.msg"
del /q "%OUT%\_work_st04r0_msg\st04r0.msg"
mkdir "%OUT%\st04r0.msg"
xcopy /e /y /q "%OUT%\_work_st04r0_msg\*" "%OUT%\st04r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st04r0_msg"
if exist "%OUT%\_work_st04r1_msg" rmdir /s /q "%OUT%\_work_st04r1_msg"
mkdir "%OUT%\_work_st04r1_msg"
copy /y "%OUT%\st04r1.msg" "%OUT%\_work_st04r1_msg\st04r1.msg" >nul
cd /d "%OUT%\_work_st04r1_msg"
thmsg.exe -d 20 st04r1.msg st04r1.txt
cd /d "%OUT%"
del /q "%OUT%\st04r1.msg"
del /q "%OUT%\_work_st04r1_msg\st04r1.msg"
mkdir "%OUT%\st04r1.msg"
xcopy /e /y /q "%OUT%\_work_st04r1_msg\*" "%OUT%\st04r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st04r1_msg"
if exist "%OUT%\_work_st04r2_msg" rmdir /s /q "%OUT%\_work_st04r2_msg"
mkdir "%OUT%\_work_st04r2_msg"
copy /y "%OUT%\st04r2.msg" "%OUT%\_work_st04r2_msg\st04r2.msg" >nul
cd /d "%OUT%\_work_st04r2_msg"
thmsg.exe -d 20 st04r2.msg st04r2.txt
cd /d "%OUT%"
del /q "%OUT%\st04r2.msg"
del /q "%OUT%\_work_st04r2_msg\st04r2.msg"
mkdir "%OUT%\st04r2.msg"
xcopy /e /y /q "%OUT%\_work_st04r2_msg\*" "%OUT%\st04r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st04r2_msg"
if exist "%OUT%\_work_st04r3_msg" rmdir /s /q "%OUT%\_work_st04r3_msg"
mkdir "%OUT%\_work_st04r3_msg"
copy /y "%OUT%\st04r3.msg" "%OUT%\_work_st04r3_msg\st04r3.msg" >nul
cd /d "%OUT%\_work_st04r3_msg"
thmsg.exe -d 20 st04r3.msg st04r3.txt
cd /d "%OUT%"
del /q "%OUT%\st04r3.msg"
del /q "%OUT%\_work_st04r3_msg\st04r3.msg"
mkdir "%OUT%\st04r3.msg"
xcopy /e /y /q "%OUT%\_work_st04r3_msg\*" "%OUT%\st04r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st04r3_msg"
if exist "%OUT%\_work_st04wla_anm" rmdir /s /q "%OUT%\_work_st04wla_anm"
mkdir "%OUT%\_work_st04wla_anm"
copy /y "%OUT%\st04wla.anm" "%OUT%\_work_st04wla_anm\st04wla.anm" >nul
cd /d "%OUT%\_work_st04wla_anm"
thanm.exe -x 20 st04wla.anm
cd /d "%OUT%"
del /q "%OUT%\st04wla.anm"
del /q "%OUT%\_work_st04wla_anm\st04wla.anm"
mkdir "%OUT%\st04wla.anm"
xcopy /e /y /q "%OUT%\_work_st04wla_anm\*" "%OUT%\st04wla.anm\" >nul
rmdir /s /q "%OUT%\_work_st04wla_anm"
if exist "%OUT%\_work_st04wlb_anm" rmdir /s /q "%OUT%\_work_st04wlb_anm"
mkdir "%OUT%\_work_st04wlb_anm"
copy /y "%OUT%\st04wlb.anm" "%OUT%\_work_st04wlb_anm\st04wlb.anm" >nul
cd /d "%OUT%\_work_st04wlb_anm"
thanm.exe -x 20 st04wlb.anm
cd /d "%OUT%"
del /q "%OUT%\st04wlb.anm"
del /q "%OUT%\_work_st04wlb_anm\st04wlb.anm"
mkdir "%OUT%\st04wlb.anm"
xcopy /e /y /q "%OUT%\_work_st04wlb_anm\*" "%OUT%\st04wlb.anm\" >nul
rmdir /s /q "%OUT%\_work_st04wlb_anm"
if exist "%OUT%\_work_st04wlc_anm" rmdir /s /q "%OUT%\_work_st04wlc_anm"
mkdir "%OUT%\_work_st04wlc_anm"
copy /y "%OUT%\st04wlc.anm" "%OUT%\_work_st04wlc_anm\st04wlc.anm" >nul
cd /d "%OUT%\_work_st04wlc_anm"
thanm.exe -x 20 st04wlc.anm
cd /d "%OUT%"
del /q "%OUT%\st04wlc.anm"
del /q "%OUT%\_work_st04wlc_anm\st04wlc.anm"
mkdir "%OUT%\st04wlc.anm"
xcopy /e /y /q "%OUT%\_work_st04wlc_anm\*" "%OUT%\st04wlc.anm\" >nul
rmdir /s /q "%OUT%\_work_st04wlc_anm"
if exist "%OUT%\_work_st04wld_anm" rmdir /s /q "%OUT%\_work_st04wld_anm"
mkdir "%OUT%\_work_st04wld_anm"
copy /y "%OUT%\st04wld.anm" "%OUT%\_work_st04wld_anm\st04wld.anm" >nul
cd /d "%OUT%\_work_st04wld_anm"
thanm.exe -x 20 st04wld.anm
cd /d "%OUT%"
del /q "%OUT%\st04wld.anm"
del /q "%OUT%\_work_st04wld_anm\st04wld.anm"
mkdir "%OUT%\st04wld.anm"
xcopy /e /y /q "%OUT%\_work_st04wld_anm\*" "%OUT%\st04wld.anm\" >nul
rmdir /s /q "%OUT%\_work_st04wld_anm"
if exist "%OUT%\_work_st05_ecl" rmdir /s /q "%OUT%\_work_st05_ecl"
mkdir "%OUT%\_work_st05_ecl"
copy /y "%OUT%\st05.ecl" "%OUT%\_work_st05_ecl\st05.ecl" >nul
cd /d "%OUT%\_work_st05_ecl"
thecl.exe -d 20 st05.ecl st05.ecl.txt
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
thstd.exe -d 20 st05.std st05.std.txt
cd /d "%OUT%"
del /q "%OUT%\st05.std"
del /q "%OUT%\_work_st05_std\st05.std"
mkdir "%OUT%\st05.std"
xcopy /e /y /q "%OUT%\_work_st05_std\*" "%OUT%\st05.std\" >nul
rmdir /s /q "%OUT%\_work_st05_std"
if exist "%OUT%\_work_st05bs_ecl" rmdir /s /q "%OUT%\_work_st05bs_ecl"
mkdir "%OUT%\_work_st05bs_ecl"
copy /y "%OUT%\st05bs.ecl" "%OUT%\_work_st05bs_ecl\st05bs.ecl" >nul
cd /d "%OUT%\_work_st05bs_ecl"
thecl.exe -d 20 st05bs.ecl st05bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st05bs.ecl"
del /q "%OUT%\_work_st05bs_ecl\st05bs.ecl"
mkdir "%OUT%\st05bs.ecl"
xcopy /e /y /q "%OUT%\_work_st05bs_ecl\*" "%OUT%\st05bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st05bs_ecl"
if exist "%OUT%\_work_st05enm_anm" rmdir /s /q "%OUT%\_work_st05enm_anm"
mkdir "%OUT%\_work_st05enm_anm"
copy /y "%OUT%\st05enm.anm" "%OUT%\_work_st05enm_anm\st05enm.anm" >nul
cd /d "%OUT%\_work_st05enm_anm"
thanm.exe -x 20 st05enm.anm
cd /d "%OUT%"
del /q "%OUT%\st05enm.anm"
del /q "%OUT%\_work_st05enm_anm\st05enm.anm"
mkdir "%OUT%\st05enm.anm"
xcopy /e /y /q "%OUT%\_work_st05enm_anm\*" "%OUT%\st05enm.anm\" >nul
rmdir /s /q "%OUT%\_work_st05enm_anm"
if exist "%OUT%\_work_st05logo_anm" rmdir /s /q "%OUT%\_work_st05logo_anm"
mkdir "%OUT%\_work_st05logo_anm"
copy /y "%OUT%\st05logo.anm" "%OUT%\_work_st05logo_anm\st05logo.anm" >nul
cd /d "%OUT%\_work_st05logo_anm"
thanm.exe -x 20 st05logo.anm
cd /d "%OUT%"
del /q "%OUT%\st05logo.anm"
del /q "%OUT%\_work_st05logo_anm\st05logo.anm"
mkdir "%OUT%\st05logo.anm"
xcopy /e /y /q "%OUT%\_work_st05logo_anm\*" "%OUT%\st05logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st05logo_anm"
if exist "%OUT%\_work_st05m0_msg" rmdir /s /q "%OUT%\_work_st05m0_msg"
mkdir "%OUT%\_work_st05m0_msg"
copy /y "%OUT%\st05m0.msg" "%OUT%\_work_st05m0_msg\st05m0.msg" >nul
cd /d "%OUT%\_work_st05m0_msg"
thmsg.exe -d 20 st05m0.msg st05m0.txt
cd /d "%OUT%"
del /q "%OUT%\st05m0.msg"
del /q "%OUT%\_work_st05m0_msg\st05m0.msg"
mkdir "%OUT%\st05m0.msg"
xcopy /e /y /q "%OUT%\_work_st05m0_msg\*" "%OUT%\st05m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st05m0_msg"
if exist "%OUT%\_work_st05m1_msg" rmdir /s /q "%OUT%\_work_st05m1_msg"
mkdir "%OUT%\_work_st05m1_msg"
copy /y "%OUT%\st05m1.msg" "%OUT%\_work_st05m1_msg\st05m1.msg" >nul
cd /d "%OUT%\_work_st05m1_msg"
thmsg.exe -d 20 st05m1.msg st05m1.txt
cd /d "%OUT%"
del /q "%OUT%\st05m1.msg"
del /q "%OUT%\_work_st05m1_msg\st05m1.msg"
mkdir "%OUT%\st05m1.msg"
xcopy /e /y /q "%OUT%\_work_st05m1_msg\*" "%OUT%\st05m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st05m1_msg"
if exist "%OUT%\_work_st05m2_msg" rmdir /s /q "%OUT%\_work_st05m2_msg"
mkdir "%OUT%\_work_st05m2_msg"
copy /y "%OUT%\st05m2.msg" "%OUT%\_work_st05m2_msg\st05m2.msg" >nul
cd /d "%OUT%\_work_st05m2_msg"
thmsg.exe -d 20 st05m2.msg st05m2.txt
cd /d "%OUT%"
del /q "%OUT%\st05m2.msg"
del /q "%OUT%\_work_st05m2_msg\st05m2.msg"
mkdir "%OUT%\st05m2.msg"
xcopy /e /y /q "%OUT%\_work_st05m2_msg\*" "%OUT%\st05m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st05m2_msg"
if exist "%OUT%\_work_st05m3_msg" rmdir /s /q "%OUT%\_work_st05m3_msg"
mkdir "%OUT%\_work_st05m3_msg"
copy /y "%OUT%\st05m3.msg" "%OUT%\_work_st05m3_msg\st05m3.msg" >nul
cd /d "%OUT%\_work_st05m3_msg"
thmsg.exe -d 20 st05m3.msg st05m3.txt
cd /d "%OUT%"
del /q "%OUT%\st05m3.msg"
del /q "%OUT%\_work_st05m3_msg\st05m3.msg"
mkdir "%OUT%\st05m3.msg"
xcopy /e /y /q "%OUT%\_work_st05m3_msg\*" "%OUT%\st05m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st05m3_msg"
if exist "%OUT%\_work_st05mbs_ecl" rmdir /s /q "%OUT%\_work_st05mbs_ecl"
mkdir "%OUT%\_work_st05mbs_ecl"
copy /y "%OUT%\st05mbs.ecl" "%OUT%\_work_st05mbs_ecl\st05mbs.ecl" >nul
cd /d "%OUT%\_work_st05mbs_ecl"
thecl.exe -d 20 st05mbs.ecl st05mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st05mbs.ecl"
del /q "%OUT%\_work_st05mbs_ecl\st05mbs.ecl"
mkdir "%OUT%\st05mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st05mbs_ecl\*" "%OUT%\st05mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st05mbs_ecl"
if exist "%OUT%\_work_st05r0_msg" rmdir /s /q "%OUT%\_work_st05r0_msg"
mkdir "%OUT%\_work_st05r0_msg"
copy /y "%OUT%\st05r0.msg" "%OUT%\_work_st05r0_msg\st05r0.msg" >nul
cd /d "%OUT%\_work_st05r0_msg"
thmsg.exe -d 20 st05r0.msg st05r0.txt
cd /d "%OUT%"
del /q "%OUT%\st05r0.msg"
del /q "%OUT%\_work_st05r0_msg\st05r0.msg"
mkdir "%OUT%\st05r0.msg"
xcopy /e /y /q "%OUT%\_work_st05r0_msg\*" "%OUT%\st05r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st05r0_msg"
if exist "%OUT%\_work_st05r1_msg" rmdir /s /q "%OUT%\_work_st05r1_msg"
mkdir "%OUT%\_work_st05r1_msg"
copy /y "%OUT%\st05r1.msg" "%OUT%\_work_st05r1_msg\st05r1.msg" >nul
cd /d "%OUT%\_work_st05r1_msg"
thmsg.exe -d 20 st05r1.msg st05r1.txt
cd /d "%OUT%"
del /q "%OUT%\st05r1.msg"
del /q "%OUT%\_work_st05r1_msg\st05r1.msg"
mkdir "%OUT%\st05r1.msg"
xcopy /e /y /q "%OUT%\_work_st05r1_msg\*" "%OUT%\st05r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st05r1_msg"
if exist "%OUT%\_work_st05r2_msg" rmdir /s /q "%OUT%\_work_st05r2_msg"
mkdir "%OUT%\_work_st05r2_msg"
copy /y "%OUT%\st05r2.msg" "%OUT%\_work_st05r2_msg\st05r2.msg" >nul
cd /d "%OUT%\_work_st05r2_msg"
thmsg.exe -d 20 st05r2.msg st05r2.txt
cd /d "%OUT%"
del /q "%OUT%\st05r2.msg"
del /q "%OUT%\_work_st05r2_msg\st05r2.msg"
mkdir "%OUT%\st05r2.msg"
xcopy /e /y /q "%OUT%\_work_st05r2_msg\*" "%OUT%\st05r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st05r2_msg"
if exist "%OUT%\_work_st05r3_msg" rmdir /s /q "%OUT%\_work_st05r3_msg"
mkdir "%OUT%\_work_st05r3_msg"
copy /y "%OUT%\st05r3.msg" "%OUT%\_work_st05r3_msg\st05r3.msg" >nul
cd /d "%OUT%\_work_st05r3_msg"
thmsg.exe -d 20 st05r3.msg st05r3.txt
cd /d "%OUT%"
del /q "%OUT%\st05r3.msg"
del /q "%OUT%\_work_st05r3_msg\st05r3.msg"
mkdir "%OUT%\st05r3.msg"
xcopy /e /y /q "%OUT%\_work_st05r3_msg\*" "%OUT%\st05r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st05r3_msg"
if exist "%OUT%\_work_st05wl_anm" rmdir /s /q "%OUT%\_work_st05wl_anm"
mkdir "%OUT%\_work_st05wl_anm"
copy /y "%OUT%\st05wl.anm" "%OUT%\_work_st05wl_anm\st05wl.anm" >nul
cd /d "%OUT%\_work_st05wl_anm"
thanm.exe -x 20 st05wl.anm
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
thecl.exe -d 20 st06.ecl st06.ecl.txt
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
thstd.exe -d 20 st06.std st06.std.txt
cd /d "%OUT%"
del /q "%OUT%\st06.std"
del /q "%OUT%\_work_st06_std\st06.std"
mkdir "%OUT%\st06.std"
xcopy /e /y /q "%OUT%\_work_st06_std\*" "%OUT%\st06.std\" >nul
rmdir /s /q "%OUT%\_work_st06_std"
if exist "%OUT%\_work_st06bs_ecl" rmdir /s /q "%OUT%\_work_st06bs_ecl"
mkdir "%OUT%\_work_st06bs_ecl"
copy /y "%OUT%\st06bs.ecl" "%OUT%\_work_st06bs_ecl\st06bs.ecl" >nul
cd /d "%OUT%\_work_st06bs_ecl"
thecl.exe -d 20 st06bs.ecl st06bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st06bs.ecl"
del /q "%OUT%\_work_st06bs_ecl\st06bs.ecl"
mkdir "%OUT%\st06bs.ecl"
xcopy /e /y /q "%OUT%\_work_st06bs_ecl\*" "%OUT%\st06bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st06bs_ecl"
if exist "%OUT%\_work_st06enm_anm" rmdir /s /q "%OUT%\_work_st06enm_anm"
mkdir "%OUT%\_work_st06enm_anm"
copy /y "%OUT%\st06enm.anm" "%OUT%\_work_st06enm_anm\st06enm.anm" >nul
cd /d "%OUT%\_work_st06enm_anm"
thanm.exe -x 20 st06enm.anm
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
thanm.exe -x 20 st06logo.anm
cd /d "%OUT%"
del /q "%OUT%\st06logo.anm"
del /q "%OUT%\_work_st06logo_anm\st06logo.anm"
mkdir "%OUT%\st06logo.anm"
xcopy /e /y /q "%OUT%\_work_st06logo_anm\*" "%OUT%\st06logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st06logo_anm"
if exist "%OUT%\_work_st06m0_msg" rmdir /s /q "%OUT%\_work_st06m0_msg"
mkdir "%OUT%\_work_st06m0_msg"
copy /y "%OUT%\st06m0.msg" "%OUT%\_work_st06m0_msg\st06m0.msg" >nul
cd /d "%OUT%\_work_st06m0_msg"
thmsg.exe -d 20 st06m0.msg st06m0.txt
cd /d "%OUT%"
del /q "%OUT%\st06m0.msg"
del /q "%OUT%\_work_st06m0_msg\st06m0.msg"
mkdir "%OUT%\st06m0.msg"
xcopy /e /y /q "%OUT%\_work_st06m0_msg\*" "%OUT%\st06m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st06m0_msg"
if exist "%OUT%\_work_st06m1_msg" rmdir /s /q "%OUT%\_work_st06m1_msg"
mkdir "%OUT%\_work_st06m1_msg"
copy /y "%OUT%\st06m1.msg" "%OUT%\_work_st06m1_msg\st06m1.msg" >nul
cd /d "%OUT%\_work_st06m1_msg"
thmsg.exe -d 20 st06m1.msg st06m1.txt
cd /d "%OUT%"
del /q "%OUT%\st06m1.msg"
del /q "%OUT%\_work_st06m1_msg\st06m1.msg"
mkdir "%OUT%\st06m1.msg"
xcopy /e /y /q "%OUT%\_work_st06m1_msg\*" "%OUT%\st06m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st06m1_msg"
if exist "%OUT%\_work_st06m2_msg" rmdir /s /q "%OUT%\_work_st06m2_msg"
mkdir "%OUT%\_work_st06m2_msg"
copy /y "%OUT%\st06m2.msg" "%OUT%\_work_st06m2_msg\st06m2.msg" >nul
cd /d "%OUT%\_work_st06m2_msg"
thmsg.exe -d 20 st06m2.msg st06m2.txt
cd /d "%OUT%"
del /q "%OUT%\st06m2.msg"
del /q "%OUT%\_work_st06m2_msg\st06m2.msg"
mkdir "%OUT%\st06m2.msg"
xcopy /e /y /q "%OUT%\_work_st06m2_msg\*" "%OUT%\st06m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st06m2_msg"
if exist "%OUT%\_work_st06m3_msg" rmdir /s /q "%OUT%\_work_st06m3_msg"
mkdir "%OUT%\_work_st06m3_msg"
copy /y "%OUT%\st06m3.msg" "%OUT%\_work_st06m3_msg\st06m3.msg" >nul
cd /d "%OUT%\_work_st06m3_msg"
thmsg.exe -d 20 st06m3.msg st06m3.txt
cd /d "%OUT%"
del /q "%OUT%\st06m3.msg"
del /q "%OUT%\_work_st06m3_msg\st06m3.msg"
mkdir "%OUT%\st06m3.msg"
xcopy /e /y /q "%OUT%\_work_st06m3_msg\*" "%OUT%\st06m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st06m3_msg"
if exist "%OUT%\_work_st06r0_msg" rmdir /s /q "%OUT%\_work_st06r0_msg"
mkdir "%OUT%\_work_st06r0_msg"
copy /y "%OUT%\st06r0.msg" "%OUT%\_work_st06r0_msg\st06r0.msg" >nul
cd /d "%OUT%\_work_st06r0_msg"
thmsg.exe -d 20 st06r0.msg st06r0.txt
cd /d "%OUT%"
del /q "%OUT%\st06r0.msg"
del /q "%OUT%\_work_st06r0_msg\st06r0.msg"
mkdir "%OUT%\st06r0.msg"
xcopy /e /y /q "%OUT%\_work_st06r0_msg\*" "%OUT%\st06r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st06r0_msg"
if exist "%OUT%\_work_st06r1_msg" rmdir /s /q "%OUT%\_work_st06r1_msg"
mkdir "%OUT%\_work_st06r1_msg"
copy /y "%OUT%\st06r1.msg" "%OUT%\_work_st06r1_msg\st06r1.msg" >nul
cd /d "%OUT%\_work_st06r1_msg"
thmsg.exe -d 20 st06r1.msg st06r1.txt
cd /d "%OUT%"
del /q "%OUT%\st06r1.msg"
del /q "%OUT%\_work_st06r1_msg\st06r1.msg"
mkdir "%OUT%\st06r1.msg"
xcopy /e /y /q "%OUT%\_work_st06r1_msg\*" "%OUT%\st06r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st06r1_msg"
if exist "%OUT%\_work_st06r2_msg" rmdir /s /q "%OUT%\_work_st06r2_msg"
mkdir "%OUT%\_work_st06r2_msg"
copy /y "%OUT%\st06r2.msg" "%OUT%\_work_st06r2_msg\st06r2.msg" >nul
cd /d "%OUT%\_work_st06r2_msg"
thmsg.exe -d 20 st06r2.msg st06r2.txt
cd /d "%OUT%"
del /q "%OUT%\st06r2.msg"
del /q "%OUT%\_work_st06r2_msg\st06r2.msg"
mkdir "%OUT%\st06r2.msg"
xcopy /e /y /q "%OUT%\_work_st06r2_msg\*" "%OUT%\st06r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st06r2_msg"
if exist "%OUT%\_work_st06r3_msg" rmdir /s /q "%OUT%\_work_st06r3_msg"
mkdir "%OUT%\_work_st06r3_msg"
copy /y "%OUT%\st06r3.msg" "%OUT%\_work_st06r3_msg\st06r3.msg" >nul
cd /d "%OUT%\_work_st06r3_msg"
thmsg.exe -d 20 st06r3.msg st06r3.txt
cd /d "%OUT%"
del /q "%OUT%\st06r3.msg"
del /q "%OUT%\_work_st06r3_msg\st06r3.msg"
mkdir "%OUT%\st06r3.msg"
xcopy /e /y /q "%OUT%\_work_st06r3_msg\*" "%OUT%\st06r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st06r3_msg"
if exist "%OUT%\_work_st06wl_anm" rmdir /s /q "%OUT%\_work_st06wl_anm"
mkdir "%OUT%\_work_st06wl_anm"
copy /y "%OUT%\st06wl.anm" "%OUT%\_work_st06wl_anm\st06wl.anm" >nul
cd /d "%OUT%\_work_st06wl_anm"
thanm.exe -x 20 st06wl.anm
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
thecl.exe -d 20 st07.ecl st07.ecl.txt
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
thstd.exe -d 20 st07.std st07.std.txt
cd /d "%OUT%"
del /q "%OUT%\st07.std"
del /q "%OUT%\_work_st07_std\st07.std"
mkdir "%OUT%\st07.std"
xcopy /e /y /q "%OUT%\_work_st07_std\*" "%OUT%\st07.std\" >nul
rmdir /s /q "%OUT%\_work_st07_std"
if exist "%OUT%\_work_st07bs_ecl" rmdir /s /q "%OUT%\_work_st07bs_ecl"
mkdir "%OUT%\_work_st07bs_ecl"
copy /y "%OUT%\st07bs.ecl" "%OUT%\_work_st07bs_ecl\st07bs.ecl" >nul
cd /d "%OUT%\_work_st07bs_ecl"
thecl.exe -d 20 st07bs.ecl st07bs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st07bs.ecl"
del /q "%OUT%\_work_st07bs_ecl\st07bs.ecl"
mkdir "%OUT%\st07bs.ecl"
xcopy /e /y /q "%OUT%\_work_st07bs_ecl\*" "%OUT%\st07bs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st07bs_ecl"
if exist "%OUT%\_work_st07enm_anm" rmdir /s /q "%OUT%\_work_st07enm_anm"
mkdir "%OUT%\_work_st07enm_anm"
copy /y "%OUT%\st07enm.anm" "%OUT%\_work_st07enm_anm\st07enm.anm" >nul
cd /d "%OUT%\_work_st07enm_anm"
thanm.exe -x 20 st07enm.anm
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
thanm.exe -x 20 st07logo.anm
cd /d "%OUT%"
del /q "%OUT%\st07logo.anm"
del /q "%OUT%\_work_st07logo_anm\st07logo.anm"
mkdir "%OUT%\st07logo.anm"
xcopy /e /y /q "%OUT%\_work_st07logo_anm\*" "%OUT%\st07logo.anm\" >nul
rmdir /s /q "%OUT%\_work_st07logo_anm"
if exist "%OUT%\_work_st07m0_msg" rmdir /s /q "%OUT%\_work_st07m0_msg"
mkdir "%OUT%\_work_st07m0_msg"
copy /y "%OUT%\st07m0.msg" "%OUT%\_work_st07m0_msg\st07m0.msg" >nul
cd /d "%OUT%\_work_st07m0_msg"
thmsg.exe -d 20 st07m0.msg st07m0.txt
cd /d "%OUT%"
del /q "%OUT%\st07m0.msg"
del /q "%OUT%\_work_st07m0_msg\st07m0.msg"
mkdir "%OUT%\st07m0.msg"
xcopy /e /y /q "%OUT%\_work_st07m0_msg\*" "%OUT%\st07m0.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m0_msg"
if exist "%OUT%\_work_st07m1_msg" rmdir /s /q "%OUT%\_work_st07m1_msg"
mkdir "%OUT%\_work_st07m1_msg"
copy /y "%OUT%\st07m1.msg" "%OUT%\_work_st07m1_msg\st07m1.msg" >nul
cd /d "%OUT%\_work_st07m1_msg"
thmsg.exe -d 20 st07m1.msg st07m1.txt
cd /d "%OUT%"
del /q "%OUT%\st07m1.msg"
del /q "%OUT%\_work_st07m1_msg\st07m1.msg"
mkdir "%OUT%\st07m1.msg"
xcopy /e /y /q "%OUT%\_work_st07m1_msg\*" "%OUT%\st07m1.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m1_msg"
if exist "%OUT%\_work_st07m2_msg" rmdir /s /q "%OUT%\_work_st07m2_msg"
mkdir "%OUT%\_work_st07m2_msg"
copy /y "%OUT%\st07m2.msg" "%OUT%\_work_st07m2_msg\st07m2.msg" >nul
cd /d "%OUT%\_work_st07m2_msg"
thmsg.exe -d 20 st07m2.msg st07m2.txt
cd /d "%OUT%"
del /q "%OUT%\st07m2.msg"
del /q "%OUT%\_work_st07m2_msg\st07m2.msg"
mkdir "%OUT%\st07m2.msg"
xcopy /e /y /q "%OUT%\_work_st07m2_msg\*" "%OUT%\st07m2.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m2_msg"
if exist "%OUT%\_work_st07m3_msg" rmdir /s /q "%OUT%\_work_st07m3_msg"
mkdir "%OUT%\_work_st07m3_msg"
copy /y "%OUT%\st07m3.msg" "%OUT%\_work_st07m3_msg\st07m3.msg" >nul
cd /d "%OUT%\_work_st07m3_msg"
thmsg.exe -d 20 st07m3.msg st07m3.txt
cd /d "%OUT%"
del /q "%OUT%\st07m3.msg"
del /q "%OUT%\_work_st07m3_msg\st07m3.msg"
mkdir "%OUT%\st07m3.msg"
xcopy /e /y /q "%OUT%\_work_st07m3_msg\*" "%OUT%\st07m3.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m3_msg"
if exist "%OUT%\_work_st07m4_msg" rmdir /s /q "%OUT%\_work_st07m4_msg"
mkdir "%OUT%\_work_st07m4_msg"
copy /y "%OUT%\st07m4.msg" "%OUT%\_work_st07m4_msg\st07m4.msg" >nul
cd /d "%OUT%\_work_st07m4_msg"
thmsg.exe -d 20 st07m4.msg st07m4.txt
cd /d "%OUT%"
del /q "%OUT%\st07m4.msg"
del /q "%OUT%\_work_st07m4_msg\st07m4.msg"
mkdir "%OUT%\st07m4.msg"
xcopy /e /y /q "%OUT%\_work_st07m4_msg\*" "%OUT%\st07m4.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m4_msg"
if exist "%OUT%\_work_st07m5_msg" rmdir /s /q "%OUT%\_work_st07m5_msg"
mkdir "%OUT%\_work_st07m5_msg"
copy /y "%OUT%\st07m5.msg" "%OUT%\_work_st07m5_msg\st07m5.msg" >nul
cd /d "%OUT%\_work_st07m5_msg"
thmsg.exe -d 20 st07m5.msg st07m5.txt
cd /d "%OUT%"
del /q "%OUT%\st07m5.msg"
del /q "%OUT%\_work_st07m5_msg\st07m5.msg"
mkdir "%OUT%\st07m5.msg"
xcopy /e /y /q "%OUT%\_work_st07m5_msg\*" "%OUT%\st07m5.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m5_msg"
if exist "%OUT%\_work_st07m6_msg" rmdir /s /q "%OUT%\_work_st07m6_msg"
mkdir "%OUT%\_work_st07m6_msg"
copy /y "%OUT%\st07m6.msg" "%OUT%\_work_st07m6_msg\st07m6.msg" >nul
cd /d "%OUT%\_work_st07m6_msg"
thmsg.exe -d 20 st07m6.msg st07m6.txt
cd /d "%OUT%"
del /q "%OUT%\st07m6.msg"
del /q "%OUT%\_work_st07m6_msg\st07m6.msg"
mkdir "%OUT%\st07m6.msg"
xcopy /e /y /q "%OUT%\_work_st07m6_msg\*" "%OUT%\st07m6.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m6_msg"
if exist "%OUT%\_work_st07m7_msg" rmdir /s /q "%OUT%\_work_st07m7_msg"
mkdir "%OUT%\_work_st07m7_msg"
copy /y "%OUT%\st07m7.msg" "%OUT%\_work_st07m7_msg\st07m7.msg" >nul
cd /d "%OUT%\_work_st07m7_msg"
thmsg.exe -d 20 st07m7.msg st07m7.txt
cd /d "%OUT%"
del /q "%OUT%\st07m7.msg"
del /q "%OUT%\_work_st07m7_msg\st07m7.msg"
mkdir "%OUT%\st07m7.msg"
xcopy /e /y /q "%OUT%\_work_st07m7_msg\*" "%OUT%\st07m7.msg\" >nul
rmdir /s /q "%OUT%\_work_st07m7_msg"
if exist "%OUT%\_work_st07mbs_ecl" rmdir /s /q "%OUT%\_work_st07mbs_ecl"
mkdir "%OUT%\_work_st07mbs_ecl"
copy /y "%OUT%\st07mbs.ecl" "%OUT%\_work_st07mbs_ecl\st07mbs.ecl" >nul
cd /d "%OUT%\_work_st07mbs_ecl"
thecl.exe -d 20 st07mbs.ecl st07mbs.ecl.txt
cd /d "%OUT%"
del /q "%OUT%\st07mbs.ecl"
del /q "%OUT%\_work_st07mbs_ecl\st07mbs.ecl"
mkdir "%OUT%\st07mbs.ecl"
xcopy /e /y /q "%OUT%\_work_st07mbs_ecl\*" "%OUT%\st07mbs.ecl\" >nul
rmdir /s /q "%OUT%\_work_st07mbs_ecl"
if exist "%OUT%\_work_st07menm_anm" rmdir /s /q "%OUT%\_work_st07menm_anm"
mkdir "%OUT%\_work_st07menm_anm"
copy /y "%OUT%\st07menm.anm" "%OUT%\_work_st07menm_anm\st07menm.anm" >nul
cd /d "%OUT%\_work_st07menm_anm"
thanm.exe -x 20 st07menm.anm
cd /d "%OUT%"
del /q "%OUT%\st07menm.anm"
del /q "%OUT%\_work_st07menm_anm\st07menm.anm"
mkdir "%OUT%\st07menm.anm"
xcopy /e /y /q "%OUT%\_work_st07menm_anm\*" "%OUT%\st07menm.anm\" >nul
rmdir /s /q "%OUT%\_work_st07menm_anm"
if exist "%OUT%\_work_st07r0_msg" rmdir /s /q "%OUT%\_work_st07r0_msg"
mkdir "%OUT%\_work_st07r0_msg"
copy /y "%OUT%\st07r0.msg" "%OUT%\_work_st07r0_msg\st07r0.msg" >nul
cd /d "%OUT%\_work_st07r0_msg"
thmsg.exe -d 20 st07r0.msg st07r0.txt
cd /d "%OUT%"
del /q "%OUT%\st07r0.msg"
del /q "%OUT%\_work_st07r0_msg\st07r0.msg"
mkdir "%OUT%\st07r0.msg"
xcopy /e /y /q "%OUT%\_work_st07r0_msg\*" "%OUT%\st07r0.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r0_msg"
if exist "%OUT%\_work_st07r1_msg" rmdir /s /q "%OUT%\_work_st07r1_msg"
mkdir "%OUT%\_work_st07r1_msg"
copy /y "%OUT%\st07r1.msg" "%OUT%\_work_st07r1_msg\st07r1.msg" >nul
cd /d "%OUT%\_work_st07r1_msg"
thmsg.exe -d 20 st07r1.msg st07r1.txt
cd /d "%OUT%"
del /q "%OUT%\st07r1.msg"
del /q "%OUT%\_work_st07r1_msg\st07r1.msg"
mkdir "%OUT%\st07r1.msg"
xcopy /e /y /q "%OUT%\_work_st07r1_msg\*" "%OUT%\st07r1.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r1_msg"
if exist "%OUT%\_work_st07r2_msg" rmdir /s /q "%OUT%\_work_st07r2_msg"
mkdir "%OUT%\_work_st07r2_msg"
copy /y "%OUT%\st07r2.msg" "%OUT%\_work_st07r2_msg\st07r2.msg" >nul
cd /d "%OUT%\_work_st07r2_msg"
thmsg.exe -d 20 st07r2.msg st07r2.txt
cd /d "%OUT%"
del /q "%OUT%\st07r2.msg"
del /q "%OUT%\_work_st07r2_msg\st07r2.msg"
mkdir "%OUT%\st07r2.msg"
xcopy /e /y /q "%OUT%\_work_st07r2_msg\*" "%OUT%\st07r2.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r2_msg"
if exist "%OUT%\_work_st07r3_msg" rmdir /s /q "%OUT%\_work_st07r3_msg"
mkdir "%OUT%\_work_st07r3_msg"
copy /y "%OUT%\st07r3.msg" "%OUT%\_work_st07r3_msg\st07r3.msg" >nul
cd /d "%OUT%\_work_st07r3_msg"
thmsg.exe -d 20 st07r3.msg st07r3.txt
cd /d "%OUT%"
del /q "%OUT%\st07r3.msg"
del /q "%OUT%\_work_st07r3_msg\st07r3.msg"
mkdir "%OUT%\st07r3.msg"
xcopy /e /y /q "%OUT%\_work_st07r3_msg\*" "%OUT%\st07r3.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r3_msg"
if exist "%OUT%\_work_st07r4_msg" rmdir /s /q "%OUT%\_work_st07r4_msg"
mkdir "%OUT%\_work_st07r4_msg"
copy /y "%OUT%\st07r4.msg" "%OUT%\_work_st07r4_msg\st07r4.msg" >nul
cd /d "%OUT%\_work_st07r4_msg"
thmsg.exe -d 20 st07r4.msg st07r4.txt
cd /d "%OUT%"
del /q "%OUT%\st07r4.msg"
del /q "%OUT%\_work_st07r4_msg\st07r4.msg"
mkdir "%OUT%\st07r4.msg"
xcopy /e /y /q "%OUT%\_work_st07r4_msg\*" "%OUT%\st07r4.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r4_msg"
if exist "%OUT%\_work_st07r5_msg" rmdir /s /q "%OUT%\_work_st07r5_msg"
mkdir "%OUT%\_work_st07r5_msg"
copy /y "%OUT%\st07r5.msg" "%OUT%\_work_st07r5_msg\st07r5.msg" >nul
cd /d "%OUT%\_work_st07r5_msg"
thmsg.exe -d 20 st07r5.msg st07r5.txt
cd /d "%OUT%"
del /q "%OUT%\st07r5.msg"
del /q "%OUT%\_work_st07r5_msg\st07r5.msg"
mkdir "%OUT%\st07r5.msg"
xcopy /e /y /q "%OUT%\_work_st07r5_msg\*" "%OUT%\st07r5.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r5_msg"
if exist "%OUT%\_work_st07r6_msg" rmdir /s /q "%OUT%\_work_st07r6_msg"
mkdir "%OUT%\_work_st07r6_msg"
copy /y "%OUT%\st07r6.msg" "%OUT%\_work_st07r6_msg\st07r6.msg" >nul
cd /d "%OUT%\_work_st07r6_msg"
thmsg.exe -d 20 st07r6.msg st07r6.txt
cd /d "%OUT%"
del /q "%OUT%\st07r6.msg"
del /q "%OUT%\_work_st07r6_msg\st07r6.msg"
mkdir "%OUT%\st07r6.msg"
xcopy /e /y /q "%OUT%\_work_st07r6_msg\*" "%OUT%\st07r6.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r6_msg"
if exist "%OUT%\_work_st07r7_msg" rmdir /s /q "%OUT%\_work_st07r7_msg"
mkdir "%OUT%\_work_st07r7_msg"
copy /y "%OUT%\st07r7.msg" "%OUT%\_work_st07r7_msg\st07r7.msg" >nul
cd /d "%OUT%\_work_st07r7_msg"
thmsg.exe -d 20 st07r7.msg st07r7.txt
cd /d "%OUT%"
del /q "%OUT%\st07r7.msg"
del /q "%OUT%\_work_st07r7_msg\st07r7.msg"
mkdir "%OUT%\st07r7.msg"
xcopy /e /y /q "%OUT%\_work_st07r7_msg\*" "%OUT%\st07r7.msg\" >nul
rmdir /s /q "%OUT%\_work_st07r7_msg"
if exist "%OUT%\_work_st07wl_anm" rmdir /s /q "%OUT%\_work_st07wl_anm"
mkdir "%OUT%\_work_st07wl_anm"
copy /y "%OUT%\st07wl.anm" "%OUT%\_work_st07wl_anm\st07wl.anm" >nul
cd /d "%OUT%\_work_st07wl_anm"
thanm.exe -x 20 st07wl.anm
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
thanm.exe -x 20 staff.anm
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
thmsg.exe -d 20 staff1.msg staff1.txt
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
thmsg.exe -d 20 staff2.msg staff2.txt
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
thmsg.exe -d 20 staff3.msg staff3.txt
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
thmsg.exe -d 20 staff4.msg staff4.txt
cd /d "%OUT%"
del /q "%OUT%\staff4.msg"
del /q "%OUT%\_work_staff4_msg\staff4.msg"
mkdir "%OUT%\staff4.msg"
xcopy /e /y /q "%OUT%\_work_staff4_msg\*" "%OUT%\staff4.msg\" >nul
rmdir /s /q "%OUT%\_work_staff4_msg"
if exist "%OUT%\_work_staff5_msg" rmdir /s /q "%OUT%\_work_staff5_msg"
mkdir "%OUT%\_work_staff5_msg"
copy /y "%OUT%\staff5.msg" "%OUT%\_work_staff5_msg\staff5.msg" >nul
cd /d "%OUT%\_work_staff5_msg"
thmsg.exe -d 20 staff5.msg staff5.txt
cd /d "%OUT%"
del /q "%OUT%\staff5.msg"
del /q "%OUT%\_work_staff5_msg\staff5.msg"
mkdir "%OUT%\staff5.msg"
xcopy /e /y /q "%OUT%\_work_staff5_msg\*" "%OUT%\staff5.msg\" >nul
rmdir /s /q "%OUT%\_work_staff5_msg"
if exist "%OUT%\_work_stone_anm" rmdir /s /q "%OUT%\_work_stone_anm"
mkdir "%OUT%\_work_stone_anm"
copy /y "%OUT%\stone.anm" "%OUT%\_work_stone_anm\stone.anm" >nul
cd /d "%OUT%\_work_stone_anm"
thanm.exe -x 20 stone.anm
cd /d "%OUT%"
del /q "%OUT%\stone.anm"
del /q "%OUT%\_work_stone_anm\stone.anm"
mkdir "%OUT%\stone.anm"
xcopy /e /y /q "%OUT%\_work_stone_anm\*" "%OUT%\stone.anm\" >nul
rmdir /s /q "%OUT%\_work_stone_anm"
if exist "%OUT%\_work_title_anm" rmdir /s /q "%OUT%\_work_title_anm"
mkdir "%OUT%\_work_title_anm"
copy /y "%OUT%\title.anm" "%OUT%\_work_title_anm\title.anm" >nul
cd /d "%OUT%\_work_title_anm"
thanm.exe -x 20 title.anm
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
thanm.exe -x 20 title_v.anm
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
thanm.exe -x 20 trophy.anm
cd /d "%OUT%"
del /q "%OUT%\trophy.anm"
del /q "%OUT%\_work_trophy_anm\trophy.anm"
mkdir "%OUT%\trophy.anm"
xcopy /e /y /q "%OUT%\_work_trophy_anm\*" "%OUT%\trophy.anm\" >nul
rmdir /s /q "%OUT%\_work_trophy_anm"
echo === th20 转换完成 ===