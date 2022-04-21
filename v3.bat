@echo off
SETLOCAL EnableDelayedExpansion
set version=v3
REM check version
title cURL Spammer (Waiting for version) ^| Sended: N/A ^| Failed: N/A ^| Total: N/A
for /F %%I in ('curl --silent https://raw.githubusercontent.com/AuchenDevs/Phishing-fucker/main/version') do set LastV=%%I
if "%LastV%" NEQ "v3" (color 4 & echo You don't have the last version! & echo Please download it! & echo (Current: %version% ^| Last: %LastV%^) & timeout 4 /nobreak >nul) 
cls
title cURL Spammer %version% ^| Sended: N/A ^| Failed: N/A ^| Total: N/A
echo Loading...
timeout /nobreak >nul
cls 
rem can't use : on colors so I change to 8 and I normal echo
color 8


REM CONFIG
set useproxy=yes
set ProxiesFile=proxies.txt
rem set socks4 or socks5
set type=socks5


rem colors

for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

REM Set lines number
SET NumLines=0
FOR /F "usebackq tokens=* delims=" %%A IN (`TYPE !ProxiesFile!`) DO SET /A NumLines=!NumLines!+1

rem Set packets
set packet=1
set tpacket=0
set fpacket=0
set spacket=0
set "retry=no"
if "%useproxy%"=="yes" goto chooseproxy


:loop
title cURL Spammer %version% (non proxy mode)^| Sended: %spacket% ^| Failed: %fpacket% ^| Total: %tpacket%
rem Print sending request
call :ColorText 08 "Sending request #%packet% ... "
echo.

rem send curl request
curl "https://httpbin.org/ip" 
call :ColorText 0a "Request #%packet% sended. "
echo.
echo.
set /a packet=%packet%+1 >nul
timeout 5 /nobreak >nul

goto loop






:loopproxy
title cURL Spammer %version% (proxy mode) ^| Sended: %spacket% ^| Failed: %fpacket% ^| Total: %tpacket%
rem Print sending request
if "%retry%"=="no" (call :ColorText 0b "Sending request #%packet% ... " & echo  ^(!proxy!^))
set /a tpacket=%tpacket%+1 >nul
set "retry=no"

echo.

rem send curl request
curl --connect-timeout 15 -fks --%type% "!proxy!" "https://httpbin.org/ip" || (call :ColorText 0c "Request #%packet% failed!" & echo  ^(!proxy!^) & echo. & echo. & call :ColorText 0e "Re-Trying request #%packet% ... " & echo  ^(!proxy!^) & echo. & echo. & set retry=yes & set /a fpacket=%fpacket%+1 >nul & goto :chooseproxy)




call :ColorText 0a "Request #%packet% sended. "
echo  (!proxy!)
echo.
set /a packet=%packet%+1 >nul
set /a spacket=%spacket%+1 >nul
rem timeout 5 /nobreak >nul
call :chooseproxy
goto loopproxy





:chooseproxy
REM Pick a random line.
SET /A RandomLine=(%RANDOM% %% %NumLines) + 1

REM Prevent skipping all the lines. 
IF "%RandomLine%"=="%NumLines%" SET RandomLine=1

REM Print the random line.
FOR /F "usebackq tokens=* skip=%RandomLine% delims=" %%A IN (`TYPE %ProxiesFile%`) DO (
    set "proxy=%%A"
    REM We are done. Stop the script.
	goto loopproxy
)









:ColorText
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
