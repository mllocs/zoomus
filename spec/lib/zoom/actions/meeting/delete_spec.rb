# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { host_id: 'ufR93M2pRyy8ePFN92dttq', id: '252482092' } }

  xdescribe '#meeting_delete action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/delete')
      ).to_return(body: json_response('meeting', 'delete'))
    end

    it "requires a 'host_id' argument" do
      expect {
        zc.meeting_delete(filter_key(args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect {
        zc.meeting_delete(filter_key(args, :id))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(zc.meeting_delete(args)).to be_kind_of(Hash)
    end

    it 'returns id and deleted at attributes' do
      res = zc.meeting_delete(args)

      expect(res['id']).to eq(args[:id])
      expect(res['deleted_at']).to eq('2013-04-05T15:50:47Z')
    end
  end

  xdescribe '#meeting_delete! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/delete')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.meeting_delete!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
