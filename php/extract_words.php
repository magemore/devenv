<?php

$f = '/srv/esf/system/application/models/FreakAuth_light/usertemp.php';
$s = file_get_contents($f);
$s = str_replace('(',' ',$s);
$s = str_replace(')',' ',$s);
$s = str_replace('@',' ',$s);
$s = str_replace(',',' ',$s);
$s = str_replace('>',' ',$s);
$s = str_replace(';',' ',$s);
$s = str_replace('-',' ',$s);
$s = str_replace('\'',' ',$s);
$s = str_replace('<',' ',$s);
$s = str_replace('?',' ',$s);
$s = str_replace('"',' ',$s);
$s = str_replace('=',' ',$s);
$s = str_replace('+',' ',$s);
$s = str_replace('.',' ',$s);
$s = str_replace('!',' ',$s);
$s = str_replace('#',' ',$s);
$s = str_replace('&',' ',$s);
$s = str_replace('*',' ',$s);
$s = str_replace('-',' ',$s);
$s = str_replace('/',' ',$s);
$s = str_replace(']',' ',$s);
$s = str_replace('[',' ',$s);
$s = str_replace('{',' ',$s);
$s = str_replace('}',' ',$s);
$s = str_replace('\\',' ',$s);
$m=[];
preg_match_all('/(\S{4,})/i', $s, $m);
$d=$m[0];
$d=array_unique($d);
echo implode("\n",$d)."\n";

