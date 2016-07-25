var tabdown = require('tabdown');

c = console.log;

var fs = require('fs');

var f = '/srv/mage2/esf_refine_tree.txt';

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
  if (err) {
    c(err);
  }
  data = data.split("\n");
  var tree = tabdown.parse(data);
  data = tree.root;

  convertToMagentoTree(data);


});
