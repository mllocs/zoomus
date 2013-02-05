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

    it "returns 'total_records" do
      expect(@zc.user_list["total_records"]).to eq(1)
    end

    it "returns 'users' Array" do
      expect(@zc.user_list["users"]).to be_kind_of(Array)
    end
  end

  describe "#user_create action" do
    before :each do
      stub_request(:post, zoomus_url("/user/create")).to_return(:body => json_response("user_create"))
    end

    it "requires email param" do
      expect{@zc.user_create(:type => "foo@bar.com")}.to raise_error(ArgumentError)
    end

    it "requires type param" do
      expect{@zc.user_create(:email => "foo@bar.com")}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.user_create(:email => "foo@bar.com", 
                             :first_name => "Foo", 
                             :last_name => "Bar", 
                             :type => 1)).to be_kind_of(Hash)
    end

    it "returns same params" do
      res = @zc.user_create(:email => "foo@bar.com", 
                            :first_name => "Foo", 
                            :last_name => "Bar", 
                            :type => 1)

      expect(res["email"]).to eq("foo@bar.com")
      expect(res["first_name"]).to eq("Foo")
      expect(res["last_name"]).to eq("Bar")
      expect(res["type"]).to eq(1)
    end

  end
end
