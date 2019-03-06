@echo off
setlocal enabledelayedexpansion

set AGSEDITOR="C:\Program Files (x86)\Adventure Game Studio 3.4.3\AGSEditor.exe"
set AGSGAMEPROJECT=%SYSTEMDRIVE%\projects\dungeonhands

if [%~1]==[] goto :NOPARAM
set AGSGAMEPROJECT="%~1"

:NOPARAM

call %AGSEDITOR% /compile %AGSGAMEPROJECT%\Game.agf

endlocal
