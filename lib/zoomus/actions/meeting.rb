module Zoomus
  module Actions
    module Meeting

      def meeting_list
        http_response = self.class.post("/meeting/list")
        hash_response = parse(http_response)
      end

    end
  end
end