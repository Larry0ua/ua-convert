rem Script that can be added to scheduler as a daily job
cd executable
osmupdate.exe ../UA.osm.pbf ../UA.0.osm.pbf --hour -v -B=UA.poly --keep-tempfiles
cd ..
if exist UA.0.osm.pbf (
del UA.osm.pbf
ren UA.0.osm.pbf UA.osm.pbf
)
cd osmand
start process_maps.cmd
cd ..\mkgmap-stranger
call run-stranger.bat
cd ..
call package.bat
call toftp.bat