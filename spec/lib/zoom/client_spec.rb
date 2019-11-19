# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Client do

  describe 'default attributes' do
    it 'must include httparty methods' do
      expect(Zoom::Client).to include(HTTParty)
      expect(Zoom::Clients::JWT).to include(HTTParty)
    end

    it 'must have the base url set to Zoom API endpoint' do
      expect(Zoom::Client.base_uri).to eq('https://api.zoom.us/v2')
    end

    it 'must have a default timeout set to 15 seconds' do
      Zoom.configure do |config|
        config.api_key = 'xxx'
        config.api_secret = 'xxx'
      end
      Zoom.new
      expect(Zoom::Clients::JWT.default_options[:timeout]).to eq(15)
    end

    it 'must get the timeout from the configuration' do
      Zoom.configure do |config|
        config.api_key = 'xxx'
        config.api_secret = 'xxx'
        config.timeout = 20
      end
      Zoom.new
      expect(Zoom::Clients::JWT.default_options[:timeout]).to eq(20)
    end
  end

  describe 'JWT client' do
    let(:client) {
      Zoom::Clients::JWT.new(api_key: 'xxx', api_secret: 'xxx', timeout: 15)
    }
    it 'requires api_key and api_secret for a new instance' do
      expect { Zoom::Clients::JWT.new(api_key: 'xxx') }.to raise_error(ArgumentError)
      expect { Zoom::Clients::JWT.new(api_key: 'xxx', api_secret: 'xxx') }.to raise_error(ArgumentError)
    end

    it 'creates instance of Zoom::Client if api_key and api_secret is provided' do
      expect(client).to be_kind_of(Zoom::Client)
    end

    it 'has the bearer token in the auth header' do
      fake_token = 'NotTheRealToken'
      allow(client).to receive(:access_token) {fake_token}
      expect(client.request_headers['Authorization']).to eq("Bearer #{fake_token}")
    end

  end

  describe "oauth client" do
    let(:access_token) {'xxx'}
    let(:client) {
      Zoom::Clients::OAuth.new(access_token: access_token, timeout: 30)
    }
    it 'requires an access token' do
      expect { Zoom::Clients::JWT.new(timeout: 30) }.to raise_error(ArgumentError)
      expect { Zoom::Clients::JWT.new(access_token: access_token) }.to raise_error(ArgumentError)
    end

    it 'creates instance of Zoom::Client if api_key and api_secret is provided' do
      expect(client).to be_kind_of(Zoom::Client)
    end

    it 'has the bearer token in the auth header' do
      expect(client.request_headers['Authorization']).to eq("Bearer #{access_token}")
    end
  end
end
