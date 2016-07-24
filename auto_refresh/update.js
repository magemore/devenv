
function refresh() {
    location.reload();
}

var last_check = false;
function check_files_updated() {
  // console.log('cool');

  //console.log('make request');
  var request = new XMLHttpRequest();
  request.onreadystatechange = function() {
    // console.log(request)
    // console.log(request.status)
    if (request.status == 200) {
      var data = request.responseText;
      console.log(request.responseText);
      // Success!
      var data=request.responseText;
      if (!last_check) {
        last_check = data;
        return;
      }
      if (last_check!=data) {
        last_check=data;
        //refresh();
      }
    } else {
      // We reached our target server, but it returned an error
    }
    setTimeout(check_files_updated,500);
  };
  request.open('GET', '/auto_refresh/update.php', true);
  request.send();
}

check_files_updated();


