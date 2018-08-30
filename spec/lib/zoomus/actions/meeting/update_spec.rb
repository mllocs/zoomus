# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { host_id: 'ufR93M2pRyy8ePFN92dttq', id: '252482092', type: '2' } }

  describe '#meeting_update action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/update')
      ).to_return(body: json_response('meeting', 'update'))
    end

    it "requires a 'host_id' argument" do
      expect { zc.meeting_update(filter_key(args, :host_id)) }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect { zc.meeting_update(filter_key(args, :id)) }.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect { zc.meeting_update(filter_key(args, :type)) }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(zc.meeting_update(args)).to be_kind_of(Hash)
    end

    it 'returns id and updated_at attributes' do
      res = zc.meeting_update(args)

      expect(res['id']).to eq(args[:id])
      expect(res['updated_at']).to eq('2013-02-25T15:52:38Z')
    end
  end

  describe '#meeting_update! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/update')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect { zc.meeting_update!(args) }.to raise_error(Zoom::Error)
    end
  end
end
