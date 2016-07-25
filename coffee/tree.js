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
    data = data.split("\n");
    tree = tabdown.parse(data);
    data = tree.root;
    results = [];
    for (i in data) {
      for (category in data[i]) {
        if (category=='toString') continue;
        c(category);
        //c(data[i][category]);
        for (j in data[i][category]) {
          for (prop in data[i][category][j]) {
            if (prop=='toString') continue;
            c('  '+prop);
          }
        }
      }
    }
    return results;
  });

}).call(this);
