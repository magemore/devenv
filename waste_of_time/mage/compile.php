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

function isSubCommand($s) {
  if (!$s) return false;
  return $s[0]==' ';
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
  static $list=['ls','pwd','cat','bash','file-get'];
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
  $s = str_replace('$@', 'process.argv', $s);
  return str_replace('%', $with, $s);
}

function replaceSystemVars($s) {
  // todo improtve parser
  return str_replace('%', "\"'+s+'\"", $s);
}

function exceptFirstWord($subject) {
  $a=explode(' ', $subject);
  if (!$a) return '';
  unset($a[0]);
  return implode(' ',$a);
}

function makeCode($s,$sub,$level,$parent_mode=false,$next_is_sub=false) {
  $next_is_sub = true;
  if (!$s) return '';
  $loop=false;
  $system=false;
  $mode=false;
  if (isSystemCommand(firstWord($s)) ) {
    $system=true;
    $s = replaceSystemVars($s);
    if (firstWord($s)=='bash') { $s=exceptFirstWord($s); }
    elseif (firstWord($s)=='file-get') { $s='php file_get_contents.php '.exceptFirstWord($s);
  }
    #echo $s;
    #$s = str_replace("'","\'",$s);
    $t=tab($level);
    $t1=tab($level+1);
    $t2=tab($level+2);
    $c = "if '$s'!=\"\"\n{$t}exec('$s')";
    $log='';
    if (!$next_is_sub) {
      $log=tab($level)."\n${t1}console.log r";
    }
    $c.=".then (result) ->\n$t1".'r=result.stdout'."\n".$log.transform($sub,$level+1);
  }
  elseif (firstWord($s)=='exec') {
    $system=false;
    $s = exceptFirstWord($s);
    $s = replaceSystemVars($s);
    $c= "exec($s)";
    $log='';
    if (!$next_is_sub) {
      $log=tab($level+1).'console.log r';
    }
    $c.="\n".tab($level).".then (result) ->\n".tab($level+1).'r=result.stdout'."\n".transform($sub,$level+1).tab($level)."\n";
  }
  elseif (firstWord($s)=='//') {
    $c = replaceFirstWord($s,'#');
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
    elseif (firstWord($s)=='for') {
      $c = replaceFirstWord($s,'for s in');
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
  return $c;
}

function transform($a,$level=0,$parent_mode=false) {
  $s='';
  foreach ($a as $i => $d) {
    $next_is_sub = false;
    if (isset($d[$i])) $next_is_sub = isSubCommand($d[$i]);
    $c=makeCode($d['code'],$d['sub'],$level+1,$parent_mode,$next_is_sub)."\n";
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
//print_r($argv);
system('coffee --compile '.$argv[1].'.coffee');
system('coffee '.$argv[1].'.coffee');
