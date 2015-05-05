require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
  end

  describe "#user_pending action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/pending")
      ).to_return(:body => json_response("user_pending"))
    end

    it "returns a hash" do
      expect(@zc.user_pending).to be_kind_of(Hash)
    end

    it "returns 'total_records" do
      expect(@zc.user_pending["total_records"]).to eq(235)
    end

    it "returns 'users' Array" do
      expect(@zc.user_pending["users"]).to be_kind_of(Array)
    end
  end

  describe "#user_pending! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/pending")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.user_pending!
      }.to raise_error(Zoomus::Error)
    end
  end
end
