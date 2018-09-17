# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::Recording do

  before :all do
    @zc = zoom_client
    @args = {
      meeting_id: 'ucc69C82Q5mTNyCRWE29Aw=='
    }
  end

  xdescribe '#recording_get action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/recording/get')
      ).to_return(body: json_response('recording_get'))
    end

    it "requires a 'meeting_id' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :meeting_id))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(@zc.recording_get(@args)).to be_kind_of(Hash)
    end

    it 'returns id and attributes' do
      res = @zc.recording_get(@args)

      expect(res['uuid']).to eq(@args[:meeting_id])
      expect(res['meeting_number']).to eq(933560800)
      expect(res['host_id']).to eq('kEFomHcIRgqxZT8D086O6A')
      expect(res['account_id']).to eq('NyEqCEoYSNOr4jLMHoO2tA')
      expect(res['topic']).to eq('vgfdsffdfdsf s3423432')
      expect(res['start_time']).to eq('2015-04-13T01:06:04Z')
      expect(res['timezone']).to eq('UTC')
      expect(res['duration']).to eq(1)
      expect(res['total_size']).to eq(686496)
      expect(res['recording_count']).to eq(3)
    end

    it "returns 'recording_files' Array" do
      expect(@zc.recording_get(@args)['recording_files']).to be_kind_of(Array)
    end
  end

  xdescribe '#recording_get! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/recording/get')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        @zc.recording_get!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
