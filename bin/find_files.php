<?php

#system('find . > files.txt');

$a = array_slice($argv,1);
$filters = $a;

$s = file_get_contents('files.txt');
$a = explode("\n",$s);


function filter($filename,$filters) {
  if (strpos($filename,'var/cache')!==FALSE) return false;
  if (strpos($filename,'zendframe')!==FALSE) return false;
  if (!trim($filename)) return false;
  $s = file_get_contents($filename);
  if (!$s) return;
  $a = explode("\n",$s);
  $s = strtolower($s);
  foreach ($a as $d) {
    $r=true;
    foreach ($filters as $filter) {
      if (strpos($d,$filter)===FALSE) {
        $r = false;
      }
    }
    if ($r) return true;
  }
  return $r;
}

foreach ($a as $i => $d) {
  if (filter($d,$filters)) echo "$d\n";
}

