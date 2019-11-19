# frozen_string_literal: true

module Zoom
  module Clients
    class OAuth < Zoom::Client
      def initialize(config)
        Zoom::Params.new(config).require(:access_token)
        config.each { |k, v| instance_variable_set("@#{k}", v) }
        self.class.default_timeout(@timeout)
      end

      def access_token
        @access_token
      end
    end

  end

end


