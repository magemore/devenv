<?php

// todo make it domain specific

// echo '<pre>';
// print_r($_SERVER);
// print_r($_SERVER['DOCUMENT_ROOT']);
// exit();

// @todo: check if works when included from other hosts

require 'short.php';

$c = [];
# find all files
//if ()
$c[] = "find $_SERVER[DOCUMENT_ROOT] -type f";

// print_r($c);
// exit();
# ignore some
$c[] = "grep -v '.git' | grep -v '.swp' | grep -v logs | grep -v '-'";
# limit results to or in file names
$c[] = "egrep 'html|php|.js|.css'";
# make it looking good and what is important display date
$c[] = "xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2- 2>/dev/null | head";
$c   = implode(' | ', $c);
// echo $c;
// exit();
$r = md5(sr($c));

echo $r;
echo n;
