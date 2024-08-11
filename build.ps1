# Stop script on errors
$ErrorActionPreference = "Stop"

# Navigate to the directory containing the script
Set-Location -Path $PSScriptRoot

# Set variables
$scriptDir = Get-Location
$phpSdkDir = Join-Path -Path $scriptDir -ChildPath "php-sdk-binary-tools-master"
$phpSourceDir = Join-Path -Path $phpSdkDir -ChildPath "phpdev\vc16\x64\php-8.2.21-src"
$extDir = Join-Path -Path $phpSourceDir -ChildPath "ext\php-agent"

# Copy PHP agent to the extensions folder
Set-Location -Path $phpSdkDir
& .\bin\phpsdk_setvars.bat
& .\bin\phpsdk_buildtree.bat phpdev

Set-Location -Path $scriptDir

# Copy the PHP source files
Copy-Item -Path "php-8.2.21-src" -Destination "$phpSdkDir\phpdev\vc16\x64\php-8.2.21-src" -Recurse -Force
Set-Location -Path $phpSdkDir
& .\phpsdk-vs16-x64.bat

# Output
Write-Output "Build complete: $phpSourceDir\x64\Release_TS\php_agent.dll"

Write-Output "Setting up PHP SDK environment variables..."

# Exit with the last error code
exit $LASTEXITCODE
