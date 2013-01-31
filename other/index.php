<?php
// Garmin formats
function file_link_n_details($name) {
	$res = "<a href='$name'>$name</a> (";
	$sz = round(filesize($name) / 1024 / 1024, 1);
	$res.= $sz ." Mb - ".date("Y-m-d", filemtime($name)). ")";
	return $res;
}
function print_garmin() {
	$lst = glob("gmap*.zip");
	if (!$lst) { echo "Нема доступних файлів"; return; }
	echo "Вся Україна (туристичний стиль від Max Vasilev&GaM, прокладка маршрута працює, без адресного пошуку)<br>";
	if (in_array("gmapsupp.zip", $lst))
		echo "Українська версія ". file_link_n_details("gmapsupp.zip"). "<br>";
	if (in_array("gmapsup2.zip", $lst))
		echo "Русская версия ". file_link_n_details("gmapsup2.zip"). "<br>";
}
print_garmin();
?>