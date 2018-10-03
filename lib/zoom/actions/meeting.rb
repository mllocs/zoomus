# frozen_string_literal: true

module Zoom
  module Actions
    module Meeting
      # Create a meeting on Zoom, return the created meeting URL
      def meeting_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[host_id topic type], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post('/meeting/create', query: options)
      end

      # Delete a meeting on Zoom, return the deleted meeting ID.
      def meeting_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id host_id], options)
        Utils.parse_response self.class.post('/meeting/delete', query: options)
      end

      # End a meeting on Zoom, return the deleted meeting ID.
      def meeting_end(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id host_id], options)
        Utils.parse_response self.class.post('/meeting/end', query: options)
      end

      # Get a meeting on Zoom via meeting ID, return the meeting info.
      def meeting_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id host_id], options)
        Utils.parse_response self.class.post('/meeting/get', query: options)
      end

      # List all the scheduled meetings on Zoom.
      def meeting_list(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(:host_id, options)
        Utils.process_datetime_params!(:start_time, options)
        # TODO Handle `page_size` attr, Defaults to 30. Max of 300 meetings.
        # TODO Handle `page_number` attr, Defaults to 1.
        Utils.parse_response self.class.post('/meeting/list', query: options)
      end

      # Lists the live meetings on Zoom.
      def meeting_live(*args)
        options = Utils.extract_options!(args)
        Utils.parse_response self.class.post('/meeting/live', query: options)
      end

      # Register for a meeting.
      def meeting_register(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id email first_name last_name], options)
        # TODO Verify country param by referring to the id value in country list JSON file
        # TODO Verify Purchasing Time Frame, should be "Within a month", "1-3 months", "4-6 months", "More than 6 months", "No timeframe".
        # TODO Verify Role in Purchase Process, should be "Decision Maker", "Evaluator/Recommender", "Influencer", "Not involved".
        # TODO Verify Number of Employees, should be "1-20", "21-50", "51-100", "101-250", "251-500", "501-1,000", "1,001-5,000", "5,001-10,000", "More than 10,000".
        # TODO Verify Custom Questions, should be JSON format
        # TODO Verify Language, should be "en-US", "en", "zh-CN", "zh", "en-ES", "es", “fr-FR” or "fr"
        Utils.parse_response self.class.post('/meeting/register', query: options)
      end

      # Update meeting info on Zoom via meeting ID.
      def meeting_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[id host_id type], options)
        Utils.process_datetime_params!(:start_time, options)
        # TODO Handle `topic` attr, Max of 300 characters.
        # TODO Handle `timezone` attr, refer to the id value in timezone list JSON file. like "America/Los_Angeles"
        # TODO Verify `password` attr, may only contain the following characters: a-z A-Z 0-9 @ - _
        # TODO Handle `option_audio` attr, Can be "both", "telephony", "voip".
        # TODO Handle `option_auto_record_type`, Can be "local", “cloud” or "none".
        Utils.parse_response self.class.post('/meeting/update', query: options)
      end
    end
  end
end
