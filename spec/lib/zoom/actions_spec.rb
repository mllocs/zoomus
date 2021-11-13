# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions do
  describe 'self.extract_path_keys' do
    subject { described_class.extract_path_keys(path) }

    let(:path) { '/:id/foo/:bar' }
    
    it { is_expected.to contain_exactly(:id, :bar) }
  end

  describe 'self.parse_path' do
    subject { described_class.parse_path(path, path_keys, params) }

    let(:path) { '/:id/foo/:bar' }
    let(:path_keys) { [:id, :bar] }
    let(:params) { { id: 100, bar: 'baz' } }

    it { is_expected.to eq('/100/foo/baz') }
  end

  describe 'self.make_request' do
    subject { described_class.make_request(client, method, parsed_path, params, base_uri) }

    let(:client) { Zoom::Client::OAuth.new(access_token: 'xxx', timeout: 15) }
    let(:parsed_path) { '/100/foo/baz' }
    let(:params) { { id: 100, bar: 'baz' } }
    let(:base_uri) { 'https://example.com' }

    context 'when get' do
      let(:method) { :get }

      it 'calls get method on client with get request_options' do
        request_options = {
          headers: client.request_headers,
          query: params,
          base_uri: base_uri
        }
        expect(client.class).to receive(method).with(parsed_path, request_options)
        subject
      end
    end

    context 'when post' do
      let(:method) { :post }

      it 'calls post method on client with post request_options' do
        request_options = {
          headers: client.request_headers,
          body: params.to_json,
          base_uri: base_uri
        }
        expect(client.class).to receive(method).with(parsed_path, request_options)
        subject
      end
    end

    context 'when put' do
      let(:method) { :put }

      it 'calls put method on client with put request_options' do
        request_options = {
          headers: client.request_headers,
          body: params.to_json,
          base_uri: base_uri
        }
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when patch' do
      let(:method) { :patch }

      it 'calls patch method on client with patch request_options' do
        request_options = {
          headers: client.request_headers,
          body: params.to_json,
          base_uri: base_uri
        }
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end

    context 'when delete' do
      let(:method) { :delete }

      it 'calls delete method on client with delete request_options' do
        request_options = {
          headers: client.request_headers,
          base_uri: base_uri
        }
        expect(client.class).to receive(method).with(parsed_path, **request_options)
        subject
      end
    end
  end
end
