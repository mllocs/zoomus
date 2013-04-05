module Zoomus
  module Actions
    module Meeting

      def meeting_list(*args)
        options = extract_options!(args)
        require_params(:host_id, options)
        parse_response self.class.post("/meeting/list", :query => options)
      end

      def meeting_create(*args)
        options = extract_options!(args)
        require_params([:host_id, :topic, :type], options)
        parse_response self.class.post("/meeting/create", :query => options)
      end

      def meeting_update(*args)
        options = extract_options!(args)
        require_params([:id, :host_id, :topic, :type], options)
        parse_response self.class.post("/meeting/update", :query => options)
      end

      Utils::define_bang_methods(self)

    end
  end
end
