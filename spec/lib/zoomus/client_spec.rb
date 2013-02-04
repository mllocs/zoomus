require 'spec_helper'

describe Zoomus::Client do

  describe "default attributes" do
    it "must include httparty methods" do
      expect(Zoomus::Client).to include(HTTParty)
    end

    it "must have the base url set to Zoomus API endpoint" do
      expect(Zoomus::Client.base_uri).to eq('https://api.zoom.us/v1')
    end
  end

  describe "constructor" do
    it "requires api_key and api_secret for a new instance" do
      expect{Zoomus::Client.new(:api_key => "xxx")}.to raise_error(ArgumentError)
    end

    it "creates instance of Zoomus::Client if api_key and api_secret is provided" do
      expect(Zoomus::Client.new(:api_key => "xxx", :api_secret => "xxx")).to be_an_instance_of(Zoomus::Client)
    end
  end
end