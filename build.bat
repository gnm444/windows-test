setlocal

REM Stop script on errors
set "ErrorActionPreference=Stop"

REM Navigate to the directory containing the bat script.
cd /d "%~dp0"

REM Set variables
set "scriptDir=C:\\windows-test12"
set "phpSdkDir=C:\\windows-test12\\php-sdk-binary-tools-master"
set "phpSourceDir=%phpSdkDir%\\phpdev\\vc16\\x64\\php-8.2.21-src"
set "extDir=%phpSourceDir%\\ext\\php-agent"

REM Copy PHP agent to the extensions folder
cd /d "%phpSdkDir%"
call bin\\phpsdk_setvars.bat
call bin\\phpsdk_buildtree.bat phpdev

cd /d "%scriptDir%"


xcopy /e /i /y php-8.2.21-src "%phpSdkDir%\\phpdev\\vc16\\x64\\php-8.2.21-src"
cd /d "C:\\windows-test12\\php-sdk-binary-tools-master"
@echo off
call "C:\\windows-test12\\php-sdk-binary-tools-master\\phpsdk-starter.bat" -c vc16 -a x64 -t "C:\\windows-test12\\build-task.bat" --task-args "clean build"


REM Output
echo Build complete: %phpSourceDir%\x64\Release_TS\php_agent.dll

echo Setting up PHP SDK environment variables...

REM Exit with the last error code
exit /b %errorlevel%
