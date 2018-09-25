# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Zoom::Actions::Webinar do
  let(:zc) { zoom_client }
  let(:args) do
    { user_id: 'test_user_id',
      topic: 'create webinar via rest api' }
  end

  describe '#webinar_create action' do
    before :each do
      stub_request(
        :post,
        zoom_url("/users/#{args[:user_id]}/webinars")
      ).to_return(body: json_response('webinar', 'create'))
    end

    it "requires a 'host_id' argument" do
      expect { zc.webinar_create(filter_key(args, :user_id)) }.to raise_error(ArgumentError)
    end

    it "requires a 'topic' argument" do
      expect { zc.webinar_create(filter_key(args, :topic)) }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(zc.webinar_create(args)).to be_kind_of(Hash)
    end

    it 'returns the setted params' do
      res = zc.webinar_create(args)

      expect(res['host_id']).to eq(args[:user_id])
      expect(res['topic']).to eq(args[:topic])
    end

    it "returns 'start_url' and 'join_url'" do
      res = zc.webinar_create(args)

      expect(res['start_url']).to_not be_nil
      expect(res['join_url']).to_not be_nil
    end
  end

  describe '#webinar_create! action' do
    before :each do
      stub_request(
        :post,
        zoom_url("/users/#{args[:user_id]}/webinars")
      ).to_return(body: json_response('error', 'validation'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.webinar_create!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
