<?php

require '/libs/scripts.php';

$c = [];
# find all files
$c[] = "find \${1} -type f";
# ignore some
$c[] = "grep -v '.git' | grep -v '.swp' | grep -v logs | grep -v '-'";
# limit results to or in file names
$c[] = "egrep 'html|php|.js|.css'";
# make it looking good and what is important display date
$c[] = "xargs stat --format '%Y :%y %n' 2>/dev/null | sort -nr | cut -d: -f2- 2>/dev/null | head";
$c   = implode(' | ', $c);
$r   = md5(sr($c));

echo $r;
echo n;
