# frozen_string_literal: true

module Zoom
  class Client
    class OAuth < Zoom::Client
      def initialize(config)
        Zoom::Params.new(config).require(:access_token)
        config.each { |k, v| instance_variable_set("@#{k}", v) }
        self.class.default_timeout(@timeout || 20)
      end

      def access_token
        @access_token
      end
    end
  end
end
