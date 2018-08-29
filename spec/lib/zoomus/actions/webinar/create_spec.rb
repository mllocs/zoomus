# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Webinar do

  before :all do
    @zc = zoom_client
    @args = { host_id: 'AjXQQ36-RxGis5_7In8wZQ',
              topic: 'create webinar via rest api' }
  end

  describe '#webinar_create action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/webinar/create')
      ).to_return(body: json_response('webinar_create'))
    end

    it "requires a 'host_id' argument" do
      expect {
        @zc.webinar_create(filter_key(@args, :host_id))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect {
        @zc.webinar_create(filter_key(@args, :topic))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(@zc.webinar_create(@args)).to be_kind_of(Hash)
    end

    it 'returns the setted params' do
      res = @zc.webinar_create(@args)

      expect(res['host_id']).to eq(@args[:host_id])
      expect(res['topic']).to eq(@args[:topic])
    end

    it "returns 'start_url' and 'join_url'" do
      res = @zc.webinar_create(@args)

      expect(res['start_url']).to_not be_nil
      expect(res['join_url']).to_not be_nil
    end
  end

  describe '#webinar_create! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/webinar/create')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        @zc.webinar_create!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
