module Zoomus
  module Actions
    module Metrics

      def metrics_meetingdetail(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:meeting_id, :type], options)
        Utils.parse_response self.class.post("/metrics/meetingdetail", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
