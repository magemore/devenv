<?php

if (!isset($argv[1])) {
  return 0;
}

$limit = 50;
if (isset($argv[2])) {
  $limit = $argv[2];
}

$line = $argv[1];
$len = strlen($line);
if ($len>$limit) {
  $line = substr($line,0,$limit);
}
echo $line."\n";

return 1;
