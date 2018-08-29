require 'spec_helper'

describe Zoom::Actions::User do

  before :all do
    @zc = zoom_client
    @args = {:id => "eIimBAXqSrWOcB_EOIXTog",
             :first_name => "Bar",
             :last_name => "Foo"}
  end

  describe "#user_update action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/user/update")
      ).to_return(:body => json_response("user_update"))
    end

    it "requires id param" do
      expect{@zc.user_update(filter_key(@args, :id))}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_update(@args)).to be_kind_of(Hash)
    end

    it "returns id and updated_at" do
      res = @zc.user_update(@args)

      expect(res["id"]).to eq(@args[:id])
      expect(res).to have_key("updated_at")
    end
  end

  describe "#user_update! action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/user/update")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.user_update!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
