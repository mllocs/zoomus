require 'spec_helper'

describe Zoomus::Actions::Metrics do

  before :all do
    @zc = zoomus_client
    @args = {:from => '2013-04-05T15:50:47Z',
             :to => '2013-04-09T19:00:00Z'}
  end

  describe "#metrics_crc action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/metrics/crc")
      ).to_return(:body => json_response("metrics_crc"))
    end

    it "requires a 'from' argument" do
      expect { @zc.metrics_crc(filter_key(@args, :from)) }.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect { @zc.metrics_crc(filter_key(@args, :to)) }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.metrics_crc(@args)).to be_kind_of(Hash)
    end
  end

  describe "#metrics_crc! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/metrics/crc")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.metrics_crc!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
