# frozen_string_literal: true

module Zoom
  module Actions
    module Dashboard
      def dashboard_crc(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[from to])
        Utils.process_datetime_params!(%i[from to], params)
        Utils.parse_response self.class.get('/metrics/crc', query: params, headers: request_headers)
      end

      def dashboard_meetings(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(%i[from to]).permit(%i[next_page_token page_size type])
        Utils.process_datetime_params!(%i[from to], params)
        Utils.parse_response self.class.get('/metrics/meetings', query: params, headers: request_headers)
      end

      def dashboard_meeting_details(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(:type)
        Utils.parse_response self.class.get("/metrics/meetings/#{params[:meeting_id]}", query: params.except(:meeting_id), headers: request_headers)
      end

      def dashboard_meeting_participants(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(%i[next_page_token page_size type])
        Utils.parse_response self.class.get("/metrics/meetings/#{params[:meeting_id]}/participants", query: params.except(:meeting_id), headers: request_headers)
      end
    end
  end
end
