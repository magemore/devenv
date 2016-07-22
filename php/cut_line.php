<?php

$fp = fopen('php://stdin', 'r');
$last_line = false;
$message = '';
while (!$last_line) {
    $next_line = fgets($fp, 1024); // read the special file to get the user input from keyboard
    if (".\n" == $next_line) {
      $last_line = true;
    } else {
      $message .= $next_line;
    }
}

echo $message;

return 1;
