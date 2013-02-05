module Zoomus
  module Utils

    private

      def argument_error(name = "api_key and api_secret")
        ArgumentError.new("You must provide #{name}")
      end

      def parse(http_response)
        JSON.parse(http_response.parsed_response)
      end
  end
end
