Calling php from node and coffee is complicated if per functions. I used to make things in php.

Mixing coffee with php is bad idea. It's better to learn type script :-)
Coffee hard to predict. I actually make thins faster in bash sometimes than to figure how convert it in js.
this part was actually nice
```coffee
mgvg = (keys=false) ->
  r = implode '  | xargs -d "\\n" ag -l ', keys
  cmd='ag -l '+r
  xa=' | xargs -d "\\n"'
  cmd+=xa+' grep ^ '
  for s in keys
    cmd+=' | ag '+s
  return cmd
```

generation of bash search command

in php it will look like
```php
<?php
function mgvg ($keys='')
{
  $r = implode('  | xargs -d "\\n" ag -l ', $keys);
  $cmd='ag -l '.$r;
  $xa=' | xargs -d "\\n"';
  $cmd.=$xa.' grep ^ ';
  foeachr $keys as $s
    $cmd.=' | ag '.s
  return $cmd
}
```
