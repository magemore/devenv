
try {
    function refresh() {
        location.reload();
        //setTimeout('location.reload()',500);
    }

    var last_check = false;
    function check() {
        if (typeof(elem) === 'undefined') {
          setTimeout(check,500);
          return;
        }
        jQuery.get('/check_update.php',function(data) {
            if (!last_check) {
                last_check = data;
                return;
            }
            if (last_check!=data) {
                last_check=data;
                refresh();
            }
            //console.log(data);
        });
        setTimeout(check,100);
    }

    check();
}
catch(err) {
    console.log(err);
    setTimeout('refresh()',20000);
}
