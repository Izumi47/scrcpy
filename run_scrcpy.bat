@echo off
setlocal

REM Set the path to adb
set ADB=%~dp0platform-tools\adb.exe

REM Set the path to the scrcpy server
set SCRCPY_SERVER_PATH=%~dp0x\server\scrcpy-server

REM Set the path to the scrcpy icon
set SCRCPY_ICON_PATH=%~dp0app\data\icon.png

REM Run scrcpy with High Quality settings for USB (H.264, 20Mbps)
%~dp0x\app\scrcpy.exe --select-usb --video-codec=h264 --video-bit-rate=20M

endlocal