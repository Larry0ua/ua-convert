..\executable\osmconvert ..\UA.osm.pbf --out-o5m >..\UA.o5m

..\executable\osmfilter ..\UA.o5m --keep-nodes= --keep-ways-relations="boundary=administrative =postal_code postal_code=" --out-o5m > ..\ua-boundaries.o5m

java -cp ..\executable\mkgmap\mkgmap.jar uk.me.parabola.mkgmap.reader.osm.boundary.BoundaryPreprocessor ..\ua-boundaries.o5m ..\executable\mkgmap\bounds
