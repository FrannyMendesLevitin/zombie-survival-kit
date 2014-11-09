require 'spec_helper'

describe Survival::Post do
    it "POST survival-pack" do	
		file = File.read('test_cases/inputs/sample_input.json')
		data_hash = JSON.parse(file)
        post '/v1/survival-pack/pack', data_hash.to_json, 'Content-Type' => 'application/json'
        expect(response.status).to eq 201
        expect(response.body).to eq File.read('test_cases/outputs/sample_output.json').to_json.gsub('\\t', '').gsub('\\n', '')
    end
    it "POST survival-pack" do	
		file = File.read('test_cases/inputs/sample_input_big_bag.json')
		data_hash = JSON.parse(file)
        post '/v1/survival-pack/pack', data_hash.to_json, 'Content-Type' => 'application/json'
        expect(response.status).to eq 201
        expect(response.body).to eq File.read('test_cases/outputs/sample_output_big_bag.json').to_json.gsub('\\t', '').gsub('\\n', '')
    end
    it "POST survival-pack" do	
		file = File.read('test_cases/inputs/sample_input_no_bag.json')
		data_hash = JSON.parse(file)
        post '/v1/survival-pack/pack', data_hash.to_json, 'Content-Type' => 'application/json'
        expect(response.status).to eq 201
        expect(response.body.gsub(/\s+/, "")).to eq File.read('test_cases/outputs/sample_output_no_bag.json').to_json.gsub('\\t', '').gsub('\\n', '').gsub(/\s+/, "")
    end
end
