﻿REM Navigate to the source directory
set "scriptDir=%cd%"
set "phpSdkDir=%scriptDir%\php-sdk-binary-tools-master"
set "phpSourceDir=%phpSdkDir%\phpdev\vc16\x64\php-8.2.21-src"
cd /d "%phpSourceDir%"


REM Copy PHP agent to the extensions folder
cd /d "%phpSdkDir%"
call bin\phpsdk_setvars.bat
call bin\phpsdk_buildtree.bat phpdev

cd /d "%scriptDir%"


xcopy /e /i /y php-8.2.21-src "%phpSdkDir%\phpdev\vc16\x64\php-8.2.21-src"

REM Use the arguments passed from phpsdk-starter.bat
set ARGS=%*

if not "%ARGS%"=="" (
    echo Arguments provided: %ARGS%
    
    REM Parse arguments
    for %%A in (%ARGS%) do (
        if "%%A"=="clean" (
            nmake clean
        )
        if "%%A"=="build" (
        	nmake clean
            buildconf --force
            configure --disable-all --enable-cli
            nmake
        )
    )
) else (
    echo No arguments provided, running default build process
    nmake clean
    buildconf --force
    configure --disable-all --enable-cli
    nmake
)

echo Build complete