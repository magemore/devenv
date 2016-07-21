exec = require('process-promises').exec
fs = require('fs')
trim = (str, charlist) ->
  whitespace = [
    ' '
    '\n'
    '\u000d'
    '\u0009'
    '\u000c'
    '\u000b'
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    ' '
    '\u200b'
    '\u2028'
    '\u2029'
    '　'
  ].join('')
  l = 0
  i = 0
  str += ''
  if charlist
    whitespace = (charlist + '').replace(/([\[\]\(\)\.\?\/\*\{\}\+\$\^:])/g, '$1')
  l = str.length
  i = 0
  while i < l
    if whitespace.indexOf(str.charAt(i)) == -1
      str = str.substring(i)
      break
    i++
  l = str.length
  i = l - 1
  while i >= 0
    if whitespace.indexOf(str.charAt(i)) == -1
      str = str.substring(0, i + 1)
      break
    i--
  if whitespace.indexOf(str.charAt(0)) == -1 then str else ''
# ---
# generated by js2coffee 2.2.0
implode = (sep, a) ->
  Array.prototype.join.call(a,sep)
explode = (sep, a) ->
  a.split(sep)
word = (number, a, sep=' ') ->
  av = explode sep, a
  if number<0
    number=av.length-1
  return av[number]
subword = (start, length, subject, separator=' ') ->
  av = explode separator, subject
  if number<0
    number=av.length-1
  return av[number]
mgvg = (keys=false) ->
  r = implode '  | xargs -d "\\n" ag -l ', keys
  cmd='ag -l '+r
  xa=' | xargs -d "\\n"'
  cmd+=xa+' grep ^ '
  for s in keys
    cmd+=' | ag '+r
  return cmd
typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value )
filter = (subject,filt) ->
  subject.includes filt
s=mgvg(['implode','log'])
some_random_check_of_filters = (x)->
  exec(s)
    .then (result) ->
      r=result.stdout
      r = explode "\n",r
      for s in r
        if s
          if 'cat "'+s+'"'!=""
            exec('cat "'+s+'"').then (result) ->
              r=result.stdout
              r=explode "\n",r
              for s in r
                if filter(s,'split')
                  console.log trim s
    
if 'php file_get_contents.php http://esf.cc'!=""
  exec('php file_get_contents.php http://esf.cc').then (result) ->
    r=result.stdout
    if r.includes 'ESF'
      console.log 'ESF is up'
    else
      console.log 'ESF is down'
count = (a) -> a.length
show_time = (x) ->
  exec('php time.php')
    .then (result) ->
      r=result.stdout
    
time = (x) -> Date.now() / 1000 | 0
FILE_APPEND='append'
n="\n"
DATE_FILE='/home/a/.timep_date'
file_put_contents = (filename, value, param, callback) ->
  if param == FILE_APPEND
    tmpName = '/tmp/cof_tmp_'+time()
    fs.writeFile tmpName, value,->
      r = tmpName
      exec('cat "'+s+'" >> '+filename)
        .then (result) ->
          r=result.stdout
          callback()
        
    return
  else
    fs.writeFile filename, value,->
      callback()
read_logs = () -> ;
argv=['self.js','log']
has_args = count(argv) > 1
if not has_args
  show_time()
else
  command = argv[1]
  if command=='stop'
    s = time()+'"stop'
    file_put_contents(DATE_FILE,'')
    file_put_contents(LOG_FILE,'',FILE_APPEND)
  else
    if (command=='log')
      read_logs()
    else
      # unset(0)
      argv.splice(key, 0)
      s = implode ' ', argv
