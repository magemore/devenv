<?php

if (!isset($argv[1])) {
  return 0;
}

$line = $argv[1];
echo $line.'test';

return 1;
