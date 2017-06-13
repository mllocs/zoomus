require 'spec_helper'

describe Zoomus::Actions::Metrics do

  before :all do
    @zc = zoomus_client
    @args = { meeting_id: 't13b6hjVQXybvGKyeHC96w==', type: 1 }
  end

  describe "#metrics_meetingdetail action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/metrics/meetingdetail")
      ).to_return(:body => json_response("metrics_meetingdetail"))
    end

    it "requires a 'meeting_id' argument" do
      expect { @zc.metrics_meetingdetail(filter_key(@args, :meeting_id)) }.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect { @zc.metrics_meetingdetail(filter_key(@args, :type)) }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.metrics_meetingdetail(@args)).to be_kind_of(Hash)
    end

    it "returns 'participants' Array" do
      expect(@zc.metrics_meetingdetail(@args)["participants"]).to be_kind_of(Array)
    end
  end

  describe "#metrics_meetingdetail! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/metrics/meetingdetail")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.metrics_meetingdetail!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
