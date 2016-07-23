<?php

if (!isset($argv[1])) {
  echo 'set minutes in argument';
  echo "\n";
  return 0;
}
$minutes = $argv[1];

$message='';
if (isset($argv[2])) $message=$argv[2];
$now = $start=time();
$end = $start+$minutes*60;

while ($now<$end) {
  sleep(1);
  $f="i:s";
  if (($end-$now)/360>=1) $f="H:i:s";
  $m='count down';
  if ($message) $m=$message;
  echo $m.' '.gmdate($f,($end-$now))."\n";
  $now=time();
}

function say($msg) {
  echo $msg."\n";
  system("say '$msg'");
}

$msg ='count '.$minutes.' minutes ended ';
if ($message) {
  $msg=$message.' '.$msg;
}
say($msg);

return 1;

