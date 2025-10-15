@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: === Braveのパス ===
set "BRAVE=C:\Program Files\BraveSoftware\Brave-Browser\Application\brave.exe"

:: === モニター3の座標とサイズ ===
set X=1920
set Y=0
set W=1080
set H=1920

:: === 上2/3・下1/3 ===
set /a TOPH=%H%*2/3
set /a BOTTOMH=%H%-%TOPH%
set /a Y2=%Y%+%TOPH%

echo.
echo Monitor 3 Settings:
echo X=%X%  Y=%Y%  W=%W%  H=%H%
echo TOPH=%TOPH%  BOTTOMH=%BOTTOMH%  Y2=%Y2%
echo.

taskkill /IM brave.exe /F >nul 2>&1
timeout /t 1 >nul

set "CALENDAR_PROFILE=%TEMP%\brave_calendar_profile"
set "TRELLO_PROFILE=%TEMP%\brave_trello_profile"

if exist "%CALENDAR_PROFILE%" rmdir /s /q "%CALENDAR_PROFILE%"
if exist "%TRELLO_PROFILE%" rmdir /s /q "%TRELLO_PROFILE%"

mkdir "%CALENDAR_PROFILE%" >nul
mkdir "%TRELLO_PROFILE%" >nul

echo Launching Google Calendar...
start "" "%BRAVE%" --user-data-dir="%CALENDAR_PROFILE%" --new-window "https://calendar.google.com" --window-position=%X%,%Y% --window-size=%W%,%TOPH%

echo Launching Trello...
start "" "%BRAVE%" --user-data-dir="%TRELLO_PROFILE%" --new-window "https://trello.com" --window-position=%X%,%Y2% --window-size=%W%,%BOTTOMH%

echo.
echo Google Calendar (top 2/3) and Trello (bottom 1/3) opened on monitor 3.
pause
