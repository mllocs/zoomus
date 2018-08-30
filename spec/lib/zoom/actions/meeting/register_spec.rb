# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { id: 1, email: 'foo@bar.com', first_name: 'Foo', last_name: 'Bar' } }
  let(:join_url) { 'https://www.zoom.us/w/869275230?tk=2DsQiu6nZVsZVATrPLvXgqPvw8mmKyxgAGaDMizLv34.DQEAAAAAM9AWXhZ2Nm5vRjIyMlRoUzE3ZktWM3l4cHVRAA' }

  describe '#meeting_register action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/register')
      ).to_return(body: json_response('meeting', 'register'))
    end

    it 'returns a hash' do
      expect(zc.meeting_register(args)).to be_kind_of(Hash)
    end

    it "returns the created user's unique registrant_id" do
      expect(zc.meeting_register(args)['registrant_id']).to eql('555')
    end

    it 'returns a join_url' do
      expect(zc.meeting_register(args)['join_url']).to eql(join_url)
    end
  end

  describe '#meeting_register! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/register')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.meeting_register!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
