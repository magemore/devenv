#!/bin/bash
export DISPLAY=:0
eval "export $(egrep -z DBUS_SESSION_BUS_ADDRESS /proc/$(pgrep -u $LOGNAME gnome-session)/environ)";
links2 -source "https://google.co.uk/search?q=$@" > /tmp/s_go_google.html
url=$(html_first_link)
echo $url > /tmp/z_goo.txt
echo '' > /tmp/z_s_go_tmp.html
phantomjs /home/a/tools/html_get/get.js $url > /tmp/z_s_go_tmp.html
echo '<?php $s=file_get_contents("/tmp/z_s_go_tmp.html"); if (!$s) { file_put_contents("/tmp/z_s_go_tmp_result.html","not found"); return; } $a=explode("<h1",$s); if (isset($a[1])) { unset($a[0]); $s="<h1".implode("<h1",$a); } file_put_contents("/tmp/z_s_go_tmp_result.html",$s);' | php
links2 -dump /tmp/z_s_go_tmp_result.html >> /tmp/z_goo.txt
vim /tmp/z_goo.txt
