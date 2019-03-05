@echo off
setlocal enabledelayedexpansion

echo packaging game...
rem requires 7zip in PATH

echo packaging to Windows...
pushd C:\projects\dungeonhands\Compiled\Windows && 7z a -tzip DungeonHands_Windows.zip dungeonhands.exe winsetup.exe acsetup.cfg && popd
echo Done.
echo packaging to Linux...
pushd C:\projects\dungeonhands\Compiled\Linux && 7z a -ttar -so archive.tar . | 7z a -si DungeonHands_Linux.tar.gz && popd
echo Done.

endlocal
