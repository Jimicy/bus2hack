 window.fbAsyncInit = function() {
        FB.init({
          appId      : 'your-app-id',
          xfbml      : true,
          version    : 'v2.3'
        });
      };

      (function(d, s, id){
         var js, fjs = d.getElementsByTagName(s)[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement(s); js.id = id;
         js.src = "//connect.facebook.net/en_US/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
       }(document, 'script', 'facebook-jssdk'));

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
    
    FB.getLoginStatus(function(response) {
        statusChangeCallback(response);
    });
    $scope.login = function(){
        FB.login();
    } 
}])

BusToHack.controller('mainCtrl',["$scope", function($scope){
}])