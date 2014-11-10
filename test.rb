require 'json'
KnapsackItem = Struct.new(:name, :weight, :value)

# def best_bag max_weight, items
# 	result = {"selectedItems" => []}
# 	maxval = 0
# 	solutions = []
# 	bags = all_possible_bags(items)

# 	bags.each do |possibile_bag|
# 		next if possibile_bag == []
# 		value = 0
# 		weight = 0
# 		possibile_bag.each do |item|
# 			weight += item.weight 
# 			value += item.value 
# 		end
			
# 		next if weight > max_weight

# 		if value == maxval
# 			solutions << possibile_bag
# 		elsif value > maxval
# 			maxval = value
# 			solutions = possibile_bag
# 		end
# 	end
# 	solutions.each do |item|
# 		result["selectedItems"] << {"name" => item.name, "weight" => item.weight, "value" => item.value}
# 	end
# 	result
# end

# def all_possible_bags items
# 	yield [] if block_given?
# 	items.inject([[]]) do |ps, elem|
# 		r = []
# 		ps.each do |i|
# 			r << i
# 			new_subset = i + [elem]
# 			yield new_subset if block_given?
# 			r << new_subset
# 		end
# 		r
# 	end
# end
def best_bag max_weight, items
    result = {"selectedItems" => []}
    value_matrix = fill_matrix_with_zeros(items.length+1, max_weight)
    decision_matrix = fill_matrix_with_zeros(items.length+1, max_weight)  

    for i in 1..items.length
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


file = File.read('test_cases/inputs/sample_input_small_bag.json')
data_hash = JSON.parse(file)
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
puts answer.to_json
