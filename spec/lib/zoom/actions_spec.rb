# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions do
  let(:client) { Zoom::Client::OAuth.new(access_token: 'xxx', timeout: 15) }
  let(:path) { '/:id/foo/:bar' }
  let(:path_keys) { [:id, :bar] }
  let(:params) { { id: 100, bar: 'baz' } }
  let(:base_uri) { 'https://example.com' }
  let(:parsed_path) { '/100/foo/baz' }

  describe 'self.extract_path_keys' do
    subject { described_class.extract_path_keys(path) }

    it { is_expected.to match_array(path_keys) }
  end

  describe 'self.parse_path' do
    subject { described_class.parse_path(path, path_keys, params) }

    it { is_expected.to eq(parsed_path) }
  end

  describe 'self.make_request' do
    subject do
      described_class.make_request({
        client: client, method: method, parsed_path: parsed_path,
        params: params, base_uri: base_uri
      })
    end

    let(:request_options) {
      {
        headers: client.request_headers,
        base_uri: base_uri
      }
    }

    context 'when get' do
      let(:method) { :get }

      it 'calls get method on client with get request_options' do
        request_options[:query] = params
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when post' do
      let(:method) { :post }

      it 'calls post method on client with post request_options' do
        request_options[:body] = params.to_json
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when put' do
      let(:method) { :put }

      it 'calls put method on client with put request_options' do
        request_options[:body] = params.to_json
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when patch' do
      let(:method) { :patch }

      it 'calls patch method on client with patch request_options' do
        request_options[:body] = params.to_json
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when delete' do
      let(:method) { :delete }

      it 'calls delete method on client with delete request_options' do
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end
  end
end
