# frozen_string_literal: true

module Zoom
  module Actions
    module Metrics
      def metrics_crc(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:from, :to)
        Utils.process_datetime_params!(%i[from to], params)
        Utils.parse_response self.class.get('/metrics/crc', query: params, headers: request_headers)
      end

      def metrics_meetings(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:from, :to).permit(:next_page_token, :page_size, :type)
        Utils.process_datetime_params!(%i[from to], params)
        Utils.parse_response self.class.get('/metrics/meetings', query: params, headers: request_headers)
      end

      def metrics_meetingdetail(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(:type)
        Utils.parse_response self.class.get("/metrics/meetings/#{params[:meeting_id]}", query: params.except(:meeting_id), headers: request_headers)
      end

      def metrics_meetingparticipants(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id).permit(:next_page_token, :page_size, :type)
        Utils.parse_response self.class.get("/metrics/meetings/#{params[:meeting_id]}/participants", query: params.except(:meeting_id), headers: request_headers)
      end
    end
  end
end
