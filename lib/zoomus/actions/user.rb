module Zoomus
  module Actions
    module User

      def user_list
        http_response = self.class.post("/user/list")
        hash_response = parse(http_response)
      end

    end
  end
end