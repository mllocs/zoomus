# frozen_string_literal: true
#
module Zoom
  module Actions
    module Token
      extend Zoom::Actions

      post 'access_tokens',
        '/oauth/token?grant_type=authorization_code&code=:auth_code&redirect_uri=:redirect_uri',
        oauth: true

      post 'refresh_tokens',
        '/oauth/token?grant_type=refresh_token&refresh_token=:refresh_token',
        oauth: true

      post 'data_compliance', '/oauth/data/compliance',
        oauth: true,
        require: %i[
          client_id user_id account_id deauthorization_event_received compliance_completed
        ]

      post 'revoke_tokens', '/oauth/revoke?token=:access_token',
        oauth: true
    end
  end
end
