@echo off
setlocal enabledelayedexpansion

if not defined BUTLER_API_KEY (
	echo Missing BUTLER_API_KEY environment variable
	exit /b 1
)

set BUTLER_URL=https://broth.itch.ovh/butler/windows-amd64/15.8.0/archive/default
set BUTLER_MD5=49d1b5c8e465b842396a02c650ad3371

set TEMP=%SYSTEMDRIVE%\TEMP
set CACHE=%TEMP%\Cache
set FCIV=%TEMP%\fciv.exe
set WGET=%TEMP%\wget.exe
set BUTLER=%TEMP%\butler.exe
set BITSADMIN=bitsadmin /transfer bootstrap /download /priority FOREGROUND

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

set DOWNLOADER=%WGET% --quiet -N -P %CACHE%

if not exist %BUTLER% (
	echo Downloading butler...
	%DOWNLOADER% --output-document=%CACHE%\butler.zip  %BUTLER_URL%
	call :VERIFY %BUTLER_MD5% %CACHE%\butler.zip && move %CACHE%\butler.zip  %TEMP%
	echo Extracting butler...
	pushd %TEMP%
	powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('butler.zip', '.'); }"
	popd
	del /f %TEMP%\butler.zip
	if not exist %BUTLER% exit /b 1
)

echo Pushing to icth.io with butler...
echo project is %1
echo artifact is %2

%BUTLER% push %1 %2

goto :END

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

rem End label is needed to be able to skip functions

:END
endlocal

