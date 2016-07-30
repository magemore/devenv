<?php

echo $s = file_get_contents('http://dreamviewer.io/index.php');

if (!strpos($s,'auto_refresh/update.js')):
?>
<script src="/auto_refresh/update.js"></script>
<? endif;