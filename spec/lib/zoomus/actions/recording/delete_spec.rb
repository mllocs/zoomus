# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Recording do

  before :all do
    @zc = zoom_client
    @args = {:meeting_id => "ucc69C82Q5mTNyCRWE29Aw==" }
  end

  describe "#recording_delete action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/recording/delete")
      ).to_return(:body => json_response("recording_delete"))
    end

    it "requires a 'meeting_id' argument" do
      expect {
        @zc.recording_delete(filter_key(@args, :meeting_id))
      }.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.recording_delete(@args)).to be_kind_of(Hash)
    end

    it "returns id and deleted at attributes" do
      res = @zc.recording_delete(@args)

      expect(res["id"]).to eq(@args[:meeting_id])
      expect(res["deleted_at"]).to eq("2012-11-25T12:00:00Z")
    end
  end

  describe "#recording_delete! action" do
    before :each do
      stub_request(
        :post,
        zoom_url("/recording/delete")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoom::Error exception" do
      expect {
        @zc.recording_delete!(@args)
      }.to raise_error(Zoom::Error)
    end
  end
end
