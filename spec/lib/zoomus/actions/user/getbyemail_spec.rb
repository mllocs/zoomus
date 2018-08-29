require 'spec_helper'

describe Zoom::Actions::User do

  before :all do
    @zc = zoomus_client
    @args = {:email => "foo@bar.com",
             :login_type => 99}
  end

  describe "#user_getbyemail action" do
    before :each do
      stub_request(:post, zoomus_url("/user/getbyemail")).to_return(:body => json_response("user_getbyemail"))
    end

    it "requires email param" do
      expect{@zc.user_getbyemail(filter_key(@args, :email))}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_getbyemail(@args)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_getbyemail(@args)

      expect(res).to have_key("id")
      expect(res).to have_key("first_name")
      expect(res).to have_key("last_name")
      expect(res["email"]).to eq(@args[:email])
      expect(res["type"]).to eq(@args[:login_type])
    end
  end

  describe "#user_getbyemail! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/getbyemail")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.user_getbyemail!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
