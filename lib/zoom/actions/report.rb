# frozen_string_literal: true

module Zoom
  module Actions
    module Report
      extend Zoom::Actions

      define_action(
        name: 'daily_report',
        method: :get,
        url: '/report/daily',
        permitted: %i[year month]
      )

      define_action(
        name: 'meeting_details_report',
        method: :get,
        url: '/report/meetings/:id'
      )

      define_action(
        name: 'meeting_participants_report',
        method: :get,
        url: '/report/meetings/:id/participants',
        permitted: %i[page_size next_page_token]
      )

      define_action(
        name: 'webinar_participants_report',
        method: :get,
        url: '/report/webinars/:id/participants',
        permitted: %i[page_size next_page_token]
      )
    end
  end
end
