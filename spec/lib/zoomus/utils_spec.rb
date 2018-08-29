# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Utils do

  before(:all) do
    class Utils < Zoom::Utils; end
  end

  describe "#argument_error" do
    it "raises ArgumentError" do
      expect(Utils.argument_error("foo")).to be_instance_of(ArgumentError)
    end
  end

  describe "#raise_if_error!" do
    it "raises Zoom::Error if error is present" do
      response = {'error' => { 'message' => 'lol error'}}
      expect{Utils.raise_if_error!(response)}.to raise_error(Zoom::Error)
    end

    it "does not raise Zoom::Error if error is not present" do
      response = {}
      expect{Utils.raise_if_error!(response)}.to_not raise_error
    end
  end

  describe "#require_params" do
    it "raises ArgumentError if the param is not present" do
      expect{Utils.require_params(:foo, {:bar => 'bar'})}.to raise_error(ArgumentError)
    end

    it "does not raise ArgumentError if the param is present" do
      expect{Utils.require_params(:foo, {:foo => 'foo'})}.to_not raise_error
    end
  end

  describe "#extract_options!" do
    it "converts array to hash options" do
      args = [{:foo => 'foo'}, {:bar => 'bar'}, {:zemba => 'zemba'}]
      expect(Utils.extract_options!(args)).to be_kind_of(Hash)
    end
  end

  describe "#process_datetime_params" do
    it "converts the Time objects to formatted strings" do
      args = {
        :foo => 'foo',
        :bar => Time.utc(2000, "jan", 1, 20, 15, 1)
      }
      expect(
        Utils.process_datetime_params!(:bar, args)
      ).to eq({:foo => 'foo',
               :bar => "2000-01-01T20:15:01Z"})
    end
  end

  describe '#define_bang_methods' do
    before :each do
      stub_request(:post, zoom_url("/user/custcreate")).to_timeout
    end

    it "raises Zoom::GatewayTimeout on timeout" do
      args = {:email => "foo@bar.com",
               :first_name => "Foo",
               :last_name => "Bar",
               :type => 1}

      expect { zoom_client.user_custcreate!(args) }.to raise_error(Zoom::GatewayTimeout)
    end
  end
end
