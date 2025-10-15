@echo off
chcp 65001
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
echo モニター3の設定:
echo X=%X%  Y=%Y%  W=%W%  H=%H%
echo 上2/3=%TOPH%  下1/3=%BOTTOMH%  下段Y開始=%Y2%
echo.

:: === Braveプロセスを完全終了 ===
taskkill /IM brave.exe /F >nul 2>&1
timeout /t 1 >nul

:: === 固定プロファイル（ログイン状態保持用） ===
set "PROFILE_DIR=%USERPROFILE%\Documents\BraveProfiles"
set "CALENDAR_PROFILE=%PROFILE_DIR%\calendar"
set "TRELLO_PROFILE=%PROFILE_DIR%\trello"

if not exist "%CALENDAR_PROFILE%" mkdir "%CALENDAR_PROFILE%"
if not exist "%TRELLO_PROFILE%" mkdir "%TRELLO_PROFILE%"

:: === Googleカレンダー ===
echo Googleカレンダーを起動中...
start "" "%BRAVE%" --user-data-dir="%CALENDAR_PROFILE%" --new-window "https://calendar.google.com" --window-position=%X%,%Y% --window-size=%W%,%TOPH%

:: === Trello ===
echo Trelloを起動中...
start "" "%BRAVE%" --user-data-dir="%TRELLO_PROFILE%" --new-window "https://trello.com" --window-position=%X%,!Y2! --window-size=%W%,%BOTTOMH%

echo.
echo ✅ Googleカレンダー（上2/3）と Trello（下1/3）をモニター3に配置しました。
pause
