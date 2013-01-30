echo uploading to FTP server...

rem rename output file, then rename at the ftp
ren results/gmapsupp.img results/gmapsupp1.img

set HOSTNAME=ftp.beta.koding.com
set USERNAME=larry0ua
set PASSWORD=*******
(
echo quote USER %USERNAME%
echo quote PASS %PASSWORD%
echo cd /Sites/larry0ua.koding.com/website/garmin
echo binary
echo hash
echo quote PASV
echo put results/gmapsupp1.img
echo rename gmapsupp1.img gmapsupp.img
echo quit
) | ftp -dvin %HOSTNAME%
