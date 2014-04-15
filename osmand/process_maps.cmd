rem @echo off
echo Start...

rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rem ~~~ Modified script, original author: AHTOH ~~~
rem ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

:: C��������� ����� ������ ���������� (���� ����)/ WGET ����������������. ������ ��� ������ 1 ���� ���� ���� ���������� � ������� �� �����.
:: ��������� ����� -nv ��� ����� ��������� ���������� � ���� ���������
rem ..\executable\wget http://download.osmand.net/latest-night-build/OsmAndMapCreator-main.zip -P input 
:: ���������� ������ ����������
rem if not errorlevel 1 7z.exe x input\OsmAndMapCreator-main.zip -o./OsmAndMapCreator -y

:: ������ ��������������� ��������� ������
:: ��� ���������� ������� ���� � ����������� ��� ������ (���� �� ���������� � �������) 

..\executable\wget -N --no-check-certificate https://raw.github.com/xmd5a2/UniRS/master/rendering_types.xml

copy ..\UA.osm.pbf input\Ukraine.osm.pbf

rem call ..\executable\osmosis\bin\osmosis.bat ^
rem  --read-pbf file=..\UA.osm.pbf ^
rem  --tag-transform file=transform_names_uk.xml ^
rem  --write-pbf file=input\Ukraine.osm.pbf

@echo on

del ..\result\Ukraine_*.obf
del /Q output\*.*
del /Q temp\*.*

java.exe -Djava.util.logging.config.file=logging.properties -Xms256M -Xmx2G -cp "./OsmAndMapCreator/OsmAndMapCreator.jar;./OsmAndMapCreator/lib/OsmAnd-core.jar;./OsmAndMapCreator/lib/*.jar" net.osmand.data.index.IndexBatchCreator ./cfg/batch.xml 

copy temp\Ukraine_2.obf ..\results\Ukraine_europe.obf

call ..\executable\osmosis\bin\osmosis.bat ^
 --read-pbf file=..\UA.osm.pbf ^
 --tag-transform file=transform_names_ru.xml ^
 --write-pbf file=input\Ukraine.osm.pbf

@echo on

del ..\result\Ukraine_*.obf
del /Q output\*.*
del /Q temp\*.*

java.exe -Djava.util.logging.config.file=logging.properties -Xms256M -Xmx2G -cp "./OsmAndMapCreator/OsmAndMapCreator.jar;./OsmAndMapCreator/lib/OsmAnd-core.jar;./OsmAndMapCreator/lib/*.jar" net.osmand.data.index.IndexBatchCreator ./cfg/batch.xml 

copy temp\Ukraine_2.obf ..\results\Ukraine_europe_ru.obf
cd ..
call toftp.osmand.bat
