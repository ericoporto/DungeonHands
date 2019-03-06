@echo off
setlocal enabledelayedexpansion

set AGSGAMEPROJECT=%SYSTEMDRIVE%\projects\dungeonhands

if [%~1]==[] goto :NOPARAM
set AGSGAMEPROJECT="%~1"
:NOPARAM

echo packaging game...
rem requires 7zip in PATH

echo packaging to Windows...
pushd %AGSGAMEPROJECT%\Compiled\Windows && 7z a -tzip DungeonHands-windows.zip dungeonhands.exe winsetup.exe acsetup.cfg && popd
echo Done.
echo packaging to Linux...
pushd %AGSGAMEPROJECT%\Compiled\Linux && 7z a -ttar -so archive.tar . | 7z a -si DungeonHands-linux.tar.gz && popd
echo Done.

endlocal
