<?php

$s = file_get_contents("since.txt");

$mode = @$argv[1];

$a=explode("\n",$s);
$start=$a[0];
$subject=$a[1];
if ($mode=='start') {
echo "task ".$subject.'started at '.$start."\n";
exit();
}
// calc
list($hour,$min) = explode(':',$start);
$o=[];
exec('date +%H:%M',$o);
$now=@$o[0];
list($chour,$cmin) = explode(':',$now);
function toMin($h,$m){
    return intval($h)*60+intval($min);
}
$s1=toMin($hour,$min);
$s2=toMin($chour,$cmin);
$m=$s2-$s1;
echo $m." minutes since started $subject\n";

