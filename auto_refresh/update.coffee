auto_refresh = ->
  last_check = false
  request = new XMLHttpRequest

  refresh = ->
    location.reload()
    return

  check_files_updated = ->
    request.open 'GET', '/auto_refresh/update.php', true
    request.send()
    setTimeout check_files_updated, 500
    return

  request.onreadystatechange = ->
    if request.status == 200
      data = request.responseText
      # sometimes on request state change data is empty. strange.
      # anybody knows why? how to make it better? it refreshes when not needed. so there this check
      if data
        if !last_check
          last_check = data
          return
        if last_check != data
          last_check = data
          refresh()
    else
      # ignore errors
    return

  check_files_updated()
  return

auto_refresh()
