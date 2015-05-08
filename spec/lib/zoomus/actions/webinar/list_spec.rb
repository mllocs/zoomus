require 'spec_helper'

describe Zoomus::Actions::Webinar do

  before :all do
    @zc = zoomus_client
    @args = {:host_id => "ufR93M2pRyy8ePFN92dttq"}
  end

  describe "#webinar_list action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/webinar/list")
      ).to_return(:body => json_response("webinar_list"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.webinar_list}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.webinar_list(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.webinar_list(@args)["total_records"]).to eq(2)
    end

    it "returns 'webinars' Array" do
      expect(@zc.webinar_list(@args)["webinars"]).to be_kind_of(Array)
    end
  end

  describe "#webinar_list! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/webinar/list")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.webinar_list!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
