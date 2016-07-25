'use strict';

function MainController($scope, photoSearchService) {

  /**
  List of photos matching the user's latest search term. Each
  object in the array will have a "title" and "thumbUrl"
  */
  $scope.photos = [];

  /**
  The keyword the user has entered.
  */
  $scope.searchKeyword = '';

  $scope.thumbSize = 'small';

  /**
  Starts a new search using the keyword the user has entered.
  */
  $scope.submitSearch = function() {

    $scope.photos = [];

    var keyword = $scope.searchKeyword;
    photoSearchService.findPhotos(keyword, function(photos) {
      // Update the "searchResults" model.
      $scope.photos = photos;
    });
  };

  $scope.setThumbSize = function(size) {
    $scope.thumbSize = size;
  }
}