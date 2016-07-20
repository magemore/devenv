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

