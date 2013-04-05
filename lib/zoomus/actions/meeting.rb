module Zoomus
  module Actions
    module Meeting

      def meeting_list(*args)
        options = args.extract_options!
        require_params(:host_id, options)
        parse_response self.class.post("/meeting/list", :query => options)
      end

      def meeting_create(*args)
        options = args.extract_options!
        require_params([:host_id, :topic, :type], options)
        parse_response self.class.post("/meeting/create", :query => options)
      end

      def meeting_update(*args)
        options = args.extract_options!
        require_params([:id, :host_id, :topic, :type], options)
        parse_response self.class.post("/meeting/update", :query => options)
      end

    end
  end
end
