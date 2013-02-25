require 'spec_helper'

describe Zoomus::Actions::Meeting do

  before :all do
    @zc = zoomus_client
    @host_id = "ufR93M2pRyy8ePFN92dttq"
  end

  describe "#meeting_list action" do
    before :each do
      stub_request(:post, zoomus_url("/meeting/list")).to_return(:body => json_response("meeting_list"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.meeting_list()}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.meeting_list(:host_id => @host_id)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.meeting_list(:host_id => @host_id)["total_records"]).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(@zc.meeting_list(:host_id => @host_id)["meetings"]).to be_kind_of(Array)
    end
  end
end
