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

    it "raises an error when args missing" do
      expect { zc.access_tokens }.to raise_error(Zoom::ParameterMissing, [:code, :redirect_uri].to_s)
    end

    it 'returns a hash' do
      expect(zc.access_tokens(args)).to be_kind_of(Hash)
    end

    it 'passes args in the body' do
      # allow(Zoom::Actions).to receive(:post).with(
      #   '/oauth/token?grant_type=authorization_code',
      #   { code: 'xxx', redirect_uri: 'http://localhost:3000' }
      # )
      # zc.access_tokens(args)
      expect(Zoom::Actions).to receive(:post).with(
        '/oauth/token?grant_type=authorization_code',
        { body: { code: 'xxx', redirect_uri: 'http://localhost:3000' } }
      )
      zc.access_tokens(args)
    end
  end
end
