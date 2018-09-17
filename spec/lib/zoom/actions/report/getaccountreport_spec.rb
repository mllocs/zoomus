# frozen_string_literal: true

require 'spec_helper'

xdescribe Zoom::Actions::Report do
  let(:zc) { zoom_client}
  let(:args) { { from: '2013-04-05T15:50:47Z', to: '2013-04-09T19:00:00Z' } }
  let(:response) { zc.report_getaccountreport(args) }

  xdescribe '#report_getaccountreport action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/report/getaccountreport')
      ).to_return(body: json_response('report_getaccountreport'))
    end

    it "requires a 'from' argument" do
      expect {
        zc.report_getaccountreport(filter_key(args, :from))
      }.to raise_error(ArgumentError)
    end

    it "requires a 'to' argument" do
      expect {
        zc.report_getaccountreport(filter_key(args, :to))
      }.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(response).to be_kind_of(Hash)
    end

    it "returns 'total_records'" do
      expect(response['total_records']).to eq(1)
    end

    it "returns 'users' Array" do
      expect(response['users']).to be_kind_of(Array)
    end
  end

  xdescribe '#report_getaccountreport! action' do
    before :each do
      stub_request(
        :post,
        zoom_url('/report/getaccountreport')
      ).to_return(body: json_response('error'))
    end

    it 'raises Zoom::Error exception' do
      expect {
        zc.report_getaccountreport!(args)
      }.to raise_error(Zoom::Error)
    end
  end
end
