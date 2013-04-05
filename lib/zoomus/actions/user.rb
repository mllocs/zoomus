module Zoomus
  module Actions
    module User

      def user_list
        Utils.parse_response self.class.post("/user/list")
      end

      def user_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:type, :email], options)
        Utils.parse_response self.class.post("/user/create", :query => options)
      end

      def user_custcreate(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:type, :email], options)
        Utils.parse_response self.class.post("/user/custcreate", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
