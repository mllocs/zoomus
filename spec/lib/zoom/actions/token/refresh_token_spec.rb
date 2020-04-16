# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Token do
  let(:zc) { oauth_client }
  let(:args) { { refresh_token: 'xxx' } }

  describe '#refresh_tokens action' do
    before :each do
      stub_request(
        :post,
        zoom_auth_url('oauth/token')
      ).to_return(body: json_response('token', 'refresh_token'),
                    headers: { 'Content-Type' => 'application/json' })
    end

    it "requires an error when args missing" do
      expect { zc.refresh_tokens }.to raise_error(Zoom::ParameterMissing, [:refresh_token].to_s)
    end

    it 'returns a hash' do
      expect(zc.refresh_tokens(args)).to be_kind_of(Hash)
    end
  end
end
