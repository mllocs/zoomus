module Zoomus
  module Actions
    module Meeting

      def meeting_list(*args)
        options = args.extract_options!
        require_params(:host_id, options)
        parse_response self.class.post("/meeting/list", :query => options)
      end

    end
  end
end