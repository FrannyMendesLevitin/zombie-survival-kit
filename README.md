HOW TO USE
==================

Survival-Pack is a service designed to take information regarding which items are available, and returns the items which maximize your chances of surviving a zombie apocolypse. 

There are two ways to use the app. 

The first is via an AngularJS front end, found at [link](http://zombie-survival-kit.herokuapp.com/). Simply check the boxes of the items that are available, and a list of the optimal choices will pop up on the left. 

The second option is to directly submit json data to the api endpoint /v1/survival-pack/pack via an HTTP POST request. The api will return json with information regarding the best pack of items.

An example http request (via jquery) might look like this:

	var json = { 
		"maxWeight": 400,

		"availableItems": [
			{"name": "ammo", "weight": 9, "value": 150},
			{"name": "tuna", "weight": 13, "value": 35},
			{"name": "water", "weight": 153, "value": 200},
			{"name": "spam", "weight": 50, "value": 160},
			{"name": "knife", "weight": 15, "value": 60},
			{"name": "hammer", "weight": 68, "value": 45},
			{"name": "rope", "weight": 27, "value": 60},
			{"name": "saw", "weight": 39, "value": 40},
			{"name": "towel", "weight": 23, "value": 30},
			{"name": "rock", "weight": 52, "value": 10},
			{"name": "seed", "weight": 11, "value": 70},
			{"name": "blanket", "weight": 32, "value": 30},
			{"name": "skewer", "weight": 24, "value": 15},
			{"name": "dull-sword", "weight": 48, "value": 10},
			{"name": "oil", "weight": 73, "value": 40},
			{"name": "peanuts", "weight": 42, "value": 70},
			{"name": "almonds", "weight": 43, "value": 75},
			{"name": "wire", "weight": 22, "value": 80},
			{"name": "popcorn", "weight": 7, "value": 20},
			{"name": "rabbit", "weight": 18, "value": 12},
			{"name": "beans", "weight": 4, "value": 50},
			{"name": "laptop", "weight": 30, "value": 10}
			]

		}
    $.post("http://localhost:3000/v1/survival-pack/pack", JSON.parse(json))

This HTTP request would return json data that looks like this:

    {
	"selectedItems":[
		{"name":"ammo","weight":9,"value":150},
		{"name":"tuna","weight":13,"value":35},
		{"name":"water","weight":153,"value":200},
		{"name":"spam","weight":50,"value":160},
		{"name":"knife","weight":15,"value":60},
		{"name":"rope","weight":27,"value":60},
		{"name":"seed","weight":11,"value":70},
		{"name":"peanuts","weight":42,"value":70},
		{"name":"almonds","weight":43,"value":75},
		{"name":"wire","weight":22,"value":80},
		{"name":"popcorn","weight":7,"value":20},
		{"name":"beans","weight":4,"value":50}
		]
	}


PROMPT
================================

You are a survior of zombie apocalypse. You are moving from town-to-town collecting the most valuable items necessary for survival. You have a backpack that can only hold a certain amount of weight and it is your job is to choose the best set of items based on their weight and value.

Write a API in Grape with an API endpoint called /v1/survival-pack.

That API endpoint will be given the following data via a POST request:

a set of survival items with a name and unique weight and value combination
an overall weight restriction
The endpoint should accept a JSON data structure as input
It will (maybe asynchronously) produce an optimal set of survival items which:

are within the total weight restriction
maximizes your chance of survival
is in JSON
Requirements:

Use Rails
Use Grape - https://github.com/intridea/grape
Use Bundler - https://github.com/bundler/bundler
Include multiple system test cases to validate your solution (like the one included below adapted to a JSON API format)
Provide instructions in a README for submitting a survival pack to the API and interpretting the results
Deploy it to Heroku or similar service
Make your solution available on GitHub or similar service


Input:

max weight: 400

name    weight value
ammo        9   150
tuna       13    35
water     153   200
spam       50   160
knife      15    60
hammer     68    45
rope       27    60
saw        39    40
towel      23    30
rock       52    10
seed       11    70
blanket    32    30
skewer     24    15
dull-sword 48    10
oil        73    40
peanuts    42    70
almonds    43    75
wire       22    80
popcorn     7    20
rabbit     18    12
beans       4    50
laptop     30    10

Result:

name    weight value
beans       4    50
popcorn     7    20
wire       22    80
almonds    43    75
peanuts    42    70
seed       11    70
rope       27    60
knife      15    60
spam       50   160
water     153   200
tuna       13    35
ammo        9   150

Hint:

Read this - http://en.wikipedia.org/wiki/Knapsack_problem
Extra Credit:

Create a tested JS frontend to manually exercise your solution using Knockout or Angular