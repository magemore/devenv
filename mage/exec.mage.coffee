exec = require('process-promises').exec
fs = require('fs')
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
filter = (subject,filt) ->
  if Array.isArray(subject)
    r = ''
    for s in subject
      r += filter(s,filt) + "\n"
  if filt in subject
    return s
  return ''
s=mgvg(['implode','log'])
fs.writeFile('/tmp/testexec', s,->
  exec('/tmp/testexec')
  .then((result) ->
    r=result.stdout
    r = explode "\n",r
    for s in r
      if s
        if 'cat "'+s+'"'!=""
          exec('cat "'+s+'"').then (result) ->
            r=result.stdout
            r=explode "\n",r
            console.log filter r,'split'
  )
  return
)

