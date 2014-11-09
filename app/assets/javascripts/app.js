(function(){ 
	var app = angular.module('SurvivalApp', []);
	app.controller('survivalController', ["$scope", "$http", function($scope, $http){ 
	 	var survivalKit = this;
	 	survivalKit.maxWeight = 0;
	 	survivalKit.availableItems = [];
		survivalKit.selectedItems = [];
		survivalKit.possibleItems = [];
		survivalKit.request = {};
		$scope.change = function(){
			survivalKit.currentItems = [];
			survivalKit.maxWeight = $scope.weightLimit;
			$('input[type=checkbox]').each(function() {
				var itemName = this.parentNode.parentNode.getElementsByTagName("td")[1].textContent;
				var itemWeight = this.parentNode.parentNode.getElementsByTagName("td")[2].textContent;
				var itemValue = this.parentNode.parentNode.getElementsByTagName("td")[3].textContent;
            	if (this.checked) {
                	survivalKit.currentItems.push({ "name": itemName, "weight": itemWeight, "value": itemValue }); 
           		}
           	});
           	survivalKit.request = {"maxWeight": survivalKit.maxWeight, "availableItems": survivalKit.currentItems };
			requestBestPack(survivalKit.request);
		};
		var requestBestPack = function(availableItems){
			console.log(availableItems);
			$http.post('/v1/survival-pack/pack', survivalKit.request).success(function(data){
				json_data = JSON.parse(data);
				survivalKit.selectedItems = json_data['selectedItems'];
		 	}); 	
		};

		var requestAvailableItems = function(){
			$http.get('/v1/survival-pack/available').success(function(data){
		 		json_data = JSON.parse(data);
		 		survivalKit.maxWeight = json_data['maxWeight'];
		 		survivalKit.availableItems = json_data['availableItems'];
	 		}); 
		}
		requestAvailableItems();
	}]);
})();