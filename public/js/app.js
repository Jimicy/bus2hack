var BusToHack = angular.module('BusToHack',['ngRoute', 'ngResource', 'ngAnimate'])

BusToHack.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'templates/landingpage.html',
        controller: 'LandCtrl'
      })
      otherwise({
        redirectTo: '/'
      });
  }]);

BusToHack.controller('LandCtrl', ["$scope", function($scope){

    $scope.text = 'hello';
    
}])