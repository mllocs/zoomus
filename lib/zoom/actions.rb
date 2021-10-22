# frozen_string_literal: true

module Zoom
  module Actions
    def self.extract_url_param_keys(url)
      url.scan(/:\w+/).map { |match| match[1..].to_sym }
    end

    def self.parse_url(url, url_param_keys, params)
      parsed_url = url.dup
      url_param_keys.each do |key|
        value       = params[key].to_s
        parsed_url  = parsed_url.gsub(":#{key}", value)
      end
      parsed_url
    end

    def self.make_request(obj, method, url, url_param_keys, params, required_params)
      request_options = {
        headers: obj.request_headers
      }
      case method
      when :get
        request_options[:query] = required_params
      when :post, :patch
        request_options[:body] = required_params.to_json
      end
      parsed_url = parse_url(url, url_param_keys, params)
      obj.class.public_send(method, parsed_url, **request_options)
    end

    def define_action(name:, method:, url:, required: [], permitted: [])
      required  = [required]  if required.is_a?(Symbol)
      permitted = [permitted] if permitted.is_a?(Symbol)

      define_method(name) do |*args|
        params = Zoom::Params.new(Utils.extract_options!(args))
        url_param_keys = Zoom::Actions.extract_url_param_keys(url)
        required_params = params
        required_params = url_param_keys.empty? ? required_params : required_params.require(url_param_keys)
        required_params = required.empty? ? required_params : required_params.require(required)
        required_params.permit(permitted) unless permitted.empty?
        response = Zoom::Actions.make_request(self, method, url, url_param_keys, params, required_params)
        Utils.parse_response(response)
      end
    end
  end
end
