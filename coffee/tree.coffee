tabdown = require 'tabdown'
c = console.log
fs = require 'fs'
f = '/srv/mage2/esf_refine_tree.txt'

parse = (tree) ->
  for d,name in tree
    for j, k in d
      c j
  return

fs.readFile f, 'utf8', (err, data) ->
  if err
    c err
  #data = data.replace '  ',"\t"
  data = data.split "\n"
  tree = tabdown.parse data
  #parse tree.root
  s = JSON.stringify tree
  c s

  #c tree
  #c data
