# frozen_string_literal: true

module Zoom
  class Utils
    class << self
      def argument_error(name)
        name ? ArgumentError.new("You must provide #{name}") : ArgumentError.new
      end

      def exclude_argument_error(name)
        name ? ArgumentError.new("Unrecognized parameter #{name}") : ArgumentError.new
      end

      def raise_if_error!(response)
        if response['code'] == 300
          error_hash = { base: response['message']}
          raise Error, error_hash unless response['errors']
          error_hash[response['message']] = response['errors']
          raise Error, error_hash
        else
          response
        end
      end

      def parse_response(http_response)
        response = http_response.parsed_response
        # Mocked response returns a string
        response.is_a?(Hash) ? response : JSON.parse(response)
      end

      def require_params(params, options)
        params = [params] unless params.is_a? Array
        params.each do |param|
          raise argument_error(param.to_s) unless options[param]
        end
      end

      def permit_params(params, options)
        params = [params] unless params.is_a? Array
        options.keys.each do |key|
          raise exclude_argument_error(key.to_s) unless params.include?(key)
        end
      end

      # Dinamically defines bang methods for Actions modules
      def define_bang_methods(klass)
        klass.instance_methods.each do |m|
          klass.send(:define_method, "#{m}!") do |*args|
            response = send(m, *args)
            Utils.raise_if_error!(response)
          rescue Net::OpenTimeout, Net::ReadTimeout, Timeout::Error => _e
            raise ::Zoom::GatewayTimeout.new
          end
        end
      end

      def extract_options!(array)
        array.last.is_a?(::Hash) ? array.pop : {}
      end

      def validate_password(password)
        password_regex = /\A[a-zA-Z0-9@-_*]{0,10}\z/
        raise(Error , 'Invalid Password') unless password[password_regex].nil?
      end

      def process_datetime_params!(params, options)
        params = [params] unless params.is_a? Array
        params.each do |param|
          if options[param] && options[param].kind_of?(Time)
            options[param] = options[param].strftime('%FT%TZ')
          end
        end
        options
      end
    end
  end
end
