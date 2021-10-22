# frozen_string_literal: true
#
module Zoom
  module Actions
    module Phone
      extend Zoom::Actions

      define_action(
        name: 'call_logs',
        method: :get,
        url: '/phone/users/:user_id/call_logs'
      )

      define_action(
        name: 'phone_users_list',
        method: :get,
        url: '/phone/users'
      )

      define_action(
        name: 'call_recordings',
        method: :get,
        url: '/phone/users/:user_id/recordings'
      )
    end
  end
end
