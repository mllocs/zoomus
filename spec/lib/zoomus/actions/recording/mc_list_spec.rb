require 'spec_helper'

describe Zoom::Actions::Recording do

  before :all do
    @zc = zoomus_client
    @args = {:host_id => "kEFomHcIRgqxZT8D086O6A"}
  end

  describe "#mc_recording_list action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/mc/recording/list")
      ).to_return(:body => json_response("mc_recording_list"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.mc_recording_list}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.mc_recording_list(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.mc_recording_list(@args)["total_records"]).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(@zc.mc_recording_list(@args)["meetings"]).to be_kind_of(Array)
    end
  end

  describe "#mc_recording_list! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/mc/recording/list")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.mc_recording_list!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
