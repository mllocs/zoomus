require 'spec_helper'

describe Zoomus::Actions::Meeting do

  before :all do
    @zc = zoomus_client
    @host_id = "ufR93M2pRyy8ePFN92dttq"
    @id = "252482092"
  end

  describe "#meeting_update action" do
    before :each do
      stub_request(:post, zoomus_url("/meeting/update")).to_return(:body => json_response("meeting_update"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.meeting_update(:id => @id, :type => 1, :topic => "Foo")}.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect{@zc.meeting_update(:id => @id, :host_id => @host_id, :type => "Foo")}.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect{@zc.meeting_update(:id => @id, :host_id => @host_id, :topic => "Foo")}.to raise_error(ArgumentError)
    end

    it "requires a 'meeting id' argument" do
      expect{@zc.meeting_update(:host_id => @host_id, :topic => "Foo", :type => 1)}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.meeting_update(:host_id => @host_id,
                                :id => @id,
                                :type => 1,
                                :topic => "Foo")).to be_kind_of(Hash)
    end

    it "returns id and updated_at attributes" do
      res = @zc.meeting_update(:host_id => @host_id,
                               :id => @id,
                               :type => 1,
                               :topic => "Foo")

      expect(res["id"]).to eq(@id)
      expect(res["updated_at"]).to eq("2013-02-25T15:52:38Z")
    end
  end
end
