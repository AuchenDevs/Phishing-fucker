@echo off
REM By craciu25yt
rem new: Posibility to use proxy
rem thanks stackoverflow for the random proxy script

REM CONFIG
set useproxy=yes
set ProxiesFile=proxies.txt
rem set socks4 or socks5
set type=socks5


rem colors
title Fuck phishing website
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

REM Set lines number
SET NumLines=0
FOR /F "usebackq tokens=* delims=" %%A IN (`TYPE !ProxiesFile!`) DO SET /A NumLines=!NumLines!+1

rem Set packets
set packet=1
:loop
if "%useproxy%"=="yes" call :chooseproxy

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


rem Print sending request
call :ColorText 08 "Sending request #%packet% ... "
echo.

rem send curl request
curl --connect-timeout 5 -fks --%type% "%proxy%" "https://httpbin.org/ip"
call :ColorText 0a "Request #%packet% sended. "
echo.
echo.
set /a packet=%packet%+1 >nul
rem timeout 5 /nobreak >nul
call :chooseproxy
goto loopproxy

:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof


:chooseproxy
REM Pick a random line.
SET /A RandomLine=(%RANDOM% %% %NumLines) + 1

REM Prevent skipping all the lines.
IF "%RandomLine%"=="%NumLines%" SET RandomLine=1

REM Print the random line.
FOR /F "usebackq tokens=* skip=%RandomLine% delims=" %%A IN (`TYPE %ProxiesFile%`) DO (
    set "proxy=%%A"
    REM We are done. Stop the script.
    GOTO loopproxy
)
