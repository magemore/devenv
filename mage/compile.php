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
  public function set($value,$filename_append='') {
    if (is_array($value)) $value = implode("\n",$value);
    $fn = $this->path.$filename_append;
    #echo $fn."\n";
    file_put_contents($fn,$value);
  }
}




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
    $len = strlen($d)-2;
    $a[$i]=substr($d,2,$len);
  }
  return $a;
}

function isSystemCommand($s) {
  $s=trim($s);
  static $list=['ls','pwd','cat'];
  return (in_array($s, $list));
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

function tab($level) {
  return str_repeat('  ',$level);
}

function firstWord($s) {
  $a=explode(' ', $s);
  if (!$a) return false;
  return $a[0];
}

function replaceFirstWord($subject,$replace) {
  $a=explode(' ', $subject);
  if (!$a) return '';
  $a[0]=$replace;
  return implode(' ',$a);
}

function replaceVars($s,$with=false) {
  // todo improtve parser
  if (!$with) $with = 'r';
  return str_replace('$', $with, $s);
}

function replaceSystemVars($s) {
  // todo improtve parser
  return str_replace('$', "\"'+s+'\"", $s);
}

function makeCode($s,$sub,$level,$parent_mode=false) {
  if (!$s) return '';
  $loop=false;
  $system=false;
  $mode=false;
  if (isSystemCommand(firstWord($s)) ) {
    $system=true;
    $s = replaceSystemVars($s);
    $c = "exec('$s')";
    $c.=".then (result) ->\n".tab($level).'r=result.stdout'."\n".transform($sub,$level);
  }
  else {
    if ($s=='loop') {
      $loop=true;
      $mode='loop';
      $c = 'for s in r';
    }
    elseif ($s=='echo') {
      $c = 'console.log r';
    }
    elseif (firstWord($s)=='echo') {
      $c = replaceFirstWord($s,'console.log');
    }
    else {
      $c = $s;
    }
    if ($parent_mode=='loop') {
      $c = replaceVars($c,'s');
    }
    else {
      $c = replaceVars($c);
    }
    $c.="\n".transform($sub,$level,$mode);
  }
  if ($system) {
    $c.="\n".tab($level)."return";
  }
  return $c;
}

function transform($a,$level=0,$parent_mode=false) {
  $s='';
  foreach ($a as $d) {
    $c=makeCode($d['code'],$d['sub'],$level+1,$parent_mode)."\n";
    $c = tab($level).$c;
    $s.=$c;
  }
  // hack to clean returns
  while (strpos($s,"\n\n"))
    $s = str_replace("\n\n","\n",$s);

  return $s;
}

$file = new file($argv[1]);
$a = $file->get();

$commands=proc($a);
$code = transform($commands);

$r = "exec = require('process-promises').exec\n";
$r.= $code;
$r.= "\n";

#echo $r;

$file->set($r,'.coffee');

