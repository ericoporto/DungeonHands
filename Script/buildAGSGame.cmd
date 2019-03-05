@echo off
setlocal enabledelayedexpansion

set AGSEDITOR="C:\Program Files (x86)\Adventure Game Studio 3.4.3\AGSEditor.exe"
set AGSGAMEPROJECT=%SYSTEMDRIVE%\projects\dungeonhands

call %AGSEDITOR% /compile %AGSGAMEPROJECT%\Game.agf

endlocal
