@echo off
echo [%~0]
%~d0
cd %~dp0
set dp=%~dp0
set /p nvimwin64=nvim-win64 abspath: 
if defined nvimwin64 (
  set pack=%nvimwin64%\share\nvim\runtime\pack\
)
if exist %pack% (
  xcopy %dp% %pack%nvimconfig\ /s /e /f /h /y
) else (
  echo no "%pack%"
)
pause
