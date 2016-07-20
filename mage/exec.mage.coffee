exec = require('process-promises').exec
test (r) ->
  console.log r
exec('ls').then (result) ->
  r=result.stdout
  for s in r
    console.log s
    exec('cat "'+s+'"').then (result) ->
      r=result.stdout
      console.log r
      test 1
      return
  return
mgvg = ->
  keys=process.argv
  r = implode keys, 'xargs -d "\n" ag -l |'
  cmd='ag -l'+r
  # ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz |
  for s in keys
    cmd+='ag+r+'|''
  # ag foo | ag bar | ag buzz
  cmd+='xargs -d "\n" grep ^'
  cmd+='ag '
  r = implode '|', keys
  cmd+=r
  console.log cmd
mgvg()
implode = (a,sep) ->
  sep.replace '"\n"', '"\\n"'
  a.join sep
mgvg = (r) ->
  keys=['foo', 'buzz', 'bar']
  r = implode keys, ' xargs -d "\n" ag -l | '
  cmd='ag -l'+r
  # ag -l foo | xargs -d "\n" ag -l bar | xargs -d "\n" ag -l buzz |
  for s in keys
    cmd+='ag+r+'|''
  # ag foo | ag bar | ag buzz
  cmd+='xargs -d "\n" grep ^'
  cmd+='ag '
  r = implode '|', keys
  cmd+=r
  console.log cmd
mgvg()

