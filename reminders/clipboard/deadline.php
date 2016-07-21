<?php

function g() {
    $o=[];
    exec('/data/data/com.termux/files/home/bin/share_get');
    $share = '/data/data/com.termux/files/home/tmp/share';
    return file_get_contents($share);
}

$old = g();

// first refresh tmp
while (true) {
    sleep(50);
    $new = g();
        $old = $new;
        system('termux-clipboard-set < /data/data/com.termux/files/home/tmp/share'); }

