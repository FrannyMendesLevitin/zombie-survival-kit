require 'spec_helper'

describe Survival::Post do
	file = File.read('sample_input.json')
	data_hash = JSON.parse(file)
    it "POST survival-pack" do
        post '/v1/survival-pack/pack', data_hash.to_json, 'Content-Type' => 'application/json'
        expect(response.status).to eq 201
        expect(response.body).to eq File.read('sample_output.json').to_json.gsub('\\t', '').gsub('\\n', '')
    end
end
