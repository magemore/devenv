find . -name *.txt
grep foo
grep bar
grep -v buzz

cd 1; ls

---
<?php

function ex($c){
  $o=[];
  exec($c,$o);
  # todo: check if it has return done at the end
  
  return implode("\n",$o);
}
