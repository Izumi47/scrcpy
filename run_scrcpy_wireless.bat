@echo off
setlocal enabledelayedexpansion

REM Set the path to adb
set ADB=%~dp0platform-tools\adb.exe

REM Set the path to the scrcpy server
set SCRCPY_SERVER_PATH=%~dp0x\server\scrcpy-server

REM Set the path to the scrcpy icon
set SCRCPY_ICON_PATH=%~dp0app\data\icon.png

REM Load last IP
set "LAST_IP="
if exist "%~dp0scrcpy-last-ip.txt" (
    set /p LAST_IP=<"%~dp0scrcpy-last-ip.txt"
)

REM Default to Balanced Quality (H.264, 20Mbps, 2772p) to reduce latency
set "SCRCPY_ARGS=--video-codec=h264 --render-driver=opengl --video-bit-rate=10M --max-fps=120 --print-fps"

REM Print scrcpy arugments in a nice format
echo ==================================================================
echo Scrcpy Wireless Launcher Arguments:
echo    Video Codec     : H.264
echo    Video Bit Rate  : 10 Mbps
echo    Max Size        : 2772p
echo    Max FPS         : 144
echo    Audio Buffer    : 50 ms
echo ==================================================================
echo.

if defined LAST_IP (
    echo Attempting to connect to last known IP: !LAST_IP!
    "%~dp0x\app\scrcpy.exe" --tcpip=!LAST_IP! !SCRCPY_ARGS!
    if !errorlevel! equ 0 exit /b
    echo.
    echo [WARNING] Connection to !LAST_IP! failed. Falling back to menu...
    echo.
)

echo ==================================================================
echo Scrcpy Wireless Connection Launcher
echo ==================================================================
echo.
echo 1. Auto-detect (Requires device connected via USB first)
echo    - Select this if you haven't set up wireless yet.
echo.

if defined LAST_IP (
    echo 2. Connect to saved IP: !LAST_IP!
    echo    - Quick connect to your last used device.
    echo.
    echo 3. Connect to a new IP
    echo    - Enter a new IP address manually.
) else (
    echo 2. Connect to IP
    echo    - Enter a device IP address manually.
)
echo.

if defined LAST_IP (
    set /p CHOICE="Select option (1, 2, or 3): "
) else (
    set /p CHOICE="Select option (1 or 2): "
)

if "%CHOICE%"=="1" goto :AutoDetect
if defined LAST_IP (
    if "%CHOICE%"=="2" goto :ConnectLastIP
    if "%CHOICE%"=="3" goto :ManualIP
) else (
    if "%CHOICE%"=="2" goto :ManualIP
)

echo.
echo Invalid choice.
pause
exit /b

:AutoDetect
echo.
echo Attempting auto-detection via USB...

REM Use a temp file to capture IP route output to avoid batch syntax errors
set "IP_TEMP=%TEMP%\scrcpy_ip_%RANDOM%.txt"
"%ADB%" -d shell ip route > "%IP_TEMP%" 2>nul

set "DEVICE_IP="
if exist "%IP_TEMP%" (
    REM Look for the line with 'wlan' and 'src'
    for /f "usebackq tokens=*" %%a in (`findstr "wlan" "%IP_TEMP%" ^| findstr "src"`) do (
        set "LINE=%%a"
        set "NEXT_IS_IP=0"
        for %%b in (!LINE!) do (
            if "!NEXT_IS_IP!"=="1" (
                set "DEVICE_IP=%%b"
                set "NEXT_IS_IP=0"
            )
            if "%%b"=="src" set "NEXT_IS_IP=1"
        )
    )
    del "%IP_TEMP%"
)

if defined DEVICE_IP (
    echo [INFO] Detected Device IP: !DEVICE_IP!
    
    echo [INFO] Enabling TCP/IP mode on device...
    "%ADB%" -d tcpip 5555
    
    echo Waiting for device to restart in TCP/IP mode...
    timeout /t 3 /nobreak >nul

    echo !DEVICE_IP!> "%~dp0scrcpy-last-ip.txt"
    echo [INFO] Saved IP !DEVICE_IP! for future wireless connections.
    
    echo.
    echo Connecting to !DEVICE_IP!...
    "%~dp0x\app\scrcpy.exe" --tcpip=!DEVICE_IP! !SCRCPY_ARGS!
    goto :CheckError
)

REM Fallback if IP detection failed
echo [WARNING] Could not detect IP automatically. Falling back to scrcpy internal detection...
"%~dp0x\app\scrcpy.exe" --select-usb --tcpip !SCRCPY_ARGS!

echo.
echo [DEBUG] Scrcpy finished. Checking for wireless device...
set "DEVICES_TEMP=%TEMP%\scrcpy_devices_%RANDOM%.txt"
"%ADB%" devices > "%DEVICES_TEMP%"
type "%DEVICES_TEMP%"
echo.

REM Attempt to save the IP address for next time
set "FOUND_IP="
if exist "%DEVICES_TEMP%" (
    for /f "usebackq tokens=1 delims=:" %%a in (`findstr ":5555" "%DEVICES_TEMP%"`) do (
        set FOUND_IP=%%a
        echo [DEBUG] Found IP: %%a
    )
    del "%DEVICES_TEMP%"
)

if defined FOUND_IP (
    echo !FOUND_IP!> "%~dp0scrcpy-last-ip.txt"
    echo.
    echo [INFO] Saved IP !FOUND_IP! for future wireless connections.
) else (
    echo [WARNING] Could not detect wireless device IP to save.
    echo Please ensure the device is still connected via TCP/IP.
)

goto :CheckError

:ConnectLastIP
set IP=!LAST_IP!
goto :ConnectIP

:ManualIP
echo.
set /p IP="Enter Device IP address (e.g. 192.168.1.50): "
if "%IP%"=="" (
    echo IP address cannot be empty.
    pause
    exit /b
)
REM Save the IP
echo %IP%> "%~dp0scrcpy-last-ip.txt"
goto :ConnectIP

:ConnectIP
echo.
echo Connecting to %IP%...
"%~dp0x\app\scrcpy.exe" --tcpip=%IP% !SCRCPY_ARGS!
goto :CheckError

:CheckError
if errorlevel 1 (
    echo.
    echo An error occurred. Press any key to exit.
    pause >nul
)
endlocal
