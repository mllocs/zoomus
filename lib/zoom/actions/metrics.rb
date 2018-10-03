# frozen_string_literal: true

module Zoom
  module Actions
    module Metrics
      def metrics_crc(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[from to], options)
        Utils.process_datetime_params!(%i[from to], options)
        Utils.parse_response self.class.post('/metrics/crc', query: options)
      end

      def metrics_meetings(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[from to type], options)
        Utils.process_datetime_params!(%i[from to], options)
        Utils.parse_response self.class.post('/metrics/meetings', query: options)
      end

      def metrics_meetingdetail(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(%i[meeting_id type], options)
        Utils.parse_response self.class.post('/metrics/meetingdetail', query: options)
      end
    end
  end
end
