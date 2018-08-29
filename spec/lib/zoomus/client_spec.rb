# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Client do

  describe 'default attributes' do
    it 'must include httparty methods' do
      expect(Zoom::Client).to include(HTTParty)
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
      expect(Zoom::Client.default_options[:timeout]).to eq(15)
    end

    it 'must get the timeout from the configuration' do
      Zoom.configure do |config|
        config.api_key = 'xxx'
        config.api_secret = 'xxx'
        config.timeout = 20
      end
      Zoom.new
      expect(Zoom::Client.default_options[:timeout]).to eq(20)
    end
  end

  describe 'constructor' do
    it 'requires api_key and api_secret for a new instance' do
      expect { Zoom::Client.new(api_key: 'xxx') }.to raise_error(ArgumentError)
    end

    it 'creates instance of Zoom::Client if api_key and api_secret is provided' do
      expect(Zoom::Client.new(api_key: 'xxx', api_secret: 'xxx', timeout: 15)).to be_an_instance_of(Zoom::Client)
    end
  end
end
