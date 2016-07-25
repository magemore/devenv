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
  c tree
  #c data
