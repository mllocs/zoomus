# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client}
  let(:args) { { id: '123456789' } }

  describe '#webinar_delete' do
    before :each do
      stub_request(
        :delete,
        zoom_url("/webinars/#{args[:id]}")
      ).to_return(status: 204, body: json_response('webinar', 'delete'))
    end

    it "requires a 'id' argument" do
      expect { zc.webinar_delete(filter_key(args, :id)) }.to raise_error(Zoom::ParameterMissing, [:id].to_s)
    end

    it 'returns the http status code as a number' do
      expect(zc.webinar_delete(args)).to be_kind_of(Integer)
    end
  end

  describe '#webinar_delete!' do
    before :each do
      stub_request(
        :delete,
        zoom_url("/webinars/#{args[:id]}")
      ).to_return(body: json_response('error', 'validation'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.webinar_delete!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
