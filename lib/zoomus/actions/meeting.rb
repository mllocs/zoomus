module Zoomus
  module Actions
    module Meeting

      def meeting_list(*args)

        options = args.extract_options!

        raise argument_error('host_id') unless options[:host_id]

        parse_response self.class.post("/meeting/list", :query => { :host_id => options[:host_id] })
      end

    end
  end
end