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
        parsed_url  = parsed_url.gsub(":#{key}", value)
      end
      parsed_url
    end

    def self.make_request(obj, method, parsed_url, filtered_params)
      request_options = {
        headers: obj.request_headers
      }
      case method
      when :get
        request_options[:query] = filtered_params
      when :post, :patch
        request_options[:body] = filtered_params.to_json
      end
      obj.class.public_send(method, parsed_url, **request_options)
    end

    def self.filter_params(params, url_keys, required, permitted)
      filtered_params = params
      filtered_params = filtered_params.require(url_keys) unless url_keys.empty?
      filtered_params = filtered_params.require(required) unless required.empty?
      filtered_params.permit(permitted) unless permitted.empty?
      filtered_params
    end

    def define_action(name:, method:, url:, required: [], permitted: [])
      required  = [required]  if required.is_a?(Symbol)
      permitted = [permitted] if permitted.is_a?(Symbol)

      define_method(name) do |*args|
        params = Zoom::Params.new(Utils.extract_options!(args))
        url_keys = Zoom::Actions.extract_url_keys(url)
        filtered_params = Zoom::Actions.filter_params(params, url_keys, required, permitted)
        parsed_url = Zoom::Actions.parse_url(url, url_keys, params)
        response = Zoom::Actions.make_request(self, method, parsed_url, filtered_params)
        Utils.parse_response(response)
      end
    end
  end
end
