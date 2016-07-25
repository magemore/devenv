(function() {
  var c, f, fs, tabdown;

  tabdown = require('tabdown');

  c = console.log;

  fs = require('fs');

  f = '/srv/mage2/esf_refine_tree.txt';

  function indentLevel(level) {
    var s='';
    var tab='  ';
    for (var i = 0; i<level; i++) {
      s+=tab;
    }
    return s;
  }

  function parseList(data,level) {
    var t='';
    for (var i in data) {
      for (var j in data[i]) {
        if (j=='toString') continue;
        t=indentLevel(level);
        c(t+j);
        parseList(data[i][j],level+1);
      }
    }
  }

  function convertToMagentoTree(data) {
    parseList(data,0);
  }

c('start:');
c('');
  fs.readFile(f, 'utf8', function(err, data) {
    var i, j, k, l, len, results, tree;
    if (err) {
      c(err);
    }
    var data = data.split("\n");
    var tree = tabdown.parse(data);
    var data = tree.root;

    convertToMagentoTree(data);
    // for (var i in data) {
    //   for (var category in data[i]) {

    //     if (category=='toString') continue;
    //     c(category);
    //     //c(data[i][category]);
    //     for (var j in data[i][category]) {

    //       for (var prop in data[i][category][j]) {
    //         if (prop=='toString') continue;
    //         c('  '+prop);
    //       }

    //     }
    //   }
    // }

  });
}).call(this);
