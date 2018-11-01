# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::User do
  let(:zc) { zoom_client }
  let(:args) do
    { action: 'create',
      email: 'foo@bar.com',
      first_name: 'Zoomie',
      last_name: 'Userton',
      type: 1,
      password: 'testerino' }
  end

  describe '#user_create' do
    context 'with 201 response' do
      before :each do
        stub_request(
          :post,
          zoom_url('/users')
        ).to_return(status: 201,
                    body: json_response('user', 'create'),
                    headers: {"Content-Type"=> "application/json"})
      end

      it 'requires action param' do
        expect { zc.user_create(filter_key(args, :action)) }.to raise_error(Zoom::ParameterMissing, [:action].to_s)
      end

      it 'does not raise an error when action is create' do
        args[:action] = 'create'
        expect { zc.user_create(args) }.not_to raise_error
      end

      it 'does not raise an error when action is custCreate' do
        args[:action] = 'custCreate'
        expect { zc.user_create(args) }.not_to raise_error
      end

      it 'does not raise an error when action is autoCreate' do
        args[:action] = 'autoCreate'
        expect { zc.user_create(args) }.not_to raise_error
      end

      it 'does not raise an error when action is ssoCreate' do
        args[:action] = 'ssoCreate'
        expect { zc.user_create(args) }.not_to raise_error
      end

      it 'requires valid action' do
        args[:action] = 'baz'
        expect { zc.user_create(args) }.to raise_error(Zoom::ParameterValueNotPermitted, "#{:action.to_s}: #{args[:action].to_s}")
      end

      it 'requires email param' do
        expect { zc.user_create(filter_key(args, :email)) }.to raise_error(Zoom::ParameterMissing, [:email].to_s)
      end

      it 'requires type param' do
        expect { zc.user_create(filter_key(args, :type)) }.to raise_error(Zoom::ParameterMissing, [:type].to_s)
      end

      it 'does not require password param when action is not autoCreate' do
        expect { zc.user_create(filter_key(args, :password)) }.not_to raise_error
      end

      it 'requires password param when action is autoCreate' do
        args[:action] = 'autoCreate'
        expect { zc.user_create(filter_key(args, :password)) }.to raise_error(Zoom::ParameterMissing, [:password].to_s)
      end

      it 'returns a hash' do
        expect(zc.user_create(args)).to be_kind_of(Hash)
      end

      it 'returns same params' do
        res = zc.user_create(args)

        expect(res['email']).to eq(args[:email])
        expect(res['first_name']).to eq(args[:first_name])
        expect(res['last_name']).to eq(args[:last_name])
        expect(res['type']).to eq(args[:type])
      end
    end

    context 'with 409 response' do
      before :each do
        stub_request(
          :post,
          zoom_url('/users')
        ).to_return(status: 409,
                    body: json_response('error', 'already_exists'),
                    headers: {"Content-Type"=> "application/json"})
      end

      it 'raises an error' do
        expect { zc.user_create(args) }.to raise_error(Zoom::Error)
      end
    end
  end
end
