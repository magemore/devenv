
function refresh() {
    location.reload();
}

var last_check = false;
function check_files_updated() {
  // console.log('cool');

  console.log('make request');
  var request = new XMLHttpRequest();
  request.open('GET', '/auto_refresh/update.php', true);
  request.onload = function() {
    console.log('done');
    if (request.status >= 200 && request.status < 400) {
      console.log(data);
      // Success!
      var data=request.responseText;
      if (!last_check) {
        last_check = data;
        return;
      }
      if (last_check!=data) {
        last_check=data;
        refresh();
      }
    } else {
      // We reached our target server, but it returned an error
    }
    setTimeout(check_files_updated,200);
  };
  request.onerror = function() {
    console.log('error');
    // There was a connection error of some sort
  };

}

check_files_updated();


