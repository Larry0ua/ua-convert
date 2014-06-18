
echo Splitting...
java -Xmx1G -jar ..\executable\splitter\splitter.jar d:\europe.osm.pbf --output-dir=_split

rem echo Creating -ru map with mkgmap
rem java -Xmx1000M -jar ..\executable\mkgmap\mkgmap.jar --style-file=stranger-ru/stranger --family-id=44 --output-dir=_intermediate-ru --read-config=ukrstranger.cfg stranger-ru\stranger.typ
rem copy stranger-ru\stranger.typ _intermediate-ru\

rem copy _intermediate-ru\gmapsupp.img ..\results\gmapsup2.img

echo Creating -uk map with mkgmap
java -Xmx1000M -jar ..\executable\mkgmap\mkgmap.jar --style-file=stranger-uk/stranger --family-id=44 --output-dir=_intermediate-eu --read-config=europe.cfg stranger-uk\stranger.txt

echo Copying result files
copy _intermediate-uk\gmapsupp.img ..\results\
