# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      extend Zoom::Actions

      post 'access_tokens',
        '/oauth/token?grant_type=authorization_code',
        base_uri: 'https://zoom.us/',
        require: %i[code redirect_uri],
        args_to_params: { auth_code: :code },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }

      post 'refresh_tokens',
        '/oauth/token?grant_type=refresh_token',
        base_uri: 'https://zoom.us/',
        require: :refresh_token,
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }

      post 'data_compliance', '/oauth/data/compliance',
        base_uri: 'https://zoom.us/',
        require: %i[
          client_id user_id account_id deauthorization_event_received compliance_completed
        ]

      post 'revoke_tokens', '/oauth/revoke',
        base_uri: 'https://zoom.us/',
        require: :token,
        args_to_params: { access_token: :token },
        headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
    end
  end
end
