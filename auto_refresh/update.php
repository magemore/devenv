<?php

require 'short.php';

$c = [];
# find all files
$c[] = "find -L $_SERVER[DOCUMENT_ROOT] -type f";
#print_r($c);

# ignore some
$c[] = "grep -v '.git' | grep -v '.swp' | grep -v logs | grep -v '-'";
# limit results to or in file names
$c[] = "egrep 'html|php|.js|.css'";
# make it looking good and what is important display date
$c[] = "xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2- 2>/dev/null | head";
$c   = implode(' | ', $c);

// sr is short for system that acts like exec returns data
$r = md5(sr($c));

echo $r;
echo n;
