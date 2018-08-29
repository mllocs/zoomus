require 'spec_helper'

describe Zoom::Actions::Report do
	before :all do
		@zc = zoomus_client
		@args = { year: 2017, month: 7 }
	end

	describe '#report_getdailyreport action' do
		before :each do
			stub_request(
				:post,
				zoomus_url('/report/getdailyreport')
			).to_return(:body => json_response('report_getdailyreport'))
		end

		it "requires a 'year' argument" do
			expect {
				@zc.report_getdailyreport(filter_key(@args, :year))
			}.to raise_error(ArgumentError)
		end

		it "requires a 'month' argument" do
			expect {
				@zc.report_getdailyreport(filter_key(@args, :month))
			}.to raise_error(ArgumentError)
		end

		it "returs a Hash" do
			expect(@zc.report_getdailyreport(@args)).to be_kind_of(Hash)
		end

		it "returns a 'year'" do
			expect(@zc.report_getdailyreport(@args)['year']).to eq(@args[:year])
		end

		it "returns a 'month'" do
			expect(@zc.report_getdailyreport(@args)['month']).to eq(@args[:month])
		end

		it "returns a 'dates' Array" do
			expect(@zc.report_getdailyreport(@args)['dates']).to be_kind_of(Array)
		end
	end

	describe "#report_getdailyreport! action" do
		before :each do
			stub_request(
				:post,
				zoomus_url("/report/getdailyreport")
			).to_return(:body => json_response("error"))
		end

		it "raises Zoom::Error exception" do
			expect {
				@zc.report_getdailyreport!(@args)
			}.to raise_error(Zoom::Error)
		end
  end
end