call ..\executable\osmosis\bin\osmosis.bat ^
 --read-pbf file=..\UA.osm.pbf ^
 --tag-transform file=transform_names_uk.xml ^
 --write-pbf file=input\Ukraine.osm.pbf

@echo on

del ..\result\Ukraine_*.obf
del /Q output\*.*
del /Q temp\*.*

java.exe -Djava.util.logging.config.file=logging.properties -Xms256M -Xmx2G -cp "./OsmAndMapCreator/OsmAndMapCreator.jar;./OsmAndMapCreator/lib/OsmAnd-core.jar;./OsmAndMapCreator/lib/*.jar" net.osmand.data.index.IndexBatchCreator ./cfg/batch.xml 
