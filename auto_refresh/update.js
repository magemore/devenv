var auto_refresh = function(){
  function refresh() {
      location.reload();
  }

  var last_check = false;
  var request = new XMLHttpRequest();
  request.onreadystatechange = function() {
      // console.log(request)
      // console.log(request.status)
      if (request.status == 200) {
        var data = request.responseText;
        //console.log(request.responseText);
        // Success!
        var data=request.responseText;
        if (!last_check) {
          last_check = data;
          return;
        }
        if (data) {
          if (last_check!=data) {
            // console.log(data);
            last_check=data;
            refresh();
          }
        }
      } else {
        // We reached our target server, but it returned an error
      }
  };

  function check_files_updated() {
    request.open('GET', '/auto_refresh/update.php', true);
    request.send();
    setTimeout(check_files_updated,500);
  }

  check_files_updated();
}

auto_refresh();
