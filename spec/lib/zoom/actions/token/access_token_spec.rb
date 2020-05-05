# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Token do
  let(:zc) { oauth_client }
  let(:args) { { auth_code: 'xxx', redirect_uri: 'http://localhost:3000' } }

  describe '#access_tokens action' do
    before :each do
      stub_request(
        :post,
        zoom_auth_url('oauth/token')
      ).to_return(body: json_response('token', 'access_token'),
                    headers: { 'Content-Type' => 'application/json' })
    end

    it "requires an error when args missing" do
      expect { zc.access_tokens }.to raise_error(Zoom::ParameterMissing, [:auth_code, :redirect_uri].to_s)
    end

    it 'returns a hash' do
      expect(zc.access_tokens(args)).to be_kind_of(Hash)
    end
  end
end
