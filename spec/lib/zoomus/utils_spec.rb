require 'spec_helper'

describe Zoomus::Utils do

  before(:all) do
    class Utils < Zoomus::Utils; end
  end

  describe "#argument_error" do
    it "raises ArgumentError" do
      expect(Utils.argument_error("foo")).to be_instance_of(ArgumentError)
    end
  end

  describe "#raise_if_error!" do
    it "raises Zoomus::Error if error is present" do
      response = {'error' => { 'message' => 'lol error'}}
      expect{Utils.raise_if_error!(response)}.to raise_error(Zoomus::Error)
    end

    it "does not raise Zoomus::Error if error is not present" do
      response = {}
      expect{Utils.raise_if_error!(response)}.to_not raise_error(Zoomus::Error)
    end
  end

  describe "#require_params" do
    it "raises ArgumentError if the param is not present" do
      expect{Utils.require_params(:foo, {:bar => 'bar'})}.to raise_error(ArgumentError)
    end

    it "does not raise ArgumentError if the param is present" do
      expect{Utils.require_params(:foo, {:foo => 'foo'})}.to_not raise_error(ArgumentError)
    end
  end

  describe "#extract_options!" do
    it "converts array to hash options" do
      args = [{:foo => 'foo'}, {:bar => 'bar'}, {:zemba => 'zemba'}]
      expect(Utils.extract_options!(args)).to be_kind_of(Hash)
    end
  end
end
