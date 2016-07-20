exec = require('process-promises').exec
fs = require('fs')
# fs.writeFile('/tmp/testexec', 'echo 1',->
#   bash '/tmp/testexec'
#     echo r
# )
implode = (sep, a) ->
  Array.prototype.join.call(a,sep)
mgvg = (keys=false) ->
  r = implode '  | xargs -d "\\n" ag -l ', keys
  cmd='ag -l '+r
  for s in keys
    cmd+=' | ag '+s
  cmd+=' | xargs -d "\\n" grep ^ | '
  cmd+='ag '
  r = implode '|', keys
  cmd+=r
  #echo cmd
  fs.writeFile('/tmp/testexec', cmd,->
    exec('/tmp/testexec').then (result) ->
      r=result.stdout
      console.log r
      return
  )
mgvg(['implode'])
console.log 'works'

