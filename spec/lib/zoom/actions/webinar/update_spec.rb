# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::Webinar do

  before :all do
    @zc = zoom_client
    @args = { host_id: 'ufR93M2pRyy8ePFN92dttq',
              id: '123456789' }
  end

  xdescribe '#webinar_update action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/webinar/update')
      ).to_return(body: json_response('webinar_update'))
    end

    it "requires a 'host_id' argument" do
      expect { @zc.webinar_update(filter_key(@args, :host_id)) }.to raise_error(ArgumentError)
    end

    it "requires a 'id' argument" do
      expect { @zc.webinar_update(filter_key(@args, :id)) }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(@zc.webinar_update(@args)).to be_kind_of(Hash)
    end

    it 'returns id and updated_at attributes' do
      res = @zc.webinar_update(@args)

      expect(res['id']).to eq(@args[:id])
      expect(res['updated_at']).to eq('2012-11-25T12:00:00Z')
    end
  end

  xdescribe '#webinar_update! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/webinar/update')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        @zc.webinar_update!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
