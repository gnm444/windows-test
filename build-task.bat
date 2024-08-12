REM This should run in PHP SDK shell
cd /d "C:\\windows-test16\\php-sdk-binary-tools-master\\phpdev\\vc16\\x64\\php-8.2.21-src"
buildconf
configure --disable-all --enable-cli
nmake
echo Build Task complete
