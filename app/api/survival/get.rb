module Survival
  class Get < Grape::API
    format :json
    desc 'Gets list of available objects.'
    get :available do
		file = File.read('test_cases/inputs/sample_input.json')
    end
  end
end
