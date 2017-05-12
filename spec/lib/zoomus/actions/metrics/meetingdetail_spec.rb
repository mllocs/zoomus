require 'spec_helper'

describe Zoomus::Actions::Metrics do

  before :all do
    @zc = zoomus_client
    @args = {
      :type => "2",
      :meeting_id => "qOQjMWA4SFKbwZnrAzviWw=="
    }
  end

  describe "#metrics_meetingdetail action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/metrics/meetingdetail")
      ).to_return(:body => json_response("metrics_meetingdetail"))
    end

    it "requires a 'meeting_id' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :meeting_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :type))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.metrics_meetingdetail(@args)).to be_kind_of(Hash)
    end

    it "returns id and attributes" do
      res = @zc.metrics_meetingdetail(@args)

      expect(res["uuid"]).to eq(@args[:meeting_id])
      expect(res["start_time"]).to eq("2017-05-11T13:26:15Z")
      expect(res["end_time"]).to eq("2017-05-11T13:29:28Z")
      expect(res["duration"]).to eq("4mins")
      expect(res["participants"].size).to eq(2)
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
