<?php
date_default_timezone_set("Europe/Helsinki");

$last_date = @file_get_contents("last_daily.txt");
if(!$last_date) {
	file_put_contents("last_daily.txt", date("ymd", time()));
	die();
}
$date = mktime(date("H"), date("i"), date("s"), substr($last_date, 2, 2), substr($last_date, 4, 2), substr($last_date, 0, 2));

//executable\wget.exe http://be.gis-lab.info/data/osm_dump/diff/UA/UA-130729-130730.osc.gz
while ($date < time()) {
	$diff = "UA-".date("ymd", $date)."-".date("ymd", $date + 24*60*60).".osc.gz";
	echo "executable\\wget.exe http://be.gis-lab.info/data/osm_dump/diff/UA/$diff\n";
	echo "executable\\osmconvert.exe UA.osm.pbf $diff --out-pbf -o=UA_.osm.pbf\n";
	echo "copy UA_.osm.pbf UA.osm.pbf\n";
	echo "del UA_.osm.pbf\n";
	$date += 24*60*60;
}
file_put_contents("last_daily.txt", date("ymd", $date));