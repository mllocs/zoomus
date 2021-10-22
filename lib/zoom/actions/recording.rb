# frozen_string_literal: true

module Zoom
  module Actions
    module Recording
      extend Zoom::Actions

      RECORDING_SETTINGS_KEYS = %i[share_recording recording_authentication
                                   authentication_option authentication_domains viewer_download password
                                   on_demand approval_type send_email_to_host show_social_share_buttons].freeze

      define_action(
        name: 'recording_list',
        method: :get,
        url: '/users/:user_id/recordings'
      )

      define_action(
        name: 'meeting_recording_get',
        method: :get,
        url: '/meetings/:meeting_id/recordings/settings'
      )

      define_action(
        name: 'meeting_recording_settings_get',
        method: :get,
        url: '/meetings/:meeting_id/recordings/settings'
      )

      define_action(
        name: 'meeting_recording_settings_update',
        method: :patch,
        url: '/meetings/:meeting_id/recordings/settings',
        permitted: RECORDING_SETTINGS_KEYS
      )

      define_action(
        name: 'meeting_recording_file_delete',
        method: :delete,
        url: '/meetings/:meeting_id/recordings/:recording_id'
      )
    end
  end
end
