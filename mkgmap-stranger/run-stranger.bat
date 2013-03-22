
echo Splitting...
java -Xmx1G -jar ..\executable\splitter\splitter.jar ..\UA.osm.pbf --output-dir=_split

echo Creating -ru map with mkgmap
java -Xmx1300M -jar ..\executable\mkgmap\mkgmap.jar --style-file=stranger-ru/stranger --family-id=44 --output-dir=_intermediate-ru --read-config=ukrstranger.cfg stranger-ru\stranger.typ
copy stranger-ru\stranger.typ _intermediate-ru\

copy _intermediate-ru\gmapsupp.img ..\results\gmapsup2.img

echo Creating -uk map with mkgmap
java -Xmx1300M -jar ..\executable\mkgmap\mkgmap.jar --style-file=stranger-uk/stranger --family-id=45 --output-dir=_intermediate-uk --read-config=ukrstranger.cfg stranger-uk\stranger.txt

echo Copying result files
copy _intermediate-uk\gmapsupp.img ..\results\
