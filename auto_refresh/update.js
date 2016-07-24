
{
  function get(url) {
    var request = new XMLHttpRequest();
    request.open('GET', url, true);

    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        // Success!
        var data = JSON.parse(request.responseText);
      } else {
        // We reached our target server, but it returned an error
      }
    };

    request.onerror = function() {
      // There was a connection error of some sort
    };

    request.send();
  }

  try {
      function refresh() {
          location.reload();
          //setTimeout('location.reload()',500);
      }

      var last_check = false;
      function check() {
          request.open('GET', '/update.php', true);
          request.onload = function() {
            if (request.status >= 200 && request.status < 400) {
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
          };
          request.onerror = function() {
            // There was a connection error of some sort
          };
          setTimeout(check,100);


      }

      check();
  }
  catch(err) {
      console.log(err);
      setTimeout('refresh()',20000);
  }
}
