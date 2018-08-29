# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Report do

  before :all do
    @zc = zoom_client
    @args = {:from => '2013-04-05T15:50:47Z',
             :to => '2013-04-09T19:00:00Z',
             :user_id => 'ufR93M2pRyy8ePFN92dttq'}
  end

  describe "#report_getuserreport action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/report/getuserreport")
      ).to_return(:body => json_response("report_getuserreport"))
    end

    it "requires a 'user_id' argument" do
      expect {
        @zc.report_getuserreport(filter_key(@args, :user_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'from' argument" do
      expect {
        @zc.report_getuserreport(filter_key(@args, :from))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect {
        @zc.report_getuserreport(filter_key(@args, :to))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.report_getuserreport(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.report_getuserreport(@args)["total_records"]).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(@zc.report_getuserreport(@args)["meetings"]).to be_kind_of(Array)
    end
  end

  describe "#report_getuserreport! action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/report/getuserreport")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.report_getuserreport!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
