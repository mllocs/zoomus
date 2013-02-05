module Zoomus
  module Actions
    module Meeting

      def meeting_list(host_id = nil)
        raise argument_error("host_id") unless host_id
        http_response = self.class.post("/meeting/list", :query => { :host_id => host_id })
        parse(http_response)
      end

    end
  end
end