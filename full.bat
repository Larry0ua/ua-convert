mkdir results 2>nul
mkdir navitel\extracts 2>nul
mkdir navitel\maps 2>nul
mkdir mkgmap-stranger\_intermediate 2>nul
mkdir mkgmap-stranger\_split 2>nul


del /Q results\*.*
del /Q navitel\extracts\*.*
del /Q navitel\maps\*.*
del /Q mkgmap-stranger\_intermediate\*.*
del /Q mkgmap-stranger\_split\*.*


executable\wget -N http://data.gis-lab.info/osm_dump/dump/latest/UA.osm.pbf

cd mkgmap-stranger
call run-stranger.bat
cd ..

cd navitel
call generate-navitel.bat
cd ..

rem package each file into archive
call package.bat

rem call toftp.bat