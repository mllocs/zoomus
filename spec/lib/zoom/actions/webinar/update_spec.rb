# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client }
  let(:args) { { id: '123456789' } }

  describe '#webinar_update' do
    before :each do
      stub_request(
        :patch,
        zoom_url("/webinars/#{args[:id]}")
      ).to_return(status: 204,
                  body: json_response('webinar', 'update'),
                  headers: {"Content-Type"=> "application/json"})
    end

    it "requires a 'id' argument" do
      expect { zc.webinar_update(filter_key(args, :id)) }.to raise_error(Zoom::ParameterMissing, [:id].to_s)
    end

    it 'returns the http status code as a number' do
      expect(zc.webinar_update(args)).to eql(204)
    end
  end

  describe '#webinar_update!' do
    before :each do
      stub_request(
        :patch,
        zoom_url("/webinars/#{args[:id]}")
      ).to_return(status: 404,
                  body: json_response('error', 'validation'),
                  headers: {"Content-Type"=> "application/json"})
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.webinar_update!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
