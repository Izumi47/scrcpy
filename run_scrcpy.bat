@echo off
setlocal

REM Set the path to adb
set ADB=%~dp0platform-tools\adb.exe

REM Set the path to the scrcpy server
set SCRCPY_SERVER_PATH=%~dp0x\server\scrcpy-server

REM Run scrcpy
%~dp0x\app\scrcpy.exe

endlocal