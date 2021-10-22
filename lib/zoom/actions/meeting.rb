# frozen_string_literal: true

module Zoom
  module Actions
    module Meeting
      extend Zoom::Actions

      # List all the scheduled meetings on Zoom.
      define_action(
        name: 'meeting_list',
        method: :get,
        url: '/users/:user_id/meetings',
        permitted: %i[type page_size next_page_token page_number]
      )

      # Create a meeting on Zoom, return the created meeting URL
      define_action(
        name: 'meeting_create',
        method: :post,
        url: '/users/:user_id/meetings',
        permitted: %i[
          topic type start_time duration schedule_for timezone password agenda tracking_fields
          recurrence settings
        ]
      )

      # Get a meeting on Zoom via meeting ID, return the meeting info.
      define_action(
        name: 'meeting_get',
        method: :get,
        url: '/meetings/:meeting_id/',
        permitted: %i[occurrence_id show_previous_occurrences]
      )

      # Update meeting info on Zoom via meeting ID.
      # TODO Handle `topic` attr, Max of 300 characters.
      # TODO Handle `timezone` attr, refer to the id value in timezone list JSON file. like "America/Los_Angeles"
      # TODO Verify `password` attr, may only contain the following characters: a-z A-Z 0-9 @ - _
      # TODO Handle `option_audio` attr, Can be "both", "telephony", "voip".
      # TODO Handle `option_auto_record_type`, Can be "local", “cloud” or "none".
      define_action(
        name: 'meeting_update',
        method: :patch,
        url: '/meetings/:meeting_id'
      )

      # Delete a meeting on Zoom, return the deleted meeting ID.
      define_action(
        name: 'meeting_delete',
        method: :delete,
        url: '/meetings/:meeting_id'
      )

      # Update a meeting's status
      define_action(
        name: 'meeting_update_status',
        method: :put,
        url: '/meetings/:meeting_id/status',
        permitted: :action
      )

      # Register for a meeting.
      define_action(
        name: 'meeting_add_registrant',
        method: :post,
        url: '/meetings/:meeting_id/registrants',
        required: %i[email first_name],
        permitted: %i[
          last_name address city country zip state phone industry org job_title
          purchasing_time_frame role_in_purchase_process no_of_employees comments custom_questions
          language occurrence_ids
        ]
      )

      # Register for a meeting.
      define_action(
        name: 'meeting_registrant_questions',
        method: :patch,
        url: '/meeting/:meeting_id/registrants/questions'
      )

      # Retrieve ended meeting details
      define_action(
        name: 'past_meeting_details',
        method: :get,
        url: '/past_meetings/:meeting_uuid'
      )

      # Retrieve ended meeting participants
      define_action(
        name: 'past_meeting_participants',
        method: :get,
        url: '/past_meetings/:meeting_uuid/participants'
      )

      define_action(
        name: 'livestream',
        method: :patch,
        url: '/meetings/:meeting_id/livestream',
        required: %i[stream_url stream_key],
        permitted: :page_url
      )

      # Get a meeting on Zoom via meeting ID, return the meeting info.
      define_action(
        name: 'meeting_invitation',
        method: :get,
        url: '/meetings/:meeting_id/invitation',
      )
    end
  end
end
