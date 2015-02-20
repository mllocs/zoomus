module Zoomus
  module Actions
    module User

      def user_list(*args)
        options = Utils.extract_options!(args)
        Utils.parse_response self.class.post('/user/list', :query => options)
      end

      def user_create(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:type, :email], options)
        Utils.parse_response self.class.post('/user/create', :query => options)
      end

      def user_delete(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.parse_response self.class.post('/user/delete', :query => options)
      end

      def user_custcreate(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:type, :email], options)
        Utils.parse_response self.class.post('/user/custcreate', :query => options)
      end

      def user_update(*args)
        options = Utils.extract_options!(args)
        Utils.require_params([:id], options)
        Utils.parse_response self.class.post('/user/update', :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
