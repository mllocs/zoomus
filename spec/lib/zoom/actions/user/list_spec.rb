# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::User do
  let(:zc) { zoom_client }

  xdescribe '#user_list action' do
    before :each do
      stub_request(
        :get,
        zoom_url('/users')
      ).to_return(body: json_response('user', 'list'))
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
      expect { zc.user_list(foo: 'bar', status: 'active') }.to raise_error(ArgumentError, 'Unrecognized parameter foo')
    end
  end

  xdescribe '#user_list! action' do
    before :each do
      stub_request(
        :get,
        zoom_url('/users')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.user_list!
      }.to raise_error(Zoom::Error)
    end
  end
end
