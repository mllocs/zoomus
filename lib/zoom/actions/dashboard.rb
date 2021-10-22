# frozen_string_literal: true

module Zoom
  module Actions
    module Dashboard
      extend Zoom::Actions

      define_action(
        name: 'dashboard_crc',
        method: :get,
        url: '/metrics/crc',
        required: %i[from to]
      )

      define_action(
        name: 'dashboard_meetings',
        method: :get,
        url: '/metrics/meetings',
        required: %i[from to],
        permitted: %i[next_page_token page_size type]
      )

      define_action(
        name: 'dashboard_meeting_details',
        method: :get,
        url: '/metrics/meetings/:meeting_id',
        permitted: :type
      )

      define_action(
        name: 'dashboard_meeting_participants',
        method: :get,
        url: '/metrics/meetings/:meeting_id/participants',
        permitted: %i[next_page_token page_size type]
      )
    end
  end
end
