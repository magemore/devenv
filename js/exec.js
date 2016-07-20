var exec = require('process-promises').exec;

exec('node ./node_modules/gulp/bin/gulp.js default')
    .on('process', function(process) {
        console.log('Pid: ', process.pid);
    })
    .then(function (result) {
        console.log('stdout: ', result.stdout);
        console.log('stderr: ', result.stderr);
    })
    .fail(function (err) {
        console.error('ERROR: ', err);
    });
