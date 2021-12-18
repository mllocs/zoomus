# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      extend Zoom::Actions

      post 'access_tokens',
        '/oauth/token?grant_type=authorization_code&code=:auth_code&redirect_uri=:redirect_uri',
        base_uri: 'https://zoom.us/'

      post 'refresh_tokens',
        '/oauth/token?grant_type=refresh_token&refresh_token=:refresh_token',
        base_uri: 'https://zoom.us/'

      post 'data_compliance', '/oauth/data/compliance',
        base_uri: 'https://zoom.us/',
        require: %i[
          client_id user_id account_id deauthorization_event_received compliance_completed
        ]

      post 'revoke_tokens', '/oauth/revoke?token=:access_token',
        base_uri: 'https://zoom.us/'
    end
  end
end
