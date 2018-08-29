# frozen_string_literal: true

module Zoom
  module Actions
    module Metrics
      def metrics_crc(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:from, :to], options)
        Utils.process_datetime_params!([:from, :to], options)
        Utils.parse_response self.class.post("/metrics/crc", :query => options)
      end

      def metrics_meetings(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:from, :to, :type], options)
        Utils.process_datetime_params!([:from, :to], options)
        Utils.parse_response self.class.post("/metrics/meetings", :query => options)
      end

      def metrics_meetingdetail(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:meeting_id, :type], options)
        Utils.parse_response self.class.post("/metrics/meetingdetail", :query => options)
      end

      Utils.define_bang_methods(self)
    end
  end
end
