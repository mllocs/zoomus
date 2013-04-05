module Zoomus
  module Actions
    module User

      def user_list
        parse_response self.class.post("/user/list")
      end

      def user_create(*args)
        options = extract_options!(args)
        require_params([:type, :email], options)
        parse_response self.class.post("/user/create", :query => options)
      end

      def user_custcreate(*args)
        options = extract_options!(args)
        require_params([:type, :email], options)
        parse_response self.class.post("/user/custcreate", :query => options)
      end

    end
  end
end
