module Zoomus
  module Utils
    private
      def argument_error(name)
        name ? ArgumentError.new("You must provide #{name}") : ArgumentError
      end

      def parse_response(http_response)
        JSON.parse(http_response.parsed_response)
      end
  end
end

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end