module Zoomus
  module Actions
    module User

      def user_list
        parse_response self.class.post("/user/list")
      end

    end
  end
end