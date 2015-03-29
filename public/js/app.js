var BusToHack = angular.module('BusToHack',['ngRoute'])

BusToHack.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/login', {
        templateUrl: 'templates/login.html',
        controller: 'loginCtrl'      }).
      otherwise({
        redirectTo: '/login'
      })
  }])

BusToHack.controller('loginCtrl', ["$scope","$http", function($scope,$http){
    $scope.login = function (){
        $http.post('/session',{"username":$scope.username, "password":$scope.password}).success(function(data){
            console.log(data)
        })
    }
    
}])

BusToHack.controller('regCtrl',["$scope", function($scope){
    $scope.isLoggedIn = false;
}])

BusToHack.controller('landCtrl',["$scope", function($scope){
}])