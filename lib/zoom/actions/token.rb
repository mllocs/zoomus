# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      def access_tokens(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[auth_code redirect_uri])
        response = self.class.post("/oauth/token?grant_type=authorization_code&code=#{options[:auth_code]}&redirect_uri=#{options[:redirect_uri]}", headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response(response)
      end

      def refresh_tokens(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[refresh_token])
        response = self.class.post("/oauth/token?grant_type=refresh_token&refresh_token=#{options[:refresh_token]}", headers: oauth_request_headers, base_uri: 'https://zoom.us/')
        Utils.parse_response(response)
      end
    end
  end
end
