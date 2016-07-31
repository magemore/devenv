var app = angular.module('webshellApp', []);
app.controller('shellFilesCtrl', function($scope, $http) {
	$scope.files=<?=json_encode(getExecFiles('ls -l'))?>;
});
