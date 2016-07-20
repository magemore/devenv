implode = (a,sep) ->
  r='';
  for s in a
    r+=s+sep
mgvg = (r) ->
  keys=['foo', 'buzz', 'bar']
  r = implode keys, ' xargs -d "\\n" ag -l | '
  cmd='ag -l'+r
  # ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz |
  for s in keys
    cmd+='ag+r+'|''
  # ag foo | ag bar | ag buzz
  cmd+='xargs -d "\\n" grep ^'
  cmd+='ag '
  r = implode '|', keys
  cmd+=r
  console.log cmd
  exec(cmd).then (result) ->
    r=result.stdout
    for s in r
      console.log r
    return
mgvg()

