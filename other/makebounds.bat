..\executable\osmconvert ..\UA.osm.pbf --out-o5m >..\UA.o5m
..\executable\osmfilter ..\UA.o5m --keep-nodes= --keep-ways-relations="boundary=administrative =postal_code postal_code= place=" --out-o5m >..\ua-boundaries.o5m
..\executable\osmconvert ..\ua-boundaries.o5m --out-pbf -o=..\ua-boundaries.pbf

call ..\executable\osmosis\bin\osmosis.bat ^
 --read-pbf file=..\ua-boundaries.pbf outPipe.0=data1 ^
 --read-pbf file=..\ua-boundaries.pbf outPipe.0=data2 ^
 --tag-transform file=transform_places.xml inPipe.0=data1 outPipe.0=5 ^
 --tag-filter accept-relations boundary=administrative,postal_code inPipe.0=5 outPipe.0=6 ^
 --used-way inPipe.0=6 outPipe.0=7 ^
 --tag-transform file=transform_places.xml inPipe.0=data2 outPipe.0=8.1 ^
 --tag-filter reject-relations inPipe.0=8.1 outPipe.0=8 ^
 --tag-filter accept-ways boundary=administrative,postal_code inPipe.0=8 outPipe.0=9 ^
 --used-node inPipe.0=9 outPipe.0=10 ^
 --used-node inPipe.0=7 outPipe.0=11 ^
 --merge inPipe.0=10 inPipe.1=11 outPipe.0=12 ^
 --write-pbf file=..\ua-boundaries.osm.pbf omitmetadata=true compress=deflate inPipe.0=12 

java -cp ..\executable\mkgmap\mkgmap.jar uk.me.parabola.mkgmap.reader.osm.boundary.BoundaryPreprocessor ..\ua-boundaries.osm.pbf ..\executable\mkgmap\bounds
