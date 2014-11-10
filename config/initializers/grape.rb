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
		bags = all_possible_bags(items)

		bags.each do |possibile_bag|
			value = 0
			weight = 0
			possibile_bag.each do |bag|
				bag.flatten!
				bag.each do |item|
					weight += item.weight
					value += item.value
				end
			end
			next if weight > max_weight

			if value == maxval
				solutions << possibile_bag
			elsif value > maxval
				maxval = value
				solutions = possibile_bag
			end
		end
		solutions.each do |set|
			set.each {|item| result["selectedItems"] << {"name" => item.name, "weight" => item.weight, "value" => item.value}}
		end
		result
	end

	def all_possible_bags items
	    result = []
	    possibilities = []
	    items.each do |item|
	        result.each do |res|
	            possibilities = [res+[item]]
	        end
	        result << possibilities
	    end
	    result
	end
  end
end