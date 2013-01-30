cd mkgmap-stranger

mkdir _intermediate 2>nul
mkdir _split 2>nul

echo Splitting...
java -Xmx1G -jar ..\executable\splitter\splitter.jar ..\UA.osm.pbf --output-dir=_split

echo Creating map with mkgmap
java -Xmx1300M -jar ..\executable\mkgmap\mkgmap.jar --read-config=ukrstranger.cfg stranger\stranger.txt

echo Copying result files
copy _intermediate\gmapsupp.img ..\results\

echo Removing intermediate files...
rem del /Q _intermediate
rem del /Q _split

cd ..