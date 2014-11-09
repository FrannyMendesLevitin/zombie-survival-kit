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

		# optimize for case where all items can be carried
		total_weight = 0
		items.each do |item|
			total_weight += item.weight
		end
		if total_weight <= max_weight
			items.each do |item|
				result["selectedItems"] << {"name" => item.name, "weight" => item.weight, "value" => item.value}
			end
			return result
		end

		# Otherwise, do it the long way
		value_matrix = fill_matrix_with_zeros(items.length+1, max_weight)
		decision_matrix = fill_matrix_with_zeros(items.length+1, max_weight)  

		for i in 0..items.length
		    if i==0
		      next
		    end
			for j in 1..max_weight
				array_j = j - 1
				if (j > items[i-1].weight)
					value_matrix[i][array_j] = [value_matrix[i-1][array_j], (items[i-1].value + value_matrix[i-1][(j - items[i-1].weight)-1])].max
					if ((items[i-1].value + value_matrix[i-1][(j - items[i-1].weight)-1]) > value_matrix[i-1][array_j])
						decision_matrix[i][array_j] = 1
					end
				elsif (j == items[i-1].weight)
					value_matrix[i][array_j] = items[i-1].value
					decision_matrix[i][array_j] = 1
				else
					value_matrix[i][array_j] = value_matrix[i-1][array_j]
				end
			end
		end

		w = max_weight
		i = items.length
		while w>=0 and i<=items.length and i>0 
			if (decision_matrix[i][w-1]==1)
				result["selectedItems"] << {"name" => items[i - 1].name, "weight" => items[i - 1].weight, "value" => items[i - 1].value}
				w -= items[i - 1].weight
				i -= 1
			else
				i -= 1 
			end
		end
		result
	end

	def fill_matrix_with_zeros rows, cols
		Array.new(rows) do |row|
			Array.new(cols, 0)
		end
	end

  end
end