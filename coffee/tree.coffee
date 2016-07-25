tabdown = require 'tabdown'

c = console.log

fs = require 'fs'

f = '/srv/mage2/esf_refine_tree.txt'

indentLevel = (level) ->
  s = ''
  tab = '  '
  i = 0
  while i < level
    s += tab
    i++
  s

parseList = (data,level) ->
  t = ''
  for id,i in data
    for jd,j in data[i]
      if j == 'toString'
        continue
      t = indentLevel level
      c t+j
      parseList data[i][j], level+1
  return

convertToMagentoTree = (data) ->
  parseList data, 0
  return

c 'start:'
c ''
fs.readFile f, 'utf8', (err, data) ->
  if err
    c err
  data = data.split('\n')
  tree = tabdown.parse(data)
  data = tree.root
  convertToMagentoTree data
  return
