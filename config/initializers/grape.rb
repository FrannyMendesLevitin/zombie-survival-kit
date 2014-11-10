require 'grape/endpoint'

module Grape
  class Endpoint
    def url_helper
      @url_helper ||= ::API::RoutingHelper.new(self)
    end

    # Using brute force solution because my dynamic programming attempt was buggy. Might rewrite more scalable version later.
	def best_bag max_weight, items
		result = {"selectedItems" => []}
		maxval = 0
		solutions = []
		bags = all_possible_bags(items)

		bags.each do |possibile_bag|
			next if possibile_bag == []
			value = 0
			weight = 0
			possibile_bag.each do |item|
				weight += item.weight 
				value += item.value 
			end
			next if weight > max_weight
			if value >= maxval
				maxval = value
				solutions = possibile_bag
			end
		end
		solutions.each do |item|
			puts item.inspect
			result["selectedItems"] << {"name" => item.name, "weight" => item.weight, "value" => item.value}
		end
		result
	end

	# Adapted from Powerset code found on StackOverflow
	def all_possible_bags items
		yield [] if block_given?
		items.inject([[]]) do |ps, elem|
			r = []
			ps.each do |i|
				r << i
				new_subset = i + [elem]
				yield new_subset if block_given?
				r << new_subset
			end
			r
		end
	end

  end
end