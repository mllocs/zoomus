# frozen_string_literal: true

module Zoom
  module Actions
    def self.extract_url_keys(url)
      url.scan(/:\w+/).map { |match| match[1..].to_sym }
    end

    def self.parse_url(url, url_keys, params)
      parsed_url = url.dup
      url_keys.each do |key|
        value       = params[key].to_s
        parsed_url  = parsed_url.sub(":#{key}", value)
      end
      parsed_url
    end

    def self.make_request(obj, method, parsed_url, filtered_params, base_uri)
      request_options = { headers: obj.request_headers }
      request_options[:base_uri] = base_uri if base_uri
      case method
      when :get
        request_options[:query] = filtered_params
      when :post, :patch
        request_options[:body] = filtered_params.to_json
      end
      obj.class.public_send(method, parsed_url, **request_options)
    end

    [:get, :post, :patch, :put, :delete].each do |method|
      define_method(method) do |name, url, options={}|
        required, permitted, base_uri = options.values_at :require, :permit, :base_uri
        required = Array(required) unless required.is_a?(Hash)
        permitted = Array(permitted) unless permitted.is_a?(Hash)

        define_method(name) do |*args|
          url_keys = Zoom::Actions.extract_url_keys(url)
          params = Zoom::Params.new(Utils.extract_options!(args))
          parsed_url = Zoom::Actions.parse_url(url, url_keys, params)
          params = params.require(url_keys) unless url_keys.empty?
          params_without_required = required.empty? ? params : params.require(required)
          params_without_required.permit(permitted) unless permitted.empty?
          response = Zoom::Actions.make_request(self, method, parsed_url, params, base_uri)
          Utils.parse_response(response)
        end
      end
    end
  end
end
