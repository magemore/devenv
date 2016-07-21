<?php

date_default_timezone_set('Europe/Kiev');
$path = "/data/data/com.termux/files/home/tmp/local_reminder";

$s =date('H:i')."\n";
$h = date('H');
$s .= ' prosipai ss ya';
//file_put_contents($path,$s);
#system('termux-clipboard-set < '.$path)UU'termux-clipboard-set "'$s.'"'
system('termux-clipboard-set "'.$s.'"');
