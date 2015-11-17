module Zoomus
  module Actions
    module Webinar

      def webinar_list(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(:host_id, options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/webinar/list", :query => options)
      end

      def webinar_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:host_id, :topic], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/webinar/create", :query => options)
      end

      def webinar_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.process_datetime_params!(:start_time, options)
        Utils.parse_response self.class.post("/webinar/update", :query => options)
      end

      def webinar_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/webinar/delete", :query => options)
      end

      def webinar_end(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/webinar/end", :query => options)
      end

      def webinar_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id, :host_id], options)
        Utils.parse_response self.class.post("/webinar/get", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
