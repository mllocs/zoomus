# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do
  let(:zc) { zoom_client }

  describe '#user_list action' do
    context 'with a valid response' do
      before :each do
        stub_request(
          :get,
          zoom_url('/users')
        ).to_return(body: json_response('user', 'list'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'returns a hash' do
        expect(zc.user_list).to be_kind_of(Hash)
      end

      it "returns 'total_records" do
        expect(zc.user_list['total_records']).to eq(1)
      end

      it "returns 'users' Array" do
        expect(zc.user_list['users']).to be_kind_of(Array)
      end

      it 'raises an error when passed an invalid option' do
        expect { zc.user_list(foo: 'bar', status: 'active') }.to raise_error(Zoom::ParameterNotPermitted, [:foo].to_s)
      end
    end

    context 'with a 4xx response' do
      before :each do
        stub_request(
          :get,
          zoom_url('/users')
        ).to_return(status: 404,
                    body: json_response('error', 'not_found'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'raises Zoom::Error exception' do
        expect { zc.user_list }.to raise_error(Zoom::Error)
      end
    end
  end
end
