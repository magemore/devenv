tabdown = require 'tabdown'
c = console.log
fs = require 'fs'
f = '/srv/mage2/esf_refine_tree.txt'
fs.readFile f, 'utf8', (err, data) ->
  if err
    c err
  c data
