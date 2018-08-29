# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Meeting do

  before :all do
    @zc = zoom_client
    @args = { host_id: 'ufR93M2pRyy8ePFN92dttq',
              type: 1,
              topic: 'Foo' }
  end

  describe '#meeting_create action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/meeting/create')
      ).to_return(body: json_response('meeting_create'))
    end

    it "requires a 'host_id' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :topic))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'type' argument" do
      expect {
        @zc.meeting_create(filter_key(@args, :type))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(@zc.meeting_create(@args)).to be_kind_of(Hash)
    end

    it 'returns the setted params' do
      res = @zc.meeting_create(@args)

      expect(res['host_id']).to eq(@args[:host_id])
      expect(res['type']).to eq(@args[:type])
      expect(res['topic']).to eq(@args[:topic])
    end

    it "returns 'start_url' and 'join_url'" do
      res = @zc.meeting_create(@args)

      expect(res['start_url']).to_not be_nil
      expect(res['join_url']).to_not be_nil
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
        @zc.meeting_create!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
