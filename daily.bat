rem Script that can be added to scheduler as a daily job
call D:\Development\php-5.3.6\php.exe genscript.php > daily_diff_merge.bat
call daily_diff_merge.bat
cd osmand
start process_maps.cmd
cd ..\mkgmap-stranger
call run-stranger.bat
cd ..
call package.bat
call toftp.bat