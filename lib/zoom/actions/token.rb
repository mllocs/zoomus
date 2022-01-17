# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      extend Zoom::Actions

      post 'access_tokens',
        '/oauth/token?grant_type=authorization_code',
        base_uri: 'https://zoom.us/',
        require: %i[code redirect_uri]

      post 'refresh_tokens',
        '/oauth/token?grant_type=refresh_token',
        base_uri: 'https://zoom.us/',
        require: :refresh_token

      post 'data_compliance', '/oauth/data/compliance',
        base_uri: 'https://zoom.us/',
        require: %i[
          client_id user_id account_id deauthorization_event_received compliance_completed
        ]

      post 'revoke_tokens', '/oauth/revoke',
        base_uri: 'https://zoom.us/',
        require: :token

      def self.convert_param_names!(params)
        params[:code] = params.delete :auth_code if params[:auth_code]
        params[:token] = params.delete :access_token if params[:access_token]
        params
      end

      def self.form_url_encoded_actions
        %w[access_tokens refresh_tokens revoke_tokens]
      end
    end
  end
end
