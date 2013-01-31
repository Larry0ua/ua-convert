
mkdir extracts 2>nul
mkdir maps 2>nul

for /F "tokens=1,2,3 delims=," %%A in (..\other\regions.csv) Do (
 rem %%A - region code
 rem %%B - relation ID
 rem %%C - UTF-8 region name
 if not exist extracts\%%A.poly ..\executable\getbound.pl --onering --noinner -o extracts\%%A.poly %%B
 if not exist extracts\%%A.osm ..\executable\osmconvert ../UA.osm.pbf -B=extracts\%%A.poly  --complete-ways --complex-ways  --drop-broken-refs -o=extracts\%%A.osm
 if not exist maps\%%A.mp ..\executable\osm2mp\osm2mp.pl --config=..\executable\osm2mp\cfg-navitel\navitel-ru.cfg  --target-lang=uk --default-lang=uk  --defaultcountry="UA"  -o maps\Navitel-%%A.mp extracts\%%A.osm
)
if exist maps ConvertToNM2.vbs

