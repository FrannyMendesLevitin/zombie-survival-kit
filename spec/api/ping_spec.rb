require 'spec_helper'

describe Survival::Ping do
  it 'ping' do
    get '/v1/survival-pack/ping'
    expect(response.body).to eq({ ping: 'pong' }.to_json)
  end
  it 'ping with a parameter' do
    get '/v1/survival-pack/ping?pong=test'
    expect(response.body).to eq({ ping: 'test' }.to_json)
  end
end
