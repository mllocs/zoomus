require 'spec_helper'

describe Zoomus::Actions::Report do

  before :all do
    @zc = zoomus_client
    @from = '2013-04-05T15:50:47Z'
    @to = '2013-04-09T19:00:00Z'
    @args = {:from => @from, :to => @to}
  end

  describe "#report_getaccountreport action" do
    before :each do
      stub_request(:post, zoomus_url("/report/getaccountreport")).to_return(:body => json_response("report_getaccountreport"))
    end

    it "requires a 'from' argument" do
      expect{@zc.report_getaccountreport(:to => @to)}.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect{@zc.report_getaccountreport(:from => @from)}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.report_getaccountreport(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.report_getaccountreport(@args)["total_records"]).to eq(1)
    end

    it "returns 'users' Array" do
      expect(@zc.report_getaccountreport(@args)["users"]).to be_kind_of(Array)
    end
  end

  describe "#report_getaccountreport! action" do
    before :each do
      stub_request(:post, zoomus_url("/report/getaccountreport")).
        to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect{ @zc.report_getaccountreport!(@args) }.to raise_error(Zoomus::Error)
    end
  end
end
