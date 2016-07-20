exec = require('process-promises').exec
exec('ls').then (result) ->
  r=result.stdout
  for s in r
    console.log s
    exec('cat "'+s+'"').then (result) ->
      r=result.stdout
  return

