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

:: === プロファイル設定（ログイン保持用） ===
set "PROFILE_DIR=%USERPROFILE%\Documents\BraveProfiles"
set "CALENDAR_PROFILE=%PROFILE_DIR%\calendar"
set "TRELLO_PROFILE=%PROFILE_DIR%\trello"
if not exist "%CALENDAR_PROFILE%" mkdir "%CALENDAR_PROFILE%"
if not exist "%TRELLO_PROFILE%" mkdir "%TRELLO_PROFILE%"

:: === URLファイルの読み込み ===
set "URL_FILE=%~dp0urls.txt"
set "CALENDAR_URL=https://calendar.google.com"
set "TRELLO_URL=https://trello.com"

if exist "%URL_FILE%" (
    echo URLファイルを読み込み中: %URL_FILE%
    for /f "tokens=1,2 delims== " %%A in (%URL_FILE%) do (
        if /i "%%A"=="CALENDAR_URL" set "CALENDAR_URL=%%B"
        if /i "%%A"=="TRELLO_URL" set "TRELLO_URL=%%B"
    )
) else (
    echo [WARN] URLファイルが見つかりません。既定URLを使用します。
)

:: === URLの妥当性チェック ===
echo 使用URL:
echo Googleカレンダー: %CALENDAR_URL%
echo Trello: %TRELLO_URL%

echo 検証中...
echo %CALENDAR_URL% | find "http" >nul
if errorlevel 1 (
    echo [ERROR] CALENDAR_URLが不正のため既定値を使用します。
    set "CALENDAR_URL=https://calendar.google.com"
)
echo %TRELLO_URL% | find "http" >nul
if errorlevel 1 (
    echo [ERROR] TRELLO_URLが不正のため既定値を使用します。
    set "TRELLO_URL=https://trello.com"
)

:: === Googleカレンダー ===
echo Googleカレンダーを起動中...
start "" "%BRAVE%" --user-data-dir="%CALENDAR_PROFILE%" --profile-directory="Default" ^
    --no-first-run --no-default-browser-check --new-window "%CALENDAR_URL%" ^
    --window-position=%X%,%Y% --window-size=%W%,%TOPH%

:: === Trello ===
echo Trelloを起動中...
start "" "%BRAVE%" --user-data-dir="%TRELLO_PROFILE%" --profile-directory="Default" ^
    --no-first-run --no-default-browser-check --new-window "%TRELLO_URL%" ^
    --window-position=%X%,%Y2% --window-size=%W%,%BOTTOMH%

echo.
echo ✅ Googleカレンダー（上2/3）と Trello（下1/3）をモニター3に配置しました。
pause
