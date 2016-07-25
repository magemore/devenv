<?php

$f = '/srv/esf/system/application/models/FreakAuth_light/usertemp.php';
$s = file_get_contents($f);
$a = preg_match_all('/(\S{4,})/i', $str, $m);
print_r($a);
