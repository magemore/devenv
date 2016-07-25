(function() {
  var c, f, fs, tabdown;

  tabdown = require('tabdown');

  c = console.log;

  fs = require('fs');

  f = '/srv/mage2/esf_refine_tree.txt';

  fs.readFile(f, 'utf8', function(err, data) {
    var i, j, k, l, len, results, tree;
    if (err) {
      c(err);
    }
    var data = data.split("\n");
    var tree = tabdown.parse(data);
    var data = tree.root;
    var results = [];
    for (var i in data) {
      for (var category in data[i]) {
        if (category=='toString') continue;
        c(category);
        //c(data[i][category]);
        for (var j in data[i][category]) {
          for (var prop in data[i][category][j]) {
            if (prop=='toString') continue;
            c('  '+prop);
          }
        }
      }
    }
    return results;
  });

}).call(this);
