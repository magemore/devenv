exec = require('process-promises').exec
exec('ls').then((result) ->
  console.log 'stdout: ', result.stdout
  return
)

echo ls
  log result
