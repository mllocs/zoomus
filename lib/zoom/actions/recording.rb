# frozen_string_literal: true

module Zoom
  module Actions
    module Recording
      def recording_list(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:host_id)
        Utils.process_datetime_params!(%i[from to], options)
        Utils.parse_response self.class.post('/recording/list', query: options)
      end

      def mc_recording_list(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:host_id)
        Utils.process_datetime_params!(%i[from to], options)
        Utils.parse_response self.class.post('/mc/recording/list', query: options)
      end

      def recording_get(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:meeting_id)
        Utils.parse_response self.class.post('/recording/get', query: options)
      end

      def recording_delete(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:meeting_id)
        Utils.parse_response self.class.post('/recording/delete', query: options)
      end
    end
  end
end
