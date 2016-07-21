alarm(){
    while true; do
        D=$(date +%H:%M)
        sleep $1
        clear
        termux-clipboard-set $D $2 $3 $4 $5 $6 $7 $8 $9
        echo $D
    done;
}
