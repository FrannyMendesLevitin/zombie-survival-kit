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