require 'grape/endpoint'

module Grape
  class Endpoint
    def url_helper
      @url_helper ||= ::API::RoutingHelper.new(self)
    end

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
		best_weight = 0
		best_value = 0
		all_possible_bags(items).each do |possibilities|
			possibility_weight = 0
			possibility_value = 0
			started = false
			possibilities.each do |possibility|
				next unless started
				started = true;
				possibility.each { |weight| possibility_weight += weight[1].weight || 0 }
				possibility.each { |value| possibility_value += value[2].value || 0 }
				if possibility_value > best_value and possibility_weight <= max_weight
					best_value = possibility_value
					best_weight = possibility_weight
					result["selectedItems"] = possibilities
				end
			end
		end
		result
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