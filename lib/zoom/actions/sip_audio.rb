# frozen_string_literal: true

module Zoom
  module Actions
    module SipAudio

      def sip_trunks_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:account_id)
        Utils.parse_response self.class.get("/accounts/#{params[:account_id]}/sip_trunk/trunks", headers: request_headers)
      end

    end
  end
end
