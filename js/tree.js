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

function simplify(data)  {
  var a = [];
  var c;
  for (var i in data) {
    for (var j in data[i]) {
      if (j=='toString') continue;
      c=new Object();
      c.name = j;
      a[i]={'name': j, 'children': simplify(data[i][j])};
    }
  }
  return a;
}


c('');
fs.readFile(f, 'utf8', function(err, data) {
  if (err) {
    c(err);
  }
  data = data.split("\n");
  var tree = tabdown.parse(data);
  data = tree.root;

  //convertToMagentoTree(data);
  a = simplify(data)
  s = JSON.stringify(a)
  c(s);
});
