require 'spec_helper'

describe Zoom::Actions::Metrics do

  before :all do
    @zc = zoom_client
    @args = {:type => 1,
             :from => '2013-04-05T15:50:47Z',
             :to => '2013-04-09T19:00:00Z'}
  end

  describe "#metrics_meetings action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/metrics/meetings")
      ).to_return(:body => json_response("metrics_meetings"))
    end

    it "requires a 'type' argument" do
      expect { @zc.metrics_meetings(filter_key(@args, :type)) }.to raise_error(ArgumentError)
    end

    it "requires a 'from' argument" do
      expect { @zc.metrics_meetings(filter_key(@args, :from)) }.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect { @zc.metrics_meetings(filter_key(@args, :to)) }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.metrics_meetings(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.metrics_meetings(@args)["total_records"]).to eq(1)
    end

    it "returns 'meetings' Array" do
      expect(@zc.metrics_meetings(@args)["meetings"]).to be_kind_of(Array)
    end
  end

  describe "#metrics_meetings! action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/metrics/meetings")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.metrics_meetings!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
