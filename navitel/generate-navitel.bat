for /F "tokens=1,2,3 delims=," %%A in (..\other\regions.csv) Do (
 rem %%A - region code
 rem %%B - relation ID
 rem %%C - UTF-8 region name
 if not exist extracts\%%A.poly ..\executable\getbound.pl --onering --noinner --api=op_ru --offset=0.005 -o extracts\%%A.poly %%B
REM if not exist extracts\exp-%%A.poly ..\executable\offset\offset.exe extracts\%%A.poly extracts\exp-%%A.poly
 if not exist extracts\%%A.osm ..\executable\osmconvert ../UA.osm.pbf -B=extracts\%%A.poly -o=extracts\%%A.osm
 if not exist maps\Navitel-%%A.mp ..\executable\osm2mp\osm2mp.pl --config=..\executable\osm2mp\cfg-navitel\navitel-uk.cfg  --target-lang=uk --default-lang=uk  --defaultcountry="UA" -o maps\Navitel-%%A.mp extracts\%%A.osm
 if not exist maps\Navitel-%%A.mp.err.htm ..\executable\osm2navitel\mp-postprocess-navitel.pl maps\Navitel-%%A.mp --fixrouting
)
if exist maps ConvertToNM2.vbs

copy maps\*.nm2 ..\results\
copy maps\*.htm ..\results\
