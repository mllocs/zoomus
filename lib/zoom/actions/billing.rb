# frozen_string_literal: true

module Zoom
  module Actions
    module Billing
      extend Zoom::Actions

      define_action(
        name:   'billing_get',
        method: :get,
        url:    '/accounts/:account_id/billing'
      )

      define_action(
        name:       'billing_update',
        method:     :patch,
        url:        '/accounts/:account_id/billing',
        permitted:  %i[first_name last_name email phone_number address apt city state zip country]
      )

      define_action(
        name:   'billing_plans_list',
        method: :get,
        url:    '/accounts/:account_id/plans'
      )

      define_action(
        name: 'billing_plans_usage',
        method: :get,
        url: '/accounts/:account_id/plans/usage'
      )

      define_action(
        name: 'billing_plans_subscribe',
        method: :post,
        url: '/accounts/:account_id/plans',
        required: {
          contact: %i[first_name last_name email phone_number address city state zip country],
          plan_base: %i[type hosts]
        },
        permitted: [
          :plan_recording,
          {
            contact: [:apt],
            plan_zoom_rooms: %i[type hosts],
            plan_room_connector: %i[type hosts],
            plan_large_meeting: %i[type hosts],
            plan_zoom_events: %i[type hosts],
            plan_webinar: %i[type hosts],
            plan_audio: %i[type tollfree_countries premium_countries callout_countries ddi_numbers],
            plan_phone: {
              plan_base: %i[type callout_countries],
              plan_calling: %i[type hosts],
              plan_number: %i[type hosts]
            }
          }
        ]
      )
    end
  end
end