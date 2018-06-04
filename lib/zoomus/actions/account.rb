module Zoomus
  module Actions
    module Account

      def account_get(*args)
        options = Utils.extract_options!(args)
        Utils.require_params(:account_id, options)
        Utils.parse_response self.class.post("/account/get", :query => options)
      end

      Utils.define_bang_methods(self)

    end
  end
end
