<?php

function sqlite_open($location,$mode=false)
{
  $handle = new SQLite3($location);
  return $handle;
} 

sqlite_open('test.db');

