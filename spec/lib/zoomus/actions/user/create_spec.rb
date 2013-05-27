require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
    @args = {:email => "foo@bar.com",
             :first_name => "Foo",
             :last_name => "Bar",
             :type => 1}
  end

  describe "#user_create action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/create")
      ).to_return(:body => json_response("user_create"))
    end

    it "requires email param" do
      expect{@zc.user_create(filter_key(@args, :email))}.to raise_error(ArgumentError)
    end

    it "requires type param" do
      expect{@zc.user_create(filter_key(@args, :type))}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_create(@args)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_create(@args)

      expect(res["email"]).to eq(@args[:email])
      expect(res["first_name"]).to eq(@args[:first_name])
      expect(res["last_name"]).to eq(@args[:last_name])
      expect(res["type"]).to eq(@args[:type])
    end
  end

  describe "#user_create! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/create")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.user_create!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
