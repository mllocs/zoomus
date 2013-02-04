require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
  end

  describe "#user_list action" do

    before :each do
      stub_request(:post, zoomus_url("/user/list")).to_return(:body => json_response("user_list"))
    end

    it "returns a hash" do
      expect(@zc.user_list).to be_kind_of(Hash)
    end

    it "returns 'page_count'" do
      expect(@zc.user_list["page_count"]).to eq(1)
    end

    it "returns 'users' Array" do
      expect(@zc.user_list["users"]).to be_kind_of(Array)
    end

  end
end
