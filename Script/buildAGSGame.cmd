@echo off
setlocal enabledelayedexpansion

set AGSEDITOR=%SYSTEMDRIVE%\Program Files\Adventure Game Studio 3.4.3\AGSEditor.exe
set AGSGAMEPROJECT=%SYSTEMDRIVE%\projects\dungeonhands

call %AGSEDITOR% /compile %AGSGAMEPROJECT%\Game.agf

