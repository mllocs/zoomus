# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do

  before :all do
    @zc = zoom_client
    @args = { }
  end

  describe '#meeting_live action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/live')
      ).to_return(body: json_response('meeting_live'))
    end

    it 'returns a hash' do
      expect(@zc.meeting_live(@args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(@zc.meeting_live(@args)['total_records']).to eq(235)
    end

    it "returns 'meetings' Array" do
      expect(@zc.meeting_live(@args)['meetings']).to be_kind_of(Array)
    end
  end

  describe '#meeting_live! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/live')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        @zc.meeting_live!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
