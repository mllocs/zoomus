# frozen_string_literal: true
#
module Zoom
  module Actions
    module Phone
      def call_logs(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[user_id])
        response = self.class.get("/phone/users/#{options[:user_id]}/call_logs", query: options.except(:user_id), headers: request_headers)
        Utils.parse_response(response)
      end

      def phone_users_list(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        response = self.class.get("/phone/users", query: options, headers: request_headers)
        Utils.parse_response(response)
      end

      def call_recordings(*args)
        options = Zoom::Params.new(Utils.extract_options!(args))
        options.require(%i[user_id])
        response = self.class.get("/phone/users/#{options[:user_id]}/recordings", query: options.except(:user_id), headers: request_headers)
        Utils.parse_response(response)
      end
    end
  end
end
