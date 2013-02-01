mkdir results >nul
del /Q results\*.*

executable\wget -N http://data.gis-lab.info/osm_dump/dump/latest/UA.osm.pbf 

cd mkgmap-stranger
call run-stranger.bat
cd ..

cd navitel
call generate-navitel.bat
cd ..

rem call toftp.bat