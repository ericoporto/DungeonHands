@echo off
setlocal enabledelayedexpansion

set TEMP=%SYSTEMDRIVE%\TEMP
set CACHE=%TEMP%\Cache
set FCIV=%TEMP%\fciv.exe
set WGET=%TEMP%\wget.exe
set BITSADMIN=bitsadmin /transfer bootstrap /download /priority FOREGROUND
set SEVENZIP="C:\Program Files (x86)\7-Zip\7z.exe"
set UNINSTALL=HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall

if not exist %CACHE% mkdir %CACHE%

if not exist %FCIV% (
	echo Downloading fciv...
	%BITSADMIN% https://download.microsoft.com/download/c/f/4/cf454ae0-a4bb-4123-8333-a1b6737712f7/Windows-KB841290-x86-ENU.exe %CACHE%\Windows-KB841290-x86-ENU.exe
	%CACHE%\Windows-KB841290-x86-ENU.exe /Q /T:%TEMP% && del /f %TEMP%\readme.txt
	if not exist %FCIV% exit /b 1
)

if not exist %WGET% (
	echo Downloading wget...
	%BITSADMIN% http://eternallybored.org/misc/wget/1.19.4/32/wget.exe %CACHE%\wget.exe
	call :VERIFY 3dadb6e2ece9c4b3e1e322e617658b60 %CACHE%\wget.exe && move %CACHE%\wget.exe %TEMP%
	if not exist %WGET% exit /b 1
)

set DOWNLOADER=%WGET% --no-check-certificate --quiet -N -P %CACHE%

echo Installing 3.5 .NET Framework 
DISM /Online /Enable-Feature:NetFx3 /All
echo 3.5 .NET Framework Installed

echo Installing 4.0 .NET Framework 
DISM /Online /Enable-Feature:NetFx4 /All
echo 4.0 .NET Framework Installed

set INSTALL[0][name]=7-Zip 18.05
set INSTALL[0][version]=*
set INSTALL[0][url]=https://www.7-zip.org/a/7z1805.msi
set INSTALL[0][md5]=83b2e31c6534de4b119ef32c7ab97773
set INSTALL[0][cmd]=msiexec /i %CACHE%\7z1805.msi /qb

set INSTALL[1][name]=Microsoft .NET Framework 1.1
set INSTALL[1][version]=1.1.4322
set INSTALL[1][url]=https://download.microsoft.com/download/a/a/c/aac39226-8825-44ce-90e3-bf8203e74006/dotnetfx.exe
set INSTALL[1][md5]=52456ac39bbb4640930d155c15160556
set INSTALL[1][cmd]=start /wait %CACHE%\dotnetfx.exe /q:a /c:"install.exe /qb /l"

set INSTALL[2][name]=Adventure Game Studio 3.4.3
set INSTALL[2][version]=3.4.3.1
set INSTALL[2][url]=https://github.com/adventuregamestudio/ags/releases/download/v.3.4.3.1/AGS-3.4.3-P1.exe
set INSTALL[2][md5]=89ef0fcb9ef460352039d2bb589eff31
set INSTALL[2][cmd]=start /b /wait  %CACHE%\AGS-3.4.3-P1.exe /SP- /VERYSILENT /NORESTART /MERGETASKS="!desktopicon"

for /l %%n in (0,1,2) do (
	echo Checking installation: !INSTALL[%%n][name]!
	call :ISINSTALLED "!INSTALL[%%n][name]!" "!INSTALL[%%n][version]!" || (
		for %%i in (!INSTALL[%%n][url]!) do (
			if not exist %CACHE%\%%~nxi %DOWNLOADER% !INSTALL[%%n][url]!
			call :VERIFY !INSTALL[%%n][md5]! %CACHE%\%%~nxi || exit /b 1
			echo --^> installing...
			!INSTALL[%%n][cmd]!
			call :ISINSTALLED "!INSTALL[%%n][name]!" "!INSTALL[%%n][version]!" || exit /b 1
		)
	)
)


goto :END

rem These are some functions to help along

:VERIFY
echo --^> verifying %2

for /f "tokens=1 skip=3" %%j in ('%FCIV% %2') do (
	if not %1==%%j (
		echo --^> verification failed md5:%%j
			exit /b 1
		)
	)
)

echo --^> verification passed
exit /b 0

:ISINSTALLED
echo --^> looking for %1 version %2

for /f "tokens=1,2,*" %%i in ('reg query %UNINSTALL% /s /f Display /t REG_SZ') do (
	if %%i==DisplayName (
		set DISPLAYNAME=%%k
	) else if %%i==DisplayVersion (
		set DISPLAYVERSION=%%k
	) else if %%i==DisplayIcon (
		rem do nothing
	) else (
		set DISPLAYNAME=
		set DISPLAYVERSION=
	)

	if defined DISPLAYNAME if defined DISPLAYVERSION (
		if %1=="!DISPLAYNAME!" if %2=="!DISPLAYVERSION!" (
			echo --^> installation found
			exit /b 0
		)
	)

	if defined DISPLAYNAME if %1=="!DISPLAYNAME!" if %2=="*" (
		echo --^> installation found - any
		exit /b 0
	)
)

echo --^> no installation was found
exit /b 1

rem End label is needed to be able to skip functions

:END
endlocal
