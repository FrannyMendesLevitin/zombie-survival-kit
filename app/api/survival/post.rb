module Survival
  class Post < Grape::API
    format :json
    desc 'Creates a pack from available objects.'
  	KnapsackItem = Struct.new(:name, :weight, :value)
    resource :pack do
      post do
      	data_hash = JSON.parse(params.to_json)
		max_weight = data_hash["maxWeight"].to_i
		available_items = data_hash["availableItems"]
		available_knapsack_items = []
		available_items.each do |item, value|
			if value 
				available_knapsack_items << KnapsackItem.new(value["name"], value["weight"].to_i, value["value"].to_i)
			else
				available_knapsack_items << KnapsackItem.new(item["name"], item["weight"].to_i, item["value"].to_i)
			end
		end
		answer = best_bag max_weight, available_knapsack_items
		answer.to_json
      end
    end
  end
end
