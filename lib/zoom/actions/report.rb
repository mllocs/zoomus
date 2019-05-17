# frozen_string_literal: true

module Zoom
  module Actions
    module Report
      def daily_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.permit(:year, :month)
        Utils.parse_response self.class.get('/report/daily', query: params, headers: request_headers)
      end

      def hosts_report(*args)
        # TODO: implement hosts_report
      end

      def meetings_report(*args)
        # TODO: implement meetings_report
      end

      def meeting_details_report(*args)
        # TODO: implement meeting_details_report
      end

      def meeting_participants_report(*args)
        # TODO: implement meeting_participants_report
      end

      def meeting_polls_report(*args)
        # TODO: implement meeting_polls_report
      end

      def webinar_details_report(*args)
        # TODO: implement webinar_details_report
      end

      def webinar_participants_report(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:id).permit(:page_size, :next_page_token)
        Utils.parse_response self.class.get("/report/webinars/#{params[:id]}/participants", query: params.except(:id).merge(access_token: access_token))
      end

      def webinar_polls_report(*args)
        # TODO: implement report_hosts
      end

      def webinar_qa_report(*args)
        # TODO: implement report_hosts
      end

      def telephone_report(*args)
        # TODO: implement report_hosts
      end
    end
  end
end
