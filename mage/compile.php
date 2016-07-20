<?php

class file {
  private $path;
  public function __construct($path) {
    $this->path = $path;
  }
  public function get($path=false) {
    if ($path) $this->path = $path;
    $contents = file_get_contents($this->path);
    $a = explode("\n",$contents);
    return $a;
  }
  public function set($value) {
    $value = implode("\n",$value);
    file_put_contents($this->path,$value);
  }
}

$file = new file($argv[1]);
$a = $file->get();
$commands = array();
$command_index = -1;
foreach ($a as $l) {
  // command mode
  if ($l[0]!=' ') {
    $command_index++;
    $commands[$command_index]['main']=trim($l);
  }
  else {
    $commands[$command_index]['nodes'][]=trim($l);
  }
}

print_r($commands);
echo "\n";
