exec = require('process-promises').exec
exec('node ./node_modules/gulp/bin/gulp.js default').on('process', (process) ->
  console.log 'Pid: ', process.pid
  return
).then((result) ->
  console.log 'stdout: ', result.stdout
  console.log 'stderr: ', result.stderr
  return
).fail (err) ->
  console.error 'ERROR: ', err
  return
