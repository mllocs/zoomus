# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client }
  let(:args) { { user_id: 'ufR93M2pRyy8ePFN92dttq' } }

  describe '#webinar_list action' do
    before :each do
      stub_request(
        :get,
        zoom_url("/users/#{args[:user_id]}/webinars")
      ).to_return(body: json_response('webinar', 'list'))
    end

    it "requires a 'host_id' argument" do
      expect { zc.webinar_list }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(zc.webinar_list(args)).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(zc.webinar_list(args)['total_records']).to eq(1)
    end

    it "returns 'webinars' Array" do
      expect(zc.webinar_list(args)['webinars']).to be_kind_of(Array)
    end
  end

  describe '#webinar_list! action' do
    before :each do
      stub_request(
        :get,
        zoom_url("/users/#{args[:user_id]}/webinars")
      ).to_return(body: json_response('error', 'validation'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.webinar_list!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
