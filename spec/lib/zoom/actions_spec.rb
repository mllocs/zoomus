# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions do
  describe 'self.extract_url_keys' do
    subject { described_class.extract_url_keys(url) }

    let(:url) { 'https://example.com/:id/foo/:bar' }
    
    it { is_expected.to contain_exactly(:id, :bar) }
  end

  describe 'self.parse_url' do
    subject { described_class.parse_url(url, url_keys, params) }

    let(:url) { 'https://example.com/:id/foo/:bar' }
    let(:url_keys) { [:id, :bar] }
    let(:params) { { id: 100, bar: 'baz' } }

    it { is_expected.to eq('https://example.com/100/foo/baz') }
  end
end
