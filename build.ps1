# Stop script on errors
$ErrorActionPreference = "Stop"

# Navigate to the directory containing the script
Set-Location -Path $PSScriptRoot

# Set variables
$scriptDir = Get-Location
$phpSdkDir = "C:\\windows-test16\\php-sdk-binary-tools-master"
$phpSourceDir = "C:\\windows-test16\\php-sdk-binary-tools-master\\phpdev\\vc16\\x64\\php-8.2.21-src"


# Copy PHP agent to the extensions folder
Set-Location -Path $phpSdkDir
& .\bin\phpsdk_setvars.bat
& .\bin\phpsdk_buildtree.bat phpdev

Set-Location -Path $scriptDir

# Copy the PHP source files
Copy-Item -Path "php-8.2.21-src" -Destination "$phpSdkDir\phpdev\vc16\x64\php-8.2.21-src" -Recurse -Force

Set-Location -Path $phpSdkDir

# Print the current directory for debugging
Write-Output "Current directory: $(Get-Location)"

# List all directories in the current location for debugging
Write-Output "Directories in current location:"
Get-ChildItem -Directory


# Execute the batch file and wait for it to complete
#Start-Process -FilePath "C:\\windows-test16\\php-sdk-binary-tools-master\\phpsdk-vs16-x64.bat" -Wait -NoNewWindow


Write-Output "No Sleep over in current location:"
# Wait for build-task.bat to finish

# Run the batch file in the same shell
& "C:\\windows-test16\\php-sdk-binary-tools-master\\phpsdk-starter.bat" -c vc16 -a x64 -t "C:\\windows-test16\\build-task.bat" --task-args "clean build"


Write-Output "Waiting over in current location:"
#Start-Process -FilePath "C:\\windows-test15\\php-sdk-binary-tools-master\\phpsdk-starter.bat" -c vc16 -a x64 -t "C:\\windows-test13\\php-sdk-binary-tools-master\\build-task.bat" --task-args "clean build" -Wait -NoNewWindow
Write-Output "Starting in current location:"


Write-Output "Waiting over in current location:"
# Wait for phpsdk-starter.bat to initialize (adjust timeout as needed)


# Output
Write-Output "Build complete: $phpSourceDir\x64\Release_TS\php_agent.dll"

Write-Output "Setting up PHP SDK environment variables..."

# Exit with the last error code
exit $LASTEXITCODE
