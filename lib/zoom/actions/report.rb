# frozen_string_literal: true

module Zoom
  module Actions
    module Report
      def daily_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.permit(%i[year month])
        Utils.parse_response self.class.get('/report/daily', query: params, headers: request_headers)
      end
      def meeting_details_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id)
        Utils.parse_response self.class.get("/report/meetings/#{params[:id]}", query: params.except(:id), headers: request_headers)
      end

      def meeting_participants_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(%i[page_size next_page_token])
        Utils.parse_response self.class.get("/report/meetings/#{params[:id]}/participants", query: params.except(:id), headers: request_headers)
      end

      def webinar_participants_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(%i[page_size next_page_token])
        Utils.parse_response self.class.get("/report/webinars/#{params[:id]}/participants", query: params.except(:id), headers: request_headers)
      end
    end
  end
end
