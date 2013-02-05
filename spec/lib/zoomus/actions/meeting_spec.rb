require 'spec_helper'

describe Zoomus::Actions::Meeting do

  before :all do
    @zc = zoomus_client
  end

  describe "#meeting_list action" do

    before :each do
      stub_request(:post, zoomus_url("/meeting/list")).to_return(:body => json_response("meeting_list"))
    end

    it "returns a hash" do
      expect(@zc.meeting_list).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.meeting_list["total_records"]).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(@zc.meeting_list["meetings"]).to be_kind_of(Array)
    end

  end
end

