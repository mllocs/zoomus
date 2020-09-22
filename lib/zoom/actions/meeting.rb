# frozen_string_literal: true

module Zoom
  module Actions
    module Meeting
      # List all the scheduled meetings on Zoom.
      def meeting_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:user_id).permit(%i[type page_size next_page_token page_number])
        Utils.parse_response self.class.get("/users/#{params[:user_id]}/meetings", query: params.except(:user_id), headers: request_headers)
      end

      # Create a meeting on Zoom, return the created meeting URL
      def meeting_create(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:user_id).permit(%i[topic type start_time duration schedule_for timezone password agenda tracking_fields recurrence settings])
        Utils.process_datetime_params!(:start_time, params)
        Utils.parse_response self.class.post("/users/#{params[:user_id]}/meetings", body: params.except(:user_id).to_json, headers: request_headers)
      end

      # Get a meeting on Zoom via meeting ID, return the meeting info.
      def meeting_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(%i[occurrence_id show_previous_occurrences])
        Utils.parse_response self.class.get("/meetings/#{params[:meeting_id]}", query: params.except(:meeting_id), headers: request_headers)
      end

      # Update meeting info on Zoom via meeting ID.
      def meeting_update(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id)
        Utils.process_datetime_params!(:start_time, params)
        # TODO Handle `topic` attr, Max of 300 characters.
        # TODO Handle `timezone` attr, refer to the id value in timezone list JSON file. like "America/Los_Angeles"
        # TODO Verify `password` attr, may only contain the following characters: a-z A-Z 0-9 @ - _
        # TODO Handle `option_audio` attr, Can be "both", "telephony", "voip".
        # TODO Handle `option_auto_record_type`, Can be "local", “cloud” or "none".
        Utils.parse_response self.class.patch("/meetings/#{params[:meeting_id]}", body: params.except(:meeting_id).to_json, headers: request_headers)
      end

      # Delete a meeting on Zoom, return the deleted meeting ID.
      def meeting_delete(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id)
        Utils.parse_response self.class.delete("/meetings/#{params[:meeting_id]}", query: params.except(:meeting_id), headers: request_headers)
      end

      # Update a meeting's status
      def meeting_update_status(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(:action)
        Utils.parse_response self.class.put("/meetings/#{params[:meeting_id]}/status", body: params.except(:meeting_id).to_json, headers: request_headers)
      end

      # Register for a meeting.
      def meeting_add_registrant(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[meeting_id email first_name]).permit(%i[last_name address city country zip state phone industry org job_title purchasing_time_frame role_in_purchase_process no_of_employees comments custom_questions language occurrence_ids])
        Utils.parse_response self.class.post("/meetings/#{params[:meeting_id]}/registrants", query: params.slice(:occurrence_ids), body: params.except(:meeting_id).to_json, headers: request_headers)
      end

      # Register for a meeting.
      def meeting_registrant_questions(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id)
        Utils.parse_response self.class.patch("/meetings/#{params[:meeting_id]}/registrants/questions", body: params.except(:meeting_id).to_json, headers: request_headers)
      end

      # Retrieve ended meeting details
      def past_meeting_details(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_uuid)
        Utils.parse_response self.class.get("/past_meetings/#{params[:meeting_uuid]}", headers: request_headers)
      end

      # Retrieve ended meeting participants
      def past_meeting_participants(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_uuid)
        Utils.parse_response self.class.get("/past_meetings/#{params[:meeting_uuid]}/participants", headers: request_headers)
      end

      def livestream(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[meeting_id stream_url stream_key]).permit(:page_url)
        Utils.parse_response self.class.patch("/meetings/#{params[:meeting_id]}/livestream", body: params.except(:meeting_id).to_json, headers: request_headers)
      end

      # Get a meeting on Zoom via meeting ID, return the meeting info.
      def meeting_invitation(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id)
        Utils.parse_response self.class.get("/meetings/#{params[:meeting_id]}/invitation", headers: request_headers)
      end
    end
  end
end
