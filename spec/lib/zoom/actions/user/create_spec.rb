# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do
  let(:zc) { zoom_client }
  before :all do
    @args = { email: 'foo@bar.com',
              first_name: 'Foo',
              last_name: 'Bar',
              type: 1 }
  end

  describe '#user_create action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/users')
      ).to_return(body: json_response('user', 'create'))
    end

    # it 'requires email param' do
    #   expect { zc.user_create(filter_key(@args, :email)) }.to raise_error(ArgumentError)
    # end

    # it 'requires type param' do
    #   expect { zc.user_create(filter_key(@args, :type)) }.to raise_error(ArgumentError)
    # end

    it 'returns a hash' do
      binding.pry
      expect(zc.user_create(@args)).to be_kind_of(Hash)
    end

    it 'returns same params' do
      res = zc.user_create(@args)

      expect(res['email']).to eq(@args[:email])
      expect(res['first_name']).to eq(@args[:first_name])
      expect(res['last_name']).to eq(@args[:last_name])
      expect(res['type']).to eq(@args[:type])
    end
  end

  describe '#user_create! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/user/create')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.user_create!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
