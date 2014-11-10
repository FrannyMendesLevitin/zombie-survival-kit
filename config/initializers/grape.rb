require 'grape/endpoint'

module Grape
  class Endpoint
    def url_helper
      @url_helper ||= ::API::RoutingHelper.new(self)
    end

	#
	# To get the best knapsack, we want to maximize the value (sum of item values), 
	# subject to a weight constraint (the sum of the weights must be less than some maximum)
	# 
	# A decision matrix representing each item will have a 1 in a cell if the item will be taken, 
	# and a 0 if it will be left behind
	#

	def best_bag max_weight, items
		result = {"selectedItems" => []}
		maxval = 0
		solutions = []
		 
		all_possible_bags(items) do |subset|
		  weight = subset.inject(0) {|w, elem| w += elem.weight}
		  next if weight > max_weight
		 
		  value = subset.inject(0) {|v, elem| v += elem.value}
		  if value == maxval
		    solutions << subset
		  elsif value > maxval
		    maxval = value
		    solutions = [subset]
		  end
		end
		 
		solutions.each do |set|
		  set.each {|item| result["selectedItems"] << {"name" => item.name, "weight" => item.weight, "value" => item.value}
		}
		end
	end

	def all_possible_bags items
	    result = [[]]
	    possibilities = []
	    items.each do |item|
	   		result.each do |res|
	  			possibilities = [res+[item]]
	  		end
	  		result << possibilities
	  	end
	    return result
	end

  end
end