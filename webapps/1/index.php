<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<title>Scripts</title>
<script src="/auto_refresh/update.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css">

<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/angular.min.js"></script>
<script src="/js/jquery.dataTables.min.js"></script>
<script src='js/app.js'></script>
<style>
.table-striped>tbody>tr:nth-of-type(odd).dir, .dir {
  color: #82ACD8;
}
.table {
  cursor: pointer; 
}
.dataTables_length {
  float: left; 
}

input,
select {
  border-color: grey;
  background-color: black;
  color: white; 
  margin-left:5px;
  margin-right:5px;
}
</style>
</head>
<body>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title"> Explorer </h3>
  </div>
  <div class="panel-body" ng-app="webshellApp" ng-controller="shellFilesCtrl">
    <table class='table-striped table table-bordered table-hover' id="explorer">
      <thead>
        <tr>
          <th>name</th>
          <th>size</th>
          <th>date</th>
          <th>user</th>
          <th>permissions</th>
        </tr>
      </thead>
      <tbody>
        <tr ng-repeat="file in files" ng-class="{'info': file.is_dir }">
          <td>{{ file.name }}</td>
          <td>{{ file.size }}</td>
          <td>{{ file.date }}</td>
          <td>{{ file.user }}</td>
          <td>{{ file.permissions }}</td>
        </tr>
      </tbody>
    </table>
    <div id="total">{{ total }}</div>
  </div>
</div>
</body>
</html>
