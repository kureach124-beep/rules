@echo off
chcp 65001 > nul

set MY_NAME=%USERNAME%

for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4"') do set MY_IP=%%a
set MY_IP=%MY_IP:~1%

echo Fetching weather...
set WEATHER=Failed
for /f "delims=" %%a in ('curl -s "wttr.in/Tokyo?format=%%C" 2^>nul') do set WEATHER=%%a

echo ---- Sending ----
echo  Name   : %MY_NAME%
echo  IP     : %MY_IP%
echo  Weather: %WEATHER%
echo ------------------

curl -X POST "https://white-dream-0732.kurea-ch124.workers.dev/" ^
    -H "Content-Type: application/json" ^
    -d "{\"name\":\"%MY_NAME%\",\"ip\":\"%MY_IP%\",\"weather\":\"%WEATHER%\"}"

echo.
echo Done.
pause