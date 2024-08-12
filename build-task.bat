REM Running Build Task
cd /d "C:\\windows-test14\\php-sdk-binary-tools-master\\phpdev\\vc16\\x64\\php-8.2.21-src"
buildconf --force
configure --disable-all --enable-cli
nmake
echo Build Task complete
