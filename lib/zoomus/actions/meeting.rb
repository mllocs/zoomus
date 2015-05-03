module Zoomus
  module Actions
    module Meeting

      def meeting_list(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(:host_id, options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/meeting/list", :query => options)
      end

      def meeting_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:host_id, :topic, :type], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/meeting/create", :query => options)
      end

      def meeting_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/meeting/update", :query => options)
      end

      def meeting_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/meeting/delete", :query => options)
      end

      def meeting_end(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/meeting/end", :query => options)
      end

      def meeting_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/meeting/get", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
