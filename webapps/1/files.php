<?php
require 'exec.php';
echo json_encode(getExecFiles('ls -l'));
