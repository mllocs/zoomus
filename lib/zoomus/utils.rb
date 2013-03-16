module Zoomus
  module Utils
    private
      def argument_error(name)
        name ? ArgumentError.new("You must provide #{name}") : ArgumentError
      end

      def parse_response(http_response)
        response = http_response.parsed_response
        # Mocked response returns a string
        response.kind_of?(Hash) ? response : JSON.parse(response)
      end

      def require_params(params, options)
        params = [params] unless params.is_a? Array
        params.each do |param|
          unless options[param]
            raise argument_error(param.to_s)
            break
          end
        end
      end
  end
end

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end