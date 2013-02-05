module Zoomus
  module Actions
    module User

      def user_list
        parse_response self.class.post("/user/list")
      end

      def user_create(*args)
        options = args.extract_options!
        require_params([:type, :email], options)
        parse_response self.class.post("/user/create", :query => options)
      end

    end
  end
end