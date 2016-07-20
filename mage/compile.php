<?php

function json_print($a) {
  echo json_encode($a);
}

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


function getOffset($s) {
  for ($i=0; $i<strlen($s); $i++) {
    if ($i!=' ') return $i;
  }
  return 0;
}

function notCommand($s) {
  if (!$s) return true;
  return $s[0]==' ';
}

function isCommand($s) {
  return !notCommand($s);
}

function subShift($a) {
  foreach ($a as $i => $d) {
    $a[$i]=substr($d,2,-1);
  }
  return $a;
}

function proc($a) {
  $r=[];
  $ra=[];
  $j=0;
  $len = count($a);
  while ($j < $len) {
    $d=$a[$j];
    if (isCommand($d)) {
      $r['code']=$d;
      $sub=[];
      $j++;
      while ($j < $len && notCommand($a[$j])) {
        if (trim($a[$j])) {
          $sub[]=$a[$j];
        }
        $j++;
      }
      $j--;
      $r['sub']=proc(subShift($sub));
      $ra[]=$r;
    }
    $j++;
  }
  return $ra;
}



$commands=proc($a);
print_r($commands);
echo "\n";
