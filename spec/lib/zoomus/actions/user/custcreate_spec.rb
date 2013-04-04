require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
  end

  describe "#user_custcreate action" do
    before :each do
      stub_request(:post, zoomus_url("/user/custcreate")).to_return(:body => json_response("user_custcreate"))
    end

    it "requires email param" do
      expect{@zc.user_custcreate(:type => 1, :password => "lolcat")}.to raise_error(ArgumentError)
    end

    it "requires type param" do
      expect{@zc.user_custcreate(:email => "foo@bar.com", :password => "lolcat")}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_custcreate(:email => "foo@bar.com",
                                 :first_name => "Foo",
                                 :last_name => "Bar",
                                 :password => "lolcat",
                                 :type => 1)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_custcreate(:email => "foo@bar.com",
                                :first_name => "Foo",
                                :last_name => "Bar",
                                :password => "lolcat",
                                :type => 1)

      expect(res["email"]).to eq("foo@bar.com")
      expect(res["first_name"]).to eq("Foo")
      expect(res["last_name"]).to eq("Bar")
      expect(res["type"]).to eq(1)
    end
  end
end
