require 'spec_helper'

describe Zoomus::Client do

  describe "default attributes" do
    it "must include httparty methods" do
      expect(Zoomus::Client).to include(HTTParty)
    end

    it "must have the base url set to Zoomus API endpoint" do
      expect(Zoomus::Client.base_uri).to eq('https://api.zoom.us/v2')
    end

    it "must have a default timeout set to 15 seconds" do
      Zoomus.configure do |config|
        config.api_key = 'xxx'
        config.api_secret = 'xxx'
      end
      Zoomus.new
      expect(Zoomus::Client.default_options[:timeout]).to eq(15)
    end

    it "must get the timeout from the configuration" do
      Zoomus.configure do |config|
        config.api_key = 'xxx'
        config.api_secret = 'xxx'
        config.timeout = 20
      end
      Zoomus.new
      expect(Zoomus::Client.default_options[:timeout]).to eq(20)
    end
  end

  describe "constructor" do
    it "requires api_key and api_secret for a new instance" do
      expect{Zoomus::Client.new(:api_key => "xxx")}.to raise_error(ArgumentError)
    end

    it "creates instance of Zoomus::Client if api_key and api_secret is provided" do
      expect(Zoomus::Client.new(:api_key => "xxx", :api_secret => "xxx", :timeout => 15)).to be_an_instance_of(Zoomus::Client)
    end
  end
end
