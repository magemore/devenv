<!doctype html>
<html>
<head>
<?php
require 'exec.php';
$title = 'Scripts';
?>
<meta charset="utf-8">
<title>
<?=$title?>
</title>
<script src="/auto_refresh/update.js"></script>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<script src="/js/jquery.min.js"></script>
<script src="/js/bootstrap.min.js"></script>
<script src="/js/angular.min.js"></script>
</head>
<body>
<script src='js/app.js'></script>
<div class="panel panel-default">
  <div class="panel-heading">
    <h3 class="panel-title">
      <?=$title?>
    </h3>
  </div>
  <div class="panel-body" ng-app="webshellApp" ng-controller="shellFilesCtrl">
    <table class='table-striped table'>
      <tr>
        <th>name</th>
        <th>size</th>
        <th>date</th>
        <th>user</th>
        <th>permissions</th>
      </tr>
      <tr ng-repeat="file in files">
        <td>{{ file.name }}</td>
        <td>{{ file.size }}</td>
        <td>{{ file.date }}</td>
        <td>{{ file.user }}</td>
        <td>{{ file.permissions }}</td>
      </tr>
    </table>
    <div id="total">{{ total }}</div>
  </div>
</div>
</body>
</html>
