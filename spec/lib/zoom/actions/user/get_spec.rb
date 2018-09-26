# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do
  let(:zc) { zoom_client }
  let(:args) { { id: 'ufR9342pRyf8ePFN92dttQ' } }

  describe '#user_get action' do
    before :each do
      stub_request(
        :get,
        zoom_url("/users/#{args[:id]}")
        ).to_return(body: json_response('user', 'get'))
    end

    it 'requires id param' do
      expect { zc.user_get(filter_key(args, :id)) }.to raise_error(Zoom::ParameterMissing, 'id')
    end

    it 'returns a hash' do
      expect(zc.user_get(args)).to be_kind_of(Hash)
    end

    it 'returns same params' do
      res = zc.user_get(args)

      expect(res['id']).to eq(args[:id])
      expect(res).to have_key('first_name')
      expect(res).to have_key('last_name')
      expect(res).to have_key('email')
      expect(res).to have_key('type')
    end
  end

  xdescribe '#user_get! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/user/get')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.user_get!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
