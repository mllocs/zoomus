# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  # let(:args) { { host_id: 'dh23hdu23gd', id: '123456789', meeting_id: '123456789' } }
  let(:args) { {meeting_id: '123456789'} }

  describe '#meeting_end action' do
    before :each do
      stub_request(:put,
        zoom_url("/meetings/#{args[:meeting_id]}/status")
      ).to_return(
        status: 204
      )
    end

    it "requires a 'meeting_id' argument" do
      expect {
        zc.meeting_end(filter_key(args, :meeting_id))
      }.to raise_error(Zoom::ParameterMissing)
    end

    it 'returns a hash' do
      # expect(zc.meeting_end(args)).to be_kind_of(Hash)
      expect(zc.meeting_end(args)).to eq(204)
    end
  end
end
