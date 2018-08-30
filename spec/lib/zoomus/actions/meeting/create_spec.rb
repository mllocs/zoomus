# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do
  let(:zc) { zoom_client }
  let(:args) { { host_id: 'ufR93M2pRyy8ePFN92dttq', type: 2, topic: 'Foo' } }
  let(:response) { zc.meeting_create(args) }

  describe '#meeting_create action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/create')
      ).to_return(body: json_response('meeting','create'))
    end

    it "requires a 'host_id' argument" do
      expect {
        zc.meeting_create(filter_key(args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect {
        zc.meeting_create(filter_key(args, :topic))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect {
        zc.meeting_create(filter_key(args, :type))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(response).to be_kind_of(Hash)
    end

    it 'returns the set params' do
      expect(response['host_id']).to eq(args[:host_id])
      expect(response['type']).to eq(args[:type])
      expect(response['topic']).to eq(args[:topic])
    end

    it "returns 'start_url' and 'join_url'" do
      expect(response['start_url']).to_not be_nil
      expect(response['join_url']).to_not be_nil
    end
  end

  describe '#meeting_create! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/create')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.meeting_create!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
