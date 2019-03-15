require 'spec_helper'

describe Zoomus::Actions::Report do

  before :all do
    @zc = zoomus_client
    @args = {:from => '2013-04-05T15:50:47Z',
             :to => '2013-04-09T19:00:00Z'}
  end

  describe "#report_getaudioreport action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/report/getaudioreport")
      ).to_return(:body => json_response("report_getaudioreport"))
    end

    it "requires a 'from' argument" do
      expect {
        @zc.report_getaudioreport(filter_key(@args, :from))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect {
        @zc.report_getaudioreport(filter_key(@args, :to))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.report_getaudioreport(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.report_getaudioreport(@args)["total_records"]).to eq(1)
    end

    it "returns 'telephony_usage' Array" do
      expect(@zc.report_getaudioreport(@args)["telephony_usage"]).to be_kind_of(Array)
    end
  end

  describe "#report_getaudioreport! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/report/getaudioreport")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.report_getaudioreport!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
