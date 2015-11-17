module Zoomus
  class Utils

    class << self

      def argument_error(name)
        name ? ArgumentError.new("You must provide #{name}") : ArgumentError.new
      end

      def raise_if_error!(response)
        if response["error"]
          raise Error.new(response["error"]["message"])
        else
          response
        end
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

      # Dinamically defines bang methods for Actions modules
      def define_bang_methods(klass)
        klass.instance_methods.each do |m|
          klass.send(:define_method, "#{m}!") do |*args|
            begin
              response = send(m, *args)
              Utils.raise_if_error!(response)
            rescue Net::OpenTimeout, Net::ReadTimeout, Timeout::Error => _e
              raise ::Zoomus::GatewayTimeout.new
            end
          end
        end
      end

      def extract_options!(array)
        array.last.is_a?(::Hash) ? array.pop : {}
      end

      def process_datetime_params!(params, options)
        params = [params] unless params.is_a? Array
        params.each do |param|
          if options[param] && options[param].kind_of?(Time)
            options[param] = options[param].strftime("%FT%TZ")
          end
        end
        options
      end
    end
  end
end
