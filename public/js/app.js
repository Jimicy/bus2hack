var BusToHack = angular.module('BusToHack',['ngRoute'])

BusToHack.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/', {
        templateUrl: 'templates/login.html',
        controller: 'landCtrl'
      }).
      otherwise({
        redirectTo: '/'
      })
  }])

BusToHack.controller('loginCtrl', ["$scope", function($scope){
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
    
    $scope.login = function(){
        
    }
    
}])

BusToHack.controller('mainCtrl',["$scope", function($scope){
}])