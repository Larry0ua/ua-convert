mkdir results >nul
del /Q results\*.*

executable\wget -N http://data.gis-lab.info/osm_dump/dump/latest/UA.osm.pbf 

call mkgmap-stranger\run-stranger.bat

call toftp.bat