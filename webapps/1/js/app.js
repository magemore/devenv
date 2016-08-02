var app = angular.module('webshellApp', []);
app.controller('shellFilesCtrl', function($scope, $http) {
	$http({
	  method: 'GET',
	  url: '/files.php'
	}).then(function successCallback(response) {
      $scope.files=response.data.files;
      $scope.total=response.data.total;
      setTimeout(function(){
        jQuery("#explorer").DataTable();
      },500);
	  }, function errorCallback(response) {
	    // called asynchronously if an error occurs
	    // or server returns response with an error status.
	  });
});

