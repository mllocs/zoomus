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

  describe "#meeting_list action" do
    before :each do
      stub_request(:post, zoomus_url("/meeting/create")).to_return(:body => json_response("meeting_create"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.meeting_create(:type => 1, :topic => "Foo")}.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect{@zc.meeting_create(:host_id => 1, :type => "Foo")}.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect{@zc.meeting_create(:host_id => 1, :topic => "Foo")}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.meeting_create(:host_id => @host_id,
                                :type => 1,
                                :topic => "Foo")).to be_kind_of(Hash)
    end

    it "returns the setted params" do
      res = @zc.meeting_create(:host_id => @host_id,
                               :type => 1,
                               :topic => "Foo")

      expect(res["host_id"]).to eq(@host_id)
      expect(res["type"]).to eq(1)
      expect(res["topic"]).to eq("Foo")
    end

    it "returns 'start_url' and 'join_url'" do
      res = @zc.meeting_create(:host_id => @host_id,
                               :type => 1,
                               :topic => "Foo")

      expect(res["start_url"]).to_not be_nil
      expect(res["join_url"]).to_not be_nil
    end
  end
end

