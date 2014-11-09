module Survival
  class Post < Grape::API
    format :json
    desc 'Creates a pack from available objects.'
    resource :pack do
      post do
      	data_hash = JSON.parse(params.to_json)
      	KnapsackItem = Struct.new(:name, :weight, :value)
		max_weight = data_hash["maxWeight"]
		available_items = data_hash["availableItems"]
		available_knapsack_items = []
		available_items.each do |item|
			available_knapsack_items << KnapsackItem.new(item["name"], item["weight"], item["value"])
		end

		answer = best_bag 400, available_knapsack_items
		answer.to_json

      end
    end

  end

end
