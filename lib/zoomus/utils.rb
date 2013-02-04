module Zoomus
  module Utils

    private

      def argument_error
        ArgumentError.new("You must provide the api_key and api_secret")
      end

      def parse(http_response)
        JSON.parse(http_response.parsed_response)
      end
  end
end
