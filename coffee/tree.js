// Generated by CoffeeScript 1.10.0
(function() {
  var c, f, fs, tabdown;

  tabdown = require('tabdown');

  c = console.log;

  fs = require('fs');

  f = '/srv/mage2/esf_refine_tree.txt';

  fs.readFile(f, 'utf8', function(err, data) {
    var tree;
    if (err) {
      c(err);
    }
    data = data.split("\n");
    tree = tabdown.parse(data);
    return c(tree);
  });

}).call(this);
