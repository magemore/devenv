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
	<table>
    	<tr ng-repeat="file in files"><td>{{ file }}</td></tr>
    </table>
  </div>
</div>
<div class='hidden' id="files"></div>
</body>
</html>
