
echo Splitting...
java -Xmx1G -jar ..\executable\splitter\splitter.jar ..\UA.osm.pbf --output-dir=_split

echo Creating -ru map with mkgmap
java -Xmx1300M -jar ..\executable\mkgmap\mkgmap.jar style-file=stranger-ru/stranger --read-config=ukrstranger.cfg stranger-ru\stranger.typ

ren _intermediate\gmapsupp.img _intermediate\gmapsup2.img

echo Creating -uk map with mkgmap
java -Xmx1300M -jar ..\executable\mkgmap\mkgmap.jar style-file=stranger-uk/stranger --read-config=ukrstranger.cfg stranger-uk\stranger.typ

echo Copying result files
copy _intermediate\gmapsup?.img ..\results\
