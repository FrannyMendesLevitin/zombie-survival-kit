require 'spec_helper'

describe Survival::Post do
  [true, false].each do |reticulated|
    it "POST #{reticulated ? 'reticulated' : 'unreticulated' } spline" do
      post '/v1/survival-pack/spline', { 'reticulated' => reticulated }.to_json, 'Content-Type' => 'application/json'
      expect(response.status).to eq 201
      expect(response.body).to eq({ 'reticulated' => reticulated }.to_json)
    end
  end

end
