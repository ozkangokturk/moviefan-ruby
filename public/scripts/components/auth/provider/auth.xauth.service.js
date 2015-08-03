'use strict';

angular.module('moviefanApp')
    .factory('AuthServerProvider', function loginService($http, localStorageService, Base64) {
        return {
            login: function(credentials) {
                return $http.post('/api/authenticate', {user: {login: credentials.username, password: credentials.password} })
                    .then(function(response) {
                        return response;
                    });
            },
            logout: function() {
                return $http.delete('/api/account', { })
                    .then(function(response) {
                        //Stateless API : No server logout
                        localStorageService.clearAll();
                        return response;
                    });

            },
            getToken: function () {
                return localStorageService.get('token');
            },
            hasValidToken: function () {
                var token = this.getToken();
                return token && token.expires && token.expires > new Date().getTime();
            }
        };
    });
