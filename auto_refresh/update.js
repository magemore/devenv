var auto_refresh = function(){
  function refresh() {
      // delay because after file saved it can be formated with plugins and saved again
      // to make less refreshes in seconds
      setTimeout(function(){location.reload();},500);
  }

  var last_check = false;
  var request = new XMLHttpRequest();
  request.onreadystatechange = function() {
    if (request.status == 200) {
      var data=request.responseText;
      // sometimes on request state change data is empty. strange.
      // anybody knows why? how to make it better? it refreshes when not needed. so there this check
      if (data) {
        if (!last_check) {
          last_check = data;
          return;
        }
        if (last_check!=data) {
          last_check=data;
          refresh();
        }
      }
    } else {
      // ignore errors
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
