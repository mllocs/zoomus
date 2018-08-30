require 'spec_helper'

describe Zoom::Actions::User do

  before :all do
    @zc = zoom_clients
    @args = {email: "foo@bar.com",
             password: "somepassword123",
             first_name: "Foo",
             last_name: "Bar",
             type: 1}
  end

  describe "#user_autocreate2 action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/autocreate2")
      ).to_return(:body => json_response("user_autocreate")) # the api for autocreate2 is basically all the same
    end

    it "requires email param" do
      expect{@zc.user_autocreate2(filter_key(@args, :email))}.to raise_error(ArgumentError)
    end

    it "requires type param" do
      expect{@zc.user_autocreate2(filter_key(@args, :type))}.to raise_error(ArgumentError)
    end

    it "requires password param" do
      expect{@zc.user_autocreate2(filter_key(@args, :password))}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_autocreate2(@args)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_autocreate2(@args)

      expect(res["email"]).to eq(@args[:email])
      expect(res["first_name"]).to eq(@args[:first_name])
      expect(res["last_name"]).to eq(@args[:last_name])
      expect(res["type"]).to eq(@args[:type])
    end
  end

  describe "#user_autocreate2! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/autocreate2")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.user_autocreate2!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end