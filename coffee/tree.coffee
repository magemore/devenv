tabdown = require 'tabdown'
c = console.log
fs = require 'fs'
f = '/srv/mage2/esf_refine_tree.txt'

fs.readFile f, 'utf8', (err, data) ->
  if err
    c err
  #data = data.replace '  ',"\t"
  data = data.split "\n"
  tree = tabdown.parse data
  data = tree.root
  #s = JSON.stringify data
  #c s
  for k,j in data
    #c JSON.stringify k
    c j, k
    for j,i in k
      c j, i

  #c tree
  #c data
