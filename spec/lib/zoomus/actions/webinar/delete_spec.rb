require 'spec_helper'

describe Zoomus::Actions::Webinar do

  before :all do
    @zc = zoomus_client
    @args = {:host_id => "ufR93M2pRyy8ePFN92dttq",
             :id => "123456789"}
  end

  describe "#webinar_delete action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/webinar/delete")
      ).to_return(:body => json_response("webinar_delete"))
    end

    it "requires a 'host_id' argument" do
      expect {
        @zc.webinar_delete(filter_key(@args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect {
        @zc.webinar_delete(filter_key(@args, :id))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.webinar_delete(@args)).to be_kind_of(Hash)
    end

    it "returns id and deleted at attributes" do
      res = @zc.webinar_delete(@args)

      expect(res["id"]).to eq(@args[:id])
      expect(res["deleted_at"]).to eq("2012-11-25T12:00:00Z")
    end
  end

  describe "#webinar_delete! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/webinar/delete")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.webinar_delete!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
