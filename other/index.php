<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Конвертації в формат навігаторів OpenStreetMap України</title>
  <meta name="description" content="Garmin and Navitel conversions OpenStreetMap Ukraine">
  <meta name="author" content="SitePoint">
</head>
<body>
<?php
error_reporting(E_ERROR);
// Garmin formats
function file_link_n_details($name) {
	$res = "<a href='$name'>$name</a> (";
	$sz = round(filesize($name) / 1024 / 1024, 1);
	$res.= $sz ." Mb - ".date("Y-m-d", filemtime($name)). ")";
	return $res;
}
function print_garmin() {
	$lst = glob("gmap*.img.zip");
	if (!$lst) { echo "Нема доступних файлів конвертації в формат Garmin<br>"; return; }
	echo "Вся Україна (туристичний стиль від Max Vasilev, прокладка маршрута працює, без адресного пошуку)<br>\n<table><tr><th>Опис</th><th>Посилання</th></tr>";
	if (in_array("gmapsupp.img.zip", $lst))
		echo "<tr><td>Українська версія</td><td>" . file_link_n_details("gmapsupp.img.zip") . "</td></tr>";
	if (in_array("gmapsup2.img.zip", $lst))
		echo "<tr><td>Русская версия</td><td>" . file_link_n_details("gmapsup2.img.zip") . "</td></tr>";
	echo "</table>";
}
function print_navitel() {
	$fp = fopen("regions.csv", "r");
	echo "Конвертація в формат Navitel NM2<br><table><tr><th>Регіон</th><th>Посилання</th></tr>";
	while (($str = fgets($fp, 1000)) !== FALSE) {
		$data = explode(',', $str);
		if (file_exists("Navitel-${data[0]}.nm2.zip")) {
			echo "<tr><td>" . $data[2] ."</td><td>". file_link_n_details("Navitel-${data[0]}.nm2.zip") . "</td></tr>"; 
		}
	}
	echo "</table>";
	//	if (!$lst) { echo "Нема доступних файлів конвертації в формат Navitel<br>"; return; }



}
print_garmin();
echo "<br>";
print_navitel();
?>
</body>
</html>
